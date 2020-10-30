import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/providers/deliverysite/detail/delivery_detail_site_model.dart';
import 'package:pomangam_client_flutter/providers/help/help_model.dart';
import 'package:provider/provider.dart';

import 'package:pomangam_client_flutter/providers/deliverysite/delivery_site_model.dart';

class HomeAppBar extends AppBar {
  final Function onTitleTap;
  final Function onHelpTap;

  HomeAppBar({
    this.onTitleTap,
    this.onHelpTap,
  }) : super(
    centerTitle: false,
    automaticallyImplyLeading: true,
    elevation: 0.3,
    title :InkWell(
      key: Get.context.read<HelpModel>().keyButton1,
      child: Consumer<DeliveryDetailSiteModel>(
        builder: (_, detailModel, __) {
          return Consumer<DeliverySiteModel>(
            builder: (_, deliveryModel, __) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('${deliveryModel?.userDeliverySite?.name ?? ''}', style: const TextStyle(fontSize: 15.0, color: Colors.black)),
                      Icon(Icons.arrow_drop_down, color: Theme.of(Get.context).primaryColor)
                    ],
                  ),
                  Text('${detailModel?.userDeliveryDetailSite?.name ?? ''}', style: const TextStyle(fontSize: 11.0, color: Colors.grey)),
                ],
              );
            },
          );
        },
      ),
      onTap: onTitleTap,
    ),
    iconTheme: IconThemeData(color: Colors.black.withOpacity(0.5)),
    actions: [
      if(!kIsWeb) GestureDetector(
        onTap: onHelpTap,
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(Get.context).primaryColor,
                    shape: BoxShape.circle
                  ),
                  padding: const EdgeInsets.all(6),
                  child: Text('?', style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  )),
                ),
              ],
            ),
          ),
        ),
      )
    ]
  );
}
