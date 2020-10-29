// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_sub.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductSub _$ProductSubFromJson(Map<String, dynamic> json) {
  return ProductSub(
    idxStore: json['idxStore'] as int,
    salePrice: json['salePrice'] as int,
    productSubInfo: json['productSubInfo'] == null
        ? null
        : ProductSubInfo.fromJson(
            json['productSubInfo'] as Map<String, dynamic>),
    sequence: json['sequence'] as int,
    productSubCategory: json['productSubCategory'] as String,
    numberMinimum: json['numberMinimum'] as int,
    numberMaximum: json['numberMaximum'] as int,
    productImageMainPath: json['productImageMainPath'] as String,
    productImageSubPaths: (json['productImageSubPaths'] as List)
        ?.map((e) => e as String)
        ?.toList(),
    isTempActive: json['isTempActive'] as bool,
  )
    ..idx = json['idx'] as int
    ..registerDate = json['registerDate'] == null
        ? null
        : DateTime.parse(json['registerDate'] as String)
    ..modifyDate = json['modifyDate'] == null
        ? null
        : DateTime.parse(json['modifyDate'] as String);
}

Map<String, dynamic> _$ProductSubToJson(ProductSub instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'registerDate': instance.registerDate?.toIso8601String(),
      'modifyDate': instance.modifyDate?.toIso8601String(),
      'idxStore': instance.idxStore,
      'salePrice': instance.salePrice,
      'productSubInfo': instance.productSubInfo?.toJson(),
      'sequence': instance.sequence,
      'productSubCategory': instance.productSubCategory,
      'numberMinimum': instance.numberMinimum,
      'numberMaximum': instance.numberMaximum,
      'productImageMainPath': instance.productImageMainPath,
      'productImageSubPaths': instance.productImageSubPaths,
      'isTempActive': instance.isTempActive,
    };
