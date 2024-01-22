import 'package:hive_flutter/hive_flutter.dart';
part 'dark_mode.g.dart';

@HiveType(typeId: 4)
enum AppThemeState {
  @HiveField(0)
  light,

  @HiveField(1)
  dark
}
