import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class PaymentPointLogItemWidget extends StatelessWidget {

  final int index;
  final String title;
  final String subTitle;
  final String trailingText;

  PaymentPointLogItemWidget({this.index, this.title, this.subTitle, this.trailingText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
            title:  Text(
              '$title',
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)
            ),
            subtitle: Text(
              '$subTitle',
              style: TextStyle(fontSize: 12.0, color: Colors.black.withOpacity(0.5)),
            ),
            trailing: Text(
              '$trailingText',
              style: TextStyle(fontSize: 14.0, color: Theme.of(Get.context).primaryColor),
            ),
          ),
          Divider(height: kIsWeb ? 1.0 : 0.5, thickness: 0.5)
        ],
      ),
    );
  }
}
