import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class UserInfoCategoryTitleWidget extends StatelessWidget {
  final String title;

  UserInfoCategoryTitleWidget({this.title});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Theme.of(Get.context).primaryColor)),
            ),
            Divider(height: kIsWeb ? 1.0 : 0.5, thickness: 0.5)
          ],
        ),
      ),
    );
  }
}
