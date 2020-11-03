import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/providers/deliverysite/delivery_site_model.dart';

import 'package:pomangam_client_flutter/providers/sign/sign_in_model.dart';
import 'package:pomangam_client_flutter/providers/store/store_model.dart';
import 'package:pomangam_client_flutter/views/widgets/sign/sign_modal.dart';
import 'package:provider/provider.dart';

class StoreAppBar extends AppBar {
  StoreAppBar() : super(
    automaticallyImplyLeading: true,
    leading: IconButton(
      icon: const Icon(CupertinoIcons.back, size: 20, color: Colors.black),
      onPressed:() => Get.back()// Navigator.pop(context, false),
    ),
    centerTitle: true,
    title: Consumer<StoreModel>(
      builder: (_, model, child) {
        return Text(
            '${model?.store?.storeInfo?.name ?? ''}',
            style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w600)
        );
      },
    ),
    actions: <Widget>[
      Consumer<StoreModel>(
        builder: (_, model, child) {
          return model.isStoreFetching
          ? Container()
          : IconButton(
            icon: model?.store?.isLike != null &&  model.store.isLike
              ? Icon(Icons.favorite, color: Theme.of(Get.context).primaryColor)
              : Icon(Icons.favorite_border, color: Theme.of(Get.context).primaryColor),
            onPressed: () => _onPressed(model: model),
          );
        },
      )
    ],
    elevation: 0.0,
  );
}

void _onPressed({StoreModel model}) {
  if(model.store == null) return;

  bool isSignIn = Get.context.read<SignInModel>().isSignIn();
  if(isSignIn) {
    model.likeToggle(
        dIdx: Get.context.read<DeliverySiteModel>().userDeliverySite?.idx,
        sIdx: model.store?.idx
    );
  } else {
    showSignModal(predicateUrl: Get.currentRoute);
  }
}