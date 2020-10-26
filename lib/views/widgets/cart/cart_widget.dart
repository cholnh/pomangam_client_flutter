import 'package:flutter/material.dart';
import 'package:pomangam_client_flutter/providers/cart/cart_model.dart';
import 'package:pomangam_client_flutter/providers/deliverysite/delivery_site_model.dart';
import 'package:pomangam_client_flutter/providers/order/time/order_time_model.dart';
import 'package:pomangam_client_flutter/views/widgets/cart/panel/cart_panel_widget.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'collapsed/cart_collapsed_widget.dart';

class CartWidget extends StatefulWidget {

  final PanelController controller;

  CartWidget({this.controller});

  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {

  bool isPanelShown = false;

  @override
  Widget build(BuildContext context) {
    bool isShowCart = context.watch<CartModel>().cart.isNotEmpty();
    if(isShowCart) {
      return SlidingUpPanel(
        controller: widget.controller,
        minHeight: 80.0,
        maxHeight: 550.0,
        backdropEnabled: true,
        renderPanelSheet: false,
        onPanelOpened: _onCartOpen,
        onPanelClosed: _onCartClose,
        panel: CartPanelWidget(),
        collapsed: CartCollapsedWidget(
          onSelected: _onCartSelected
        ),
      );
    } else {
      return Container();
    }
  }

  void _onCartOpen() {
    //if(isPanelShown) return;
    isPanelShown = true;

    DeliverySiteModel deliverySiteModel = context.read();
    OrderTimeModel orderTimeModel = context.read();
    CartModel cartModel = context.read();

    cartModel.updateOrderableStore(
        dIdx: deliverySiteModel.userDeliverySite?.idx,
        oIdx: orderTimeModel.userOrderTime?.idx,
        oDate: orderTimeModel.userOrderDate
    );
  }

  void _onCartClose() {
    isPanelShown = false;
    context.read<CartModel>().changeIsUpdatedOrderableStore(false);
  }

  void _onCartSelected() {
    widget.controller.open();
  }
}
