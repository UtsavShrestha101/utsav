// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserNotification _$UserNotificationFromJson(Map<String, dynamic> json) =>
    UserNotification(
      json['transaction'] == null
          ? null
          : Transaction.fromJson(json['transaction'] as Map<String, dynamic>),
      id: json['id'] as String,
      type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
      read: json['read'] as bool,
      sender: Sender.fromJson(json['sender'] as Map<String, dynamic>),
      post: json['post'] as String?,
      createdAt: json['createdAt'] as int,
      updatedAt: json['updatedAt'] as int,
    );

Map<String, dynamic> _$UserNotificationToJson(UserNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$NotificationTypeEnumMap[instance.type]!,
      'read': instance.read,
      'post': instance.post,
      'transaction': instance.transaction,
      'sender': instance.sender,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

const _$NotificationTypeEnumMap = {
  NotificationType.LIKE_POST: 'LIKEPOST',
  NotificationType.DISLIKE_POST: 'DISLIKEPOST',
  NotificationType.REMOVE_LIKE_POST: 'REMOVELIKEPOST',
  NotificationType.REMOVE_DISLIKE_POST: 'REMOVEDISLIKEPOST',
  NotificationType.TAG_POST: 'TAGPOST',
  NotificationType.REPORT_POST: 'REPORTPOST',
  NotificationType.FOLLOW: 'FOLLOW',
  NotificationType.PAID_FOLLOW: 'PAIDFOLLOW',
  NotificationType.UNFOLLOW: 'UNFOLLOW',
  NotificationType.REPORT_USER: 'REPORTUSER',
  NotificationType.CREDIT: 'CREDIT',
  NotificationType.DEBIT: 'DEBIT',
  NotificationType.WITHDRAW: 'WITHDRAW',
  NotificationType.SCREENSHOTPOST: 'SCREENSHOTPOST',
  NotificationType.SCREENSHOTPROFILE: 'SCREENSHOTPROFILE',
};

Sender _$SenderFromJson(Map<String, dynamic> json) => Sender(
      id: json['id'] as String,
      username: json['username'] as String,
      avatar: json['avatar'] as String?,
      isIdentityVerified: json['isIdentityVerified'] as bool,
    );

Map<String, dynamic> _$SenderToJson(Sender instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'avatar': instance.avatar,
      'isIdentityVerified': instance.isIdentityVerified,
    };

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      amount: (json['amount'] as num).toDouble(),
      fee: (json['fee'] as num).toDouble(),
      service: (json['service'] as num).toDouble(),
      rate: json['rate'],
      originalCurrency: json['originalCurrency'] as String,
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'fee': instance.fee,
      'service': instance.service,
      'rate': instance.rate,
      'originalCurrency': instance.originalCurrency,
    };
