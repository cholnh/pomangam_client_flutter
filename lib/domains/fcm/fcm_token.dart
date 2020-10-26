import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client_flutter/domains/_bases/entity_auditing.dart';

part 'fcm_token.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class FcmToken extends EntityAuditing {

 String token;

  FcmToken({
    int idx, DateTime registerDate, DateTime modifyDate,
    this.token
  }): super(idx: idx, registerDate: registerDate, modifyDate: modifyDate);

  Map<String, dynamic> toJson() => _$FcmTokenToJson(this);
  factory FcmToken.fromJson(Map<String, dynamic> json) => _$FcmTokenFromJson(json);
  static List<FcmToken> fromJsonList(List<dynamic> jsonList) {
    List<FcmToken> entities = [];
    jsonList.forEach((map) => entities.add(FcmToken.fromJson(map)));
    return entities;
  }
}