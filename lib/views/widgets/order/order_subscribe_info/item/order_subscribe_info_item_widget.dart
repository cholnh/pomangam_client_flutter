import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client_flutter/_bases/constants/endpoint.dart';

import 'package:pomangam_client_flutter/views/widgets/order/order_info/item/order_info_current_item_body_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/order/order_subscribe_info/item/order_subscribe_info_item_footer_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/order/order_subscribe_info/item/order_subscribe_info_item_header_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/order/order_subscribe_info/item/order_subscribe_info_item_membership_widget.dart';

class OrderSubscribeInfoItemWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0)
          ),
          border: Border.all(
            width: 0.5,
            color: Colors.black.withOpacity(0.5),
          )
        ),
        child: Column(
          children: <Widget>[
            OrderSubscribeInfoItemHeaderWidget(title: '정기배송'),
            Divider(color: Colors.black.withOpacity(0.5), thickness: 0.5),
            OrderInfoCurrentItemBodyWidget(),
            Divider(color: Colors.black.withOpacity(0.5), thickness: 0.5, height: 0.0),
            OrderSubcribeInfoItemMembershipWidget(),
            OrderSubscribeInfoItemFooterWidget()
          ],
        ),
      ),
    );
  }
}
