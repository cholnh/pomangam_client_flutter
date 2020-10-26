import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/_bases/constants/endpoint.dart';
import 'package:pomangam_client_flutter/domains/order/order_response.dart';
import 'package:pomangam_client_flutter/domains/order/order_type.dart';
import 'package:pomangam_client_flutter/views/pages/order/order_info/order_info_detail_page.dart';
import 'package:pomangam_client_flutter/views/pages/order/order_info/order_info_page_type.dart';
import 'package:pomangam_client_flutter/views/widgets/order/order_info/item/order_info_current_item_body_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/order/order_info/item/order_info_current_item_footer_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/order/order_info/item/order_info_current_item_header_widget.dart';

class OrderInfoCurrentItemWidget extends StatelessWidget {

  final OrderResponse order;
  final OrderInfoPageType pageType;

  OrderInfoCurrentItemWidget({this.order, this.pageType});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
                Radius.circular(13.0)
            ),
            border: Border.all(
              width: 0.5,
              color: Theme.of(context).textTheme.subtitle2.color,
            )
          ),
          child: Column(
            children: <Widget>[
              OrderInfoCurrentItemHeaderWidget(order: order),
              Divider(color: Theme.of(context).textTheme.subtitle2.color, thickness: 0.5),
              OrderInfoCurrentItemBodyWidget(order: order, pageType: pageType),
              OrderInfoCurrentItemFooterWidget(order: order)
            ],
          ),
        ),
      ),
    );
  }

  void _onTap() {
    Get.to(OrderInfoDetailPage(order: order),
      transition: Transition.cupertino,
      duration: Duration.zero
    );
  }
}
