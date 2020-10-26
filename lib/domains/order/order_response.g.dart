// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderResponse _$OrderResponseFromJson(Map<String, dynamic> json) {
  return OrderResponse(
    idx: json['idx'] as int,
    registerDate: json['registerDate'] == null
        ? null
        : DateTime.parse(json['registerDate'] as String),
    modifyDate: json['modifyDate'] == null
        ? null
        : DateTime.parse(json['modifyDate'] as String),
    orderType: _$enumDecodeNullable(_$OrderTypeEnumMap, json['orderType']),
    boxNumber: json['boxNumber'] as int,
    paymentType:
        _$enumDecodeNullable(_$PaymentTypeEnumMap, json['paymentType']),
    ordererType:
        _$enumDecodeNullable(_$OrdererTypeEnumMap, json['ordererType']),
    usingPoint: json['usingPoint'] as int,
    usingCoupons: (json['usingCoupons'] as List)
        ?.map((e) =>
            e == null ? null : Coupon.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    usingPromotions: (json['usingPromotions'] as List)
        ?.map((e) =>
            e == null ? null : Promotion.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    savedPoint: json['savedPoint'] as int,
    cashReceipt: json['cashReceipt'] as String,
    totalCost: json['totalCost'] as int,
    discountCost: json['discountCost'] as int,
    paymentCost: json['paymentCost'] as int,
    idxDeliverySite: json['idxDeliverySite'] as int,
    idxDeliveryDetailSite: json['idxDeliveryDetailSite'] as int,
    nameDeliverySite: json['nameDeliverySite'] as String,
    nameDeliveryDetailSite: json['nameDeliveryDetailSite'] as String,
    orderDate: json['orderDate'] == null
        ? null
        : DateTime.parse(json['orderDate'] as String),
    idxOrderTime: json['idxOrderTime'] as int,
    arrivalTime: json['arrivalTime'] as String,
    additionalTime: json['additionalTime'] as String,
    orderItems: (json['orderItems'] as List)
        ?.map((e) => e == null
            ? null
            : OrderItemResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$OrderResponseToJson(OrderResponse instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'registerDate': instance.registerDate?.toIso8601String(),
      'modifyDate': instance.modifyDate?.toIso8601String(),
      'orderType': _$OrderTypeEnumMap[instance.orderType],
      'boxNumber': instance.boxNumber,
      'paymentType': _$PaymentTypeEnumMap[instance.paymentType],
      'ordererType': _$OrdererTypeEnumMap[instance.ordererType],
      'usingPoint': instance.usingPoint,
      'usingCoupons': instance.usingCoupons?.map((e) => e?.toJson())?.toList(),
      'usingPromotions':
          instance.usingPromotions?.map((e) => e?.toJson())?.toList(),
      'savedPoint': instance.savedPoint,
      'cashReceipt': instance.cashReceipt,
      'totalCost': instance.totalCost,
      'discountCost': instance.discountCost,
      'paymentCost': instance.paymentCost,
      'idxDeliverySite': instance.idxDeliverySite,
      'idxDeliveryDetailSite': instance.idxDeliveryDetailSite,
      'nameDeliverySite': instance.nameDeliverySite,
      'nameDeliveryDetailSite': instance.nameDeliveryDetailSite,
      'orderDate': instance.orderDate?.toIso8601String(),
      'idxOrderTime': instance.idxOrderTime,
      'arrivalTime': instance.arrivalTime,
      'additionalTime': instance.additionalTime,
      'orderItems': instance.orderItems?.map((e) => e?.toJson())?.toList(),
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$OrderTypeEnumMap = {
  OrderType.PAYMENT_READY: 'PAYMENT_READY',
  OrderType.PAYMENT_READY_FAIL_POINT: 'PAYMENT_READY_FAIL_POINT',
  OrderType.PAYMENT_READY_FAIL_COUPON: 'PAYMENT_READY_FAIL_COUPON',
  OrderType.PAYMENT_READY_FAIL_PROMOTION: 'PAYMENT_READY_FAIL_PROMOTION',
  OrderType.PAYMENT_SUCCESS: 'PAYMENT_SUCCESS',
  OrderType.PAYMENT_FAIL: 'PAYMENT_FAIL',
  OrderType.PAYMENT_CANCEL: 'PAYMENT_CANCEL',
  OrderType.PAYMENT_REFUND: 'PAYMENT_REFUND',
  OrderType.ORDER_READY: 'ORDER_READY',
  OrderType.ORDER_QUICK_READY: 'ORDER_QUICK_READY',
  OrderType.ORDER_SUCCESS: 'ORDER_SUCCESS',
  OrderType.ORDER_REFUSE: 'ORDER_REFUSE',
  OrderType.ORDER_CANCEL: 'ORDER_CANCEL',
  OrderType.DELIVERY_READY: 'DELIVERY_READY',
  OrderType.DELIVERY_PICKUP: 'DELIVERY_PICKUP',
  OrderType.DELIVERY_DELAY: 'DELIVERY_DELAY',
  OrderType.DELIVERY_SUCCESS: 'DELIVERY_SUCCESS',
  OrderType.MISS_BY_DELIVERER: 'MISS_BY_DELIVERER',
  OrderType.MISS_BY_STORE: 'MISS_BY_STORE',
  OrderType.RE_DELIVERY: 'RE_DELIVERY',
};

const _$PaymentTypeEnumMap = {
  PaymentType.CONTACT_CREDIT_CARD: 'CONTACT_CREDIT_CARD',
  PaymentType.CONTACT_CASH: 'CONTACT_CASH',
  PaymentType.COMMON_CREDIT_CARD: 'COMMON_CREDIT_CARD',
  PaymentType.COMMON_PHONE: 'COMMON_PHONE',
  PaymentType.COMMON_V_BANK: 'COMMON_V_BANK',
  PaymentType.COMMON_BANK: 'COMMON_BANK',
};

const _$OrdererTypeEnumMap = {
  OrdererType.GUEST: 'GUEST',
  OrdererType.USER: 'USER',
};
