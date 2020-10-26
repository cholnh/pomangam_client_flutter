import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client_flutter/domains/cart/item/cart_item.dart';
import 'package:pomangam_client_flutter/domains/order/item/sub/order_item_sub_request.dart';

part 'order_item_request.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class OrderItemRequest {

  int idxStore;
  int idxProduct;
  int quantity;
  String requirement;
  List<OrderItemSubRequest> orderItemSubs = List();

  OrderItemRequest({
    this.idxStore, this.idxProduct, this.quantity,
    this.requirement, this.orderItemSubs
  });

  Map<String, dynamic> toJson() => _$OrderItemRequestToJson(this);
  factory OrderItemRequest.fromJson(Map<String, dynamic> json) => _$OrderItemRequestFromJson(json);

  static List<OrderItemRequest> fromCartItems(List<CartItem> cartItems) {
    return cartItems.map((cartItem) {
      return OrderItemRequest(
          idxStore: cartItem.store.idx,
          idxProduct: cartItem.product.idx,
          quantity: cartItem.quantity,
          requirement: cartItem.requirement,
          orderItemSubs: cartItem.orderSubItems()
      );
    }).toList();
  }
}