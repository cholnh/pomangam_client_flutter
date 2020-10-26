import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pomangam_client_flutter/_bases/util/string_utils.dart';
import 'package:pomangam_client_flutter/_bases/util/toast_utils.dart';
import 'package:pomangam_client_flutter/domains/user/user.dart';
import 'package:pomangam_client_flutter/providers/sign/sign_in_model.dart';
import 'package:pomangam_client_flutter/providers/sign/sign_up_model.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/basic_app_bar.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_dialog_utils.dart';
import 'package:pomangam_client_flutter/views/widgets/payment/payment_bottom_bar.dart';
import 'package:provider/provider.dart';

class NicknamePage extends StatefulWidget {

  @override
  _NicknamePageState createState() => _NicknamePageState();
}

class _NicknamePageState extends State<NicknamePage> {

  final FocusNode _focusNode = FocusNode();
  TextEditingController _textEditingController;
  bool isEditMode = true;
  bool isChanged = true;
  bool isTextEmpty = false;
  bool isValidNickname = true;
  String _savedNickname;

  @override
  void initState() {
    super.initState();

    _textEditingController = TextEditingController();
    _savedNickname = context.read<SignInModel>().userInfo.nickname;
    _textEditingController.text = _savedNickname;
    Future.delayed(Duration(milliseconds: 300), () {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    User userInfo = context.watch<SignInModel>().userInfo;

    return ModalProgressHUD(
      inAsyncCall: context.watch<SignUpModel>().signUpNicknameLock,
      child: Scaffold(
        appBar: BasicAppBar(
          title: '내 정보 수정',
          leadingIcon: Icon(CupertinoIcons.back, size: 20, color: Colors.black),
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: _onChanged,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 40.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('닉네임', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.headline1.color)),
                                ],
                              ),
                            ),
                            if (isEditMode) Flexible(
                              child: TextFormField(
                                focusNode: _focusNode,
                                controller: _textEditingController,
                                textAlign: TextAlign.end,
                                maxLines: 1,
                                autofocus: true,
                                expands: false,
                                keyboardType: TextInputType.text,
                                cursorColor: Theme.of(context).primaryColor,
                                style: TextStyle(fontSize: 14.0, color: Theme.of(context).textTheme.headline1.color),
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Theme.of(context).backgroundColor),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Theme.of(context).backgroundColor),
                                  ),
                                ),
                                onChanged: (text) {
                                  setState(() {
                                    this.isTextEmpty = text.isEmpty;
                                  });
                                },
                              ),
                            ) else Row(
                              children: <Widget>[
                                Text('${userInfo.nickname}', style: TextStyle(fontSize: 14.0, color: Theme.of(context).textTheme.headline1.color)),
                                Icon(Icons.arrow_drop_down)
                              ],
                            ),
                          ],
                        ),
                      ),
                      Text('10자 이내의 한글, 알파벳, 숫자만 가능합니다.', style: TextStyle(
                        fontSize: 12.0,
                        color: Theme.of(context).primaryColor,
                      ))
                    ],
                  ),
                ),
              ),
              PaymentBottomBar(
                centerText: '저장',
                isActive: !isTextEmpty,
                onSelected: () => _onBottomSelected(),
                isVisible: isChanged,
              )
            ],
          )
        ),
      ),
    );
  }

  void _onChanged() {
    setState(() {
      this.isChanged = true;
      this.isEditMode = true;
    });
  }

  void _onBottomSelected() async {
    SignUpModel signUpModel = context.read();
    SignInModel signInModel = context.read();

    try {
      signUpModel.lockSignUpNickname(); // Lock

      String nickname = _textEditingController.text;
      if (nickname != _savedNickname) {
        if (StringUtils.isValidNickname(nickname)) {
          bool isExisted = await signUpModel.isExistNickname(nickname: nickname);
          if (isExisted) {
            _verifyError('이미 등록된 닉네임입니다.');
            return;
          } else {
            User patched = await signUpModel.patchNickname(
              phoneNumber: signInModel.userInfo.phoneNumber,
              nickname: nickname
            );
            signInModel.changeNickname(patched.nickname);
          }
        } else {
          _verifyError('닉네임을 다시 입력해주세요.');
          return;
        }
      }

      Get.back();
      ToastUtils.showToast();
    } catch (error) {
      print(error);
      _verifyError('오류발생');
    } finally {
      signUpModel.unLockSignUpNickname(); // Unlock
    }
  }

  void _verifyError(String cause) {
    DialogUtils.dialog(Get.context, '$cause', whenComplete: () {
      FocusScope.of(context).requestFocus(_focusNode);
      setState(() {
        this.isValidNickname = false;
      });
    });
  }
}
