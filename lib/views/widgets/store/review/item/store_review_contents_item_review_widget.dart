import 'package:flutter/material.dart';


class StoreReviewContentsItemReviewWidget extends StatelessWidget {

  final String commentContents;
  final String date;

  StoreReviewContentsItemReviewWidget({this.commentContents, this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(5.0)
      ),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(15.0),
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Text('사장님', style: TextStyle(
                fontSize: 15,
                color: Theme.of(context).textTheme.headline1.color,
                fontWeight: FontWeight.bold
              )),
              SizedBox(width: 5),
              Text(date, style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600]
              ))
            ],
          ),
          SizedBox(height: 10),
          Text(commentContents, style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).textTheme.headline1.color,
          )),
        ],
      )
    );
  }
}
