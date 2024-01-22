// ignore_for_file: constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
part 'peer.g.dart';

@JsonSerializable()
class Peer {
  final String id;
  final String username;
  final FollowType type;
  final bool isIdentityVerified;
  final String? avatar;

  Peer(this.id, this.username, this.isIdentityVerified, this.type, this.avatar);

  factory Peer.fromJson(Map<String, dynamic> json) => _$PeerFromJson(json);

  Map<String, dynamic> get toJson => _$PeerToJson(this);
}

enum FollowType {
  @JsonValue("FREE")
  FREE,
  @JsonValue("PAID")
  PAID,
}
