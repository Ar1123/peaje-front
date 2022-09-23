import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:peaje/config/api/http_connect.dart';
import 'package:peaje/config/shared/preferences.dart';

class LoginProvider {
  final _http = HttpRequest();
  final _pref = Preferences();
  Future<bool> sendInfoLogin({
    required Map<String, dynamic> data,
  }) async {
    bool valid = false;
    final result = await _http.post(
      body: data,
      path: "auth-dev/login",
      headers: {},
    );
    if (!result.toString().contains("code")) {
      return false;
    }
    if (result["code"] == "ok") {
      _pref.setKeyString = {
        "key": "token",
        "value": result["body"]["access_token"]
      };
      valid = true;
    }
    return valid;
  }

  Future<bool> closeSession({required BuildContext context}) async {
    bool status = false;
    final update = await _http.update(
      data: {
        "fin": {
          "hora": TimeOfDay.now().format(context),
          "fecha": DateTime.now().toIso8601String(),
        }
      },
      headers: {
        "x-token": _pref.getKeyString("token")!,
      },
      path: "turnos-dev/update",
    );
    if (update["code"] == "Ok") {
      status = true;
      await _pref.clearPreferences("token");
    }
    log("$update--->--<");
    return status;
  }

  Future<bool> sessionActive() async {
    final token = _pref.getKeyString("token") ?? "";
    return token.isEmpty;
  }
}
