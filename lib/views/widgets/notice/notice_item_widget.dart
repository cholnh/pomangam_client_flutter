import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class NoticeItemWidget extends StatelessWidget {

  final int index;
  final String title;
  final String subTitle;
  final Function onTap;

  NoticeItemWidget({this.index, this.title, this.subTitle, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        color: Colors.transparent,
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
              trailing: const Icon(Icons.chevron_right, color: Color.fromRGBO(0x2e, 0x2e, 0x2e, 0.5))
            ),
            Divider(height: kIsWeb ? 1.0 : 0.5, thickness: 0.5),
          ],
        ),
      ),
    );
  }
}