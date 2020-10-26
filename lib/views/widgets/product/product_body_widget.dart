import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client_flutter/domains/product/product_type.dart';
import 'package:pomangam_client_flutter/views/widgets/product/custom/product_custom_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/product/normal/product_normal_widget.dart';

class ProductBodyWidget extends StatelessWidget {

  final ProductType type;

  ProductBodyWidget({this.type});

  @override
  Widget build(BuildContext context) {

    switch(type) {
      case ProductType.NORMAL:
        return ProductNormalWidget();
      case ProductType.CUSTOMIZING_2:
      case ProductType.CUSTOMIZING_3:
      case ProductType.CUSTOMIZING_4:
      case ProductType.CUSTOMIZING_5:
      case ProductType.CUSTOMIZING_6:
        return ProductCustomWidget(type: type);
      default:
        return _loading();
    }
  }

  Widget _loading() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(child: CupertinoActivityIndicator()),
    );
  }
}
