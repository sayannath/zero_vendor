import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zero_vendor/models/product.dart';
import 'package:zero_vendor/services/authService.dart';
import 'package:zero_vendor/services/baseService.dart';

class ProductService extends BaseService {
  static Future<http.Response> createProduct(Product p) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = await AuthService.getSavedAuth();
    var id = prefs.get("id");
    Map<String, String> headers = {
      "Authorization": "Bearer ${user['token']}",
      "Content-Type": "application/form-data"
    };

    String url = BaseService.ITEM_URI + id;
    print(url);

    return http.post(url, headers: headers, body: productToJson(p));
  }
}
