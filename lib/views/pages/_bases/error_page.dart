import 'package:flutter/material.dart';
import 'package:pomangam_client_flutter/_bases/i18n/messages.dart';
import 'package:pomangam_client_flutter/_bases/key/pmg_key.dart';

class ErrorPage extends StatelessWidget {
  final String contents;

  ErrorPage({
    Key key,
    this.contents})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false), // 뒤로가기 방지
      child: Scaffold(
        key: PmgKeys.errorPage,
        body: SafeArea(
          child: Center(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(Messages.errorMsg, style: TextStyle(fontSize: 26)),
                  Text(contents, style: TextStyle(fontSize: 20)),
                  const Padding(padding: EdgeInsets.only(bottom: 20)),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
