// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faq_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaqCategory _$FaqCategoryFromJson(Map<String, dynamic> json) {
  return FaqCategory(
    idx: json['idx'] as int,
    registerDate: json['registerDate'] == null
        ? null
        : DateTime.parse(json['registerDate'] as String),
    modifyDate: json['modifyDate'] == null
        ? null
        : DateTime.parse(json['modifyDate'] as String),
    title: json['title'] as String,
    faqs: (json['faqs'] as List)
        ?.map((e) => e == null ? null : Faq.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$FaqCategoryToJson(FaqCategory instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'registerDate': instance.registerDate?.toIso8601String(),
      'modifyDate': instance.modifyDate?.toIso8601String(),
      'title': instance.title,
      'faqs': instance.faqs?.map((e) => e?.toJson())?.toList(),
    };
