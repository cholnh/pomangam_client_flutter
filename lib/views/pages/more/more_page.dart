import 'package:flutter/material.dart';
import 'package:pomangam_client_flutter/views/widgets/home/drawer/home_drawer_body_widget.dart';

class MorePage extends StatefulWidget {
  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Future.value(false);
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                HomeDrawerBodyWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
