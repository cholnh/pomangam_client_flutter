import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pomangam_client_flutter/_bases/i18n/i18n.dart';

class HomeDrawerFooterWidget extends StatelessWidget {

  HomeDrawerFooterWidget();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          child: Container(
            child: Text('${Messages.companyName}', style: TextStyle(color: Theme.of(Get.context).backgroundColor, fontSize: 13.0)),
          ),
        ),
      ),
    );
  }
}
