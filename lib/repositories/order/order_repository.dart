import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:pomangam_client_flutter/_bases/network/api/api.dart';
import 'package:pomangam_client_flutter/domains/_bases/page_request.dart';
import 'package:pomangam_client_flutter/domains/order/bootpay/bootpay_vbank.dart';
import 'package:pomangam_client_flutter/domains/order/order_request.dart';
import 'package:pomangam_client_flutter/domains/order/order_response.dart';

class OrderRepository {

  final Api api; // 서버 연결용
  OrderRepository({this.api});

  Future<OrderResponse> saveOrder({
    @required OrderRequest orderRequest
  }) async => OrderResponse.fromJson((await api.post(
      url: '/orders',
      data: orderRequest.toJson())).data);

  Future<bool> verify({
    @required int oIdx,
    @required String receiptId
  }) async => (await api.post(
      url: '/orders/$oIdx/verify?receipt=$receiptId')).data;

  Future<void> cancel({
    @required int oIdx
  }) async => (await api.post(
      url: '/orders/$oIdx/cancel')).data;

  Future<void> paymentFail({
    @required int oIdx
  }) async => (await api.post(
      url: '/orders/$oIdx/paymentfail')).data;

  Future<List<OrderResponse>> findToday({
    int fIdx,
    String pn,
    PageRequest pageRequest
  }) async => OrderResponse.fromJsonList((await api.get(
      url: '/orders/today' + (fIdx != null ? '?fIdx=$fIdx' : '?pn=$pn'),
      pageRequest: pageRequest)).data);

  Future<int> countToday({
    int fIdx,
    String pn,
  }) async => (await api.get(
      url: '/orders/today/count' + (fIdx != null ? '?fIdx=$fIdx' : '?pn=$pn'))).data;

  Future<List<OrderResponse>> findAll({
    int fIdx,
    String pn,
    PageRequest pageRequest
  }) async => OrderResponse.fromJsonList((await api.get(
      url: '/orders' + (fIdx != null ? '?fIdx=$fIdx' : '?pn=$pn'),
      pageRequest: pageRequest)).data);

  Future<OrderResponse> patchDetailSite({
    @required int oIdx,
    @required int ddIdx,
  }) async => OrderResponse.fromJson((await api.patch(
      url: '/orders/$oIdx?ddIdx=$ddIdx')).data);

  Future<BootpayVbank> getVbank({
    @required int oIdx
  }) async => BootpayVbank.fromJson((await api.get(
        url: '/orders/$oIdx/vbank')).data);


  Future<BootpayVbank> postVbank({
    @required BootpayVbank bootpayVbank
  }) async => BootpayVbank.fromJson((await api.post(
      url: '/orders/${bootpayVbank.idxOrder}/vbank',
      data: bootpayVbank.toJson())).data);

  Future<void> postReceiptId({
    @required int oIdx,
    @required String receiptId
  }) async => await api.post(
      url: '/orders/$oIdx/receipt?receiptId=$receiptId');

}