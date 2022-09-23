import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:peaje/config/api/http_connect.dart';

import '../models/arrive.dart';

class ArrivalsProvider {
  final _requestHttp = HttpRequest();

  Future<bool> addArrival({
    required Map<String, dynamic> data,
  }) async {
    bool status = false;
    final sendArrival = await _requestHttp.post(
      body: data,
      path: "arrivals-dev/create",
      headers: {},
    );
    if (sendArrival["code"] == "Ok") {
      status = true;
    }
    return status;
  }

  Future<Arrive> getReport() async {
    Arrive arrive = Arrive();
    final report = await _requestHttp.getAll(
      headers: {},
      path: "arrivals-dev/getReport",
    );

    log("$report", name: "Report");

    arrive = Arrive.fromJson(report);
    return arrive;
  }
}
