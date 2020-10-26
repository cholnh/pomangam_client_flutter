import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/_bases/util/string_utils.dart';
import 'package:pomangam_client_flutter/domains/user/enum/sign_in_state.dart';
import 'package:pomangam_client_flutter/domains/user/user.dart';
import 'package:pomangam_client_flutter/providers/sign/sign_in_model.dart';
import 'package:pomangam_client_flutter/providers/sign/sign_up_model.dart';
import 'package:pomangam_client_flutter/views/pages/_bases/base_page.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_dialog_utils.dart';
import 'package:pomangam_client_flutter/views/widgets/sign/sign_app_bar.dart';
import 'package:pomangam_client_flutter/views/widgets/sign/up/sign_up_bottom_btn_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/sign/up/sign_up_title_widget.dart';
import 'package:provider/provider.dart';

class SignUpNicknamePage extends StatefulWidget {
  @override
  _SignUpNicknamePageState createState() => _SignUpNicknamePageState();
}

class _SignUpNicknamePageState extends State<SignUpNicknamePage> {

  SignUpModel _model;
  TextEditingController _controller;
  FocusNode _focusNode;
  String savedNickname;

  @override
  void initState() {
    super.initState();
    _model = Provider.of<SignUpModel>(context, listen: false);
    savedNickname = _model.nickname;
    _controller = TextEditingController()
      ..text = savedNickname;
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller?.dispose();
    _focusNode?.dispose();
    super.dispose();
  }

  Widget _bottomNavigationBar() {
    SignUpModel model = Provider.of<SignUpModel>(context);
    return SignUpBottomBtnWidget(
      isActive: !model.signUpNicknameLock,
      title: '완료',
      onTap: () {
        _verify();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false), // 뒤로가기 방지
      child: Scaffold(
        appBar: SignAppBar(context, enableBackButton: false),
        bottomNavigationBar: _bottomNavigationBar(),
        backgroundColor: Theme.of(Get.context).backgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: SignUpTitleWidget(
                    title: '포만이가 되신것을 환영합니다.',
                    subTitle: '아래 닉네임으로 활동하시게 됩니다.',
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 180.0,
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                        child: TextFormField(
                          controller: _controller,
                          focusNode: _focusNode,
                          autocorrect: false,
                          enableSuggestions: false,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(fontWeight: FontWeight.bold, locale: Locale('ko')),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                          ],
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                            labelText: '닉네임',
                            alignLabelWithHint: true,
                            suffixText: '님'
                          ),
                        ),
                      ),
                      Consumer<SignUpModel>(
                        builder: (_, model, child) {
                          return model.isValidNicknameFilled
                            ? Container()
                            : Container(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text(
                                  '10자 이내의 한글, 알파벳, 숫자만 가능합니다.',
                                  style: TextStyle(color: Theme.of(Get.context).primaryColor),
                                  textAlign: TextAlign.start,
                                )
                              );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _verify() async {
    try {
      _model.lockSignUpNickname();  // Lock
      String nickname = _controller.text;
      if(nickname == savedNickname) {
        context.read<SignInModel>().changeSignState(SignInState.SIGNED_IN);
        _routeNext(predicateUrl: _model.predicateUrl);
        return;
      }
      if(StringUtils.isValidNickname(nickname)) {
        bool isExisted = await _model.isExistNickname(nickname: nickname);
        User patched = await _model.patchNickname(nickname: nickname);

        if(!isExisted && patched != null) {
          context.read<SignInModel>()
            ..userInfo.nickname = patched.nickname
            ..changeSignState(SignInState.SIGNED_IN);
          _routeNext(predicateUrl: _model.predicateUrl);
          return;
        } else {
          _verifyError('이미 등록된 닉네임입니다.');
        }
      } else {
        _verifyError('닉네임을 다시 입력해주세요.');
      }
    } finally {
      _model.unLockSignUpNickname();  // Unlock
    }
  }

  void _focus(FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  void _routeNext({String predicateUrl = ''}) {
    if(predicateUrl == null || predicateUrl.isEmpty) {
      Get.offAll(BasePage(), transition: Transition.cupertino);
      return;
    }
    Get.offAll(BasePage(), transition: Transition.cupertino);
    //Get.until(ModalRoute.withName(predicateUrl));
  }

  void _verifyError(String cause) {
    DialogUtils.dialog(context, '$cause');
    _focus(_focusNode);
    _model.changeValidNicknameFilled(to: false);
  }
}
