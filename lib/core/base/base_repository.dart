import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:saro/core/exceptions/network_exception.dart';
import 'package:saro/core/services/database_service.dart';

import '../flavor/flavor_config.dart';
import '../models/credentials.dart';
import '../models/user.dart';

class BaseRepository {
  final Dio dio;
  final LocalDatabaseService database;

  User? get currentUser => database.currentUser;

  BaseRepository(this.dio, this.database) {
    _configDio(dio);
  }

  // **************************************************************************
  // BaseRepository Config
  // **************************************************************************

  final _limit = 10;
  int get limit => _limit;

  // **************************************************************************
  // Dio Config
  // **************************************************************************

  void _configDio(Dio dio, {bool addTokenInterceptor = true}) {
    dio.options = BaseOptions(baseUrl: FlavorConfig.values.baseUrl);

    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      HttpClient client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    if (kDebugMode) {
      dio.interceptors.add(_debugLogInterceptor);
    }
    if (addTokenInterceptor) {
      dio.interceptors.add(_tokenInterceptor);
    }
  }

  // **************************************************************************
  // Base Function to make Dio Request
  // **************************************************************************

  Future<T> makeDioRequest<T>(Future<T> Function() dioRequest) async {
    try {
      return await dioRequest();
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      rethrow;
    }
  }

  // **************************************************************************
  // Helpers Functions
  // **************************************************************************

  Future<Credentials> _refreshToken(
    String bearerRefreshToken,
  ) async {
    final refreshDio = Dio();
    _configDio(refreshDio, addTokenInterceptor: false);

    final response = await refreshDio.get(
      '/auth/refresh-token',
      options: Options(headers: {'Authorization': bearerRefreshToken}),
    );
    return Credentials.fromJson(response.data);
  }

  Future<Response<dynamic>> _retryRequest(RequestOptions options) {
    final retryDio = Dio();
    _configDio(retryDio, addTokenInterceptor: false);
    return retryDio.fetch(options);
  }

  // **************************************************************************
  // Network Interceptors
  // **************************************************************************

  get _tokenInterceptor => QueuedInterceptorsWrapper(
        onRequest: (options, handler) async {
          handler.next(
            options
              ..headers['Authorization'] =
                  options.path.contains("push-notification/token")
                      ? database.credentials?.bearerRefreshToken
                      : database.credentials?.bearerAccessToken,
          );
        },
        onError: (e, handler) async {
          try {
            if (e.response?.statusCode == 401 && database.credentials != null) {
              if (database.credentials!.hasAccessTokenExpired) {
                final updatedToken = await _refreshToken(
                    database.credentials!.bearerRefreshToken);
                await database.setCredentials(updatedToken);
              }

              e.requestOptions.headers['Authorization'] =
                  database.credentials!.bearerAccessToken;

              final response = await _retryRequest(e.requestOptions);

              return handler.resolve(response);
            }
            handler.next(e);
          } on DioException catch (e) {
            handler.next(e);
          } catch (e) {
            rethrow;
          }
        },
      );

  get _debugLogInterceptor => InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint('👉 ${options.uri}');
          handler.next(options);
        },
        onResponse: (e, handler) {
          debugPrint('👍 ${e.statusCode}');
          handler.next(e);
        },
        onError: (e, handler) {
          debugPrint(
              '👎 ${e.response?.statusCode} : ${e.response?.statusMessage}');
          handler.next(e);
        },
      );

  // **************************************************************************
  // Dio Error Handler
  // **************************************************************************

  _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return NetworkException.connectionTimeout;
      case DioExceptionType.sendTimeout:
        return NetworkException.sendTimeout;
      case DioExceptionType.receiveTimeout:
        return NetworkException.receiveTimeout;
      case DioExceptionType.badCertificate:
        return NetworkException.badCertificate;
      case DioExceptionType.badResponse:
        return NetworkException.badResponse(
          e.response!.statusCode!,
          e.response!.data['message'],
        );
      case DioExceptionType.cancel:
        return NetworkException.cancel;
      case DioExceptionType.connectionError:
        return NetworkException.connectionError;
      case DioExceptionType.unknown:
        if (e.error is SocketException) {
          return NetworkException.noInternet;
        }
        return NetworkException.unknown;
    }
  }
}
