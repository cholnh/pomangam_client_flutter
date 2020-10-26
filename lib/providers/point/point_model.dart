import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client_flutter/domains/user/point_log/point_log.dart';
import 'package:pomangam_client_flutter/domains/user/point_rank/point_rank.dart';
import 'package:pomangam_client_flutter/repositories/point/point_repository.dart';

class PointModel with ChangeNotifier {

  PointRepository _pointRepository;

  List<PointLog> pointLogs = List();
  List<PointRank> pointRanks = List();

  bool isFetching = false;

  PointModel() {
    _pointRepository = Injector.appInstance.getDependency<PointRepository>();
  }

  Future<void> fetchLogs() async {
    isFetching = true;
    try {
      this.pointLogs = await _pointRepository.findUserPointLogs();
    } catch (error) {
      print('[Debug] DeliverySiteModel.fetchLogs Error - $error');
    }
    isFetching = false;
    notifyListeners();
  }

  Future<void> fetchRanks() async {
    isFetching = true;
    try {
      this.pointRanks = await _pointRepository.findPointRanks();
    } catch (error) {
      print('[Debug] DeliverySiteModel.fetchRanks Error - $error');
    }
    isFetching = false;
    notifyListeners();
  }

}