import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client_flutter/domains/advertisement/advertisement.dart';
import 'package:pomangam_client_flutter/repositories/advertisement/advertisement_repository.dart';

class AdvertisementModel with ChangeNotifier {

  AdvertisementRepository _advertisementRepository = Injector.appInstance.getDependency<AdvertisementRepository>();

  List<Advertisement> advertisements = List();

  bool isAdvertisementFetching = false;

  Future<void> fetch({
    @required int dIdx
  }) async {
    isAdvertisementFetching = true;
    try {
      this.advertisements = await _advertisementRepository.findAll(dIdx: dIdx);
    } catch (error) {
      print('[Debug] AdvertisementModel.fetch Error - $error');
      this.isAdvertisementFetching = false;
    }
    this.isAdvertisementFetching = false;
    notifyListeners();
  }

  void clear({bool notify = true}) {
    isAdvertisementFetching = false;
    advertisements.clear();
    if(notify) {
      notifyListeners();
    }
  }
}