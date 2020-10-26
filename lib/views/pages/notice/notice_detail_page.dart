import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:pomangam_client_flutter/providers/notice/notice_model.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/basic_app_bar.dart';

class NoticeDetailPage extends StatefulWidget {

  final int nIdx;
  NoticeDetailPage(this.nIdx);

  @override
  _NoticeDetailPageState createState() => _NoticeDetailPageState();
}

class _NoticeDetailPageState extends State<NoticeDetailPage> {

  @override
  void initState() {
    super.initState();
    Provider.of<NoticeModel>(context, listen: false).fetchOne(nIdx: widget.nIdx);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoticeModel>(
      builder: (_, model, __) {
        return Scaffold(
          appBar: BasicAppBar(
            title: '${model.notice?.title ?? ''}',
            leadingIcon: Icon(CupertinoIcons.back, size: 20, color: Colors.black),
            elevation: 1.0,
          ),
          body: model.isFetching
            ? Center(
                child: CupertinoActivityIndicator(),
            )
            : Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, right: 20.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text('${_textDate(model.notice?.modifyDate)}', style: TextStyle(fontSize: 12.0, color: Colors.black.withOpacity(0.5))),
                  ),
                ),
                SizedBox(height: 15),
                SingleChildScrollView(
                child: Html(
                  data: model.notice?.contents ?? '',
                  backgroundColor: Theme.of(Get.context).backgroundColor,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  defaultTextStyle: TextStyle(fontSize: 14.0),
                ),
          ),
              ],
            ),
        );
      }
    );
  }

  String _textDate(DateTime dt) {
    return dt == null ? '' : DateFormat('yyyy. MM. dd').format(dt);
  }
}
