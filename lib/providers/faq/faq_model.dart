import 'package:flutter/foundation.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client_flutter/domains/faq/faq_category.dart';
import 'package:pomangam_client_flutter/repositories/faq/faq_repository.dart';

class FaqModel with ChangeNotifier {

  FaqRepository _faqRepository = Injector.appInstance.getDependency<FaqRepository>();

  List<FaqCategory> faqCategories = List();

  bool isFetching = false;

  Future<void> fetchAll({
    @required int dIdx
  }) async {
    isFetching = true;
    try {
      this.faqCategories = await _faqRepository.findAll(dIdx: dIdx);
    } catch (error) {
      print('[Debug] FaqModel.fetch Error - $error');
    }
    isFetching = false;
    notifyListeners();
  }

  void clear({bool notify = true}) {
    faqCategories.clear();
    isFetching = false;
    if(notify) {
      notifyListeners();
    }
  }
}