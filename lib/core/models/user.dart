// ignore_for_file: non_constant_identifier_names

import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:saro/core/models/spotify_searched_track.dart';
part 'user.g.dart';

@JsonSerializable()
@HiveType(typeId: 2)
class User {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String username;

  @HiveField(3)
  final String role;

  @HiveField(4)
  final bool isEmailVerified;

  @HiveField(5)
  final int createdAt;

  @HiveField(6)
  final int updatedAt;

  @HiveField(7)
  final int bestiesCount;

  @HiveField(9)
  final int lurkersCount;

  @HiveField(10)
  final int likesCount;

  @HiveField(11)
  final int hatersCount;

  @HiveField(12)
  final int? notificationCount;

  @HiveField(13)
  final double? amount;

  @HiveField(14)
  final String? avatar;

  @HiveField(15)
  final List<CreditCard>? cards;

  @HiveField(16)
  final double? premiumCharge;

  @HiveField(17)
  final bool? isSpotifyConnected;

  @HiveField(18)
  final bool isIdentityVerified;

  @HiveField(19)
  bool? isFollowing;

  @JsonKey(defaultValue: <SpotifySearchedTrack>[])
  @HiveField(20, defaultValue: <SpotifySearchedTrack>[])
  final List<SpotifySearchedTrack>? tracks;

  @JsonKey(defaultValue: "")
  @HiveField(21)
  String? roomId;
  
  User(
    this.id,
    this.avatar,
    this.email,
    this.username,
    this.role,
    this.isEmailVerified,
    this.createdAt,
    this.updatedAt,
    this.bestiesCount,
    this.lurkersCount,
    this.likesCount,
    this.hatersCount,
    this.notificationCount,
    this.amount,
    this.cards,
    this.isIdentityVerified,
    this.isSpotifyConnected,
    this.premiumCharge,
    this.isFollowing,
    this.tracks,
    this.roomId,
  );

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> get toJson => _$UserToJson(this);

  User copyWith(
      {String? username,
      String? avatar,
      bool? isEmailVerified,
      bool? isSpotifyConnected}) {
    return User(
      id,
      avatar ?? this.avatar,
      email,
      username ?? this.username,
      role,
      isEmailVerified ?? this.isEmailVerified,
      createdAt,
      updatedAt,
      bestiesCount,
      lurkersCount,
      likesCount,
      hatersCount,
      notificationCount,
      amount,
      cards,
      isIdentityVerified,
      isSpotifyConnected ?? this.isSpotifyConnected,
      premiumCharge,
      isFollowing,
      tracks,
      roomId,
    );
  }
}

@JsonSerializable()
@HiveType(typeId: 3)
class CreditCard {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String last4;
  @HiveField(2)
  final String exp_month;
  @HiveField(3)
  final String exp_year;
  @HiveField(4)
  final String brand;
  @HiveField(5)
  final String countryCode;
  @HiveField(6)
  final bool isPrimary;

  factory CreditCard.fromJson(Map<String, dynamic> json) =>
      _$CreditCardFromJson(json);

  CreditCard(this.id, this.last4, this.exp_month, this.exp_year, this.brand,
      this.countryCode, this.isPrimary);

  Map<String, dynamic> get toJson => _$CreditCardToJson(this);
}
