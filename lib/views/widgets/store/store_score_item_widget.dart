import 'package:flutter/material.dart';
import 'package:pomangam_client_flutter/providers/store/store_model.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_shimmer.dart';
import 'package:provider/provider.dart';

class StoreScoreItemWidget extends StatelessWidget {

  final String title;
  final String value;

  StoreScoreItemWidget({this.title, this.value});

  @override
  Widget build(BuildContext context) {
    bool isFetching = context.watch<StoreModel>().isStoreFetching;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        isFetching
          ? Padding(
            padding: const EdgeInsets.only(bottom: 3.0),
            child: CustomShimmer(height: 15, width: 30),
          )
          : Text('$value', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Theme.of(context).textTheme.headline1.color)),
        isFetching
          ? CustomShimmer(height: 15, width: 30)
          : Text('$title', style: TextStyle(fontSize: 13.0, color: Theme.of(context).textTheme.headline1.color))
      ],
    );
  }
}
