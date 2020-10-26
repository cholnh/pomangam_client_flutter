import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:pomangam_client_flutter/_bases/constants/endpoint.dart';

class DioCore {

  Dio oauth;
  Dio resource;
  Dio externalApi;

  static final DioCore _singleton = DioCore._internal();

  factory DioCore() {
    return _singleton;
  }

  DioCore._internal() {
    initialize();
  }

  void initialize() {
    final BaseOptions options = BaseOptions(
      baseUrl: Endpoint.serverDomain,
      connectTimeout: Endpoint.connectTimeout,
      receiveTimeout: Endpoint.receiveTimeout,
    );
    oauth = Dio(options);
    resource = Dio(options);
    externalApi = Dio();
  }

  void setResourceLocale(Locale locale) {
    addResourceHeader({
      'Accept-Language': locale
    });
  }

  void addResourceHeader(Map<String, dynamic> header) {
    resource.interceptors.add(InterceptorsWrapper(
      onRequest:(RequestOptions options) async {
        options.headers.addAll(header);
        return options;
      }
    ));
  }
}