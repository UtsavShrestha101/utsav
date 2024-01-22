import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'dependency_injection.config.dart';

final get = GetIt.instance;

@InjectableInit()
Future<GetIt> configureDependencies() => get.init();

@module
abstract class RegisterModule {
  @singleton
  Dio get dio => Dio();

  @singleton
  FlutterSecureStorage get flutterSecureStorage => const FlutterSecureStorage();

  @singleton
  ImagePicker get imagePicker => ImagePicker();
}
 