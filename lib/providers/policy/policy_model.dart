import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client_flutter/repositories/policy/policy_repository.dart';

class PolicyModel with ChangeNotifier {

  PolicyRepository _policyRepository;

  String htmlPrivacy;
  String htmlTerms;
  String htmlRefund;

  PolicyModel() {
    _policyRepository = Injector.appInstance.getDependency<PolicyRepository>();
  }

  Future<void> privacy() async {
    try {
      htmlPrivacy = await _policyRepository.privacy();
    } catch (error) {
      print('[Debug] PolicyModel.privacy Error - $error');
    }
    notifyListeners();
  }

  Future<void> terms() async {
    try {
      htmlTerms = await _policyRepository.terms();
    } catch (error) {
      print('[Debug] PolicyModel.terms Error - $error');
    }
    notifyListeners();
  }

  Future<void> refund() async {
    try {
      htmlRefund = await _policyRepository.refund();
    } catch (error) {
      print('[Debug] PolicyModel.refund Error - $error');
    }
    notifyListeners();
  }
}