import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client_flutter/domains/_bases/entity_auditing.dart';

part 'fcm_client_token_request.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class FcmClientTokenRequest extends EntityAuditing {

  String token;
  String phoneNumber;

  FcmClientTokenRequest({
    int idx, DateTime registerDate, DateTime modifyDate,
    this.token, this.phoneNumber
  }): super(idx: idx, registerDate: registerDate, modifyDate: modifyDate);

  Map<String, dynamic> toJson() => _$FcmClientTokenRequestToJson(this);
  factory FcmClientTokenRequest.fromJson(Map<String, dynamic> json) => _$FcmClientTokenRequestFromJson(json);
  static List<FcmClientTokenRequest> fromJsonList(List<dynamic> jsonList) {
    List<FcmClientTokenRequest> entities = [];
    jsonList.forEach((map) => entities.add(FcmClientTokenRequest.fromJson(map)));
    return entities;
  }

  @override
  String toString() {
    return 'FcmOwnerTokenRequest{token: $token, phoneNumber: $phoneNumber}';
  }
}