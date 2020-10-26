import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      child: Consumer<DeliverySiteModel>(
        builder: (_, model, __) {
          return Row(
            children: <Widget>[
              Text('${model?.userDeliverySite?.name ?? ''}', key: Get.context.read<HelpModel>().keyButton1, style: TextStyle(fontSize: 16.0, color: Colors.black)),
              Icon(Icons.arrow_drop_down, color: Theme.of(Get.context).primaryColor)
            ],
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
