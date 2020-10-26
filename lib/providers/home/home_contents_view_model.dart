import 'package:flutter/widgets.dart';
import 'package:pomangam_client_flutter/views/widgets/home/contents/item/home_contents_type.dart';

class HomeContentsViewModel with ChangeNotifier {

  HomeContentsType contentsType = HomeContentsType.LIST;

  void toggleHomeContentsType() {
    if(this.contentsType == HomeContentsType.LIST) {
      this.contentsType = HomeContentsType.GRID;
    } else {
      this.contentsType = HomeContentsType.LIST;
    }
    notifyListeners();
  }

  void changeHomeContentsType(HomeContentsType type) {
    this.contentsType = type;
    notifyListeners();
  }
}