import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:pomangam_client_flutter/domains/user/enum/sex.dart';
import 'package:pomangam_client_flutter/providers/sign/sign_in_model.dart';
import 'package:pomangam_client_flutter/providers/sign/sign_up_model.dart';
import 'package:pomangam_client_flutter/views/pages/_bases/base_page.dart';
import 'package:pomangam_client_flutter/views/pages/sign/in/sign_in_view_type.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_dialog_utils.dart';
import 'package:provider/provider.dart';

class SignInPhoneNumberInputWidget extends StatelessWidget {

  final TextEditingController controller;
  final FocusNode focusNode;
  final Function onSelected;
  final bool isView;

  SignInPhoneNumberInputWidget({this.controller, this.focusNode, this.onSelected, this.isView});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isView ? 1.0 : 0.0,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: controller,
            focusNode: focusNode,
            autofocus: false,
            autocorrect: false,
            enableSuggestions: false,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.done,
            style: TextStyle(fontWeight: FontWeight.bold),
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly,
              NumberTextInputFormatter(),
              LengthLimitingTextInputFormatter(13)
            ],
            decoration: InputDecoration(
              labelText: '휴대폰 번호',
              alignLabelWithHint: true,
              suffixIcon: IconButton(
                padding: EdgeInsets.only(top: 15.0),
                icon: Icon(Icons.cancel, size: 18.0),
                onPressed: () {
                  WidgetsBinding.instance.addPostFrameCallback((_) => controller.clear());
                },
              ),
            ),
          ),
          Padding(padding: const EdgeInsets.only(bottom: 20.0)),
          Consumer<SignInModel>(
            builder: (_, model, __) {
              bool isLock = model.signInPhoneNumberLock;
              return GestureDetector(
                onTap: () => isLock || !isView ? {} : onSelected(),
                child: SizedBox(
                  height: 50.0,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(Get.context).primaryColor,
                        border: Border.all(color: Theme.of(Get.context).primaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(12.0))
                    ),
                    child: Center(
                      child: isLock
                        ? CupertinoActivityIndicator()
                        : Text('인증문자 받기', style: TextStyle(color: Theme.of(Get.context).backgroundColor, fontWeight: FontWeight.bold, fontSize: 16.0)),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 30),
          if(!kIsWeb) Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Divider(height: kIsWeb ? 1.0 : 0.5, thickness: 0.5)),
              SizedBox(width: 10),
              Text('or', style: TextStyle(
                fontSize: 12,
              )),
              SizedBox(width: 10),
              Expanded(child: Divider(height: kIsWeb ? 1.0 : 0.5, thickness: 0.5)),
            ],
          ),
          if(!kIsWeb) SizedBox(height: 30),
          if(!kIsWeb) GestureDetector(
            onTap: _kakaoLogin,
            child: SizedBox(
              height: 50.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0xfe, 0xe5, 0x00, 1.0), // FEE500
                  border: Border.all(color: Color.fromRGBO(0xfe, 0xe5, 0x00, 1.0)),
                  borderRadius: BorderRadius.all(Radius.circular(12.0))
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Text('카카오 로그인', style: TextStyle(color: Color.fromRGBO(0x47, 0x44, 0x32, 1.0), fontWeight: FontWeight.bold, fontSize: 16.0)),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 20),
                      child: Image(image: const AssetImage('assets/kakao_logo.png'), height: 20),
                    ),
                  ],
                ),
              ),
            )
          )
//          Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: [
//              Text('전화번호가 변경되었나요?', style: TextStyle(
//                fontSize: 13,
//                color: Theme.of(context).textTheme.subtitle2.color
//              )),
//              SizedBox(width: 5),
//              GestureDetector(
//                onTap: _kakaoLogin,
//                child: Text('소셜로그인', style: TextStyle(
//                  fontSize: 13,
//                  color: Theme.of(context).textTheme.subtitle2.color,
//                  fontWeight: FontWeight.bold,
//                  decoration: TextDecoration.underline,
//                )),
//              ),
//            ],
//          )
        ],
      ),
    );
  }

  void _kakaoLogin() async {
    KakaoContext.clientId = 'e3f5155803af7730f617e92aa89dbe85';
    try {
      var code = await isKakaoTalkInstalled()
        ? await AuthCodeClient.instance.requestWithTalk()
        : await AuthCodeClient.instance.request();
      AccessTokenResponse token = await AuthApi.instance.issueAccessToken(code);
      AccessTokenStore.instance.toStore(token);
      if(token != null) {
        requestMe(token: token.accessToken);
      }
    } catch(e) {
      print('_kakaoLogin error : $e');
      _loginFail();
    }
  }


  Future<void> requestMe({String token}) async {
    try {
      bool isSignIn;
      SignUpModel signUpModel = Get.context.read();
      SignInModel signInModel = Get.context.read();

      try {
        signInModel.changeIsSigningIn(true);

        User user = await UserApi.instance.me();
        if (user.kakaoAccount.phoneNumberNeedsAgreement ||
            user.kakaoAccount.genderNeedsAgreement ||
            user.kakaoAccount.birthdayNeedsAgreement ||
            user.kakaoAccount.birthyearNeedsAgreement ||
            user.kakaoAccount.profileNeedsAgreement) {
          await retryAfterUserAgrees(['phone_number', 'gender', 'birthday', 'birthyear', 'profile']);
          return;
        }

        // 단순 정보 기입용 (추후 로그인으로 사용 x)
        String phoneNumber =
            '0'+user.kakaoAccount.phoneNumber.split(' ')[1]
                .replaceAll('-', '')
                .replaceAll('\p{Z}', '');
        bool isExist = await signUpModel.verifyExistPhoneNumber(phoneNumber: 'K$phoneNumber');
        if(!isExist) {
          signUpModel
            ..phoneNumber = 'K$phoneNumber'
            ..name = user.kakaoAccount.profile.nickname
            ..nickname = user.kakaoAccount.profile.nickname
            ..sex = user.kakaoAccount.gender == Gender.MALE ? Sex.MALE : Sex.FEMALE
            ..password = token;
          await signUpModel.postUser();
        }
        // 서버 로그인
        isSignIn = await signInModel.signIn(
            phoneNumber: 'K$phoneNumber#kakao',
            password: token
        );
      } finally {
        signInModel.changeIsSigningIn(false);
      }

      if(isSignIn) {
        signInModel
          ..passwordTryCount = 0
          ..signInViewType = SignInViewType.PHONE_NUMBER_VIEW;
        _routeBack(predicateUrl: signUpModel.predicateUrl);
      } else {
        _loginFail();
      }
    } catch (e) {
      _loginFail();
      print(e);
    }
  }

  void _routeBack({String predicateUrl = ''}) {
    if(predicateUrl == null || predicateUrl.isEmpty) {
      Get.offAll(BasePage(), transition: Transition.cupertino);
      return;
    }
    Get.offAll(BasePage(), transition: Transition.cupertino);
    //Get.until(ModalRoute.withName(predicateUrl));
  }

  void _loginFail() {
    DialogUtils.dialog(
        Get.context,
        '가입이 비정상적으로 처리되었습니다.'
    );
  }

  Future<void> retryAfterUserAgrees(List<String> requiredScopes) async {
    String authCode = await AuthCodeClient.instance.requestWithAgt(requiredScopes);
    AccessTokenResponse token = await AuthApi.instance.issueAccessToken(authCode);
    AccessTokenStore.instance.toStore(token); // Store access token in AccessTokenStore for future API requests.
    await requestMe();
  }
}

class NumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();
    if (newTextLength >= 4) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 3) + ' ');
      if (newValue.selection.end >= 3)
        selectionIndex++;
    }
    if (newTextLength >= 8) {
      newText.write(newValue.text.substring(3, usedSubstringIndex = 7) + ' ');
      if (newValue.selection.end >= 7)
        selectionIndex++;
    }

    // Dump the rest.
    if (newTextLength >= usedSubstringIndex) {
      newText.write(newValue.text.substring(usedSubstringIndex));
    }

    return new TextEditingValue(
      text: newText.toString(),
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}