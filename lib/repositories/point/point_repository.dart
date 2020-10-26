import 'package:pomangam_client_flutter/_bases/network/api/api.dart';
import 'package:pomangam_client_flutter/domains/user/point_log/point_log.dart';
import 'package:pomangam_client_flutter/domains/user/point_rank/point_rank.dart';

class PointRepository {

  final Api api; // 서버 연결용
  PointRepository({this.api});

  Future<List<PointLog>> findUserPointLogs() async
    => PointLog.fromJsonList((await api.get(url: '/users/-/points')).data);

  Future<List<PointRank>> findPointRanks() async
  => PointRank.fromJsonList((await api.get(url: '/points/rank')).data);
}