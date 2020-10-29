import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client_flutter/_bases/constants/endpoint.dart';
import 'package:pomangam_client_flutter/_bases/util/log_utils.dart';
import 'package:pomangam_client_flutter/domains/_bases/page_request.dart';
import 'package:pomangam_client_flutter/domains/order/order_response.dart';
import 'package:pomangam_client_flutter/domains/order/order_type.dart';
import 'package:pomangam_client_flutter/providers/sign/sign_in_model.dart';
import 'package:pomangam_client_flutter/repositories/order/order_repository.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pomangam_client_flutter/_bases/key/shared_preference_key.dart' as s;

class OrderInfoModel with ChangeNotifier {

  /// repository
  OrderRepository _orderRepository = Injector.appInstance.getDependency<OrderRepository>();

  /// model
  List<OrderResponse> todayOrders = List();
  List<OrderResponse> allOrders = List();

  /// data
  bool isFetching = false;
  bool hasNext = true;
  int curPage = Endpoint.defaultPage;
  int size = Endpoint.defaultSize;
  bool isCanceling = false;
  int countTodayOrders = 0;

  /// model fetch today order
  Future<void> fetchToday({
    bool isForceUpdate = false
  }) async {
    if(!isForceUpdate && !hasNext) return;
    hasNext = false; // lock
    isFetching = true;

    List<OrderResponse> fetched = [];
    if(isForceUpdate) {
      curPage = Endpoint.defaultPage;
      size = Endpoint.defaultSize;
      todayOrders.clear();
    }
    try {
      int fIdx = (await SharedPreferences.getInstance()).get(s.idxFcmToken);

      SignInModel signInModel = Get.context.read();
      if(signInModel.isSignIn()) {
        fetched = await _orderRepository.findToday(
          pn: signInModel.userInfo.phoneNumber,
          pageRequest: PageRequest(
            page: curPage++,
            size: size
          )
        );
      } else {
        if(fIdx == null) return;
        fetched = await _orderRepository.findToday(
            fIdx: fIdx,
            pageRequest: PageRequest(
              page: curPage++,
              size: size
            )
        );
      }

      if(fetched != null && fetched.isNotEmpty) {
        fetched = fetched.where((item) => _isValidType(item.orderType)).toList();
      }
      todayOrders.addAll(fetched);
      hasNext = fetched.length >= size;
    } catch (error) {
      print(error);
      debug('OrderModel.fetchToday Error', error: error);
    } finally {
      isFetching = false;
      notifyListeners();
    }
  }

  Future<void> countToday() async {
    SignInModel signInModel = Get.context.read();
    if(signInModel.isSignIn()) {
      countTodayOrders = await _orderRepository.countToday(pn: signInModel.userInfo.phoneNumber);
    } else {
      int fIdx = (await SharedPreferences.getInstance()).get(s.idxFcmToken);
      if(fIdx == null) return;
      countTodayOrders = await _orderRepository.countToday(fIdx: fIdx);
    }
  }

  /// model fetch all order
  Future<void> fetchAll({
    bool isForceUpdate = false
  }) async {
    if(!isForceUpdate && !hasNext) return;
    hasNext = false; // lock
    isFetching = true;

    List<OrderResponse> fetched = [];
    if(isForceUpdate) {
      curPage = Endpoint.defaultPage;
      size = Endpoint.defaultSize;
      todayOrders.clear();
      allOrders.clear();
    }
    try {
      int fIdx = (await SharedPreferences.getInstance()).get(s.idxFcmToken);

      SignInModel signInModel = Get.context.read();
      if(signInModel.isSignIn()) {
        fetched = await _orderRepository.findAll(
            pn: signInModel.userInfo.phoneNumber,
            pageRequest: PageRequest(
                page: curPage++,
                size: size
            )
        );
      } else {
        if(fIdx == null) return;
        fetched = await _orderRepository.findAll(
            fIdx: fIdx,
            pageRequest: PageRequest(
                page: curPage++,
                size: size
            )
        );
      }

      if(fetched != null && fetched.isNotEmpty) {
        fetched = fetched.where((item) => _isValidType(item.orderType)).toList();
      }
      allOrders.addAll(fetched);
      hasNext = fetched.length >= size;
    } catch (error) {
      debug('OrderModel.fetchAll Error', error: error);
    } finally {
      isFetching = false;
      notifyListeners();
    }
  }

  void clear({bool notify = true}) {
    isFetching = false;
    hasNext = true;
    curPage = Endpoint.defaultPage;
    size = Endpoint.defaultSize;
    isCanceling = false;
    todayOrders.clear();
    allOrders.clear();
    if(notify) {
      notifyListeners();
    }
  }

  bool _isValidType(OrderType orderType) {
    switch(orderType) {
      case OrderType.PAYMENT_READY_FAIL_POINT:
      case OrderType.PAYMENT_READY_FAIL_COUPON:
      case OrderType.PAYMENT_READY_FAIL_PROMOTION:
      case OrderType.PAYMENT_FAIL:
        return false;
      default:
        return true;
    }
  }

  void clearToday({bool notify = true}) {
    isFetching = false;
    hasNext = true;
    curPage = Endpoint.defaultPage;
    size = Endpoint.defaultSize;
    isCanceling = false;
    todayOrders.clear();
    if(notify) {
      notifyListeners();
    }
  }

  void clearAll({bool notify = true}) {
    isFetching = false;
    hasNext = true;
    curPage = Endpoint.defaultPage;
    size = Endpoint.defaultSize;
    isCanceling = false;
    allOrders.clear();
    if(notify) {
      notifyListeners();
    }
  }

  void changeIsCanceling(bool tf) {
    isCanceling = tf;
    notifyListeners();
  }
}
