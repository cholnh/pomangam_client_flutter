// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_sub_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductSubInfo _$ProductSubInfoFromJson(Map<String, dynamic> json) {
  return ProductSubInfo(
    name: json['name'] as String,
    description: json['description'] as String,
    subDescription: json['subDescription'] as String,
  );
}

Map<String, dynamic> _$ProductSubInfoToJson(ProductSubInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'subDescription': instance.subDescription,
    };
