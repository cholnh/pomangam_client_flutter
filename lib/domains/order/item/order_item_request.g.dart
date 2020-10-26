// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItemRequest _$OrderItemRequestFromJson(Map<String, dynamic> json) {
  return OrderItemRequest(
    idxStore: json['idxStore'] as int,
    idxProduct: json['idxProduct'] as int,
    quantity: json['quantity'] as int,
    requirement: json['requirement'] as String,
    orderItemSubs: (json['orderItemSubs'] as List)
        ?.map((e) => e == null
            ? null
            : OrderItemSubRequest.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$OrderItemRequestToJson(OrderItemRequest instance) =>
    <String, dynamic>{
      'idxStore': instance.idxStore,
      'idxProduct': instance.idxProduct,
      'quantity': instance.quantity,
      'requirement': instance.requirement,
      'orderItemSubs':
          instance.orderItemSubs?.map((e) => e?.toJson())?.toList(),
    };
