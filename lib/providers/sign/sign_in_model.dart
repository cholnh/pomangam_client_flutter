import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:kakao_flutter_sdk/auth.dart';
import 'package:kakao_flutter_sdk/user.dart' as KakaoUser;
import 'package:pomangam_client_flutter/_bases/constants/endpoint.dart';
import 'package:pomangam_client_flutter/providers/sign/sign_in_fail_type.dart';
import 'package:pomangam_client_flutter/views/pages/sign/in/sign_in_view_type.dart';
import 'package:pomangam_client_flutter/domains/user/auth_code_result.dart';
import 'package:pomangam_client_flutter/domains/user/enum/sign_in_state.dart';
import 'package:pomangam_client_flutter/domains/user/user.dart';
import 'package:pomangam_client_flutter/repositories/sign/sign_repository.dart';

class SignInModel with ChangeNotifier {

  /// repository
  SignRepository _signRepository = Injector.appInstance.getDependency<SignRepository>();

  /// data
  User userInfo;
  SignInState signInState = SignInState.SIGNED_OUT;
  int passwordTryCount = 0;
  String phoneNumber;
  String authCode;
  bool isSigningIn = false;
  bool isSigningOut = false;

  /// authCode page data
  SignInViewType signInViewType = SignInViewType.PHONE_NUMBER_VIEW;
  bool isAuthCodeFilled = false;
  int authCodeSendCount = 0;
  String authCodeFailMessage;
  SignInFailType signInFailType;

  /// password page data
  String passwordFailMessage;
  bool signInPhoneNumberLock = false;
  bool signInAuthCodeLock = false;
  bool signInPasswordLock = false;


  /// Sign in
  Future<bool> signIn({
    @required String phoneNumber,
    @required String password
  }) async {
    assert(phoneNumber != null && phoneNumber.isNotEmpty && password != null && password.isNotEmpty);

    changeSignState(SignInState.SIGNING_IN);
    passwordTryCount++;
    try {
      userInfo = await _signRepository.signIn(phoneNumber: phoneNumber, password: password);
    } catch(error) {
      changeSignState(SignInState.SIGNED_FAIL);
      return false;
    }
    changeSignState(SignInState.SIGNED_IN);
    return true;
  }

  /// Sign out
  Future<void> signOut({bool notify = true}) async {
    changeIsSigningOut(true);
    try {
      userInfo = null;

      try {
        // kakao oauth logout
        AccessToken token = await AccessTokenStore.instance.fromStore();
        if (token.refreshToken == null) {
          await KakaoUser.UserApi.instance.logout();
        }
      } catch (e) {}
      changeSignState(SignInState.SIGNED_OUT, notify: false);
      await _signRepository.signOut(trySignInGuest: true);
    } finally {
      changeIsSigningOut(false, notify: false);
      if(notify) {
        notifyListeners();
      }
    }
  }

  Future<void> renewUserInfo({bool notify = true}) async {
    try {
      if(isSignIn()) {
        userInfo = await _signRepository.renewUserInfo();
      }
    } finally {
      if(notify) {
        notifyListeners();
      }
    }
  }

  void changeIsSigningIn(bool tf, {bool notify = true}) {
    this.isSigningIn = tf;
    if(notify) {
      notifyListeners();
    }
  }

  void changeIsSigningOut(bool tf, {bool notify = true}) {
    this.isSigningOut = tf;
    if(notify) {
      notifyListeners();
    }
  }

  void changeSignState(SignInState signInState, {bool notify = true}) {
    this.signInState = signInState;
    if(notify) {
      notifyListeners();
    }
  }

  bool isMaxPasswordCount()
  => Endpoint.maxPasswordTryCount <= passwordTryCount;

  Future<bool> requestAuthCodeForSignIn({
    @required String phoneNumber
  }) async {
    bool isValid = false;
    if(phoneNumber != null && phoneNumber.isNotEmpty) {
      AuthCodeResult result;
      try {
        authCodeSendCount++;
        result = await _signRepository.requestAuthCodeForId(phoneNumber: phoneNumber);
      } catch(error) {
        isValid = false;
      }
      if(result != null && result.code == 'success') {
        isValid = true;
      }
    }
    notifyListeners();
    return isValid;
  }

  Future<bool> verifyAuthCodeForSignIn({
    @required String code
  }) async {
    bool isValid;
    try {
      isValid = await _signRepository.verifyAuthCodeForId(phoneNumber: phoneNumber, code: code);
      if(!isValid) {
        signInFailType = SignInFailType.IN_VALID_PHONE_NUMBER;
        authCodeFailMessage = '가입되지 않은 번호입니다.';
      }
    } catch(error) {
      isValid = false;
      signInFailType = SignInFailType.IN_VALID_AUTH_CODE;
      authCodeFailMessage = '인증번호를 확인해주세요.';
    }
    return isValid;
  }

  bool isSignIn() {
    return this.signInState == SignInState.SIGNED_IN;
  }

  changeSignInViewType(SignInViewType signInViewType) {
    this.signInViewType = signInViewType;
    notifyListeners();
  }

  void lockSignInPhoneNumberLock() {
    signInPhoneNumberLock = true;
    notifyListeners();
  }

  void unLockSignInPhoneNumberLock() {
    signInPhoneNumberLock = false;
    notifyListeners();
  }

  void lockSignInAuthCodeLock() {
    signInAuthCodeLock = true;
    notifyListeners();
  }

  void unLockSignInAuthCodeLock() {
    signInAuthCodeLock = false;
    notifyListeners();
  }

  void lockSignInPasswordLock() {
    signInPasswordLock = true;
    notifyListeners();
  }

  void unLockSignInPasswordLock() {
    signInPasswordLock = false;
    notifyListeners();
  }

  void changeNickname(String nickname) {
    userInfo.nickname = nickname;
    notifyListeners();
  }
}