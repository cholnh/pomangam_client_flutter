// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    idx: json['idx'] as int,
    registerDate: json['registerDate'] == null
        ? null
        : DateTime.parse(json['registerDate'] as String),
    modifyDate: json['modifyDate'] == null
        ? null
        : DateTime.parse(json['modifyDate'] as String),
    idxStore: json['idxStore'] as int,
    salePrice: json['salePrice'] as int,
    productInfo: json['productInfo'] == null
        ? null
        : ProductInfo.fromJson(json['productInfo'] as Map<String, dynamic>),
    productCategoryTitle: json['productCategoryTitle'] as String,
    cntLike: json['cntLike'] as int,
    cntReply: json['cntReply'] as int,
    sequence: json['sequence'] as int,
    productImageMainPath: json['productImageMainPath'] as String,
    productImageSubPaths: (json['productImageSubPaths'] as List)
        ?.map((e) => e as String)
        ?.toList(),
    isLike: json['isLike'] as bool,
    replies: (json['replies'] as List)
        ?.map((e) =>
            e == null ? null : ProductReply.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    productSubCategories: (json['productSubCategories'] as List)
        ?.map((e) => e == null
            ? null
            : ProductSubCategory.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    productType:
        _$enumDecodeNullable(_$ProductTypeEnumMap, json['productType']),
    isTempActive: json['isTempActive'] as bool,
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'idx': instance.idx,
      'registerDate': instance.registerDate?.toIso8601String(),
      'modifyDate': instance.modifyDate?.toIso8601String(),
      'idxStore': instance.idxStore,
      'salePrice': instance.salePrice,
      'productInfo': instance.productInfo?.toJson(),
      'productCategoryTitle': instance.productCategoryTitle,
      'cntLike': instance.cntLike,
      'cntReply': instance.cntReply,
      'sequence': instance.sequence,
      'productImageMainPath': instance.productImageMainPath,
      'productImageSubPaths': instance.productImageSubPaths,
      'isLike': instance.isLike,
      'replies': instance.replies?.map((e) => e?.toJson())?.toList(),
      'productSubCategories':
          instance.productSubCategories?.map((e) => e?.toJson())?.toList(),
      'productType': _$ProductTypeEnumMap[instance.productType],
      'isTempActive': instance.isTempActive,
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
