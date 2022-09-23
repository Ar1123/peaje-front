import 'dart:developer';
import 'dart:ui';

import 'package:peaje/config/api/http_connect.dart';
import 'package:peaje/models/category.dart';

class CategoryProvider {
  final _requestHttp = HttpRequest();

  Future<Category> getCategoryById({required String id}) async {
    Category category = Category();
    final getCategory = await _requestHttp.getAll(
      path: "category-dev/get/$id",
      headers: {},
    );
    category = Category.fromJson(getCategory);
    return category;
  }
}
