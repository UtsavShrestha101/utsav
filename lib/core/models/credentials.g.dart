// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credentials.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CredentialsAdapter extends TypeAdapter<Credentials> {
  @override
  final int typeId = 1;

  @override
  Credentials read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Credentials(
      fields[1] as String,
      fields[2] as String,
      fields[3] as int,
      fields[4] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Credentials obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.accessToken)
      ..writeByte(2)
      ..write(obj.refreshToken)
      ..writeByte(3)
      ..write(obj.accessTokenExpiry)
      ..writeByte(4)
      ..write(obj.refreshTokenExpiry);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CredentialsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Credentials _$CredentialsFromJson(Map<String, dynamic> json) => Credentials(
      json['accessToken'] as String,
      json['refreshToken'] as String,
      json['accessTokenExpiry'] as int,
      json['refreshTokenExpiry'] as int?,
    );

Map<String, dynamic> _$CredentialsToJson(Credentials instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'accessTokenExpiry': instance.accessTokenExpiry,
      'refreshTokenExpiry': instance.refreshTokenExpiry,
    };
