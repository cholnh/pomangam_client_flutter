import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pomangam_client_flutter/_bases/util/string_utils.dart';
import 'package:pomangam_client_flutter/domains/promotion/promotion.dart';
import 'package:pomangam_client_flutter/providers/product/product_model.dart';
import 'package:pomangam_client_flutter/providers/promotion/promotion_model.dart';
import 'package:provider/provider.dart';

class RequirementCollapsedWidget extends StatelessWidget {

  final Function onSelected;

  RequirementCollapsedWidget({this.onSelected});

  @override
  Widget build(BuildContext context) {
    ProductModel productModel = Provider.of<ProductModel>(context);
    int discountPrice = promotionDiscountCost(productModel.quantity);
    int totalPrice = productModel.totalPrice();

    return GestureDetector(
      onTap: onSelected,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(Get.context).primaryColor,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
        ),
        margin: const EdgeInsets.fromLTRB(10.0, 24.0, 10.0, 0.0),
        child: Stack(
          children: <Widget>[
            Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        '카트에 추가',
                        style: TextStyle(color: Theme.of(Get.context).backgroundColor, fontWeight: FontWeight.bold, fontSize: 15.0)
                    ),
                  ],
                )
            ),
            totalPrice != 0
            ? Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Text(
                      '${StringUtils.comma(totalPrice - discountPrice)}원',
                      style: TextStyle(color: Theme.of(Get.context).backgroundColor, fontSize: 14.0)
                  ),
                )
            )
            : Container(),
          ],
        ),
      ),
    );
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
