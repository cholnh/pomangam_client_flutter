// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_story.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreStory _$StoreStoryFromJson(Map<String, dynamic> json) {
  return StoreStory(
    title: json['title'] as String,
    images: (json['images'] as List)?.map((e) => e as String)?.toList(),
    sequence: json['sequence'] as int,
  )
    ..idx = json['idx'] as int
    ..registerDate = json['registerDate'] == null
        ? null
        : DateTime.parse(json['registerDate'] as String)
    ..modifyDate = json['modifyDate'] == null
        ? null
        : DateTime.parse(json['modifyDate'] as String);
}

Map<String, dynamic> _$StoreStoryToJson(StoreStory instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'registerDate': instance.registerDate?.toIso8601String(),
      'modifyDate': instance.modifyDate?.toIso8601String(),
      'title': instance.title,
      'images': instance.images,
      'sequence': instance.sequence,
    };
