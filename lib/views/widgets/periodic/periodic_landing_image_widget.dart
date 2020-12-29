import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/_bases/constants/endpoint.dart';
import 'package:scrolling_page_indicator/scrolling_page_indicator.dart';

class PeriodicLandingImageWidget extends StatelessWidget {

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {

    List<String> imagePaths = List();
    imagePaths
      ..add('assets/images/_bases/periodics/1.jpg')
      ..add('assets/images/_bases/periodics/2.jpg')
      ..add('assets/images/_bases/periodics/3.jpg');

    return SizedBox(
      height: 280,
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
}
