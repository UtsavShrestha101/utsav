import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'credentials.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class Credentials {
  
  @HiveField(1)
  final String accessToken;

  @HiveField(2)
  final String refreshToken;

  @HiveField(3)
  final int accessTokenExpiry;

  @HiveField(4)
  final int? refreshTokenExpiry;

  Credentials(
    this.accessToken,
    this.refreshToken,
    this.accessTokenExpiry,
    this.refreshTokenExpiry,
  );

  factory Credentials.fromJson(Map<String, dynamic> json) =>
      _$CredentialsFromJson(json);

  Map<String, dynamic> get toJson => _$CredentialsToJson(this);

  String get bearerAccessToken => 'Bearer $accessToken';

  String get bearerRefreshToken => 'Bearer $refreshToken';

  bool get hasAccessTokenExpired =>
      DateTime.fromMillisecondsSinceEpoch(accessTokenExpiry)
          .isBefore(DateTime.now());
}
