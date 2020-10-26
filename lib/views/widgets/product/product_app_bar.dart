import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/providers/deliverysite/delivery_site_model.dart';
import 'package:pomangam_client_flutter/providers/product/product_model.dart';
import 'package:pomangam_client_flutter/providers/sign/sign_in_model.dart';
import 'package:pomangam_client_flutter/views/widgets/sign/sign_modal.dart';
import 'package:provider/provider.dart';

class ProductAppBar extends AppBar {
  ProductAppBar() : super(
    automaticallyImplyLeading: true,
    leading: IconButton(
      icon: const Icon(CupertinoIcons.back, size: 20, color: Colors.black),
      onPressed:() => Get.back(),
    ),
    centerTitle: true,
    title: Consumer<ProductModel>(
      builder: (_, model, child) {
        return Column(
          children: <Widget>[
            Text(
              '${model?.product?.productInfo?.name ?? ''}',
              style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w600)
            ),
            Text(
                '${model?.product?.productCategoryTitle ?? ''}',
                style: TextStyle(color: Colors.black45, fontSize: 12.0)
            ),
          ],
        );
      },
    ),
    actions: <Widget>[
      Consumer<ProductModel>(
        builder: (_, model, child) {
          return IconButton(
            icon: model?.product?.isLike != null &&  model.product.isLike
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

void _onPressed({ProductModel model}) {
  if(model.product == null) return;

  bool isSignIn = Provider.of<SignInModel>(Get.context, listen: false).isSignIn();
  if(isSignIn) {
    DeliverySiteModel deliverySiteModel = Provider.of<DeliverySiteModel>(Get.context, listen: false);
    model.likeToggle(
        dIdx: deliverySiteModel.userDeliverySite?.idx,
        sIdx: model.product.idxStore,
        pIdx: model.product?.idx
    );
  } else {
    showSignModal(predicateUrl: Get.currentRoute);
  }
}