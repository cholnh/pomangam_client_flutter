import 'dart:convert';

import 'package:bootpay_api/bootpay_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/domains/order/order_response.dart';
import 'package:pomangam_client_flutter/providers/cart/cart_model.dart';
import 'package:pomangam_client_flutter/providers/order/order_info_model.dart';
import 'package:pomangam_client_flutter/providers/order/order_model.dart';
import 'package:pomangam_client_flutter/providers/sign/sign_in_model.dart';
import 'package:pomangam_client_flutter/views/pages/order/order_fail/order_fail_page.dart';
import 'package:pomangam_client_flutter/views/pages/order/order_processing/order_processing_page.dart';
import 'package:provider/provider.dart';

class PgModel with ChangeNotifier {

  /// PG 결제 요청
  Future<void> request(OrderResponse response) async {
    try {
      await BootpayApi.request(
        Get.context,
        response.payload(),
        extra: response.extra(),
        user: await response.user(),
        items: response.items(),
        onDone: (String json) {
          print('onDone: $json');
          _orderProcessing(response.idx, jsonDecode(json));
        },
        onReady: (String json) {
          print('onReady: $json');
        },
        onCancel: (String json) {
          print('onCancel: $json');
          _rollback(response.idx);
        },
        onError: (String json) {
          print('onError: $json');
          _failPayment(response.idx, json);
        },
      );
    } catch (error){
      print(error);
      _failPayment(response.idx, error.toString());
    } finally {
      Get.context.read<OrderModel>().changeIsOrderProcessing(false);
    }
  }

  void _orderProcessing(int oIdx, Map<String, dynamic> jsonMap) async {
    if(kIsWeb) {
      Get.to(OrderProcessingPage(), transition: Transition.fade);
    } else {
      Get.offAll(OrderProcessingPage(), transition: Transition.fade, predicate: (Route route) {
        return route.isFirst;
      });
    }

    OrderModel orderModel = Get.context.read();
    int status = jsonMap['status'];
    if(status == 2) {
      _failPayment(oIdx, '(구)가상계좌 오류');
    } else {
      if(await orderModel.verify(oIdx: oIdx, receiptId: jsonMap['receipt_id'])) {
        // 주문성공
        Get.context.read<CartModel>().clear();
        Get.context.read<SignInModel>().renewUserInfo();
        Get.context.read<OrderInfoModel>().countToday();
      }
    }
  }

  void _failPayment(int oIdx, String json) async {
    if(kIsWeb) {
      Get.to(OrderFailPage(), transition: Transition.fade);
    } else {
      Get.offAll(OrderFailPage(reason: json), transition: Transition.fade, predicate: (Route route) {
        return route.isFirst;
      });
    }
    _rollback(oIdx);
  }

  void _rollback(int oIdx) async {
    Get.context.read<SignInModel>().renewUserInfo();
    await Get.context.read<OrderModel>().paymentFail(oIdx: oIdx);
  }
}