// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreSummary _$StoreSummaryFromJson(Map<String, dynamic> json) {
  return StoreSummary(
    idx: json['idx'] as int,
    name: json['name'] as String,
    description: json['description'] as String,
    subDescription: json['subDescription'] as String,
    productionInfo: json['productionInfo'] == null
        ? null
        : ProductionInfo.fromJson(
            json['productionInfo'] as Map<String, dynamic>),
    quantityOrderable: json['quantityOrderable'] as int,
    storeSchedule: json['storeSchedule'] == null
        ? null
        : StoreSchedule.fromJson(json['storeSchedule'] as Map<String, dynamic>),
    avgStar: (json['avgStar'] as num)?.toDouble(),
    cntLike: json['cntLike'] as int,
    cntReview: json['cntReview'] as int,
    cntOrder: json['cntOrder'] as int,
    sequence: json['sequence'] as int,
    brandImagePath: json['brandImagePath'] as String,
    storeImageMainPath: json['storeImageMainPath'] as String,
    storeImageSubPaths:
        (json['storeImageSubPaths'] as List)?.map((e) => e as String)?.toList(),
    promotionType: json['promotionType'] as int,
    promotionValue: json['promotionValue'] as int,
    couponType: json['couponType'] as int,
    couponValue: json['couponValue'] as int,
    modifyDate: json['modifyDate'] == null
        ? null
        : DateTime.parse(json['modifyDate'] as String),
  );
}

Map<String, dynamic> _$StoreSummaryToJson(StoreSummary instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'name': instance.name,
      'description': instance.description,
      'subDescription': instance.subDescription,
      'productionInfo': instance.productionInfo?.toJson(),
      'quantityOrderable': instance.quantityOrderable,
      'storeSchedule': instance.storeSchedule?.toJson(),
      'avgStar': instance.avgStar,
      'cntLike': instance.cntLike,
      'cntReview': instance.cntReview,
      'cntOrder': instance.cntOrder,
      'sequence': instance.sequence,
      'brandImagePath': instance.brandImagePath,
      'storeImageMainPath': instance.storeImageMainPath,
      'storeImageSubPaths': instance.storeImageSubPaths,
      'promotionType': instance.promotionType,
      'promotionValue': instance.promotionValue,
      'couponType': instance.couponType,
      'couponValue': instance.couponValue,
      'modifyDate': instance.modifyDate?.toIso8601String(),
    };
