import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'delivery_site_search_widget.dart';

class DeliverySiteAppBar extends AppBar {
  final isFirst;
  DeliverySiteAppBar({
    this.isFirst
  }) : super(
    automaticallyImplyLeading: true,
    leading: !isFirst ? IconButton(
      icon: const Icon(Icons.close, color: Colors.black, size: 20),
      onPressed:() => Get.back(),
    ) : null,
    title: Container(),
    elevation: 1.0,
    actions: [
      DeliverySiteSearchWidget(isFirst)
    ]
  );
}