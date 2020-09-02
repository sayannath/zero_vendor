import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zero_vendor/models/Category.dart';
import 'package:zero_vendor/services/authService.dart';
import 'package:zero_vendor/services/baseService.dart';

class CategoryService extends BaseService {
  static Future<http.Response> getAllCategoriesRequest() async {

    var user = await AuthService.getSavedAuth();
    Map<String, String> headers = {"Authorization": "Bearer ${user['token']}"};

    String url = BaseService.CATEGORY_URI;
    print(url);

    return http.get(url, headers: headers);
  }

  static getAllCategoriesResponse() async {
    http.Response response = await getAllCategoriesRequest();
    return Category.fromJson(jsonDecode(response.body));
  }
}