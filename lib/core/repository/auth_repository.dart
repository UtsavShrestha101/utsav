import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/core/base/base_repository.dart';
import 'package:saro/core/models/credentials.dart';
import 'package:saro/core/models/user.dart';
import 'package:saro/core/router/app_router.dart';

@lazySingleton
class AuthRepository extends BaseRepository {
  AuthRepository(super.dio, super.database);

  Credentials? get credentials => database.credentials;

  static const _logInPath = '/auth/signin';
  static const _signUpPath = '/auth/signup';
  static const _forgotPasswordPath = '/auth/forgot-password';
  static const _resetPasswordPath = '/auth/reset-password';
  static const _availabilityPath = '/auth/availability';

//login
  Future<void> logIn(String email, String password) async {
    final (credentials, user) = await makeDioRequest<(Credentials, User)>(
      () async {
        final data = {"email": email, "password": password};
        final response = await dio.post(_logInPath, data: data);

        final credentials = Credentials.fromJson(response.data);
        final user = User.fromJson(response.data['user']);

        return (credentials, user);
      },
    );
    await database.setCredentials(credentials);
    await database.setCurrentUser(user);
  }

//Signin
  Future<void> signUp(
      String username, String email, String password, String dob) async {
    final (credentials, user) = await makeDioRequest<(Credentials, User)>(
      () async {
        final data = {
          "username": username,
          "email": email,
          "password": password,
          "dob": dob
        };

        final response = await dio.post(
          _signUpPath,
          data: data,
        );

        final credentials = Credentials.fromJson(response.data);
        final user = User.fromJson(response.data['user']);

        return (credentials, user);
      },
    );
    database.setCredentials(credentials);
    database.setCurrentUser(user);
  }

//username valid
  Future<bool> isAvailable({String? userName, String? email}) async {
    bool isAvailable = await makeDioRequest<bool>(() async {
      final queryData = {
        "username": userName,
        "email": email,
      };
      final response = await dio.post(
        _availabilityPath,
        queryParameters: queryData,
      );
      return response.data == "true";
    });
    return isAvailable;
  }

  //reset-password-otp
  Future<void> requestOtp(String email) async {
    await makeDioRequest<void>(() async {
      final data = {
        "email": email,
      };
      await dio.post(
        _forgotPasswordPath,
        data: data,
      );
    });
  }

  //verify-reset-otp
  Future<String?> verifyResetOTP(String email, String otp) async {
    final String token = await makeDioRequest<String>(() async {
      final data = {
        "email": email,
        "otp": otp,
      };
      Response response = await dio.post(
        _resetPasswordPath,
        data: data,
      );

      return response.data["token"];
    });
    return token;
  }

  //reset-password
  Future<void> resetPassword(String token, String password) async {
    await makeDioRequest<void>(() async {
      final data = {
        "token": token,
        "password": password,
      };
      await dio.patch(
        _resetPasswordPath,
        data: data,
      );
    });
  }


  Future<void> logOut() async {
    await database.clearCredentials();
    AppRouter.router.go(AppRouter.onboarding);
  }
}
