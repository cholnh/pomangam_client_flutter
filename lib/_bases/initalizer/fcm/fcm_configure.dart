import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/views/pages/_bases/base_page.dart';

MessageHandler onMessage = (Map<String, dynamic> message) async {
  print('on message!! $message');
};

MessageHandler onResume = (Map<String, dynamic> message) async {
  print('on Resume!! $message');
  String url = message['data']['screen'];
  if(url != null) {
    switch(url) {
      case '/search':
        Get.to(BasePage());
        break;
      case '/orderInfo':
        Get.to(BasePage());
        break;
      case '/userInfo':
        Get.to(BasePage());
        break;
    }
  }
};

MessageHandler onLaunch = (Map<String, dynamic> message) async {
  print('on launch!! $message');
};
