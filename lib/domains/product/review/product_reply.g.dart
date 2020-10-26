// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_reply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductReply _$ProductReplyFromJson(Map<String, dynamic> json) {
  return ProductReply(
    idx: json['idx'] as int,
    registerDate: json['registerDate'] == null
        ? null
        : DateTime.parse(json['registerDate'] as String),
    modifyDate: json['modifyDate'] == null
        ? null
        : DateTime.parse(json['modifyDate'] as String),
    idxUser: json['idxUser'] as int,
    idxProduct: json['idxProduct'] as int,
    isAnonymous: json['isAnonymous'] as bool,
    contents: json['contents'] as String,
    nickname: json['nickname'] as String,
    isOwn: json['isOwn'] as bool,
    cntLike: json['cntLike'] as int,
    isLike: json['isLike'] as bool,
  );
}

Map<String, dynamic> _$ProductReplyToJson(ProductReply instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'registerDate': instance.registerDate?.toIso8601String(),
      'modifyDate': instance.modifyDate?.toIso8601String(),
      'idxUser': instance.idxUser,
      'idxProduct': instance.idxProduct,
      'isAnonymous': instance.isAnonymous,
      'contents': instance.contents,
      'nickname': instance.nickname,
      'isOwn': instance.isOwn,
      'cntLike': instance.cntLike,
      'isLike': instance.isLike,
    };
