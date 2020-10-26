import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pomangam_client_flutter/_bases/util/string_utils.dart';
import 'package:pomangam_client_flutter/domains/user/enum/sex.dart';
import 'package:pomangam_client_flutter/domains/user/enum/sign_view_state.dart';
import 'package:pomangam_client_flutter/domains/user/user.dart';
import 'package:pomangam_client_flutter/providers/sign/sign_in_model.dart';
import 'package:pomangam_client_flutter/providers/sign/sign_up_model.dart';
import 'package:pomangam_client_flutter/views/pages/_bases/base_page.dart';
import 'package:pomangam_client_flutter/views/pages/sign/up/sign_up_password_page.dart';
import 'package:pomangam_client_flutter/views/pages/sign/up/sign_up_password_view_type.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_dialog_utils.dart';
import 'package:pomangam_client_flutter/views/widgets/sign/sign_app_bar.dart';
import 'package:pomangam_client_flutter/views/widgets/sign/up/sign_up_bottom_btn_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/sign/up/sign_up_first_item_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/sign/up/sign_up_second_item_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/sign/up/sign_up_title_widget.dart';
import 'package:provider/provider.dart';

class SignUpWithoutPhoneNumberPage extends StatefulWidget {

  @override
  _SignUpWithoutPhoneNumberPageState createState() => _SignUpWithoutPhoneNumberPageState();
}

class _SignUpWithoutPhoneNumberPageState extends State<SignUpWithoutPhoneNumberPage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  SignUpModel _model;
  int _curIdx = 0;
  FocusNode _nameNode, _birthNode, _sexNode;
  TextEditingController _nameController, _birthController, _sexController;
  ScrollController _scrollController;
  bool _isFirstView = true;

  @override
  void initState() {
    super.initState();
    _model = Provider.of<SignUpModel>(context, listen: false);
    _nameNode = FocusNode();
    _birthNode = FocusNode();
    _sexNode = FocusNode();
    _nameController = TextEditingController();
    _birthController = TextEditingController();
    _sexController = TextEditingController();
    _scrollController = ScrollController();
    _nextToName();
  }


  @override
  void didUpdateWidget(SignUpWithoutPhoneNumberPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    _isFirstView = false;
  }

  @override
  void dispose() {
    _nameNode.dispose();
    _birthNode.dispose();
    _sexNode.dispose();
    _nameController.dispose();
    _birthController.dispose();
    _sexController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Widget _bottomNavigationBar() {
    SignUpModel model = Provider.of<SignUpModel>(context);
    if (model.state == SignViewState.finish) {
      return SignUpBottomBtnWidget(
        isActive: !model.signUpLock,
        onTap: () => _isAllFilled() ? _verify() : _lastCheck()
    );
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: context.watch<SignUpModel>().signUpLock,
      child: Scaffold(
        appBar: SignAppBar(context),
        bottomNavigationBar: _bottomNavigationBar(),
        backgroundColor: Theme.of(Get.context).backgroundColor,
        body: SafeArea(
          child: Consumer<SignUpModel> (
              builder: (_, model, child) {
                return Column(
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
                        child: Column(
                          children: <Widget>[
                            SignUpTitleWidget(
                              title: '${model.title}',
                            ),
                            Expanded(
                              child: Container(
                                  padding: EdgeInsets.only(top: 25.0),
                                  child: Align(
                                      alignment: Alignment.topCenter,
                                      child: AnimatedList(
                                          key: _listKey,
                                          controller: _scrollController,
                                          initialItemCount: 0,
                                          reverse: true,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index, animation) {
                                            switch (index) {
                                              case 0:
                                                return SignUpFirstItemWidget(
                                                  controller: _nameController,
                                                  animation: animation,
                                                  focusNode: _nameNode,
                                                  model: model,
                                                  onChanged: (value) {
                                                    if(value.length > 0) {
                                                      _changeSignState(SignViewState.name);
                                                    } else {
                                                      _changeSignState(SignViewState.ready);
                                                    }
                                                  },
                                                  onComplete: () {
                                                    _isAllFilled()
                                                        ? _lastCheck()
                                                        : _nextToBirth();
                                                  },
                                                );
                                              case 1:
                                                return SignUpSecondItemWidget(
                                                  animation: animation,
                                                  birthController: _birthController,
                                                  sexController: _sexController,
                                                  birthNode: _birthNode,
                                                  sexNode: _sexNode,
                                                  onChangedBirth: (value) {
                                                    if(value.length >= 6) {
                                                      if(_isAllFilled()) {
                                                        _lastCheck();
                                                      } else {
                                                        _birthNode.unfocus();
                                                        _focus(_sexNode);
                                                        _changeSignState(SignViewState.sex);
                                                      }
                                                    } else {
                                                      _changeSignState(SignViewState.birth);
                                                    }
                                                  },
                                                  onChangedSex: (value) {
                                                    if(value.length >= 1) {
                                                      _isAllFilled()
                                                          ? _lastCheck()
                                                          : _changeSignState(SignViewState.finish);
                                                    } else {
                                                      _changeSignState(SignViewState.sex);
                                                    }
                                                  },
                                                  onCompleteBirth: () {
                                                    _isAllFilled()
                                                        ? _lastCheck()
                                                        : _changeSignState(SignViewState.finish);
                                                  },
                                                  onCompleteSex: () {
                                                    _lastCheck();
                                                  },
                                                );
                                              default:
                                                return Container();
                                            }
                                          }
                                      )
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (model.state == SignViewState.name) SignUpBottomBtnWidget(
                        isActive: !model.signUpLock,
                        onTap: () => _isAllFilled() ? _lastCheck() : _nextToBirth()
                    ) else Container()
                  ],
                );
              }
          ),
        ),
      ),
    );
  }

  void _nextToName() async {
    await Future.delayed(Duration(milliseconds: 500), () async {
      _setTitle('이름을 입력해주세요.');
      _listKey.currentState.insertItem(_curIdx++);
    });

    Future.delayed(Duration(milliseconds: 300), () {
      _focus(_nameNode);
    });
  }

  void _nextToBirth() {
    _listKey.currentState.insertItem(_curIdx++);
    _setTitle('주민등록번호를 입력해주세요.');
    _changeSignState(SignViewState.birth);
    Future.delayed(Duration(milliseconds: 300), () {
      _nameNode.unfocus();
      _focus(_birthNode);
    });
  }

  void _nextToSex() {
    _changeSignState(SignViewState.sex);
    _birthNode.unfocus();
    _focus(_sexNode);
  }

  void _lastCheck() {
    _setTitle('작성한 정보를 확인해주세요.');
    _unFocusAll();
    _changeSignState(SignViewState.finish);
    Future.delayed(Duration(milliseconds: 150), ()
    => _scrollController.animateTo(
        0.0,
        duration: Duration(milliseconds: 150),
        curve: Curves.linear));
  }

  void _verify() async {
    try {
      _model.lockSignUp(); // Lock

      String name = _nameController.text;
      int year = int.parse(_birthController.text.substring(0, 2));
      int month = int.parse(_birthController.text.substring(2, 4));
      int days = int.parse(_birthController.text.substring(4, 6));
      Sex sex;
      switch (_sexController.text) {
        case '1':
          sex = Sex.MALE;
          year += 1900;
          break;
        case '2':
          sex = Sex.FEMALE;
          year += 1900;
          break;
        case '3':
          sex = Sex.MALE;
          year += 2000;
          break;
        case '4':
          sex = Sex.FEMALE;
          year += 2000;
          break;
        default:
          DialogUtils.dialog(context, '주민번호 뒷자리를 확인해주세요.');
          _focus(_sexNode);
          return;
      }

      if( _validateName(name) &&
          _validateBirth(year, month, days)
      ) {
        String phoneNumber = Provider.of<SignInModel>(context, listen: false).phoneNumber;
        if(phoneNumber == null) {
          DialogUtils.dialog(context, '예기치 않은 오류입니다.');
          Get.back();
        }
        _setUserInfo(phoneNumber, name, DateTime(year, month, days), sex);

        SignUpModel signUpModel = context.read();
        SignInModel signInModel = context.read();

        User saved = await signUpModel.postUser();
        if(saved != null) {
          signUpModel.nickname = saved.nickname;
        } else {
          DialogUtils.dialog(
              context,
              '가입이 비정상적으로 처리되었습니다.',
              onPressed: (context) => _routeBack(predicateUrl: signUpModel.predicateUrl)
          );
          return;
        }
        await signInModel.signIn(
            phoneNumber: saved.phoneNumber, // phoneNumber with authCode
            password: saved.phoneNumber.split('#')[1]
        );
        _routeBack();
        //_routeNext();
      }
    } finally {
      _model.unLockSignUp(); // Unlock
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

  void _routeNext() => Get.to(SignUpPasswordPage(), arguments: SignUpPasswordViewType.FROM_SIGN_UP, transition: Transition.cupertino, duration: Duration.zero);

  void _setTitle(String to) {
    _model.changeTitle(to: to);
  }

  void _changeSignState(SignViewState to) {
    _model.changeState(to: to);
  }

  void _focus(FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  void _setUserInfo(String phoneNumber, String name, DateTime birth, Sex sex) async {
    _model.phoneNumber = phoneNumber;
    _model.name = name;
    _model.birth = birth;
    _model.sex = sex;
    _model.password = Get.context.read<SignInModel>().authCode;
  }

  bool _isAllFilled() {
    String name = _nameController.text;
    String birth = _birthController.text;
    String sex = _sexController.text;
    return name.isNotEmpty && birth.isNotEmpty && sex.isNotEmpty;
  }

  void _unFocusAll() {
    _nameNode.unfocus();
    _birthNode.unfocus();
    _sexNode.unfocus();
  }

  bool _validateName(String name) {
    if(StringUtils.hasEmojiAndSymbol(name)) {
      DialogUtils.dialog(context, '이름을 확인해주세요. $name');
      _focus(_nameNode);
      return false;
    }
    return true;
  }

  bool _validateBirth(int year, int month, int days) {
    if(year > DateTime.now().year ||
        (month < 1 || month > 12) ||
        (days < 1 || days > 31)
    ) {
      DialogUtils.dialog(context, '주민번호 앞자리를 확인해주세요.');
      _focus(_birthNode);
      return false;
    }
    return true;
  }
}