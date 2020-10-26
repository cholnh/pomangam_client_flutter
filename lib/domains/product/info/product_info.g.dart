// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductInfo _$ProductInfoFromJson(Map<String, dynamic> json) {
  return ProductInfo(
    name: json['name'] as String,
    description: json['description'] as String,
    subDescription: json['subDescription'] as String,
  );
}

Map<String, dynamic> _$ProductInfoToJson(ProductInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'subDescription': instance.subDescription,
    };
