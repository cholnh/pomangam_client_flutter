import 'dart:async';
import 'dart:isolate';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/_bases/constants/endpoint.dart';
import 'package:pomangam_client_flutter/_bases/di/injector_register.dart';
import 'package:pomangam_client_flutter/_bases/i18n/i18n.dart';
import 'package:pomangam_client_flutter/_bases/route/route.dart';
import 'package:pomangam_client_flutter/_bases/theme/custom_theme.dart';
import 'package:pomangam_client_flutter/providers/_bases/providers.dart';
import 'package:pomangam_client_flutter/views/pages/_bases/splash_page.dart';
import 'package:provider/provider.dart';

void main() {
  GoogleMap.init('AIzaSyCfgL80z55BPeCaCQSfiyabWK_J8YJkd5s');
  WidgetsFlutterBinding.ensureInitialized();
  InjectorRegister.register();

  if(!kIsWeb) {
    Crashlytics.instance.enableInDevMode = true;
    FlutterError.onError = Crashlytics.instance.recordFlutterError;
    Isolate.current.addErrorListener(RawReceivePort((pair) async {
      final List<dynamic> errorAndStacktrace = pair;
      await Crashlytics.instance.recordError(
        errorAndStacktrace.first,
        errorAndStacktrace.last,
      );
    }).sendPort);
  }

  runZoned(() {
   runApp(MyApp());
  }, onError: Crashlytics.instance.recordError);

  runZonedGuarded(() {
     runApp(MyApp());
    // runApp(_devicePreview(
    //   enabled: true,
    //   builder: (ctx) => MyApp()
    // ));
  }, (Object error, StackTrace stackTrace) {
    print('zone error!! $error');
    print(stackTrace);
  });
}

Widget _devicePreview({bool enabled, WidgetBuilder builder}) {
  return MaterialApp(
      home: Scaffold(
        body: DevicePreview(
            enabled: enabled,
            builder: builder
        ),
      )
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: GetMaterialApp(
        title: '${Messages.appName}',
        themeMode: ThemeMode.light,
        theme: customTheme(context),
        darkTheme: customTheme(context, darkMode: true),
        home: SplashPage(),
        localizationsDelegates: [
          AppLocalizationDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate
        ],
        navigatorKey: Get.key,
        popGesture: true,
        defaultTransition: Transition.cupertino,
        transitionDuration: Duration.zero,
        getPages: route,
        builder: (context, child) => _webView(
          context: context,
          enabled: kIsPcWeb(context: context),
          child: child
        ),
        supportedLocales: [Locale('ko'), Locale('en')],
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  Widget _webView({BuildContext context, bool enabled, Widget child}) {
    if(!enabled) return child;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(size: Size(Endpoint.webWidth, Endpoint.webHeight)),
      child: Scaffold(
          backgroundColor: Colors.grey[100],
          body: Center(
            child: Container(
              width: Endpoint.webWidth,
              height: Endpoint.webHeight,
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.grey[500],
                    width: 0.5
                )
              ),
              child: child,
            ),
          )
      ),
    );
  }
}
