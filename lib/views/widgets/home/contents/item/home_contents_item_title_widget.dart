import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/providers/help/help_model.dart';
import 'package:pomangam_client_flutter/providers/store/store_summary_model.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_shimmer.dart';
import 'package:provider/provider.dart';

class HomeContentsItemTitleWidget extends StatelessWidget {

  final String brandImagePath;
  final String title;
  final String subTitle;
  final Color subTitleColor;
  final double avgStar;
  final bool isFirst;

  HomeContentsItemTitleWidget({
    this.brandImagePath, this.title,
    this.subTitle, this.subTitleColor, this.avgStar,
    this.isFirst
  });

  @override
  Widget build(BuildContext context) {
    bool isFetching = context.watch<StoreSummaryModel>().isFetching;

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              if(isFetching) CustomShimmer(width: 34, height: 34, borderRadius: BorderRadius.circular(50))
              else Container(
                child: CircleAvatar(
                  child: Image.network(
                    brandImagePath,
                    fit: BoxFit.fill,
                    width: 24.0,
                    height: 24.0,
                    errorBuilder: (context, error, stackTrace) => Icon(Icons.error_outline),
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.white
                ),
                width: 34.0,
                height: 34.0,
                padding: const EdgeInsets.all(0.5),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  shape: BoxShape.circle,
                )
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if(isFetching) CustomShimmer(width: 70, height: 10)
                  else Text(
                    title,
                    style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.headline1.color)
                  ),
                  const SizedBox(height: 1),
                  if(isFetching) CustomShimmer(width: 50, height: 8)
                  else Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: _star(avgStar),
                  ),
                ],
              ),
            ],
          ),
          if(isFetching) CustomShimmer(width: 70, height: 10)
          else Text(
            subTitle,
            key: isFirst ? context.watch<HelpModel>().keyButton3 : null,
            style: TextStyle(
              color: subTitleColor,
              fontSize: 12.0
            )
          )
        ],
      ),
    );
  }

  List<Widget> _star(double avgStar) {
    int q = avgStar <= 0 ? 0 : avgStar ~/ 1;      // 몫
    double r = avgStar <= 0 ? 0 : avgStar % q;    // 나머지

    q = q > 5 ? 5 : q;
    int cnt = 0;
    List<Widget> widgets = List();
    for(int i=0; i<q; i++) {
      widgets.add(Icon(Icons.star, color: Theme.of(Get.context).primaryColor, size: 12.0));
      cnt++;
    }
    if(r != 0.0) {
      widgets.add(Icon(Icons.star_half, color: Theme.of(Get.context).primaryColor, size: 12.0));
      cnt++;
    }
    for(int i=0; i<5-cnt; i++) {
      widgets.add(Icon(Icons.star_border, color: Theme.of(Get.context).primaryColor, size: 12.0));
    }
    return widgets;
  }
}
