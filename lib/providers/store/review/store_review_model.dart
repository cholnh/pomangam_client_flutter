import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client_flutter/_bases/constants/endpoint.dart';
import 'package:pomangam_client_flutter/_bases/util/log_utils.dart';
import 'package:pomangam_client_flutter/domains/_bases/page_request.dart';
import 'package:pomangam_client_flutter/domains/store/review/store_review.dart';
import 'package:pomangam_client_flutter/domains/store/review/store_review_sort_type.dart';
import 'package:pomangam_client_flutter/repositories/store/review/store_review_repository.dart';

class StoreReviewModel with ChangeNotifier {

  StoreReviewRepository _storeReviewRepository = Injector.appInstance.getDependency<StoreReviewRepository>();

  List<StoreReview> reviews = List();

  bool isFetching = false;
  bool isSaving = false;
  bool hasNext = true;
  int curPage = Endpoint.defaultPage;
  int size = Endpoint.defaultSize;

  Future<void> fetchAll({
    bool isForceUpdate = false,
    @required int dIdx,
    @required int sIdx,
    @required StoreReviewSortType sortType
  }) async {
    if(!isForceUpdate && !hasNext) return;
    hasNext = false; // lock
    isFetching = true;

    List<StoreReview> fetched = [];
    try {
      fetched = await _storeReviewRepository.findAll(
        dIdx: dIdx,
        sIdx: sIdx,
        pageRequest: PageRequest(
          page: curPage++,
          size: size
        ),
        sortType: sortType
      );
      reviews.addAll(fetched);
      hasNext = fetched.length >= size;
    } catch(error) {
      debug('[Debug] StoreReviewModel.fetchAll Error - $error');
    } finally {
      isFetching = false;
      notifyListeners();
    }
  }

  Future<void> save({
    @required int dIdx,
    @required int sIdx,
    @required bool isAnonymous,
    @required String contents,
    @required int star,
    @required String productName,
    @required List<int> idxesOrderItem,
    List<MultipartFile> multipartFiles
  }) async {
    try {
      await _storeReviewRepository.save(
        dIdx: dIdx,
        sIdx: sIdx,
        isAnonymous: isAnonymous,
        contents: contents,
        star: star,
        productName: productName,
        idxesOrderItem: idxesOrderItem,
        multipartFiles: multipartFiles
      );
    } catch(error) {
      debug('[Debug] StoreReviewModel.save Error - $error');
    }
  }

  void lock() {
    isSaving = true;
    notifyListeners();
  }

  void unlock() {
    isSaving = false;
    notifyListeners();
  }

  void clear({bool notify = true}) {
    reviews.clear();
    hasNext = true;
    curPage = Endpoint.defaultPage;
    size = Endpoint.defaultSize;
    isFetching = false;
    isSaving = false;
    if(notify) {
      notifyListeners();
    }
  }
}