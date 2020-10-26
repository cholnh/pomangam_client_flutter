import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client_flutter/domains/store/store.dart';
import 'package:pomangam_client_flutter/repositories/store/store_repository.dart';

class StoreModel with ChangeNotifier {

  StoreRepository _storeRepository;

  Store store;

  bool isStoreFetching = false;
  bool isStoreDescriptionOpened = false;
  bool isProcessingLikeToggle = false;

  StoreModel() {
    _storeRepository = Injector.appInstance.getDependency<StoreRepository>();
  }

  void fetch({
    @required int dIdx,
    @required int sIdx,
  }) async {
    if(isStoreFetching) return;

    try {
      this.isStoreFetching = true;
      this.store = await _storeRepository.findByIdx(dIdx: dIdx, sIdx: sIdx);
    } catch (error) {
      print('[Debug] StoreModel.fetch Error - $error');
    } finally {
      isStoreFetching = false;
      notifyListeners();
    }
  }

  void likeToggle({
    @required int dIdx,
    @required int sIdx
  }) async {
    if(isProcessingLikeToggle) return;
    isProcessingLikeToggle = true;
    try {
      bool isLike = await _storeRepository.likeToggle(dIdx: dIdx, sIdx: sIdx);
      store.isLike = isLike;
      notifyListeners();
    } catch (error) {
      print('[Debug] StoreModel.likeToggle Error - $error');
    } finally {
      isProcessingLikeToggle = false;
    }
  }

  void changeIsStoreFetching(bool tf) {
    this.isStoreFetching = tf;
    notifyListeners();
  }

  void toggleIsStoreDescriptionOpened() {
    this.isStoreDescriptionOpened = !this.isStoreDescriptionOpened;
    notifyListeners();
  }

  void clear({bool notify = true}) {
    store = null;
    isStoreFetching = false;
    isStoreDescriptionOpened = false;
    isProcessingLikeToggle = false;
    if(notify) {
      notifyListeners();
    }
  }
}