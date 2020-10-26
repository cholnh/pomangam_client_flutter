import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client_flutter/domains/_bases/entity_auditing.dart';
import 'package:pomangam_client_flutter/domains/order/item/sub/order_item_sub_response.dart';

part 'order_item_response.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class OrderItemResponse extends EntityAuditing {

  int idxStore;
  String nameStore;
  int idxProduct;
  String nameProduct;
  int saleCost;
  int quantity;
  String requirement;
  List<OrderItemSubResponse> orderItemSubs = List();
  bool reviewWrite;

  OrderItemResponse({
    int idx, DateTime registerDate, DateTime modifyDate,
    this.idxStore, this.nameStore, this.idxProduct, this.nameProduct, this.saleCost,
    this.quantity, this.requirement, this.orderItemSubs, this.reviewWrite
  }): super(idx: idx, registerDate: registerDate, modifyDate: modifyDate);

  Map<String, dynamic> toJson() => _$OrderItemResponseToJson(this);
  factory OrderItemResponse.fromJson(Map<String, dynamic> json) => _$OrderItemResponseFromJson(json);

  @override
  String toString() {
    return '[OrderItemResponse]\n\nnameStore: $nameStore\nnameProduct: $nameProduct\nsaleCost: $saleCost\nquantity: $quantity\nrequirement: $requirement\n\n$orderItemSubs';
  }
}