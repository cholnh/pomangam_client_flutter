import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pomangam_client_flutter/_bases/util/string_utils.dart';
import 'package:pomangam_client_flutter/domains/promotion/promotion.dart';
import 'package:pomangam_client_flutter/providers/product/product_model.dart';
import 'package:pomangam_client_flutter/providers/promotion/promotion_model.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_shimmer.dart';
import 'package:provider/provider.dart';

class ProductPriceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProductModel model = context.watch();
    int discountPrice = promotionDiscountCost(model.quantity);
    int totalPrice = model.totalPrice();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: model.isProductFetching
            ? CustomShimmer(width: 40, height: 20)
            : Text(
              '가격',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0, color: Theme.of(context).textTheme.headline1.color)
          ),
        ),
        Row(
          children: [
            if(discountPrice != 0) Text(
              totalPrice == 0
                  ? ''
                  : '${StringUtils.comma(totalPrice)}원',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0, color: Theme.of(context).textTheme.headline1.color, decoration: TextDecoration.lineThrough)
            ),
            if(discountPrice != 0) SizedBox(width: 20),
            if(discountPrice != 0) Icon(Icons.arrow_right_alt, size: 20),
            if(discountPrice != 0) SizedBox(width: 20),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: model.isProductFetching
                ? CustomShimmer(width: 70, height: 20)
                : Text(
                  totalPrice == 0
                    ? ''
                    : '${StringUtils.comma(totalPrice - discountPrice)}원',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0, color: Theme.of(context).textTheme.headline1.color)
              ),
            ),
          ],
        )
      ],
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
