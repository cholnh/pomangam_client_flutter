import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pomangam_client_flutter/_bases/key/pmg_key.dart';
import 'package:pomangam_client_flutter/_bases/constants/endpoint.dart';
import 'package:scrolling_page_indicator/scrolling_page_indicator.dart';

class HomeContentsItemImageWidget extends StatelessWidget {

  final PageController _controller = PageController();

  final double opacity;
  final double height;
  final List<String> imagePaths;

  HomeContentsItemImageWidget({this.opacity, this.height, this.imagePaths});

  @override
  Widget build(BuildContext context) {

    List<Widget> items = imagePaths.map((imagePath)
      => _buildPage(context, imagePath)).toList();

    return Opacity(
      opacity: opacity,
      child: SizedBox(
        height: height,
        child: Column(
          children: <Widget>[
            Expanded(
              child: PageView(
                children: items,
                controller: _controller,
              ),
            ),
            imagePaths.length > 1
            ? Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: ScrollingPageIndicator(
                  dotColor: Colors.black12,
                  dotSelectedColor: Theme.of(Get.context).primaryColor,
                  dotSize: 5,
                  dotSelectedSize: 6,
                  dotSpacing: 9,
                  controller: _controller,
                  itemCount: imagePaths.length,
                  orientation: Axis.horizontal
                ),
              )
            : Container()
          ],
        ),
      ),
    );
  }

  Widget _buildPage(BuildContext context, String imagePath) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      child: Container(
          width: width,
          child: Image.network(
            '${Endpoint.serverDomain}/$imagePath',
            key: PmgKeys.homeContentsItemImage,
            fit: BoxFit.fill,
            errorBuilder: (context, error, stackTrace) => Icon(Icons.error_outline),
          )
      ),
    );
  }
}
