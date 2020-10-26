import 'package:flutter/cupertino.dart';

class ProductSubCategoryModel with ChangeNotifier {
  int idxSelectedCategory = 0;
  int idxProductSubCategory = 0;

  void changeIdxSelectedCategory(int idxSelectedCategory) {
    this.idxSelectedCategory = idxSelectedCategory;
    notifyListeners();
  }

  void changeIdxProductSubCategory(int idxProductSubCategory) {
    this.idxProductSubCategory = idxProductSubCategory;
    notifyListeners();
  }

  void clear({bool notify = true}) {
    this.idxSelectedCategory = 0;
    this.idxProductSubCategory = 0;
    if(notify) {
      notifyListeners();
    }
  }
}