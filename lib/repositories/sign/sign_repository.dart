import 'package:flutter/foundation.dart';
import 'package:pomangam_client_flutter/_bases/initalizer/initializer.dart';
import 'package:pomangam_client_flutter/_bases/network/api/api.dart';
import 'package:pomangam_client_flutter/_bases/network/domain/token.dart';
import 'package:pomangam_client_flutter/domains/user/auth_code_result.dart';
import 'package:pomangam_client_flutter/domains/user/phone_number.dart';
import 'package:pomangam_client_flutter/domains/user/update_input.dart';
import 'package:pomangam_client_flutter/domains/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pomangam_client_flutter/_bases/key/shared_preference_key.dart' as s;

class SignRepository {

  final Api api; // 서버 연결용
  final Initializer initializer;

  SignRepository({this.api, this.initializer});

  Future<bool> verifyPhoneNumber({
    @required String phoneNumber
  }) async => (await api.get(
      url: '/users/search/exist/phone?phn=$phoneNumber')).data;

  Future<AuthCodeResult> requestAuthCodeForJoin({
    @required String phoneNumber
  }) async => AuthCodeResult.fromJson((await api.post(
      url: '/auth/code/join',
      data: PhoneNumber(phoneNumber: phoneNumber).toJson())).data);

  Future<AuthCodeResult> requestAuthCodeForId({
    @required String phoneNumber
  }) async => AuthCodeResult.fromJson((await api.post(
      url: '/auth/code/id',
      data: PhoneNumber(phoneNumber: phoneNumber).toJson())).data);

  Future<AuthCodeResult> requestAuthCodeForPw({
    @required String phoneNumber
  }) async => AuthCodeResult.fromJson((await api.post(
      url: '/auth/code/pw',
      data: PhoneNumber(phoneNumber: phoneNumber).toJson())).data);

  Future<bool> verifyAuthCodeForJoin({
    @required String phoneNumber, @required String code
  }) async => (await api.post(
      url: '/auth/check/join',
      data: PhoneNumber(phoneNumber: phoneNumber, code: code).toJson())).data;

  Future<bool> verifyAuthCodeForId({
    @required String phoneNumber, @required String code
  }) async => (await api.post(
      url: '/auth/check/id',
      data: PhoneNumber(phoneNumber: phoneNumber, code: code).toJson())).data;

  Future<AuthCodeResult> verifyAuthCodeForPw({
    @required String phoneNumber, @required String code
  }) async => AuthCodeResult.fromJson((await api.post(
      url: '/auth/check/pw',
      data: PhoneNumber(phoneNumber: phoneNumber, code: code).toJson())).data);

  Future<User> updatePw({
    @required String phoneNumber, @required String code, @required String password
  }) async => User.fromJson((await api.post(
      url: '/auth/update/pw',
      data: UpdateInput(phoneNumber: phoneNumber).toJson())).data);

  Future<User> postUser({
    @required User user
  }) async => User.fromJson((await api.post(
      url: '/users',
      data: user.toJson())).data);

  Future<bool> isExistByNickname({
    @required String nickname
  }) async => (await api.get(
      url: '/users/search/exist/nickname?nickname=$nickname')).data;

  Future<User> patchUser({
    @required User user
  }) async => User.fromJson((await api.patch(
      url: '/users/${user.phoneNumber}',
      data: user.toJson())).data);

  /// ## signIn
  ///
  /// [id] ID 에 해당하는 핸드폰번호 입력
  /// [password] 비밀번호
  /// 유저 계정 서버로 전달 -> 유효성 체크 -> login token 발급 -> return 업주 정보
  ///
  Future<User> signIn({
    @required String phoneNumber,
    @required String password
  }) async {
    User user;
    Token token = await api.oauthTokenRepository.issueLoginToken(phoneNumber: phoneNumber, password: password);

    if(token != null) {
      token
        ..saveToDisk()
        ..saveToDioHeader();

      phoneNumber = phoneNumber.split('#')[0];
      (await SharedPreferences.getInstance()).setString(s.userPhoneNumber, phoneNumber);
      user = await renewUserInfo(phoneNumber: phoneNumber);

      await initializer.initializeNotification();
    }
    return user;
  }

  /// ## signOut
  ///
  /// 로그아웃
  /// SharedPreference 내부 token 값 삭제, Dio Header 내부 token 값 삭제.
  /// 로그아웃 후 View 단에서 초기화 후, 홈('/') 으로 이동 필요.
  ///
  Future<void> signOut({bool trySignInGuest = true}) async {
    await Token.clearFromDisk();
    Token.clearFromDioHeader();
    (await SharedPreferences.getInstance()).remove(s.userPhoneNumber);

    if(trySignInGuest) {
      await initializer.initializeToken();
      await initializer.initializeModelData();
      await initializer.initializeNotification();
    }
  }

  Future<User> renewUserInfo({String phoneNumber}) async {
    User user;
    phoneNumber = phoneNumber == null
      ? (await SharedPreferences.getInstance()).getString(s.userPhoneNumber)
      : phoneNumber;
    user = User.fromJson((await api.get(url: '/users/$phoneNumber')).data)
      ..saveToDisk();
    return user;
  }
}