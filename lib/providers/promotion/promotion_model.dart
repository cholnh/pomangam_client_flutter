import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client_flutter/domains/promotion/promotion.dart';
import 'package:pomangam_client_flutter/repositories/promotion/promotion_repository.dart';

class PromotionModel with ChangeNotifier {

  PromotionRepository _promotionRepository;

  List<Promotion> promotions = List();

  bool isFetching = false;

  PromotionModel() {
    _promotionRepository = Injector.appInstance.getDependency<PromotionRepository>();
  }

  Future<void> fetch({
    @required int dIdx
  }) async {
    isFetching = true;
    try {
      this.promotions = await _promotionRepository.findByDeliverySite(dIdx: dIdx);
    } catch (error) {
      print('[Debug] PromotionModel.fetch Error - $error');
    }
    isFetching = false;
    notifyListeners();
  }

}