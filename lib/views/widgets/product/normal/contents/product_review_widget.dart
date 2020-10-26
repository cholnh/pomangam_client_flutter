import 'package:flutter/material.dart';
import 'package:pomangam_client_flutter/providers/product/product_model.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_shimmer.dart';
import 'package:provider/provider.dart';

class ProductReviewWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ProductModel productModel = context.watch();

    bool isFetching = productModel.isProductFetching;

    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if(isFetching) CustomShimmer(height: 13, width: 70)
          else Text(
              '리뷰 ${productModel.product.cntReply}개 모두 보기',
              style: TextStyle(fontSize: 12.0, color: Colors.grey)
          ),
          const Padding(padding: EdgeInsets.only(bottom: 7.0)),
          if(!isFetching) Column(
            children: _buildWidget(productModel),
          )
        ],
      ),
    );
  }

  List<Widget> _buildWidget(ProductModel productModel) {
    List<Widget> previewWidgets = productModel.product.replies?.map((preview) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 7.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: RichText(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                softWrap: true,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(text: '${preview.nickname} ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '${preview.contents}'),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Icon(
                  preview.isLike ? Icons.favorite : Icons.favorite_border,
                  color: Colors.grey, size: 12.0
              ),
            )
          ],
        ),
      );
    })?.toList();

    return previewWidgets ?? List();
  }
}
