import 'package:flutter/cupertino.dart';

class ProductSubCategoryModel with ChangeNotifier {
  int idxSelectedCategory = 0;

  void changeIdxSelectedCategory(int idxSelectedCategory) {
    this.idxSelectedCategory = idxSelectedCategory;
    notifyListeners();
  }

  void clear({bool notify = true}) {
    this.idxSelectedCategory = 0;
    if(notify) {
      notifyListeners();
    }
  }
}