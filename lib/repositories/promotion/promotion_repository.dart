import 'package:pomangam_client_flutter/_bases/network/api/api.dart';
import 'package:pomangam_client_flutter/domains/promotion/promotion.dart';

class PromotionRepository {

  final Api api; // 서버 연결용
  PromotionRepository({this.api});

  Future<List<Promotion>> findByDeliverySite({int dIdx}) async
    => Promotion.fromJsonList((await api.get(url: '/dsites/$dIdx/promotions')).data);
}