import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/domains/_bases/page_request.dart';

class Endpoint {
  /// Initialize
  static const int fallbackTotalCount = 5;

  /// SignIn
  static const int maxAuthCodeSendCount = 5;
  static const int maxPasswordTryCount = 5;

  /// PageRequest
  static const int defaultPage = 0;
  static const int defaultSize = 10;
  static const int defaultProductsSize = 6;
  static const String defaultProperty = 'idx';
  static const Direction defaultDirection = Direction.DESC;

  /// Network
  static final String serverDomain = 'https://poman.kr:9530/api/v1.2'; // 'http://172.30.1.46:9530/api/v1.2'; // 'https://poman.kr:9530/api/v1.2'; // 'http://192.168.123.105:9530/api/v1.2';
  static final int connectTimeout = 5000;
  static final int receiveTimeout = 3000;
  static final String guestOauthTokenHeader = 'Z3Vlc3Q6c1pFSl45RV1la2pqLnt2Yw==';
  static final String loginOauthTokenHeader = 'bG9naW46eTdGTFtNc1o+M15wKE02eg==';

  /// BootPay
  static final String bootpayAndroidApplicationId = '5cc70f38396fa67747bd0684';
  static final String bootpayIosApplicationId = '5cc70f38396fa67747bd0685';
  static final String bootpayPg = 'kcp';
  static final String bootpayAppScheme = 'pomangamClientFlutterV3'; //'bootpayFlutterSample';

  /// Juso Api
  static final String jusoApiDomain = 'http://www.juso.go.kr/addrlink/addrLinkApi.do';
  static final String jusoApiKey = 'U01TX0FVVEgyMDIwMDUwNTE1MjgzNDEwOTcyNjY=';

  /// Coordinate Api
  static final String coordinateApiDomain = 'http://www.juso.go.kr/addrlink/addrCoordApiJsonp.do';
  static final String coordinateApiKey = 'U01TX0FVVEgyMDIwMDgwNDExMzQ0MTExMDAyMjA= ';

  /// customer service center
  static final String customerServiceCenterNumber = '050713006906';

  /// web mobile size
  static final double webWidth = 375;
  static final double webHeight = 667;

  /// vbank
  static final String vbank = '국민은행';
  static final String vbankOwner = '미스터포터';
  static final String vbankAccount = '598001-01-361949';

}

bool kIsPcWeb({BuildContext context}) {
  return kIsWeb && MediaQuery.of(context == null ? Get.context : context).size.width > 768 ;
}