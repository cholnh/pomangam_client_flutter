import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pomangam_client_flutter/_bases/constants/endpoint.dart';
import 'package:pomangam_client_flutter/domains/product/product_summary.dart';
import 'package:pomangam_client_flutter/domains/product/product_type.dart';
import 'package:pomangam_client_flutter/providers/product/product_model.dart';
import 'package:pomangam_client_flutter/views/pages/product/product_page.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_dialog_utils.dart';
import 'package:provider/provider.dart';

class StoreProductItemWidget extends StatelessWidget {

  final ProductSummary summary;

  StoreProductItemWidget({Key key, this.summary}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: summary.isTempActive
        ? () => _navigateToProductPage(context)
        : () => DialogUtils.dialog(context, '품절되었습니다.'),
      child: Stack(
        children: [
          Opacity(
            opacity: summary.isTempActive ? 1.0 : 0.5,
            child: Container(
              key: key,
              decoration: BoxDecoration(
                border: Border.all(width: 0.3, color: Theme.of(Get.context).backgroundColor)
              ),
              child: kIsWeb ? _web() : _mobile(),
            ),
          ),
          if(!summary.isTempActive) Center(
              child: Text('품절', style: TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold))
          ),
        ],
      ),
    );
  }

  Widget _mobile() {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: <Widget>[
        ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black],
            ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
          },
          blendMode: BlendMode.darken,
          child: CachedNetworkImage(
            imageUrl: '${Endpoint.serverDomain}/${summary.productImageMainPath}',
            fit: BoxFit.fill,
            placeholder: (context, url) => CupertinoActivityIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error_outline),
          )
        ),
        Container(
          padding: EdgeInsets.only(left: 5.0, bottom: 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('${summary.name}', style: TextStyle(color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.w500)),
              if(summary.salePrice != 0) Text('${summary.salePrice}', style: TextStyle(color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _web() {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: <Widget>[
        CachedNetworkImage(
          imageUrl: '${Endpoint.serverDomain}/${summary.productImageMainPath}',
          fit: BoxFit.fill,
          placeholder: (context, url) => CupertinoActivityIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error_outline),
        ),
        Container(
          height: 65.0,
          decoration: BoxDecoration(
              color: Colors.white,
              gradient: LinearGradient(
                  begin: FractionalOffset.center,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(1.0),
                    Colors.black.withOpacity(0.0),
                  ],
                  stops: [1.0, 0.0]
              )
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 5.0, bottom: 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('${summary.name}', style: TextStyle(color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.w500)),
              if(summary.salePrice != 0) Text('${summary.salePrice}', style: TextStyle(color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.w500)),
            ],
          ),
        )
      ],
    );
  }

  void _navigateToProductPage(BuildContext context) {
    context.read<ProductModel>().product?.productImageSubPaths?.clear();

    Get.to(ProductPage(pIdx: summary.idx, type: summary.productType),
        transition: Transition.cupertino,
        duration: Duration.zero
    );
  }
}
