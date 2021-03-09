import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animation_set/widget/transition_animations.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:injector/injector.dart';
import 'package:package_info/package_info.dart';
import 'package:pomangam_client_flutter/_bases/i18n/i18n.dart';
import 'package:pomangam_client_flutter/_bases/initalizer/initializer.dart';
import 'package:pomangam_client_flutter/_bases/util/log_utils.dart';
import 'package:pomangam_client_flutter/_bases/util/toast_utils.dart';
import 'package:pomangam_client_flutter/domains/version/version.dart';
import 'package:pomangam_client_flutter/providers/version/version_model.dart';
import 'package:pomangam_client_flutter/views/pages/_bases/error_page.dart';
import 'package:pomangam_client_flutter/views/pages/deliverysite/delivery_site_page.dart';
import 'package:pomangam_client_flutter/views/pages/deliverysite/delivery_site_page_type.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  AppUpdateInfo _updateInfo;

  String version;
  String buildNumber;

  @override
  void initState() {
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
          ) else Container(
            child: Text(
                'web',
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
    if(!kIsWeb) {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      setState(() {
        this.version = packageInfo.version;
        this.buildNumber = packageInfo.buildNumber;
      });

      await InAppUpdate.checkForUpdate().then((info) {
        _updateInfo = info;
        logWithDots('checkForUpdate', 'InAppUpdate.checkForUpdate', 'success');
      }).catchError((e) => _showError(e, where: 'checkForUpdate'));

      Version version = await context.read<VersionModel>().fetch();
      if(version != null) {
        final int currentVersion = int.parse(buildNumber);
        final int latestVersion = version.latestVersion;
        final int minimumVersion = version.minimumVersion;

        if(_updateInfo?.updateAvailable ?? false) {
          if(latestVersion > currentVersion && currentVersion >= minimumVersion) {
            // 백그라운드 Update
            await InAppUpdate.startFlexibleUpdate().then((_) {
              logWithDots('startFlexibleUpdate', 'InAppUpdate.startFlexibleUpdate', 'success');
            }).catchError((e) => _showError(e, where: 'startFlexibleUpdate'));
          } else if(minimumVersion > currentVersion) {
            // 강제 Update
            await InAppUpdate.performImmediateUpdate()
              .then((_) => logWithDots('performImmediateUpdate', 'InAppUpdate.performImmediateUpdate', 'success'))
              .catchError((e) => _showError(e, where: 'performImmediateUpdate'));
          }
        }
      }
    }

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      Injector.appInstance.getDependency<Initializer>()
        .initialize(
          onDone: _onDone,
          onServerError: _onServerError,
          deliverySiteNotIssuedHandler: _deliverySiteNotIssuedHandler
        ).catchError((err) => _onServerError());
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

  void _showError(dynamic exception, {String where}) {
    logWithDots('initialize', 'InAppUpdate.$where', 'failed', error: exception);
    ToastUtils.showToast(msg: exception.toString());
  }
}
