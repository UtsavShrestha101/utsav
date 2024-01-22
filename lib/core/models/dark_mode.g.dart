// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dark_mode.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppThemeStateAdapter extends TypeAdapter<AppThemeState> {
  @override
  final int typeId = 4;

  @override
  AppThemeState read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return AppThemeState.light;
      case 1:
        return AppThemeState.dark;
      default:
        return AppThemeState.light;
    }
  }

  @override
  void write(BinaryWriter writer, AppThemeState obj) {
    switch (obj) {
      case AppThemeState.light:
        writer.writeByte(0);
        break;
      case AppThemeState.dark:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppThemeStateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
