import 'package:flutter/foundation.dart';
import 'package:pomangam_client_flutter/_bases/network/api/api.dart';
import 'package:pomangam_client_flutter/domains/faq/faq_category.dart';

class FaqRepository {
  final Api api; // 서버 연결용
  FaqRepository({this.api});

  Future<List<FaqCategory>> findAll({
    @required int dIdx
  }) async => FaqCategory.fromJsonList((await api.get(url: '/dsites/$dIdx/faqs')).data);
}