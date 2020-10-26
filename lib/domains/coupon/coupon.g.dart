// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coupon _$CouponFromJson(Map<String, dynamic> json) {
  return Coupon(
    isUsed: json['isUsed'] as bool,
    discountCost: json['discountCost'] as int,
    title: json['title'] as String,
    code: json['code'] as String,
    idxUser: json['idxUser'] as int,
    beginDate: json['beginDate'] == null
        ? null
        : DateTime.parse(json['beginDate'] as String),
    endDate: json['endDate'] == null
        ? null
        : DateTime.parse(json['endDate'] as String),
  )
    ..idx = json['idx'] as int
    ..registerDate = json['registerDate'] == null
        ? null
        : DateTime.parse(json['registerDate'] as String)
    ..modifyDate = json['modifyDate'] == null
        ? null
        : DateTime.parse(json['modifyDate'] as String);
}

Map<String, dynamic> _$CouponToJson(Coupon instance) => <String, dynamic>{
      'idx': instance.idx,
      'registerDate': instance.registerDate?.toIso8601String(),
      'modifyDate': instance.modifyDate?.toIso8601String(),
      'isUsed': instance.isUsed,
      'discountCost': instance.discountCost,
      'title': instance.title,
      'code': instance.code,
      'idxUser': instance.idxUser,
      'beginDate': instance.beginDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
    };
