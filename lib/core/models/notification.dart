// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable()
class UserNotification {
  final String id;
  final NotificationType type;
  final bool read;
  final String? post;
  final Transaction? transaction;
  final Sender sender;
  final int createdAt;
  final int updatedAt;
  UserNotification(
    this.transaction, {
    required this.id,
    required this.type,
    required this.read,
    required this.sender,
    this.post,
    required this.createdAt,
    required this.updatedAt,
  });
  factory UserNotification.fromJson(Map<String, dynamic> json) =>
      _$UserNotificationFromJson(json);

  Map<String, dynamic> get toJson => _$UserNotificationToJson(this);
}

enum NotificationType {
  @JsonValue("LIKEPOST")
  LIKE_POST,
  @JsonValue("DISLIKEPOST")
  DISLIKE_POST,
  @JsonValue("REMOVELIKEPOST")
  REMOVE_LIKE_POST,
  @JsonValue("REMOVEDISLIKEPOST")
  REMOVE_DISLIKE_POST,
  @JsonValue("TAGPOST")
  TAG_POST,
  @JsonValue("REPORTPOST")
  REPORT_POST,
  @JsonValue("FOLLOW")
  FOLLOW,
  @JsonValue("PAIDFOLLOW")
  PAID_FOLLOW,
  @JsonValue("UNFOLLOW")
  UNFOLLOW,
  @JsonValue("REPORTUSER")
  REPORT_USER,
  @JsonValue("CREDIT")
  CREDIT,
  @JsonValue("DEBIT")
  DEBIT,
  @JsonValue("WITHDRAW")
  WITHDRAW,
  @JsonValue("SCREENSHOTPOST")
  SCREENSHOTPOST,
   @JsonValue("SCREENSHOTPROFILE")
  SCREENSHOTPROFILE,
}

@JsonSerializable()
class Sender {
  final String id;
  final String username;
  final String? avatar;
  final bool isIdentityVerified;

  Sender(
      {required this.id,
      required this.username,
      this.avatar,
      required this.isIdentityVerified});

  factory Sender.fromJson(Map<String, dynamic> json) => _$SenderFromJson(json);

  Map<String, dynamic> get toJson => _$SenderToJson(this);
}

@JsonSerializable()
class Transaction {
  final double amount;
  final double fee;
  final double service;
  final dynamic rate;
  final String originalCurrency;
  Transaction({
    required this.amount,
    required this.fee,
    required this.service,
    required this.rate,
    required this.originalCurrency,
  });

  double get netAmount => amount - fee - service;

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> get toJson => _$TransactionToJson(this);
}
