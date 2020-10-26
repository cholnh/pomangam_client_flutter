// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreInfo _$StoreInfoFromJson(Map<String, dynamic> json) {
  return StoreInfo(
    name: json['name'] as String,
    description: json['description'] as String,
    subDescription: json['subDescription'] as String,
    ownerName: json['ownerName'] as String,
    companyName: json['companyName'] as String,
    companyLocation: json['companyLocation'] as String,
    companyPhoneNumber: json['companyPhoneNumber'] as String,
  );
}

Map<String, dynamic> _$StoreInfoToJson(StoreInfo instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'subDescription': instance.subDescription,
      'ownerName': instance.ownerName,
      'companyName': instance.companyName,
      'companyLocation': instance.companyLocation,
      'companyPhoneNumber': instance.companyPhoneNumber,
    };
