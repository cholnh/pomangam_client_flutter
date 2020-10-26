import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {

  final double width;
  final double height;
  final BorderRadius borderRadius;

  CustomShimmer({
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    if(kIsWeb) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: borderRadius == null
            ? BorderRadius.circular(13.0)
            : borderRadius,
        ),
      );
    } else {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: borderRadius == null
                ? BorderRadius.circular(13.0)
                : borderRadius,
          ),
        ),
      );
    }
  }
}
