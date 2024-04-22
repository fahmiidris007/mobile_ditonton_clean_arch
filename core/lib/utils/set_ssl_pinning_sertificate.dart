import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class SetSSLPinningCertificate {
  static Future<HttpClient> customHttpClient() async {
    SecurityContext context = SecurityContext(withTrustedRoots: false);

    try {
      List<int> bytes = [];
      bytes = (await rootBundle.load('certificates/certificates.crt'))
          .buffer
          .asUint8List();
      context.setTrustedCertificatesBytes(bytes);
      log('[SSL Pinning] Certificate Added!');
    } on TlsException catch (e) {
      if (e.osError?.message != null &&
          e.osError!.message.contains('CERT_ALREADY_IN_HASH_TABLE')) {
        log('[SSL Pinning] Certificate already trusted! Skipping.');
      } else {
        log('[SSL Pinning] Certificate setTrustedCertificateBytes EXCEPTION: $e');
        rethrow;
      }
    } catch (e) {
      log('unexpected error $e');
      rethrow;
    }

    HttpClient httpClient = HttpClient(context: context);
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;

    return httpClient;
  }

  static Future<http.Client> createLEClient() async {
    IOClient client =
        IOClient(await SetSSLPinningCertificate.customHttpClient());
    return client;
  }
}
