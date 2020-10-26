import 'package:flutter/foundation.dart';
import 'package:pomangam_client_flutter/_bases/network/api/api.dart';
import 'package:pomangam_client_flutter/domains/notice/notice.dart';

class NoticeRepository {
  final Api api; // 서버 연결용
  NoticeRepository({this.api});

  Future<List<Notice>> findAll({
    @required int dIdx
  }) async => Notice.fromJsonList((await api.get(url: '/dsites/$dIdx/notices')).data);

  Future<Notice> findByIdx({
    @required int nIdx
  }) async => Notice.fromJson((await api.get(url: '/dsites/-/notices/$nIdx')).data);
}