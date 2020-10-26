import 'package:flutter/foundation.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client_flutter/domains/order/time/order_time.dart';
import 'package:pomangam_client_flutter/repositories/order/time/order_time_repository.dart';
import 'package:time/time.dart';

class OrderTimeModel with ChangeNotifier {
  OrderTimeRepository _orderTimeRepository;

  List<OrderTime> orderTimes = List();
  OrderTime userOrderTime;
  DateTime userOrderDate;

  bool isOrderDateMode = false;
  bool isOrderDateChanged = false;
  DateTime viewUserOrderDate;

  OrderTimeModel() {
    _orderTimeRepository = Injector.appInstance.getDependency<OrderTimeRepository>();
  }

  void clear() {
    orderTimes.clear();
    userOrderTime = null;
  }

  Future<void> fetch({
    bool forceUpdate = false,
    @required int dIdx
  }) async {
    if(!forceUpdate && orderTimes.length > 0) return;

    try {
      orderTimes = await _orderTimeRepository.findByIdxDeliverySite(dIdx: dIdx);
    } catch (error) {
      print('[Debug] OrderTimeModel.fetch Error - $error');
    }
    renewOrderableFirstTime(notify: true);
  }

  OrderTime orderableFirstTime() {
    DateTime now = DateTime.now();
    for(OrderTime orderTime in orderTimes) {
      if(now.isBefore(orderTime.getOrderEndDateTime())) {
        userOrderDate = now;
        return orderTime;
      }
    }
    userOrderDate = now + 1.days;
    return orderTimes.first;
  }

  bool isOverUserTime() {
    DateTime now = DateTime.now();
    return (now.year >= userOrderDate.year && now.month >= userOrderDate.month && now.day >= userOrderDate.day) &&
        userOrderTime.getOrderEndDateTime().isBefore(now);
  }

  void renewOrderableFirstTime({bool notify = true}) {
    userOrderTime = orderableFirstTime();
    if(notify) {
      notifyListeners();
    }
  }

  void changeUserOrderTime(OrderTime orderTime) {
    this.userOrderTime = orderTime;
    notifyListeners();
  }

  void changeUserOrderDate(DateTime userOrderDate) {
    this.userOrderDate = userOrderDate;
    notifyListeners();
  }

  void changeUserOrderDateAndOrderTime(DateTime orderDate, OrderTime orderTime) {
    this.userOrderDate = orderDate;
    this.userOrderTime = orderTime;
    notifyListeners();
  }

  void changeViewUserOrderDate(DateTime viewUserOrderDate) {
    this.isOrderDateChanged = true;
    this.viewUserOrderDate = viewUserOrderDate;
    notifyListeners();
  }

  void changeOrderDateMode(bool tf) {
    this.isOrderDateMode = tf;
    notifyListeners();
  }
}
