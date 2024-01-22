// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'peer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Peer _$PeerFromJson(Map<String, dynamic> json) => Peer(
      json['id'] as String,
      json['username'] as String,
      json['isIdentityVerified'] as bool,
      $enumDecode(_$FollowTypeEnumMap, json['type']),
      json['avatar'] as String?,
    );

Map<String, dynamic> _$PeerToJson(Peer instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'type': _$FollowTypeEnumMap[instance.type]!,
      'isIdentityVerified': instance.isIdentityVerified,
      'avatar': instance.avatar,
    };

const _$FollowTypeEnumMap = {
  FollowType.FREE: 'FREE',
  FollowType.PAID: 'PAID',
};
