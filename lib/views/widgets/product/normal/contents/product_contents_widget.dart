import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client_flutter/domains/product/product.dart';
import 'package:pomangam_client_flutter/providers/product/product_model.dart';
import 'package:pomangam_client_flutter/views/widgets/home/contents/item/home_contents_item_like_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/home/contents/item/home_contents_item_sub_title_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/product/normal/contents/product_count_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/product/normal/contents/product_image_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/product/normal/contents/product_price_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/product/normal/contents/product_review_widget.dart';
import 'package:provider/provider.dart';

class ProductContentsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<ProductModel>(
        builder: (_, model, child) {
          Product product = model.product;
          return Column(
            children: <Widget>[
              ProductImageWidget(),
              const Padding(padding: EdgeInsets.only(bottom: 10.0)),
              HomeContentsItemLikeWidget(
                cntLike: product?.cntLike ?? 0,
              ),
              const Padding(padding: EdgeInsets.only(bottom: 7.0)),
              HomeContentsItemSubTitleWidget(
                  title: product?.productInfo?.name ?? '',
                  description: product?.productInfo?.description ?? ''
              ),
              const Padding(padding: EdgeInsets.only(bottom: 7.0)),
              ProductReviewWidget(),
              const Padding(padding: EdgeInsets.only(bottom: 10.0)),
              Divider(height: kIsWeb ? 1.0 : 0.5, thickness: 0.5),
              const Padding(padding: EdgeInsets.only(bottom: 15.0)),
              ProductPriceWidget(),
              const Padding(padding: EdgeInsets.only(bottom: 7.0)),
              ProductCountWidget(),
              const Padding(padding: EdgeInsets.only(bottom: 20.0)),
              Divider(height: kIsWeb ? 1.0 : 0.5, thickness: 0.5),
            ],
          );
        }
      ),
    );
  }
}