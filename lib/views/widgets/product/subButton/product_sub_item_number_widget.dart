import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pomangam_client_flutter/_bases/util/string_utils.dart';
import 'package:pomangam_client_flutter/domains/product/sub/product_sub.dart';

@deprecated
class ProductSubItemNumberWidget extends StatelessWidget {

  final ProductSub sub;

  ProductSubItemNumberWidget({this.sub});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 20.0, right: 15.0),
      subtitle: sub?.productSubInfo?.description != null
          ? Text('${sub.productSubInfo.description} ${sub.productSubInfo?.subDescription ?? ''}', style: TextStyle(fontSize: 12.0))
          : null,
      title: Text('${sub.productSubInfo.name}', style: TextStyle(fontSize: 13.0)),
      trailing: SizedBox(
        height: 40.0,
        width: 150.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('+ ${StringUtils.comma(sub?.salePrice)}원', style: TextStyle(fontSize: 13.0)),
            Padding(padding: EdgeInsets.only(right: 8.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(3.0),
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Theme.of(Get.context).primaryColor,
                    border: Border.all(
                        width: 1.5,
                        color: Theme.of(Get.context).primaryColor
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.add, color: Theme.of(Get.context).backgroundColor, size: 12),
                ),
                Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Text('1', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0))
                ),
                Container(
                  margin: EdgeInsets.all(3.0),
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Theme.of(Get.context).primaryColor,
                    border: Border.all(
                        width: 1.5,
                        color: Theme.of(Get.context).primaryColor
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.remove, color: Theme.of(Get.context).backgroundColor, size: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
