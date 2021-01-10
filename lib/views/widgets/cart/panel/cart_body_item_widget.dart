import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:pomangam_client_flutter/_bases/constants/endpoint.dart';
import 'package:pomangam_client_flutter/_bases/util/string_utils.dart';
import 'package:pomangam_client_flutter/_bases/util/toast_utils.dart';
import 'package:pomangam_client_flutter/domains/cart/cart.dart';
import 'package:pomangam_client_flutter/domains/cart/item/cart_item.dart';
import 'package:pomangam_client_flutter/domains/promotion/promotion.dart';
import 'package:pomangam_client_flutter/providers/cart/cart_model.dart';
import 'package:pomangam_client_flutter/providers/deliverysite/delivery_site_model.dart';
import 'package:pomangam_client_flutter/providers/order/time/order_time_model.dart';
import 'package:pomangam_client_flutter/providers/promotion/promotion_model.dart';
import 'package:pomangam_client_flutter/views/pages/store/store_page.dart';
import 'package:provider/provider.dart';

class CartBodyItemWidget extends StatelessWidget {

  final Cart cart;
  final List<CartItem> cartItems;
  final bool isLast;

  CartBodyItemWidget({this.cart, this.cartItems, this.isLast});

  @override
  Widget build(BuildContext context) {
    CartItem first = cartItems.first;
    bool isOrderable = first.isOrderable;
    bool isOrderableTime = cart.isOrderableDateTime();

    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () => _navigateToStore(context, first.store.idx),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Opacity(
                  opacity: isOrderable && isOrderableTime ? 1.0 : 0.5,
                  child: Row(
                    children: <Widget>[
                      Container(
                          margin: const EdgeInsets.only(right: 5.0),
                          child: CircleAvatar(
                              child: Image.network(
                                '${Endpoint.serverDomain}/${first.store.brandImagePath}',
                                fit: BoxFit.fill,
                                width: 12.0,
                                height: 12.0,
                                errorBuilder: (context, url, error) => Icon(Icons.error_outline),
                              ),
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.white
                          ),
                          width: 18.0,
                          height: 18.0,
                          padding: const EdgeInsets.all(0.5),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            shape: BoxShape.circle,
                          )
                      ),
                      Text('${first.store.storeInfo.name}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Theme.of(context).textTheme.headline1.color)),
                      Text(' (${first?.quantityOrderable ?? 0}개 주문가능)', style: TextStyle(fontSize: 13.0, color: Colors.black.withOpacity(0.5)))
                    ],
                  ),
                ),
                isOrderable && isOrderableTime
                ? Container()
                : Text(
                    !isOrderable
                      ? '주문량 초과'
                      : !isOrderableTime
                        ? '주문시간 초과'
                        : '',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(Get.context).primaryColor, fontSize: 13.0))
              ],
            ),
          ),
          Padding(padding: const EdgeInsets.only(bottom: 5.0)),
          Column(
            children: _itemsWidget(context, isOrderable),
          ),
          isLast ? Container() : Divider(height: 20.0, thickness: 0.5)
        ],
      ),
    );
  }

  List<Widget> _itemsWidget(BuildContext context, bool isOrderable) {
    return this.cartItems.map((cartItem)
    => Padding(
      padding: const EdgeInsets.only(left: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Opacity(
                opacity: isOrderable ? 1.0 : 0.3,
                child: Text('${cartItem.product.productInfo.name} ${cartItem.quantity}개', style: TextStyle(fontSize: 14.0, color: Theme.of(context).textTheme.headline1.color))
              ),
              Row(
                children: <Widget>[
                  Opacity(
                    opacity: isOrderable ? 1.0 : 0.3,
                    child: Text('${StringUtils.comma(cartItem.totalPrice() - promotionDiscountCost(cartItem.quantity))}원', style: TextStyle(fontSize: 13.0, color: Theme.of(context).textTheme.headline1.color))
                  ),
                  Padding(padding: EdgeInsets.only(right: 5.0)),
                  GestureDetector(
                    onTap: () => _removeCartItem(context, cartItem),
                    child: Container(
                        color: Theme.of(Get.context).backgroundColor,
                        padding: EdgeInsets.all(5.0),
                        child: Icon(Icons.clear, size: 18.0, color: isOrderable ? Theme.of(context).textTheme.headline1.color : Theme.of(Get.context).primaryColor)
                    ),
                  ),
                ],
              )
            ],
          ),
          Opacity(
            opacity: isOrderable ? 1.0 : 0.3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _subItems(cartItem),
            ),
          ),
        ],
      ),
    )).toList();
  }

  List<Widget> _subItems(CartItem cartItem) {
    List<Widget> widgets = cartItem.subs.map((sub) {
      return Text(' - ${sub.productSubInfo.name} ${cartItem.quantity}개', style: TextStyle(fontSize: 13.0, color: Colors.black.withOpacity(0.5)));
    }).toList();
    if(cartItem.requirement != null && cartItem.requirement.isNotEmpty) {
      widgets.add(Text(' - ${cartItem.requirement}', style: TextStyle(fontSize: 13.0, color: Colors.black.withOpacity(0.5))));
    }
    return widgets;
  }

  void _removeCartItem(BuildContext context, CartItem cartItem) {
    DeliverySiteModel deliverySiteModel = Provider.of<DeliverySiteModel>(context, listen: false);
    OrderTimeModel orderTimeModel = Provider.of<OrderTimeModel>(context, listen: false);
    CartModel cartModel = Provider.of<CartModel>(context, listen: false);

    cartModel.cart.removeItem(cartItem);
    cartModel.updateOrderableStore(
      dIdx: deliverySiteModel.userDeliverySite?.idx,
      oIdx: orderTimeModel.userOrderTime?.idx,
      oDate: orderTimeModel.userOrderDate
    );

    ToastUtils.showToast(msg: "삭제되었습니다.");
  }

  void _navigateToStore(BuildContext context, int sIdx) {
    Get.to(StorePage(sIdx: sIdx), transition: Transition.cupertino, duration: Duration.zero);
  }

  int promotionDiscountCost(int q) {
    int total = 0;

    List<Promotion> promotions = Get.context.read<PromotionModel>().promotions;
    for(Promotion promotion in promotions) {
      total += promotion.discountCost;
    }
    return total * q;
  }
}
