import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/_bases/key/pmg_key.dart';
import 'package:pomangam_client_flutter/_bases/constants/endpoint.dart';
import 'package:pomangam_client_flutter/providers/product/product_model.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_shimmer.dart';
import 'package:provider/provider.dart';
import 'package:scrolling_page_indicator/scrolling_page_indicator.dart';

class ProductImageWidget extends StatelessWidget {

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductModel>(
      builder: (_, model, child) {

        if(model.isProductFetching) return _shimmer();

        List<String> imagePaths = List();
        if(model.product != null) {
          imagePaths.add(model.product.productImageMainPath);
          imagePaths.addAll(model.product.productImageSubPaths);
        }

        return SizedBox(
          key: PmgKeys.productImage,
          height: MediaQuery.of(context).size.width - 70,
          child: Column(
            children: <Widget>[
              Expanded(
                child: PageView(
                  children: _buildPage(context, imagePaths),
                  controller: _controller,
                ),
              ),
              Opacity(
                opacity: (imagePaths.length) > 1 ? 1 : 0,
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: ScrollingPageIndicator(
                      dotColor: Colors.black12,
                      dotSelectedColor: Theme.of(Get.context).primaryColor,
                      dotSize: 5,
                      dotSelectedSize: 6,
                      dotSpacing: 9,
                      controller: _controller,
                      itemCount: (imagePaths.length),
                      orientation: Axis.horizontal
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildPage(BuildContext context, List<String> imagePaths) {
    return imagePaths.map((imagePath) {
      return GestureDetector(
        child: Container(
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              '${Endpoint.serverDomain}/$imagePath',
              fit: BoxFit.fill,
              errorBuilder: (context, url, error) => Icon(Icons.error_outline),
            )
        ),
      );
    }).toList();
  }

  Widget _shimmer() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: CustomShimmer(
        width: MediaQuery.of(Get.context).size.width,
        height: MediaQuery.of(Get.context).size.width - 90,
        borderRadius: BorderRadius.zero,
      ),
    );
  }
}
