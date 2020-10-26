import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client_flutter/providers/store/store_model.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_shimmer.dart';
import 'package:provider/provider.dart';

class StoreBrandImageWidget extends StatelessWidget {

  final String brandImagePath;

  StoreBrandImageWidget({this.brandImagePath});

  @override
  Widget build(BuildContext context) {
    bool isFetching = context.watch<StoreModel>().isStoreFetching;
    return isFetching
      ? CustomShimmer(width: 75, height: 75, borderRadius: BorderRadius.circular(50.0))
      : Container(
        child: CircleAvatar(
          child: Image.network(
            '$brandImagePath',
            width: 50,
            height: 50,
            fit: BoxFit.fill,
            errorBuilder: (context, url, error) => Icon(Icons.error),
          ),
          foregroundColor: Colors.white,
          backgroundColor: Colors.white,
        ),

        width: 75.0,
        height: 75.0,
        padding: const EdgeInsets.all(0.5),
        decoration: BoxDecoration(
          color: Colors.black12,
          shape: BoxShape.circle,
        )
    );
  }
}
