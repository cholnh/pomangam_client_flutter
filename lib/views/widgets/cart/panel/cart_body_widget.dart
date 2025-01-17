import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client_flutter/domains/cart/item/cart_item.dart';
import 'package:pomangam_client_flutter/providers/cart/cart_model.dart';
import 'package:provider/provider.dart';

import 'cart_body_item_widget.dart';

class CartBodyWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (_, model, child) {
        List<CartItem> items = model.cart.items;
        if(items.isEmpty) {
          return SliverToBoxAdapter(
            child: Center(child: Text('장바구니가 비었습니다.', style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 14))),
          );
        }
        if(!model.isUpdatedOrderableStore) {
          return SliverToBoxAdapter(
            child: Center(child: CupertinoActivityIndicator())
          );
        }

        List<int> idxesStore = model.idxesStoreInCartItem().toList();
        return SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            int idxStore = idxesStore[index];
            List<CartItem> cartItems = model.cart.items.where((item) => item.store.idx == idxStore).toList();
            return CartBodyItemWidget(
              cart: model.cart,
              cartItems: cartItems,
              isLast: index == idxesStore.length - 1
            );
          } , childCount: idxesStore.length)
        );
      }
    );
  }
}
