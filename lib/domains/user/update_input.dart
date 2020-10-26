import 'package:json_annotation/json_annotation.dart';

part 'update_input.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)

class UpdateInput {
  String phoneNumber;

  String code;

  String password;

  UpdateInput({this.phoneNumber, this.code, this.password});
  factory UpdateInput.fromJson(Map<String, dynamic> json) => _$UpdateInputFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateInputToJson(this);
}