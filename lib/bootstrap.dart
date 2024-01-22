import 'package:flutter/material.dart';
import 'package:saro/app/app.dart';
import 'package:saro/core/di/dependency_injection.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const App());
  // runApp(DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (context) => const App(),
  // ),);
}
