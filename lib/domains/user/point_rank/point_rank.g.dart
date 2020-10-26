// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_rank.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointRank _$PointRankFromJson(Map<String, dynamic> json) {
  return PointRank(
    idx: json['idx'] as int,
    registerDate: json['registerDate'] == null
        ? null
        : DateTime.parse(json['registerDate'] as String),
    modifyDate: json['modifyDate'] == null
        ? null
        : DateTime.parse(json['modifyDate'] as String),
    level: json['level'] as int,
    title: json['title'] as String,
    nextLowerLimitOrderCount: json['nextLowerLimitOrderCount'] as int,
    nextLowerLimitRecommendCount: json['nextLowerLimitRecommendCount'] as int,
    rewardCouponPrice: json['rewardCouponPrice'] as int,
    percentSavePoint: json['percentSavePoint'] as int,
    priceSavePoint: json['priceSavePoint'] as int,
    userOrderCount: json['userOrderCount'] as int,
    userRecommendCount: json['userRecommendCount'] as int,
  );
}

Map<String, dynamic> _$PointRankToJson(PointRank instance) => <String, dynamic>{
      'idx': instance.idx,
      'registerDate': instance.registerDate?.toIso8601String(),
      'modifyDate': instance.modifyDate?.toIso8601String(),
      'level': instance.level,
      'title': instance.title,
      'nextLowerLimitOrderCount': instance.nextLowerLimitOrderCount,
      'nextLowerLimitRecommendCount': instance.nextLowerLimitRecommendCount,
      'rewardCouponPrice': instance.rewardCouponPrice,
      'percentSavePoint': instance.percentSavePoint,
      'priceSavePoint': instance.priceSavePoint,
      'userOrderCount': instance.userOrderCount,
      'userRecommendCount': instance.userRecommendCount,
    };
