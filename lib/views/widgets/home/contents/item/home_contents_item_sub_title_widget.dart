import 'package:flutter/material.dart';
import 'package:pomangam_client_flutter/providers/product/product_model.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_shimmer.dart';

import 'package:pomangam_client_flutter/views/widgets/home/contents/item/home_contents_item_widget.dart';
import 'package:provider/provider.dart';

class HomeContentsItemSubTitleWidget extends StatelessWidget {

  final double opacity;
  final String title;
  final String description;
  final String subDescription;
  final int maxLines;

  HomeContentsItemSubTitleWidget({this.opacity = 1.0, this.title = '', this.description = '', this.subDescription = '', this.maxLines = 2});

  @override
  Widget build(BuildContext context) {
    bool isFetching = context.watch<ProductModel>().isProductFetching;

    return Opacity(
      opacity: opacity,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 10, right: 10),
        child: isFetching
          ? CustomShimmer(height: 15, width: 140)
          : RichText(
          maxLines: maxLines,
          overflow: TextOverflow.clip,
          textAlign: TextAlign.left,
          softWrap: true,
          text: TextSpan(
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(text: '$title ', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: description),
              TextSpan(text: subDescription)
            ],
          ),
        )
      ),
    );
  }
}
