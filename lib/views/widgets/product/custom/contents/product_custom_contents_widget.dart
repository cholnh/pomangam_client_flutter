import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client_flutter/domains/product/product.dart';
import 'package:pomangam_client_flutter/providers/product/product_model.dart';
import 'package:pomangam_client_flutter/views/widgets/home/contents/item/home_contents_item_like_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/home/contents/item/home_contents_item_sub_title_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/product/normal/contents/product_count_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/product/normal/contents/product_price_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/product/normal/contents/product_review_widget.dart';
import 'package:provider/provider.dart';

class ProductCustomContentsWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ProductModel productModel = context.watch();
    Product product = productModel.product;
    return SliverToBoxAdapter(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 28),
          HomeContentsItemLikeWidget(cntLike: product?.cntLike),
          const  SizedBox(height: 7),
          HomeContentsItemSubTitleWidget(
            title: product?.productInfo?.name,
            description: product?.productInfo?.description,
          ),
          const SizedBox(height: 7),
          ProductReviewWidget(),
          const SizedBox(height: 10),
          Divider(height: kIsWeb ? 1.0 : 0.5, thickness: 0.5),
          const SizedBox(height: 15),
          ProductPriceWidget(),
          const SizedBox(height: 7),
          ProductCountWidget(),
          const SizedBox(height: 20),
          Divider(height: kIsWeb ? 1.0 : 0.5, thickness: 0.5),
        ],
      ),
    );
  }
}
