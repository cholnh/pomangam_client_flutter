// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Promotion _$PromotionFromJson(Map<String, dynamic> json) {
  return Promotion(
    discountCost: json['discountCost'] as int,
    title: json['title'] as String,
    contents: json['contents'] as String,
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

Map<String, dynamic> _$PromotionToJson(Promotion instance) => <String, dynamic>{
      'idx': instance.idx,
      'registerDate': instance.registerDate?.toIso8601String(),
      'modifyDate': instance.modifyDate?.toIso8601String(),
      'discountCost': instance.discountCost,
      'title': instance.title,
      'contents': instance.contents,
      'beginDate': instance.beginDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
    };
