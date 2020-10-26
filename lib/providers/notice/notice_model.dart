import 'package:flutter/cupertino.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client_flutter/domains/notice/notice.dart';
import 'package:pomangam_client_flutter/repositories/notice/notice_repository.dart';

class NoticeModel with ChangeNotifier {

  NoticeRepository _noticeRepository;

  Notice notice;
  List<Notice> notices = List();

  bool isFetching = false;

  NoticeModel() {
    _noticeRepository = Injector.appInstance.getDependency<NoticeRepository>();
  }

  Future<void> fetch({
    @required int dIdx
  }) async {
    isFetching = true;
    try {
      this.notices = await _noticeRepository.findAll(dIdx: dIdx);
    } catch (error) {
      print('[Debug] NoticeModel.fetch Error - $error');
      isFetching = false;
    }
    isFetching = false;
    notifyListeners();
  }

  Future<void> fetchOne({
    @required int nIdx
  }) async {
    isFetching = true;
    try {
      this.notice = await _noticeRepository.findByIdx(nIdx: nIdx);
    } catch (error) {
      print('[Debug] NoticeModel.fetchOne Error - $error');
      isFetching = false;
    }
    isFetching = false;
    notifyListeners();
  }
}