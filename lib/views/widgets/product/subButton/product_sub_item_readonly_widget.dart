import 'package:flutter/material.dart';

import 'package:pomangam_client_flutter/_bases/util/string_utils.dart';
import 'package:pomangam_client_flutter/domains/product/sub/product_sub.dart';

class ProductSubItemReadOnlyWidget extends StatelessWidget {

  final ProductSub sub;

  ProductSubItemReadOnlyWidget({this.sub});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: EdgeInsets.only(left: 20.0, right: 15.0),
        subtitle: sub?.productSubInfo?.description != null
            ? Text('${sub.productSubInfo.description} ${sub.productSubInfo?.subDescription ?? ''}', style: TextStyle(fontSize: 12.0))
            : null,
      title: Text('${sub.productSubInfo?.name ?? ''}', style: TextStyle(fontSize: 13.0)),
      trailing: Text('+ ${StringUtils.comma(sub?.salePrice)}원', style: TextStyle(fontSize: 13.0)),
    );
  }
}
