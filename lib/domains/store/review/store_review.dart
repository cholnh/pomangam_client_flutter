import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client_flutter/domains/_bases/entity_auditing.dart';

part 'store_review.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class StoreReview extends EntityAuditing {

  int idxStore;

  bool isAnonymous;

  String title;

  String contents;

  double star;

  int cntLike;

  String nickname;

  bool isOwn;

  bool isLike;

  String storeReviewImageMainPath;

  List<String> storeReviewImageSubPaths;

  String productName;

  String ownerReply;

  DateTime ownerReplyModifyDate;

  StoreReview({
    int idx, DateTime registerDate, DateTime modifyDate,
    this.idxStore,
    this.isAnonymous,
    this.title,
    this.contents,
    this.star,
    this.cntLike,
    this.nickname,
    this.isOwn,
    this.isLike,
    this.storeReviewImageMainPath,
    this.storeReviewImageSubPaths,
    this.productName,
    this.ownerReply,
    this.ownerReplyModifyDate
  }): super(idx: idx, registerDate: registerDate, modifyDate: modifyDate);

  factory StoreReview.fromJson(Map<String, dynamic> json) => _$StoreReviewFromJson(json);
  Map<String, dynamic> toJson() => _$StoreReviewToJson(this);
  static List<StoreReview> fromJsonList(List<dynamic> jsonList) {
    List<StoreReview> entities = [];
    jsonList.forEach((map) => entities.add(StoreReview.fromJson(map)));
    return entities;
  }
}