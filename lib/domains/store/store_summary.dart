import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client_flutter/domains/store/info/production_info.dart';
import 'package:pomangam_client_flutter/domains/store/schedule/store_schedule.dart';
import 'package:pomangam_client_flutter/domains/store/store.dart';

part 'store_summary.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class StoreSummary {

  /// 업체 인덱스
  int idx;

  /// 업체명
  String name;

  /// 업체 설명
  String description;

  /// 업체 부가 설명
  String subDescription;

  /// 업체 생산량
  ProductionInfo productionInfo;

  /// 주문 가능 수량
  int quantityOrderable;

  /// 업체 영업 시간
  StoreSchedule storeSchedule;

  /// 평균 리뷰 평점
  double avgStar;

  /// 총 좋아요 개수
  int cntLike;

  /// 총 리뷰 개수
  int cntReview;

  /// 총 주문 개수
  int cntOrder;

  /// 순서
  int sequence;

  /// 브랜드(로고) 이미지 경로
  String brandImagePath;

  /// 업체 대표 이미지 경로
  String storeImageMainPath;

  /// 업체 서브 이미지 경로 리스트
  List<String> storeImageSubPaths;

  /// 프로모션 타입
  ///
  /// 0: 프로모션 미제공
  /// 1: 프로모션 제공 (단위: 원)
  /// 2: 프로모션 제공 (단위: %)
  int promotionType;

  /// 프로모션 할인가
  int promotionValue;

  /// 쿠폰 타입
  ///
  /// 0: 쿠폰 미제공
  /// 1: 쿠폰 제공 (단위: 원)
  int couponType;

  /// 쿠폰 제공가격
  int couponValue;

  DateTime modifyDate;

  StoreSummary({
    this.idx, this.name, this.description, this.subDescription,
    this.productionInfo, this.quantityOrderable, this.storeSchedule, this.avgStar,
    this.cntLike, this.cntReview, this.cntOrder, this.sequence, this.brandImagePath,
    this.storeImageMainPath, this.storeImageSubPaths, this.promotionType,
    this.promotionValue, this.couponType, this.couponValue, this.modifyDate
  });

  void copy(Store store) {
    this.idx = store.idx;
    this.name = store.storeInfo.name;
    this.description = store.storeInfo.description;
    this.subDescription = store.storeInfo.subDescription;
    this.productionInfo = store.productionInfo;
    this.storeSchedule = store.storeSchedule;
    this.avgStar = store.avgStar;
    this.cntLike = store.cntLike;
    this.cntReview = store.cntReview;
    this.sequence = store.sequence;
    this.brandImagePath = store.brandImagePath;
    this.storeImageMainPath = store.storeImageMainPath;
    this.storeImageSubPaths = store.storeImageSubPaths;
  }

  factory StoreSummary.fromJson(Map<String, dynamic> json) => _$StoreSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$StoreSummaryToJson(this);
  static List<StoreSummary> fromJsonList(List<dynamic> jsonList) {
    List<StoreSummary> entities = [];
    jsonList.forEach((map) => entities.add(StoreSummary.fromJson(map)));
    return entities;
  }

  bool isOrderable() {
    return quantityOrderable > 0;
  }

  bool isOpenTime() {
    return storeSchedule.isOpenTime();
  }

}