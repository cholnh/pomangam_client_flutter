import 'package:flutter/cupertino.dart';
import 'package:pomangam_client_flutter/domains/store/review/store_review_sort_type.dart';

class StoreReviewSortModel with ChangeNotifier {
  StoreReviewSortType sortType = StoreReviewSortType.SORT_BY_DATE_DESC;

  void changeSortType(StoreReviewSortType sortType, {bool notify = false}) {
    this.sortType = sortType;
    if(notify) {
      notifyListeners();
    }
  }
}