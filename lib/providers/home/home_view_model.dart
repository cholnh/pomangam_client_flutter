import 'package:flutter/widgets.dart';

class HomeViewModel with ChangeNotifier {

  bool isCurrent = false;

  void changeIsCurrent(bool tf, {bool notify = false}) {
    this.isCurrent = tf;
    if(notify) {
      notifyListeners();
    }
  }
}