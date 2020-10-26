import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client_flutter/_bases/constants/endpoint.dart';

class CustomDivider extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border(
            top: BorderSide(
                color: Colors.grey[300],
                width: 1
            )
        )
      ),
      width: MediaQuery.of(context).size.width,
      height: 8,
    );
  }
}
