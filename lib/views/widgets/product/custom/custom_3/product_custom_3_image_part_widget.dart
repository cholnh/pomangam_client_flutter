import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:pomangam_client_flutter/_bases/constants/endpoint.dart';
import 'package:pomangam_client_flutter/domains/product/sub/category/product_sub_category.dart';
import 'package:pomangam_client_flutter/domains/product/sub/product_sub.dart';

class ProductCustom3ImagePartWidget extends StatelessWidget {

  final double height;
  final bool isSelected;
  final Function onTap;
  final ProductSubCategory category;
  final BorderRadiusGeometry borderRadius;

  ProductCustom3ImagePartWidget({this.height, this.isSelected, this.onTap, this.category, this.borderRadius});

  final Color borderColor = Colors.white;
  final double borderWidth = 2.5;
  final Color innerShadowColor = Colors.black26;
  final Color bottomColor = Colors.white;
  final double filterOpacity = 0.3;
  
  @override
  Widget build(BuildContext context) {
    ProductSub sub = category.selectedProductSub.isNotEmpty ? category.selectedProductSub?.first : null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
            color: sub?.productImageMainPath != null
                ? bottomColor
                : Colors.white.withOpacity(1-filterOpacity),
            borderRadius: borderRadius,
            border: Border.all(
              color: isSelected ? Theme.of(context).primaryColor : borderColor,
              width: borderWidth
            ),
            image: sub?.productImageMainPath != null
                ? DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(filterOpacity), BlendMode.darken),
                image: CachedNetworkImageProvider(
                  '${Endpoint.serverDomain}/${sub.productImageMainPath}',
                )
            )
                : null
        ),
        child: Center(
          child: sub?.productSubInfo?.name == null
              ? Text(
            '${category.categoryTitle}',
            style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: Colors.white),
          )
              : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${sub?.productSubInfo?.name}',
                  style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                (sub?.salePrice ?? 0) == 0
                    ? Container()
                    : Text(
                  '+${sub?.salePrice}원',
                  style: TextStyle(fontSize: 12.0, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
