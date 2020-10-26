import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pomangam_client_flutter/_bases/constants/endpoint.dart';
import 'package:pomangam_client_flutter/domains/user/enum/sign_in_state.dart';
import 'package:pomangam_client_flutter/domains/user/user.dart';
import 'package:pomangam_client_flutter/providers/sign/sign_in_model.dart';
import 'package:pomangam_client_flutter/providers/sign/sign_up_model.dart';
import 'package:pomangam_client_flutter/views/pages/_bases/base_page.dart';
import 'package:pomangam_client_flutter/views/pages/sign/in/sign_in_view_type.dart';
import 'package:pomangam_client_flutter/views/pages/sign/up/sign_up_nickname_page.dart';
import 'package:pomangam_client_flutter/views/pages/sign/up/sign_up_password_find_page.dart';
import 'package:pomangam_client_flutter/views/pages/sign/up/sign_up_password_view_type.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_dialog_utils.dart';
import 'package:pomangam_client_flutter/views/widgets/sign/sign_app_bar.dart';
import 'package:pomangam_client_flutter/views/widgets/sign/up/sign_up_bottom_btn_widget.dart';
import 'package:provider/provider.dart';

class SignUpPasswordPage extends StatefulWidget {
  @override
  _SignUpPasswordPageState createState() => _SignUpPasswordPageState();
}

class _SignUpPasswordPageState extends State<SignUpPasswordPage> {

  SignUpModel _signUpModel;
  SignInModel _signInModel;
  // Color.fromRGBO(0xF4, 0x7E, 60, 1);  -> 연한 주황색
  // Color.fromRGBO(0xE1, 0x5A, 0x2B, 1); -> 포만감 로고색
  // Color.fromRGBO(0xff, 45, 0, 1); -> 오렌지 레드 -> 쨍함
  Color mainColor = Theme.of(Get.context).primaryColor;
  TextEditingController _controller;
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _signUpModel = Provider.of<SignUpModel>(context, listen: false);
    _signInModel = Provider.of<SignInModel>(context, listen: false);
    _controller = TextEditingController();
    _focusNode = FocusNode();
    Future.delayed(Duration(milliseconds: 300), () {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    try {
//      _controller?.dispose();
//      _focusNode?.dispose();
    } catch(err) {
      print('[Debug] _SignUpPasswordPageState.dispose');
    }
    super.dispose();
  }

  Widget _bottomNavigationBar() {
    SignUpModel model = Provider.of<SignUpModel>(context);
    return model.isPasswordFilled
      ? SignUpBottomBtnWidget(
          isActive: !model.signUpPasswordLock,
          backgroundColor: Theme.of(Get.context).backgroundColor,
          color: mainColor,
          onTap: () {
            if(model.isPasswordFilled) {
              _verify();
            }
          },
      )
      : null;
  }

  @override
  Widget build(BuildContext context) {
    // SignUpPasswordViewType pageType = ModalRoute.of(context).settings?.arguments ?? SignUpPasswordViewType.FROM_SIGN_UP;
    SignUpPasswordViewType pageType = Get.arguments;
    bool isFromSignIn = pageType == SignUpPasswordViewType.FROM_SIGN_IN;

    return WillPopScope(
      onWillPop: () => Future.value(false), // 뒤로가기 방지
      child: Scaffold(
        appBar: SignAppBar(
            context,
            enableBackButton: true,
            backgroundColor: mainColor
        ),
        bottomNavigationBar: _bottomNavigationBar(),
        backgroundColor: mainColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Consumer<SignInModel>(
                    builder: (_, signInModel, __) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            isFromSignIn ? '보안코드를 입력해주세요.' : '보안코드를 설정합니다.',
                            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Theme.of(Get.context).backgroundColor)
                          ),
                          Padding(padding: const EdgeInsets.only(bottom: 4.0)),
                          _subText(signInModel, isFromSignIn),
                          Padding(padding: EdgeInsets.only(bottom: signInModel.signInState == SignInState.SIGNING_IN ? 20.0 : 40.0))
                        ]
                      );
                    }
                  ),
                  Center(
                    child: SizedBox(
                      height: 300,
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 250,
                            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                            child: Consumer<SignUpModel>(
                              builder: (_, signUpModel, child) {
                                return PinCodeTextField(
                                  appContext: context,
                                  cursorColor: Theme.of(context).primaryColor,
                                  backgroundColor: mainColor,
                                  length: 4,
                                  controller: _controller,
                                  focusNode: _focusNode,
                                  textStyle: TextStyle(color: Theme.of(Get.context).backgroundColor, locale: Locale('en')),
                                  keyboardType: signUpModel.isNumberMode
                                      ? TextInputType.number
                                      : TextInputType.text,
                                  obscureText: true,
                                  animationType: AnimationType.scale,
                                  animationDuration: Duration(milliseconds: 300),
                                  dialogConfig: DialogConfig(
                                    dialogTitle: '포만감',
                                    dialogContent: '코드를 붙여넣기 하시겠습니까?',
                                  ),
                                  pinTheme: PinTheme(
                                    fieldHeight: 70,
                                    fieldWidth: 58,
                                    shape: PinCodeFieldShape.underline,
                                    activeColor: mainColor,
                                    inactiveColor: Colors.deepOrange.shade900,
                                    selectedColor: Theme.of(Get.context).backgroundColor,
                                  ),
                                  onCompleted: (value) {
                                    isFromSignIn
                                        ? _verifySignIn()
                                        : signUpModel.changePasswordFilled(to: true);
                                  },
                                  onChanged: (value) {
                                    if(!isFromSignIn && value.length < 4) {
                                      signUpModel.changePasswordFilled(to: false);
                                    }
                                  },
                                );
                              },
                            )
                          ),
                          Consumer<SignUpModel>(
                            builder: (_, model, child) {
                              return !model.isPasswordFilled
                                ? GestureDetector(
                                child: Text(
                                    model.isNumberMode
                                      ? '문자로 설정하기'
                                      : '숫자로 설정하기',
                                    style: TextStyle(
                                        color: Theme.of(Get.context).backgroundColor,
                                        fontWeight: FontWeight.bold
                                    )
                                ),
                                onTap: () {
                                  model.changeNumberMode(to: !model.isNumberMode);
                                  _focusNode.unfocus();
                                  Future.delayed(Duration(milliseconds: 300), ()
                                    => FocusScope.of(context).requestFocus(_focusNode));
                                },
                              )
                              : Container();
                            }
                          ),
                          SizedBox(height: 20),
                          GestureDetector(
                            child: Text(
                              '보안코드를 잊으셨나요?',
                              style: TextStyle(
                                color: Theme.of(Get.context).backgroundColor,
                                fontWeight: FontWeight.bold
                              )
                            ),
                            onTap: () {
                              Get.to(SignUpPasswordFindPage(), transition: Transition.cupertino, duration: Duration.zero);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _subText(SignInModel signInModel, bool isFromSignIn) {
    if(signInModel.signInState == SignInState.SIGNING_IN) {
      return Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: CupertinoActivityIndicator(),
      );
    }
    if(isFromSignIn) {
      if(signInModel.signInState == SignInState.SIGNED_FAIL && signInModel.passwordTryCount > 0) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('일치하지 않습니다.', style: TextStyle(color: Theme.of(Get.context).backgroundColor)),
            Text(' (${signInModel.passwordTryCount}/${Endpoint.maxPasswordTryCount})', style: TextStyle(color: Theme.of(Get.context).backgroundColor, fontWeight: FontWeight.bold))
          ],
        );
      } else {
        return Container();
      }
    } else {
      return Text('한 번만 입력하니 정확히 입력해주세요.', style: TextStyle(color: Theme.of(Get.context).backgroundColor));
    }
  }

  void _verify() async {
    try {
      _signUpModel.lockSignUpPassword();  // Lock
      _signUpModel.password = _controller.text;
      User saved = await _signUpModel.postUser();
      if(saved != null) {
        _signUpModel.nickname = saved.nickname;
      } else {
        DialogUtils.dialog(
            context,
            '가입이 비정상적으로 처리되었습니다.',
            onPressed: (context) => _routeBack(predicateUrl: _signUpModel.predicateUrl)
        );
        return;
      }
      await _signInModel.signIn(
          phoneNumber: saved.phoneNumber, // phoneNumber with authCode
          password: _signUpModel.password
      );
      _routeNext();
    } finally {
      _signUpModel.unLockSignUpPassword();  // Unlock
    }
  }

  void _verifySignIn() async {
    if(_signInModel.signInPasswordLock) {
      return;
    }
    try {
      _signInModel.lockSignInPasswordLock();
      bool isSignIn = await _signInModel.signIn(
          phoneNumber: _signInModel.phoneNumber+'#'+_signInModel.authCode,
          password: _controller.text
      );
      if(isSignIn) {
        _signInModel
          ..passwordTryCount = 0
          ..signInViewType = SignInViewType.PHONE_NUMBER_VIEW;
        _routeBack(predicateUrl: _signUpModel.predicateUrl);
      } else {
        bool isMaxTry = Endpoint.maxPasswordTryCount <= _signInModel.passwordTryCount;
        if(isMaxTry) {
          DialogUtils.dialog(context,
              '보안코드 최대 입력 횟수를 초과하였습니다.',
              onPressed: (dialogContext) {
                Navigator.pop(dialogContext);
                _signInModel
                  ..passwordTryCount = 0
                  ..signInViewType = SignInViewType.PHONE_NUMBER_VIEW;
                _controller.clear();
                Future.delayed(Duration(milliseconds: 300), () => Get.back());
              }
          );
        } else {
          _controller.clear();
          FocusScope.of(context).requestFocus(_focusNode);
        }
      }
    } finally {
      _signInModel.unLockSignInPasswordLock();
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

  void _routeNext() => Get.off(SignUpNicknamePage(), transition: Transition.cupertino);
}
