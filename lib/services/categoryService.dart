import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zero_vendor/models/Categories.dart';
import 'package:zero_vendor/services/authService.dart';
import 'package:zero_vendor/services/baseService.dart';

class CategoryService extends AuthService {
  static Future<List<Category>> getAllCategoriesRequest() async {
    var user = await AuthService.getSavedAuth();
    Map<String, String> headers = {"Authorization": "Bearer ${user['token']}"};

    String url = AuthService.CATEGORY_URI;
    print(url);

    http.Response response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      List<Category> categories = responseMap['Categories']
          .map<Category>(
              (categoriesMap) => Category.fromJson(categoriesMap))
          .toList();
      return categories;
    } else {
      print(response.statusCode);
    }
  }
}
