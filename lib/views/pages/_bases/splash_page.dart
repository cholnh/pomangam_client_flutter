import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animation_set/widget/transition_animations.dart';
import 'package:get/get.dart';
import 'package:injector/injector.dart';
import 'package:package_info/package_info.dart';
import 'package:pomangam_client_flutter/_bases/i18n/i18n.dart';
import 'package:pomangam_client_flutter/_bases/initalizer/initializer.dart';
import 'package:pomangam_client_flutter/views/pages/_bases/error_page.dart';
import 'package:pomangam_client_flutter/views/pages/deliverysite/delivery_site_page.dart';
import 'package:pomangam_client_flutter/views/pages/deliverysite/delivery_site_page_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  String version;
  String buildNumber;

  @override
  void initState() {
    _appVersion();
    _readyInitialize(); // 초기화 준비
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: RotationTransition(
              turns: AlwaysStoppedAnimation(332 / 360),
              child: Image(
                image: const AssetImage('assets/logo_transparant.png'),
                width: 150,
                height: 150,
              ),
            ),
            alignment: Alignment.center,
          ),
          Container(
            child: Text(
                '${Messages.companyName}',
                style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).backgroundColor
                )),
            margin: const EdgeInsets.only(bottom: 65),
            alignment: Alignment.bottomCenter,
          ),
          Container(
            child: YYThreeLine(),
            margin: const EdgeInsets.only(bottom: 40),
            alignment: Alignment.bottomCenter,
          ),
          if (version != null) Container(
            child: Text(
                '$version+$buildNumber',
                style: TextStyle(
                    fontSize: 13.0,
                    color: Theme.of(context).backgroundColor
                )),
            margin: const EdgeInsets.only(bottom: 15),
            alignment: Alignment.bottomCenter,
          ),
        ],
      ),
      backgroundColor: Theme.of(Get.context).primaryColor,
    );
  }

  void _readyInitialize() async {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      Injector.appInstance.getDependency<Initializer>()
        .initialize(
          onDone: _onDone,
          onServerError: _onServerError,
          deliverySiteNotIssuedHandler: _deliverySiteNotIssuedHandler
        ).catchError((err) => _onServerError());
    });
  }

  void _appVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      this.version = packageInfo.version;
      this.buildNumber = packageInfo.buildNumber;
    });
  }

  void _onDone() => Get.offAll(BasePage(), transition: Transition.cupertino);

  void _onServerError() => Get.offAll(ErrorPage(contents: 'Server Down'));// _router.navigateTo(context, '/error/Server Down', clearStack: true);

  void _deliverySiteNotIssuedHandler() => Get.offAll(DeliverySitePage(), arguments: DeliverySitePageType.FROM_INIT); // _router.navigateTo(context, '/dsites', clearStack: true);

  @visibleForTesting
  Future<void> clearPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  @visibleForTesting
  Future<void> printPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for(String key in prefs.getKeys()) {
      print('key: $key / value: ${prefs.get(key)}');
    }
  }
}
