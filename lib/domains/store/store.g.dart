// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Store _$StoreFromJson(Map<String, dynamic> json) {
  return Store(
    idx: json['idx'] as int,
    registerDate: json['registerDate'] == null
        ? null
        : DateTime.parse(json['registerDate'] as String),
    modifyDate: json['modifyDate'] == null
        ? null
        : DateTime.parse(json['modifyDate'] as String),
    storeInfo: json['storeInfo'] == null
        ? null
        : StoreInfo.fromJson(json['storeInfo'] as Map<String, dynamic>),
    productionInfo: json['productionInfo'] == null
        ? null
        : ProductionInfo.fromJson(
            json['productionInfo'] as Map<String, dynamic>),
    storeSchedule: json['storeSchedule'] == null
        ? null
        : StoreSchedule.fromJson(json['storeSchedule'] as Map<String, dynamic>),
    avgStar: (json['avgStar'] as num)?.toDouble(),
    cntLike: json['cntLike'] as int,
    cntComment: json['cntComment'] as int,
    cntOrder: json['cntOrder'] as int,
    sequence: json['sequence'] as int,
    brandImagePath: json['brandImagePath'] as String,
    storeImageMainPath: json['storeImageMainPath'] as String,
    storeImageSubPaths:
        (json['storeImageSubPaths'] as List)?.map((e) => e as String)?.toList(),
    productCategories: (json['productCategories'] as List)
        ?.map((e) => e == null
            ? null
            : ProductCategory.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    stories: (json['stories'] as List)
        ?.map((e) =>
            e == null ? null : StoreStory.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    isLike: json['isLike'] as bool,
  )
    ..storeCategory = json['storeCategory'] as String;
}

Map<String, dynamic> _$StoreToJson(Store instance) => <String, dynamic>{
      'idx': instance.idx,
      'registerDate': instance.registerDate?.toIso8601String(),
      'modifyDate': instance.modifyDate?.toIso8601String(),
      'storeCategory': instance.storeCategory,
      'storeInfo': instance.storeInfo?.toJson(),
      'productionInfo': instance.productionInfo?.toJson(),
      'storeSchedule': instance.storeSchedule?.toJson(),
      'avgStar': instance.avgStar,
      'cntLike': instance.cntLike,
      'cntComment': instance.cntComment,
      'cntOrder': instance.cntOrder,
      'sequence': instance.sequence,
      'brandImagePath': instance.brandImagePath,
      'storeImageMainPath': instance.storeImageMainPath,
      'storeImageSubPaths': instance.storeImageSubPaths,
      'productCategories':
          instance.productCategories?.map((e) => e?.toJson())?.toList(),
      'stories': instance.stories?.map((e) => e?.toJson())?.toList(),
      'isLike': instance.isLike,
    };
