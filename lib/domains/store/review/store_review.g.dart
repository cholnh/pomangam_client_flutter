// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreReview _$StoreReviewFromJson(Map<String, dynamic> json) {
  return StoreReview(
    idx: json['idx'] as int,
    registerDate: json['registerDate'] == null
        ? null
        : DateTime.parse(json['registerDate'] as String),
    modifyDate: json['modifyDate'] == null
        ? null
        : DateTime.parse(json['modifyDate'] as String),
    idxStore: json['idxStore'] as int,
    isAnonymous: json['isAnonymous'] as bool,
    title: json['title'] as String,
    contents: json['contents'] as String,
    star: (json['star'] as num)?.toDouble(),
    cntLike: json['cntLike'] as int,
    nickname: json['nickname'] as String,
    isOwn: json['isOwn'] as bool,
    isLike: json['isLike'] as bool,
    storeReviewImageMainPath: json['storeReviewImageMainPath'] as String,
    storeReviewImageSubPaths: (json['storeReviewImageSubPaths'] as List)
        ?.map((e) => e as String)
        ?.toList(),
    productName: json['productName'] as String,
    ownerReply: json['ownerReply'] as String,
    ownerReplyModifyDate: json['ownerReplyModifyDate'] == null
        ? null
        : DateTime.parse(json['ownerReplyModifyDate'] as String),
  );
}

Map<String, dynamic> _$StoreReviewToJson(StoreReview instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'registerDate': instance.registerDate?.toIso8601String(),
      'modifyDate': instance.modifyDate?.toIso8601String(),
      'idxStore': instance.idxStore,
      'isAnonymous': instance.isAnonymous,
      'title': instance.title,
      'contents': instance.contents,
      'star': instance.star,
      'cntLike': instance.cntLike,
      'nickname': instance.nickname,
      'isOwn': instance.isOwn,
      'isLike': instance.isLike,
      'storeReviewImageMainPath': instance.storeReviewImageMainPath,
      'storeReviewImageSubPaths': instance.storeReviewImageSubPaths,
      'productName': instance.productName,
      'ownerReply': instance.ownerReply,
      'ownerReplyModifyDate': instance.ownerReplyModifyDate?.toIso8601String(),
    };
