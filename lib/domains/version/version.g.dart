// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Version _$VersionFromJson(Map<String, dynamic> json) {
  return Version(
    latestVersion: json['latestVersion'] as int,
    minimumVersion: json['minimumVersion'] as int
  );
}

Map<String, dynamic> _$VersionToJson(Version instance) => <String, dynamic>{
      'latestVersion': instance.latestVersion,
      'minimumVersion': instance.minimumVersion,
    };
