import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pomangam_client_flutter/domains/user/enum/auth_code_state.dart';
import 'package:pomangam_client_flutter/providers/sign/sign_up_model.dart';
import 'package:pomangam_client_flutter/views/pages/sign/up/sign_up_password_page.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_dialog_utils.dart';
import 'package:pomangam_client_flutter/views/widgets/sign/sign_app_bar.dart';
import 'package:pomangam_client_flutter/views/widgets/sign/up/sign_up_bottom_btn_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/sign/up/sign_up_title_widget.dart';
import 'package:provider/provider.dart';

class SignUpAuthCodePage extends StatefulWidget {
  @override
  _SignUpAuthCodePageState createState() => _SignUpAuthCodePageState();
}

class _SignUpAuthCodePageState extends State<SignUpAuthCodePage> {

  SignUpModel _model;
  TextEditingController _controller;
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _model = Provider.of<SignUpModel>(context, listen: false);
    _controller = TextEditingController();
    _focusNode = FocusNode();
    Future.delayed(Duration(milliseconds: 300), () {
      FocusScope.of(context).requestFocus(_focusNode);
      _model.changeAuthCodeFilled(to: false);
    });

    _requestAuthCode();
    _model.authCodeSendCount = 0;
  }

  @override
  void dispose() {
//    if(_streamController != null && !_streamController.isClosed) {
//      _streamController.close();
//    }
    //_controller?.dispose();
    //_focusNode?.dispose();
    super.dispose();
  }

  Widget _bottomNavigationBar() {
    SignUpModel model = Provider.of<SignUpModel>(context);
    return model.isAuthCodeFilled
      ? SignUpBottomBtnWidget(
        isActive: !model.signUpAuthCodeLock,
        onTap: () {
          if(model.isAuthCodeFilled) {
            _verify();
          }
        },
      )
      : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SignAppBar(context),
      bottomNavigationBar: _bottomNavigationBar(),
      backgroundColor: Theme.of(Get.context).backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
          child: Column(
            children: <Widget>[
              SignUpTitleWidget(title: '인증코드를 입력해주세요.'),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 40.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 250,
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                        child: Consumer<SignUpModel>(
                          builder: (_, model, child) {
                            return PinCodeTextField(
                              appContext: context,
                              cursorColor: Theme.of(context).primaryColor,
                              enabled: model.authCodeState != AuthCodeState.fail,
                              length: 4,
                              controller: _controller,
                              focusNode: _focusNode,
                              animationType: AnimationType.scale,
                              animationDuration: Duration(milliseconds: 300),
                              dialogConfig: DialogConfig(
                                dialogTitle: '포만감',
                                dialogContent: '코드를 붙여넣기 하시겠습니까?',
                              ),
                              keyboardType: TextInputType.number,
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(5),
                                fieldHeight: 70,
                                fieldWidth: 58,
                                activeColor: Theme.of(Get.context).primaryColor,
                                inactiveColor: Colors.grey,
                                selectedColor: Theme.of(Get.context).primaryColor,
                              ),
                              onCompleted: (value) {
                                model.changeAuthCodeFilled(to: true);
                              },
                              onChanged: (value) {
                                if(value.length < 4) {
                                  model.changeAuthCodeFilled(to: false);
                                }
                              },
                            );
                          }
                        )
                      ),
                      Consumer<SignUpModel>(
                        builder: (_, model, child) {
                          return Column(
                            children: <Widget>[
                              model.authCodeState == AuthCodeState.fail
                              ? Text(
                                  '인증코드 전송에 실패하였습니다.',
                                  style: TextStyle(
                                    color: Theme.of(Get.context).primaryColor,
                                  )
                              )
                              : null, // TODO 타이머 구현
                              Padding(padding: EdgeInsets.only(bottom: 10.0)),
                              GestureDetector(
                                child: Text(
                                    '인증코드 재전송' +
                                    (model.authCodeSendCount >= 1
                                        ? ' (${model.authCodeSendCount}/${model.maxAuthCodeSendCount})'
                                        : ''),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                    )
                                ),
                                onTap: _requestAuthCode,
                              ),
                            ].where((Object o) => o != null).toList()
                          );
                        }
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _requestAuthCode() async {
    if(_model.authCodeSendCount >= _model.maxAuthCodeSendCount) {
      DialogUtils.dialog(context, '5분후에 다시 시도해주세요.');
      return;
    }
    if( !await _model.requestAuthCodeForJoin() ) {
      DialogUtils.dialog(
        context,
        '핸드폰번호를 확인해주세요.',
        onPressed: (dialogContext) {
          Navigator.pop(dialogContext);
          Future.delayed(Duration(milliseconds: 500), () => Get.back()); // Navigator.pop(context));
        }
      );
    }
  }

  void _verify() async {
    try {
      _model.lockSignUpAuthCode();  // Lock
      String code = _controller.text;
      if(code.length >= 4) {
        if( await _model.verifyAuthCodeForJoin(code: code) ) {
          _routeNext();
        } else {
          DialogUtils.dialog(context, '잘못된 인증번호입니다.');
        }
      } else {
        DialogUtils.dialog(context, '인증번호를 확인해주세요.');
      }
    } finally {
      _model.unLockSignUpAuthCode();  // Unlock
    }
  }

  void _routeNext() => Get.to(SignUpPasswordPage(), transition: Transition.cupertino, duration: Duration.zero);
}
