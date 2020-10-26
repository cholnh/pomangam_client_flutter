// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItemResponse _$OrderItemResponseFromJson(Map<String, dynamic> json) {
  return OrderItemResponse(
    idx: json['idx'] as int,
    registerDate: json['registerDate'] == null
        ? null
        : DateTime.parse(json['registerDate'] as String),
    modifyDate: json['modifyDate'] == null
        ? null
        : DateTime.parse(json['modifyDate'] as String),
    idxStore: json['idxStore'] as int,
    nameStore: json['nameStore'] as String,
    idxProduct: json['idxProduct'] as int,
    nameProduct: json['nameProduct'] as String,
    saleCost: json['saleCost'] as int,
    quantity: json['quantity'] as int,
    requirement: json['requirement'] as String,
    orderItemSubs: (json['orderItemSubs'] as List)
        ?.map((e) => e == null
            ? null
            : OrderItemSubResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    reviewWrite: json['reviewWrite'] as bool,
  );
}

Map<String, dynamic> _$OrderItemResponseToJson(OrderItemResponse instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'registerDate': instance.registerDate?.toIso8601String(),
      'modifyDate': instance.modifyDate?.toIso8601String(),
      'idxStore': instance.idxStore,
      'nameStore': instance.nameStore,
      'idxProduct': instance.idxProduct,
      'nameProduct': instance.nameProduct,
      'saleCost': instance.saleCost,
      'quantity': instance.quantity,
      'requirement': instance.requirement,
      'orderItemSubs':
          instance.orderItemSubs?.map((e) => e?.toJson())?.toList(),
      'reviewWrite': instance.reviewWrite,
    };
