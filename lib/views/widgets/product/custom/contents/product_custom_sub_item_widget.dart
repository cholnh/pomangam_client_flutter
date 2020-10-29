import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client_flutter/_bases/constants/endpoint.dart';
import 'package:pomangam_client_flutter/_bases/util/string_utils.dart';
import 'package:pomangam_client_flutter/domains/product/sub/category/product_sub_category.dart';
import 'package:pomangam_client_flutter/providers/product/product_model.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_dialog_utils.dart';
import 'package:pomangam_client_flutter/views/widgets/product/sub/product_sub_item_tile_widget.dart';
import 'package:provider/provider.dart';

class ProductCustomSubItemWidget extends StatelessWidget {

  final ProductSubCategory productSubCategory;

  ProductCustomSubItemWidget({this.productSubCategory});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          color: Color.fromRGBO(0, 0, 0, 0.05),
          padding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 15.0),
          child: Text('${productSubCategory.categoryTitle}', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.headline1.color))
        ),
        Column(
          children: _subButtonGroup(context)
        )
      ],
    );
  }

  List<Widget> _subButtonGroup(BuildContext context) {
    return productSubCategory.productSubs.map((sub) {
      return ProductSubItemTileWidget(
          isActive: sub.isTempActive,
          selected: sub.isSelected,
          leading: SizedBox(
            width: 90,
            height: 65,
            child: Image.network(
              '${Endpoint.serverDomain}/${sub.productImageMainPath}',
              fit: BoxFit.fill,
              errorBuilder: (context, url, error) => Icon(Icons.error_outline),
            ),
          ),
          title: '${sub.productSubInfo?.name ?? ''}',
          subtitle: sub?.productSubInfo?.description != null
            ? '${sub.productSubInfo.description ?? ''} ${sub.productSubInfo?.subDescription ?? ''}'
            : null,
          trailing: Text('+ ${StringUtils.comma(sub?.salePrice)}원', style: TextStyle(fontSize: 13.0, color: Colors.black)),
          onTap: () {
            context.read<ProductModel>().toggleProductSubIsSelected(
                productSubCategory: productSubCategory,
                subIdx: sub.idx,
                isRadio: true
            );
          },
          onInActiveTap: () {
            DialogUtils.dialog(context, '품절되었습니다.');
          },
      );
    }).toList();
  }
}