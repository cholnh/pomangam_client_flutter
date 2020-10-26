// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item_sub_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItemSubResponse _$OrderItemSubResponseFromJson(Map<String, dynamic> json) {
  return OrderItemSubResponse(
    idx: json['idx'] as int,
    registerDate: json['registerDate'] == null
        ? null
        : DateTime.parse(json['registerDate'] as String),
    modifyDate: json['modifyDate'] == null
        ? null
        : DateTime.parse(json['modifyDate'] as String),
    nameProductSub: json['nameProductSub'] as String,
    idxProductSub: json['idxProductSub'] as int,
    saleCost: json['saleCost'] as int,
    quantity: json['quantity'] as int,
  );
}

Map<String, dynamic> _$OrderItemSubResponseToJson(
        OrderItemSubResponse instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'registerDate': instance.registerDate?.toIso8601String(),
      'modifyDate': instance.modifyDate?.toIso8601String(),
      'nameProductSub': instance.nameProductSub,
      'idxProductSub': instance.idxProductSub,
      'saleCost': instance.saleCost,
      'quantity': instance.quantity,
    };
