// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateInput _$UpdateInputFromJson(Map<String, dynamic> json) {
  return UpdateInput(
    phoneNumber: json['phoneNumber'] as String,
    code: json['code'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$UpdateInputToJson(UpdateInput instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'code': instance.code,
      'password': instance.password,
    };
