// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_sub_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductSubCategory _$ProductSubCategoryFromJson(Map<String, dynamic> json) {
  return ProductSubCategory(
    categoryTitle: json['categoryTitle'] as String,
    productSubs: (json['productSubs'] as List)
        ?.map((e) =>
            e == null ? null : ProductSub.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    productSubType:
        _$enumDecodeNullable(_$ProductSubTypeEnumMap, json['productSubType']),
  )
    ..idx = json['idx'] as int
    ..registerDate = json['registerDate'] == null
        ? null
        : DateTime.parse(json['registerDate'] as String)
    ..modifyDate = json['modifyDate'] == null
        ? null
        : DateTime.parse(json['modifyDate'] as String);
}

Map<String, dynamic> _$ProductSubCategoryToJson(ProductSubCategory instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'registerDate': instance.registerDate?.toIso8601String(),
      'modifyDate': instance.modifyDate?.toIso8601String(),
      'categoryTitle': instance.categoryTitle,
      'productSubs': instance.productSubs?.map((e) => e?.toJson())?.toList(),
      'productSubType': _$ProductSubTypeEnumMap[instance.productSubType],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$ProductSubTypeEnumMap = {
  ProductSubType.CHECKBOX: 'CHECKBOX',
  ProductSubType.RADIO: 'RADIO',
  ProductSubType.NUMBER: 'NUMBER',
  ProductSubType.READONLY: 'READONLY',
  ProductSubType.CUSTOMIZING_SUB: 'CUSTOMIZING_SUB',
};
