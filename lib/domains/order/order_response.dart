
import 'package:bootpay_api/model/extra.dart';
import 'package:bootpay_api/model/item.dart';
import 'package:bootpay_api/model/payload.dart';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client_flutter/_bases/constants/endpoint.dart';
import 'package:pomangam_client_flutter/domains/_bases/entity_auditing.dart';
import 'package:pomangam_client_flutter/domains/coupon/coupon.dart';
import 'package:pomangam_client_flutter/domains/order/item/order_item_response.dart';
import 'package:pomangam_client_flutter/domains/order/item/sub/order_item_sub_response.dart';
import 'package:pomangam_client_flutter/domains/order/order_type.dart';
import 'package:pomangam_client_flutter/domains/order/orderer/orderer_type.dart';
import 'package:pomangam_client_flutter/domains/payment/payment_type.dart';
import 'package:pomangam_client_flutter/domains/promotion/promotion.dart';
import 'package:bootpay_api/model/user.dart' as BootpayUser;
import 'package:pomangam_client_flutter/domains/user/user.dart' as PomangamUser;
import 'package:pomangam_client_flutter/providers/sign/sign_in_model.dart';
import 'package:provider/provider.dart';

part 'order_response.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class OrderResponse extends EntityAuditing {

  // 주문 기본 정보
  OrderType orderType;
  int boxNumber;
  PaymentType paymentType;
  OrdererType ordererType;
  String phoneNumber;

  // 결제 정보
  int usingPoint;
  List<Coupon> usingCoupons = List();
  List<Promotion> usingPromotions = List();
  int savedPoint;
  String cashReceipt;
  int totalCost;
  int discountCost;
  int paymentCost;

  // 받는 장소
  int idxDeliverySite;
  int idxDeliveryDetailSite;
  String nameDeliverySite;
  String nameDeliveryDetailSite;

  // 받는 날짜
  DateTime orderDate;

  // 받는 시간
  int idxOrderTime;
  String arrivalTime;
  String additionalTime;

  List<OrderItemResponse> orderItems = List();

  OrderResponse({
    int idx, DateTime registerDate, DateTime modifyDate,
    this.orderType, this.boxNumber, this.paymentType,
    this.ordererType, this.phoneNumber, this.usingPoint, this.usingCoupons,
    this.usingPromotions, this.savedPoint, this.cashReceipt, this.totalCost,
    this.discountCost, this.paymentCost, this.idxDeliverySite,
    this.idxDeliveryDetailSite, this.nameDeliverySite,
    this.nameDeliveryDetailSite, this.orderDate, this.idxOrderTime,
    this.arrivalTime, this.additionalTime, this.orderItems
  }): super(idx: idx, registerDate: registerDate, modifyDate: modifyDate);

  Map<String, dynamic> toJson() => _$OrderResponseToJson(this);
  factory OrderResponse.fromJson(Map<String, dynamic> json) => _$OrderResponseFromJson(json);
  static List<OrderResponse> fromJsonList(List<dynamic> jsonList) {
    List<OrderResponse> entities = [];
    jsonList.forEach((map) => entities.add(OrderResponse.fromJson(map)));
    return entities;
  }

  @override
  String toString() {
    return '[OrderResponse]\n\norderType: $orderType\nboxNumber: $boxNumber\npaymentType: $paymentType\nordererType: $ordererType\nusingPoint: $usingPoint\nusingCoupons: $usingCoupons\nusingPromotions: $usingPromotions\nsavedPoint: $savedPoint\ncashReceipt: $cashReceipt\ntotalCost: $totalCost\ndiscountCost: $discountCost\npaymentCost: $paymentCost\nidxDeliverySite: $idxDeliverySite\nidxDeliveryDetailSite: $idxDeliveryDetailSite\nnameDeliverySite: $nameDeliverySite\nnameDeliveryDetailSite: $nameDeliveryDetailSite\norderDate: $orderDate\nidxOrderTime: $idxOrderTime\narrivalTime: $arrivalTime\nadditionalTime: $additionalTime\n\n$orderItems';
  }

  String payloadName() {
    return '${orderItems.first.nameProduct}' +
        (orderItems.length > 1 ? '외 ${orderItems.length-1}건' : '');
  }

  Payload payload() {
    Payload payload = Payload();
    payload.androidApplicationId = Endpoint.bootpayAndroidApplicationId;
    payload.iosApplicationId = Endpoint.bootpayIosApplicationId;
    payload.pg = Endpoint.bootpayPg;
    payload.methods = _payloadMethod();
    payload.name = payloadName();
    payload.price = paymentCost.toDouble();
    payload.orderId = DateTime.now().millisecondsSinceEpoch.toString();
    return payload;
  }

  List<String> _payloadMethod() {
    switch(this.paymentType) {
      case PaymentType.COMMON_CREDIT_CARD:
        return ['card'];
      case PaymentType.COMMON_PHONE:
        return ['phone'];
      case PaymentType.COMMON_V_BANK:
        return ['vbank'];
      case PaymentType.COMMON_BANK:
        return ['bank'];
      default:
        return ['card', 'vbank', 'bank', 'phone'];
    }
  }

  Extra extra() {
    Extra extra = Extra();
    extra.quick_popup = 1;
    //extra.custom_background = '#ff4500';
    //extra.custom_font_color = '#ffffff';
    extra.appScheme = Endpoint.bootpayAppScheme;
    return extra;
  }

  Future<BootpayUser.User> user() async {
    SignInModel model = Get.context.read<SignInModel>();
    BootpayUser.User user = BootpayUser.User();
    if(model.isSignIn()) {
      PomangamUser.User userInfo = model.userInfo;
      user.username = userInfo.name;
      user.area = '$nameDeliverySite $nameDeliveryDetailSite';
      user.phone = userInfo.phoneNumber;
    } else {
      user.username = '';
      user.area = '$nameDeliverySite $nameDeliveryDetailSite';
      user.phone = this.phoneNumber;
    }
    return user;
  }

  List<Item> items() {
    List<Item> items = List();
    orderItems.forEach((OrderItemResponse orderItem) {
      Item item = Item();
      item.itemName = orderItem.nameProduct;
      item.qty = orderItem.quantity;
      item.unique = 'product-'+orderItem.idxProduct.toString();
      item.price = orderItem.saleCost.toDouble();
      items.add(item);
      orderItem.orderItemSubs.forEach((OrderItemSubResponse orderSubItem) {
        Item subItem = Item();
        subItem.itemName = orderSubItem.nameProductSub;
        subItem.qty = orderSubItem.quantity;
        subItem.unique = 'productSub-'+orderSubItem.idxProductSub.toString();
        subItem.price = orderSubItem.saleCost.toDouble();
        items.add(subItem);
      });
    });
    return items;
  }
}