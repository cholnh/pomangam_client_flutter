// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item_sub_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItemSubRequest _$OrderItemSubRequestFromJson(Map<String, dynamic> json) {
  return OrderItemSubRequest(
    idxProductSub: json['idxProductSub'] as int,
    quantity: json['quantity'] as int,
  );
}

Map<String, dynamic> _$OrderItemSubRequestToJson(
        OrderItemSubRequest instance) =>
    <String, dynamic>{
      'idxProductSub': instance.idxProductSub,
      'quantity': instance.quantity,
    };
