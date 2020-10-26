// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductSummary _$ProductSummaryFromJson(Map<String, dynamic> json) {
  return ProductSummary(
    idx: json['idx'] as int,
    salePrice: json['salePrice'] as int,
    name: json['name'] as String,
    productImageMainPath: json['productImageMainPath'] as String,
    productType:
        _$enumDecodeNullable(_$ProductTypeEnumMap, json['productType']),
  );
}

Map<String, dynamic> _$ProductSummaryToJson(ProductSummary instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'salePrice': instance.salePrice,
      'name': instance.name,
      'productImageMainPath': instance.productImageMainPath,
      'productType': _$ProductTypeEnumMap[instance.productType],
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

const _$ProductTypeEnumMap = {
  ProductType.NORMAL: 'NORMAL',
  ProductType.CUSTOMIZING_2: 'CUSTOMIZING_2',
  ProductType.CUSTOMIZING_3: 'CUSTOMIZING_3',
  ProductType.CUSTOMIZING_4: 'CUSTOMIZING_4',
  ProductType.CUSTOMIZING_5: 'CUSTOMIZING_5',
  ProductType.CUSTOMIZING_6: 'CUSTOMIZING_6',
};
