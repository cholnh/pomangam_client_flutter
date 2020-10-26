import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pomangam_client_flutter/_bases/network/api/api.dart';
import 'package:pomangam_client_flutter/domains/_bases/page_request.dart';
import 'package:pomangam_client_flutter/domains/store/review/store_review.dart';
import 'package:pomangam_client_flutter/domains/store/review/store_review_sort_type.dart';

class StoreReviewRepository {

  final Api api; // 서버 연결용

  StoreReviewRepository({this.api});

  Future<List<StoreReview>> findAll({
    @required int dIdx,
    @required int sIdx,
    @required StoreReviewSortType sortType,
    @required PageRequest pageRequest
  }) async => StoreReview.fromJsonList(
      (await api.get(
        url: '/dsites/$dIdx/stores/$sIdx/reviews?sortType=${sortType.toString().split('.').last}',
        pageRequest: pageRequest
      )).data);

  Future<StoreReview> save({
    @required int dIdx,
    @required int sIdx,
    @required bool isAnonymous,
    @required String contents,
    @required int star,
    @required String productName,
    @required List<int> idxesOrderItem,
    List<MultipartFile> multipartFiles
  }) async {
    String str = '';
    idxesOrderItem.forEach((idx) {
      str += '$idx,';
    });
    var data = FormData.fromMap({
      'isAnonymous': isAnonymous,
      'title': '',
      'contents': contents,
      'star': star,
      'productName': productName,
      'idxesOrderItem': str.isEmpty ? null : str,
    });

    for(MultipartFile file in multipartFiles) {
      data.files.add(MapEntry('images', file));
    }

    return StoreReview.fromJson((await api.post(
      url: '/dsites/$dIdx/stores/$sIdx/reviews',
      data: data
    )).data);
  }
}