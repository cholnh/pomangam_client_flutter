import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client_flutter/domains/version/version.dart';
import 'package:pomangam_client_flutter/repositories/version/version_repository.dart';

class VersionModel with ChangeNotifier {

  VersionRepository _versionRepository;

  Version version;

  VersionModel() {
    _versionRepository = Injector.appInstance.getDependency<VersionRepository>();
  }

  Future<Version> fetch() async {
    try {
      this.version = await _versionRepository.find();
    } catch (error) {
      print('[Debug] VersionModel.fetch Error - $error');
    }
    notifyListeners();
    return version;
  }

}