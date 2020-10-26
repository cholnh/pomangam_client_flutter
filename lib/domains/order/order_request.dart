import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client_flutter/domains/cart/cart.dart';
import 'package:pomangam_client_flutter/domains/order/item/order_item_request.dart';
import 'package:pomangam_client_flutter/domains/payment/cash_receipt/cash_receipt_type.dart';
import 'package:pomangam_client_flutter/domains/payment/payment.dart';
import 'package:pomangam_client_flutter/domains/payment/payment_type.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pomangam_client_flutter/_bases/key/shared_preference_key.dart' as s;

part 'order_request.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class OrderRequest {

  /// 주문 날짜
  DateTime orderDate;

  /// 주문 시간
  int idxOrderTime;

  /// 받는 장소
  int idxDeliveryDetailSite;

  /// fcm token 인덱스
  int idxFcmToken;

  /// PaymentInfo
  PaymentType paymentType;

  /// 사용 포인트
  int usingPoint;

  /// 사용 쿠폰 (코드)
  String usingCouponCode;

  /// 사용 쿠폰 (쿠폰인덱스)
  Set<int> idxesUsingCoupons = Set();

  /// 사용 프로모션
  Set<int> idxesUsingPromotions = Set();

  /// 현금영수증 번호
  String cashReceipt;

  /// 현금영수증 타입
  CashReceiptType cashReceiptType;

  /// 주문 제품
  List<OrderItemRequest> orderItems = List();

  String vbankName;

  OrderRequest({
    this.orderDate, this.idxOrderTime, this.idxDeliveryDetailSite, this.idxFcmToken,
    this.paymentType, this.usingPoint, this.usingCouponCode, this.idxesUsingCoupons,
    this.idxesUsingPromotions, this.cashReceipt, this.cashReceiptType, this.orderItems, this.vbankName
  });

  Map<String, dynamic> toJson() => _$OrderRequestToJson(this);
  factory OrderRequest.fromJson(Map<String, dynamic> json) => _$OrderRequestFromJson(json);

  static Future<OrderRequest> fromCartAndPayment(Cart cart, Payment payment) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return OrderRequest(
        orderDate: cart.orderDate,
        idxOrderTime: cart.orderTime.idx,
        idxDeliveryDetailSite: cart.detail.idx,
        idxFcmToken: prefs.get(s.idxFcmToken),
        paymentType: payment.paymentType,
        usingPoint: cart.usingPoint,
        usingCouponCode: cart.usingCouponCode?.code,
        idxesUsingCoupons: cart.usingCoupons.map((coupon) => coupon.idx).toSet(),
        idxesUsingPromotions: cart.usingPromotions.map((promotion) => promotion.idx).toSet(),
        cashReceipt: payment.cashReceipt?.cashReceiptNumber,
        cashReceiptType: payment.cashReceipt?.cashReceiptType,
        orderItems: OrderItemRequest.fromCartItems(cart.items),
        vbankName: payment.vbankName
    );
  }

  bool isValidOrder() {
    return orderItems.length > 0 &&
        usingPoint >= 0 &&
        paymentType != null &&
        idxFcmToken != null &&
        orderDate != null &&
        idxOrderTime != null &&
        idxDeliveryDetailSite != null;
  }

  @override
  String toString() {
    return 'OrderRequest{orderDate: $orderDate, idxOrderTime: $idxOrderTime, idxDeliveryDetailSite: $idxDeliveryDetailSite, idxFcmToken: $idxFcmToken, paymentType: $paymentType, usingPoint: $usingPoint, usingCouponCode: $usingCouponCode, idxesUsingCoupons: $idxesUsingCoupons, idxesUsingPromotions: $idxesUsingPromotions, cashReceipt: $cashReceipt, cashReceiptType: $cashReceiptType, orderItems: $orderItems}';
  }
}