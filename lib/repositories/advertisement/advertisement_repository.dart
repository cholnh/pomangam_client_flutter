import 'package:pomangam_client_flutter/_bases/network/api/api.dart';
import 'package:pomangam_client_flutter/domains/advertisement/advertisement.dart';

class AdvertisementRepository {
  final Api api; // 서버 연결용
  AdvertisementRepository({this.api});

  Future<List<Advertisement>> findAll({int dIdx}) async
    => Advertisement.fromJsonList((await api.get(url: '/dsites/$dIdx/advertisements')).data);
}