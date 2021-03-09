import 'package:json_annotation/json_annotation.dart';

part 'version.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class Version {

  int latestVersion;
  int minimumVersion;

  Version({
    this.latestVersion, this.minimumVersion
  });

  Map<String, dynamic> toJson() => _$VersionToJson(this);
  factory Version.fromJson(Map<String, dynamic> json) => _$VersionFromJson(json);
}