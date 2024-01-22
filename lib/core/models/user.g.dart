// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 2;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      fields[0] as String,
      fields[14] as String?,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as bool,
      fields[5] as int,
      fields[6] as int,
      fields[7] as int,
      fields[9] as int,
      fields[10] as int,
      fields[11] as int,
      fields[12] as int?,
      fields[13] as double?,
      (fields[15] as List?)?.cast<CreditCard>(),
      fields[18] as bool,
      fields[17] as bool?,
      fields[16] as double?,
      fields[19] as bool?,
      fields[20] == null
          ? []
          : (fields[20] as List?)?.cast<SpotifySearchedTrack>(),
      fields[21] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(21)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.username)
      ..writeByte(3)
      ..write(obj.role)
      ..writeByte(4)
      ..write(obj.isEmailVerified)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.updatedAt)
      ..writeByte(7)
      ..write(obj.bestiesCount)
      ..writeByte(9)
      ..write(obj.lurkersCount)
      ..writeByte(10)
      ..write(obj.likesCount)
      ..writeByte(11)
      ..write(obj.hatersCount)
      ..writeByte(12)
      ..write(obj.notificationCount)
      ..writeByte(13)
      ..write(obj.amount)
      ..writeByte(14)
      ..write(obj.avatar)
      ..writeByte(15)
      ..write(obj.cards)
      ..writeByte(16)
      ..write(obj.premiumCharge)
      ..writeByte(17)
      ..write(obj.isSpotifyConnected)
      ..writeByte(18)
      ..write(obj.isIdentityVerified)
      ..writeByte(19)
      ..write(obj.isFollowing)
      ..writeByte(20)
      ..write(obj.tracks)
      ..writeByte(21)
      ..write(obj.roomId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CreditCardAdapter extends TypeAdapter<CreditCard> {
  @override
  final int typeId = 3;

  @override
  CreditCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CreditCard(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] as String,
      fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CreditCard obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.last4)
      ..writeByte(2)
      ..write(obj.exp_month)
      ..writeByte(3)
      ..write(obj.exp_year)
      ..writeByte(4)
      ..write(obj.brand)
      ..writeByte(5)
      ..write(obj.countryCode)
      ..writeByte(6)
      ..write(obj.isPrimary);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreditCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['id'] as String,
      json['avatar'] as String?,
      json['email'] as String,
      json['username'] as String,
      json['role'] as String,
      json['isEmailVerified'] as bool,
      json['createdAt'] as int,
      json['updatedAt'] as int,
      json['bestiesCount'] as int,
      json['lurkersCount'] as int,
      json['likesCount'] as int,
      json['hatersCount'] as int,
      json['notificationCount'] as int?,
      (json['amount'] as num?)?.toDouble(),
      (json['cards'] as List<dynamic>?)
          ?.map((e) => CreditCard.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['isIdentityVerified'] as bool,
      json['isSpotifyConnected'] as bool?,
      (json['premiumCharge'] as num?)?.toDouble(),
      json['isFollowing'] as bool?,
      (json['tracks'] as List<dynamic>?)
              ?.map((e) =>
                  SpotifySearchedTrack.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      json['roomId'] as String? ?? '',
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'username': instance.username,
      'role': instance.role,
      'isEmailVerified': instance.isEmailVerified,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'bestiesCount': instance.bestiesCount,
      'lurkersCount': instance.lurkersCount,
      'likesCount': instance.likesCount,
      'hatersCount': instance.hatersCount,
      'notificationCount': instance.notificationCount,
      'amount': instance.amount,
      'avatar': instance.avatar,
      'cards': instance.cards,
      'premiumCharge': instance.premiumCharge,
      'isSpotifyConnected': instance.isSpotifyConnected,
      'isIdentityVerified': instance.isIdentityVerified,
      'isFollowing': instance.isFollowing,
      'tracks': instance.tracks,
      'roomId': instance.roomId,
    };

CreditCard _$CreditCardFromJson(Map<String, dynamic> json) => CreditCard(
      json['id'] as String,
      json['last4'] as String,
      json['exp_month'] as String,
      json['exp_year'] as String,
      json['brand'] as String,
      json['countryCode'] as String,
      json['isPrimary'] as bool,
    );

Map<String, dynamic> _$CreditCardToJson(CreditCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'last4': instance.last4,
      'exp_month': instance.exp_month,
      'exp_year': instance.exp_year,
      'brand': instance.brand,
      'countryCode': instance.countryCode,
      'isPrimary': instance.isPrimary,
    };
