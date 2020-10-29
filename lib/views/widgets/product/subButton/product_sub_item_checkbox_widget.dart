import 'package:flutter/material.dart';

import 'package:pomangam_client_flutter/_bases/util/string_utils.dart';
import 'package:pomangam_client_flutter/domains/product/sub/category/product_sub_category.dart';
import 'package:pomangam_client_flutter/domains/product/sub/product_sub.dart';
import 'package:pomangam_client_flutter/providers/product/product_model.dart';
import 'package:pomangam_client_flutter/views/widgets/product/sub/product_sub_item_tile_widget.dart';
import 'package:provider/provider.dart';

class ProductSubItemCheckBoxWidget extends StatelessWidget {

  final ProductSub sub;
  final ProductSubCategory productSubCategory;

  ProductSubItemCheckBoxWidget({this.sub, this.productSubCategory});

  @override
  Widget build(BuildContext context) {
    return ProductSubItemTileWidget(
      leading: Checkbox(
        value: sub.isSelected,
      ),
      title: '${sub.productSubInfo?.name ?? ''}',
      subtitle: sub?.productSubInfo?.description != null
        ? '${sub.productSubInfo.description} ${sub.productSubInfo?.subDescription ?? ''}'
        : null,
      trailing: Text('+ ${StringUtils.comma(sub?.salePrice)}원', style: TextStyle(fontSize: 13.0, color: Theme.of(context).textTheme.headline1.color)),
      onTap: () {
        context.read<ProductModel>().toggleProductSubIsSelected(
            productSubCategory: productSubCategory,
            subIdx: sub.idx,
            isRadio: false
        );
      },
    );
  }
}
