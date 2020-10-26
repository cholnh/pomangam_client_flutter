import 'package:flutter/material.dart';

class HomeContentsItemReviewWidget extends StatelessWidget {

  final double opacity;
  final int cntComment;

  HomeContentsItemReviewWidget({this.opacity = 1.0, this.cntComment});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
                '리뷰 $cntComment개 모두 보기',
                style: TextStyle(fontSize: 12.0, color: Colors.grey)
            ),
            // const Padding(padding: EdgeInsets.only(bottom: 7.0)),
            // RichText(
            //   maxLines: 2,
            //   overflow: TextOverflow.ellipsis,
            //   textAlign: TextAlign.left,
            //   softWrap: true,
            //   text: TextSpan(
            //     style: TextStyle(
            //       fontSize: 13.0,
            //       color: Colors.black,
            //     ),
            //     children: <TextSpan>[
            //       TextSpan(text: 'momstouch ', style: TextStyle(fontWeight: FontWeight.bold)),
            //       TextSpan(text: '여기 정말 맛있따리 ㅋㅋ여기 정말 맛있따리 ㅋㅋ여기 정말 맛있따리 ㅋㅋ여기 정말 맛있따리 ㅋㅋ여기 정말 맛있따리 ㅋㅋ여기 정말 맛있따리 ㅋㅋ'),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
