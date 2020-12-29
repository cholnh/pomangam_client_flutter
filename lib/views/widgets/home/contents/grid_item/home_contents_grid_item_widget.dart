import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:pomangam_client_flutter/_bases/constants/endpoint.dart';
import 'package:pomangam_client_flutter/domains/store/store_summary.dart';
import 'package:pomangam_client_flutter/providers/order/time/order_time_model.dart';
import 'package:pomangam_client_flutter/views/pages/store/store_page.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_shimmer.dart';
import 'package:provider/provider.dart';

class HomeContentsGridItemWidget extends StatefulWidget {

  final StoreSummary summary;

  HomeContentsGridItemWidget({Key key, this.summary}): super(key: key);

  @override
  _HomeContentsGridItemWidgetState createState() => _HomeContentsGridItemWidgetState();
}

class _HomeContentsGridItemWidgetState extends State<HomeContentsGridItemWidget> {

  bool _isOrderable;
  bool _isOpening;

  @override
  void initState() {
    super.initState();
    DateTime userOrderDate = Provider.of<OrderTimeModel>(Get.context, listen: false)
        .userOrderDate;
    bool isNextDay = userOrderDate?.isAfter(DateTime.now());
    _isOrderable = isNextDay || widget.summary.isOrderable();
    _isOpening = widget.summary.storeSchedule.isOpening; // isNextDay || widget.summary.storeSchedule.isOpening;
  }

  @override
  Widget build(BuildContext context) {
    double opacity = _isOrderable && _isOpening ? 1 : 0.5;

    if (widget.summary == null) return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: CustomShimmer(
          height: 114,
          borderRadius: BorderRadius.circular(3.0)
      ),
    );
    return GestureDetector(
      onTap: () => _isOrderable && _isOpening
          ? _navigateToStorePage()
          : {},
      child: Opacity(
        opacity: opacity,
        child: Container(
          key: widget.key,
          decoration: BoxDecoration(
              border: Border.all(width: 0.3, color: Theme.of(Get.context).backgroundColor)
          ),
          child: kIsWeb ? _web() : _mobile(),
        ),
      )
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
              imageUrl: '${Endpoint.serverDomain}/${widget.summary?.storeImageMainPath}?v=${widget.summary.modifyDate}',
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
              Text(widget.summary.name, style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white
              ), maxLines: 1, overflow: TextOverflow.ellipsis,),
              SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Theme.of(Get.context).primaryColor, size: 14),
                  SizedBox(width: 3),
                  Text('${widget.summary.avgStar.toStringAsFixed(1)}', style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white
                  )),
                  SizedBox(width: 5),
                  Text('(${widget.summary.cntReview})', style: TextStyle(
                      fontSize: 12,
                      color: Colors.white
                  ))
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _web() {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: <Widget>[
        CachedNetworkImage(
          imageUrl: '${Endpoint.serverDomain}/${widget.summary?.storeImageMainPath}?v=${widget.summary.modifyDate}',
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
              Text(widget.summary.name, style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white
              ), maxLines: 1, overflow: TextOverflow.ellipsis,),
              SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Theme.of(Get.context).primaryColor, size: 14),
                  SizedBox(width: 3),
                  Text('${widget.summary.avgStar.toStringAsFixed(1)}', style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white
                  )),
                  SizedBox(width: 5),
                  Text('(${widget.summary.cntReview})', style: TextStyle(
                      fontSize: 12,
                      color: Colors.white
                  ))
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  void _navigateToStorePage() {
    Get.to(StorePage(sIdx: widget.summary.idx), transition: Transition.cupertino, duration: Duration.zero);
  }
}
