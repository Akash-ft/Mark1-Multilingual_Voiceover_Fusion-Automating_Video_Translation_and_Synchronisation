import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:network_logger/network_logger.dart';

import 'dio_interceptors.dart';
import 'globals.dart';

HttpClient? _httpClient;

Future<void> initSSLCertificate() async {
  // ByteData bytes = await rootBundle.load('assets/vss_fleetman_ae.pfx');
  ByteData bytes =
      await rootBundle.load('assets/fmsmobileapinonprod.etisalat.ae.pfx');
  final context = SecurityContext.defaultContext;
  context.allowLegacyUnsafeRenegotiation = true;
  // context.useCertificateChainBytes(bytes.buffer.asUint8List(),
  //     password: "qa@1234");
  // context.usePrivateKeyBytes(bytes.buffer.asUint8List(), password: "qa@1234");
  context.useCertificateChainBytes(bytes.buffer.asUint8List(),
      password: "1234");
  context.usePrivateKeyBytes(bytes.buffer.asUint8List(), password: "1234");
  _httpClient = HttpClient(context: context);
  _httpClient!.badCertificateCallback =
      (X509Certificate cert, String host, int port) {
    return true;
  };
}

var httpClientProvider = Provider<HttpClient?>(
  (ref) => _httpClient,
);

var dioProvider = Provider<Dio>(
  (ref) => DioHelper(
    Globals(),
    ref.read,
    _httpClient,
  ).createDio(),
);

class DioHelper {
  final Globals _globals;
  final Reader _reader;
  final HttpClient? _httpClient;

  DioHelper(this._globals, this._reader, this._httpClient);

  Dio createDio() {
    var dio = Dio(
      BaseOptions(
        baseUrl: _globals.url,
        receiveTimeout: _globals.timeout,
        connectTimeout: _globals.timeout,
        sendTimeout: _globals.timeout,
      ),
    );
   // dio.interceptors.add(DioNetworkLogger());
    if (_httpClient != null) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        return _httpClient;
      };
    }
    dio.interceptors.addAll(
      _reader(dioInterceptorProvider(dio)),
    );

    return dio;
  }
}
