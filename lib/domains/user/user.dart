import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client_flutter/domains/_bases/entity_auditing.dart';
import 'package:pomangam_client_flutter/domains/deliverysite/detail/delivery_detail_site.dart';
import 'package:pomangam_client_flutter/domains/user/enum/sex.dart';
import 'package:pomangam_client_flutter/domains/user/point_rank/point_rank.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pomangam_client_flutter/_bases/key/shared_preference_key.dart' as s;

part 'user.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class User extends EntityAuditing {

  DeliveryDetailSite deliveryDetailSite;

  String phoneNumber;

  String password;

  String name;

  String nickname;

  Sex sex;

  DateTime birth;

  PointRank userPointRank;

  int userPoint;

  @override
  String toString() {
    return 'User{deliveryDetailSite: $deliveryDetailSite, phoneNumber: $phoneNumber, password: $password, name: $name, nickname: $nickname, sex: $sex, birth: $birth, userPointRank: $userPointRank, userPoint: $userPoint}';
  }

  User({
    int idx, DateTime registerDate, DateTime modifyDate,
    this.deliveryDetailSite, this.phoneNumber, this.password,
    this.name, this.nickname, this.sex, this.birth,
    this.userPointRank, this.userPoint
  }): super(idx: idx, registerDate: registerDate, modifyDate: modifyDate);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  static Future<User> loadFromDisk() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return User(
        idx: prefs.get(s.idxUser),
        deliveryDetailSite:  DeliveryDetailSite(
            idx: prefs.getInt(s.idxDeliveryDetailSite),
            idxDeliverySite: prefs.getInt(s.idxDeliverySite)
        ),
        phoneNumber: prefs.get(s.userPhoneNumber),
        name: prefs.get(s.userName),
        nickname: prefs.get(s.userNickname),
        sex: prefs.get(s.userSex) == 'MALE' ? Sex.MALE : Sex.FEMALE,
        birth: DateTime.parse(prefs.get(s.userBirth)),
        userPoint: prefs.get(s.userPoint)
      );
    } catch (e) {}
    return null;
  }

  Future<User> saveToDisk() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(s.idxUser, this.idx);
    prefs.setString(s.userPhoneNumber, this.phoneNumber);
    prefs.setString(s.userName, this.name);
    prefs.setString(s.userNickname, this.nickname);
    prefs.setString(s.userSex, this.sex.toString());
    prefs.setString(s.userBirth, this.birth?.toIso8601String());
    prefs.setInt(s.userPoint, this.userPoint);
    prefs.setInt(s.idxDeliveryDetailSite, this.deliveryDetailSite?.idx);
    prefs.setInt(s.idxDeliverySite, this.deliveryDetailSite?.idxDeliverySite);
    return this;
  }

  static Future<void> clearFromDisk() async {
    await SharedPreferences.getInstance()
      ..remove(s.idxUser)
      ..remove(s.idxDeliveryDetailSite)
      ..remove(s.idxDeliverySite)
      ..remove(s.userPhoneNumber)
      ..remove(s.userName)
      ..remove(s.userNickname)
      ..remove(s.userSex)
      ..remove(s.userBirth)
      ..remove(s.userPoint);
  }
}