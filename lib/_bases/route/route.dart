import 'package:get/get.dart';
import 'package:pomangam_client_flutter/views/pages/_bases/base_page.dart';
import 'package:pomangam_client_flutter/views/pages/event/event_detail_page.dart';
import 'package:pomangam_client_flutter/views/pages/notice/notice_detail_page.dart';
import 'package:pomangam_client_flutter/views/pages/store/store_page.dart';

List<GetPage> route = [
  GetPage(name: '/', page: () => BasePage()),
  GetPage(name: '/events', page: () {
    return EventDetailPage(int.tryParse(Get.parameters['eIdx']));
  }),
  GetPage(name: '/notices', page: () {
    return NoticeDetailPage(int.tryParse(Get.parameters['nIdx']));
  }),
];