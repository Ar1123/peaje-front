import 'dart:developer';

import 'package:dio/dio.dart';

class HttpRequest {
  final _dio = Dio();
  // ignore: constant_identifier_names
  static const URLBASE = "http://192.168.100.4:3000/api/v1/";

  Future<Map<String, dynamic>> post({
    required Map<String, dynamic> body,
    required String path,
    required Map<String, String> headers,
  }) async {
    final url = "$URLBASE$path";
    log(url);
    final sendPost = await _dio.post((url),
        data: body,
        options: Options(
          headers: headers,
        ));
    log("${sendPost.data}");
    return sendPost.data;
  }

  Future<Map<String, dynamic>> getAll({
    required Map<String, String> headers,
    required String path,
  }) async {
    final url = "$URLBASE$path";
    log(url);
    final getData = await _dio.get(url);
    return getData.data;
  }

  Future<Map<String, dynamic>> update({
    required Map<String, dynamic> data,
    required Map<String, dynamic> headers,
    required String path,
  }) async {
    final url = "$URLBASE$path";
    log(url);
    final sendPost = await _dio.patch((url),
        data: data,
        options: Options(
          headers: headers,
        ));
    return sendPost.data;
  }
}
