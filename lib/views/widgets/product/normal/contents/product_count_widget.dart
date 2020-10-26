import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/providers/product/product_model.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_shimmer.dart';
import 'package:provider/provider.dart';

class ProductCountWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ProductModel productModel = context.watch();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 4.0, left: 20.0),
          child: productModel.isProductFetching
          ? CustomShimmer(width: 40, height: 20)
          : Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                '수량',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0, color: Theme.of(context).textTheme.headline1.color)
              ),
              Text(
                ' (최대 ${productModel.quantityOrderable}개)',
                style: TextStyle(fontSize: 12.0, color: Colors.black.withOpacity(0.5))
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0, right: 13.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                if (productModel.isProductFetching) _shimmer()
                else GestureDetector(
                  onTap: () => _onSelected(context, isUp: true),
                  child: Opacity(
                    opacity: productModel.quantityOrderable > productModel?.quantity ? 1.0 : 0.5,
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Theme.of(Get.context).primaryColor,
                        border: Border.all(
                            width: 1.5,
                            color: Theme.of(Get.context).primaryColor
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.add, color: Theme.of(Get.context).backgroundColor, size: 13.0),
                    ),
                  ),
                ),
                if (productModel.isProductFetching) SizedBox(width: 25)
                else Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text('${productModel?.quantity ?? ''}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Theme.of(context).textTheme.headline1.color))
                ),
                if (productModel.isProductFetching) _shimmer()
                else GestureDetector(
                  onTap: () => _onSelected(context, isUp: false),
                  child: Opacity(
                    opacity: (productModel?.quantity ?? 0) <= 1 ? 0.5 : 1.0,
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Theme.of(Get.context).primaryColor,
                        border: Border.all(
                            width: 1.5,
                            color: Theme.of(Get.context).primaryColor
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.remove, color: Theme.of(Get.context).backgroundColor, size: 13.0),
                    ),
                  ),
                ),
              ],
            )
          ),
        ),
      ],
    );
  }

  void _onSelected(BuildContext context, {bool isUp}) {
    ProductModel productModel = context.read();
    if(isUp) {
      if(productModel.quantityOrderable > productModel.quantity) {
        productModel.changeUpQuantity();
      }
    } else {
      productModel.changeDownQuantity();
    }
  }

  Widget _shimmer() => Padding(
    padding: const EdgeInsets.only(right: 3.0),
    child: CustomShimmer(width: 35, height: 35, borderRadius: BorderRadius.circular(50)),
  );
}
