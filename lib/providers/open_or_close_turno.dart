import 'dart:developer';

import 'package:peaje/config/api/http_connect.dart';
import 'package:peaje/config/shared/preferences.dart';

class OpenOrCloseTurno {
  final _http = HttpRequest();
  final _prefs = Preferences();
  Future<bool> openTurn({required Map<String, dynamic> data}) async {
    bool valid = false;
    final open = await _http.post(
      body: data,
      path: "turnos-dev/create",
      headers: {
        "x-token": _prefs.getKeyString("token")!,
      },
    );

    log("-->$open");
    return valid;
  }
}
