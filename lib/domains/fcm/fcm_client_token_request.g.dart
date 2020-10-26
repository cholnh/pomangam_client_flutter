// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fcm_client_token_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FcmClientTokenRequest _$FcmClientTokenRequestFromJson(
    Map<String, dynamic> json) {
  return FcmClientTokenRequest(
    idx: json['idx'] as int,
    registerDate: json['registerDate'] == null
        ? null
        : DateTime.parse(json['registerDate'] as String),
    modifyDate: json['modifyDate'] == null
        ? null
        : DateTime.parse(json['modifyDate'] as String),
    token: json['token'] as String,
    phoneNumber: json['phoneNumber'] as String,
  );
}

Map<String, dynamic> _$FcmClientTokenRequestToJson(
        FcmClientTokenRequest instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'registerDate': instance.registerDate?.toIso8601String(),
      'modifyDate': instance.modifyDate?.toIso8601String(),
      'token': instance.token,
      'phoneNumber': instance.phoneNumber,
    };
