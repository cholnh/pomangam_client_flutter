import 'package:flutter/foundation.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client_flutter/domains/order/bootpay/bootpay_vbank.dart';
import 'package:pomangam_client_flutter/domains/order/order_request.dart';
import 'package:pomangam_client_flutter/domains/order/order_response.dart';
import 'package:pomangam_client_flutter/repositories/order/order_repository.dart';

class OrderModel with ChangeNotifier {

  /// repository
  OrderRepository _orderRepository = Injector.appInstance.getDependency<OrderRepository>();

  /// model
  OrderResponse orderResponse;

  /// data
  bool isOrderProcessing = false;
  bool isVerifying = false;
  bool isValidOrder = false;

  int status = 0;
  BootpayVbank bootpayVbank;

  Future<OrderResponse> save({
    @required OrderRequest orderRequest
  }) async {
    this.orderResponse = null;

    try {
      this.orderResponse = await _orderRepository.saveOrder(orderRequest: orderRequest);
    } catch (error) {
      print('[Debug] OrderModel.saveOrder Error - $error');
      return null;
    }
    notifyListeners();
    return this.orderResponse;
  }

  Future<bool> verify({
    @required int oIdx,
    @required String receiptId
  }) async {
    isVerifying = true;
    isValidOrder = false;
    notifyListeners();

    try {
      if(receiptId != null && receiptId.isNotEmpty) {
        this.isValidOrder = await _orderRepository.verify(oIdx: oIdx, receiptId: receiptId);
      }
    } catch (error) {
      print('[Debug] OrderModel.verify Error - $error');
    } finally {
      isVerifying = false;
      notifyListeners();
    }
    return isValidOrder;
  }

  Future<void> cancel({
    @required int oIdx
  }) async {
    try {
      await _orderRepository.cancel(oIdx: oIdx);
    } catch (error) {
      print('[Debug] OrderModel.cancel Error - $error');
    } finally {
      notifyListeners();
    }
  }

  Future<void> paymentFail({
    @required int oIdx
  }) async {
    try {
      await _orderRepository.paymentFail(oIdx: oIdx);
    } catch (error) {
      print('[Debug] OrderModel.paymentFail Error - $error');
    } finally {
      notifyListeners();
    }
  }

  Future<bool> patchDetailSite({
    @required int oIdx,
    @required int ddIdx
  }) async {
    bool isSuccess = false;
    try {
      OrderResponse response = await _orderRepository.patchDetailSite(oIdx: oIdx, ddIdx: ddIdx);
      isSuccess = response.idxDeliveryDetailSite == ddIdx;
    } catch (error) {
      print('[Debug] OrderModel.patchDetailSite Error - $error');
    }
    notifyListeners();
    return isSuccess;
  }

  Future<void> getVbank({
    @required int oIdx
  }) async {
    try {
      bootpayVbank = await _orderRepository.getVbank(oIdx : oIdx);
    } catch (error) {
      bootpayVbank = null;
      print('[Debug] OrderModel.getVbank Error - $error');
    } finally {
      notifyListeners();
    }
  }

  Future<void> postVbank() async {
    try {
      await _orderRepository.postVbank(bootpayVbank : bootpayVbank);
    } catch (error) {
      print('[Debug] OrderModel.postVbank Error - $error');
    }
  }
  Future<void> postReceiptId({
    @required int oIdx,
    @required String receiptId
  }) async {
    try {
      await _orderRepository.postReceiptId(oIdx: oIdx, receiptId: receiptId);
    } catch (error) {
      print('[Debug] OrderModel.postReceiptId Error - $error');
    }
  }

  void changeIsValidOrder(bool tf) {
    this.isValidOrder = tf;
    notifyListeners();
  }

  void changeIsOrderProcessing(bool tf) {
    this.isOrderProcessing = tf;
    notifyListeners();
  }

  void changeStatus(int status) {
    this.status = status;
    notifyListeners();
  }

  void changeBootpayVbank({
    int oIdx,
    String vbankName,
    String vbankAccount,
    int vbankPrice
  }) {
    if(bootpayVbank == null) {
      bootpayVbank = BootpayVbank();
    }
    this.bootpayVbank.idxOrder = oIdx;
    this.bootpayVbank.vbankName = vbankName;
    this.bootpayVbank.vbankAccount = vbankAccount;
    this.bootpayVbank.vbankPrice = vbankPrice;
  }

  void clear() {
    isOrderProcessing = false;
    isVerifying = false;
    isValidOrder = false;
    notifyListeners();
  }

  void vbankClear() {
    status = 0;
    bootpayVbank = null;
  }
}
