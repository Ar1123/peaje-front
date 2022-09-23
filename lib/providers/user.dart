import 'dart:developer';

import 'package:peaje/config/api/http_connect.dart';
import 'package:peaje/models/user.dart';

class UserProvider {
  final _http = HttpRequest();

  Future<UserModel> getUser({required String id}) async {
    UserModel userModel = UserModel();
    final user = await _http.getAll(
      headers: {},
      path: "user-dev/getUser/$id",
    );
    userModel = UserModel.fromJson(
      user,
    );
    log("$user -->-->");
    return userModel;
  }
}
