import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:pomangam_client_flutter/_bases/constants/endpoint.dart';
import 'package:get/get.dart';

class EventItemWidget extends StatelessWidget {

  final int index;
  final String title;
  final String subTitle;
  final String trailingText;
  final Color trailingColor;
  final Function onTap;

  EventItemWidget({this.index, this.title, this.subTitle, this.trailingText, this.trailingColor, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        color: Colors.transparent,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '$title',
                      style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.headline1.color)
                    ),
                    Padding(padding: const EdgeInsets.only(bottom: 3.0)),
                    Text(
                      '$subTitle',
                      style: TextStyle(fontSize: 12.0, color: Colors.black.withOpacity(0.5)),
                    )
                  ],
                ),
                Text(
                  '$trailingText',
                  style: TextStyle(
                      fontSize: 12.0,
                      color: trailingColor == null ? Theme.of(Get.context).primaryColor : trailingColor,
                      fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
            Padding(padding: const EdgeInsets.only(bottom: 7.0)),
            Image.network(
                '${Endpoint.serverDomain}/assets/images/_bases/events/${index+1}.png',
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width,
                height: 60.0,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.error_outline)
            ),
            Padding(padding: const EdgeInsets.only(bottom: 20.0)),
            Divider(height: kIsWeb ? 1.0 : 0.5, thickness: 0.5),
            Padding(padding: const EdgeInsets.only(bottom: 20.0))
          ],
        ),
      ),
    );
  }
}