import 'package:flutter/material.dart';

import 'package:pomangam_client_flutter/_bases/util/string_utils.dart';
import 'package:pomangam_client_flutter/providers/product/product_model.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_shimmer.dart';
import 'package:provider/provider.dart';

class ProductPriceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProductModel model = context.watch();
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
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: model.isProductFetching
            ? CustomShimmer(width: 70, height: 20)
            : Text(
              totalPrice == 0 ? '' : '${StringUtils.comma(totalPrice)}원',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0, color: Theme.of(context).textTheme.headline1.color)
          ),
        )
      ],
    );
  }
}
