import 'package:pomangam_client_flutter/_bases/network/api/api.dart';
import 'package:pomangam_client_flutter/domains/version/version.dart';

class VersionRepository {

  final Api api; // 서버 연결용
  VersionRepository({this.api});

  Future<Version> find() async
    => Version.fromJson((await api.get(url: '/versions/client')).data);
}