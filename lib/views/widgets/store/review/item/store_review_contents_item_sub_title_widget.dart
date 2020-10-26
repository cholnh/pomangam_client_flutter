import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client_flutter/_bases/constants/endpoint.dart';


class StoreReviewContentsItemSubTitleWidget extends StatelessWidget {

  final String title;
  final String description;
  final String date;

  StoreReviewContentsItemSubTitleWidget({this.title, this.description, this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width - 30,
            child: Text(title,
              style: TextStyle(
                fontSize: 15.0,
                color: Theme.of(context).textTheme.headline1.color,
                fontWeight: FontWeight.bold
              )
            ),
          ),
          SizedBox(height: 10),
          Text(description,
            textAlign: TextAlign.left,
            softWrap: true,
            style: TextStyle(
              fontSize: 14.0,
              color: Theme.of(context).textTheme.headline1.color
            )
          )
        ],
      )
    );
  }
}
