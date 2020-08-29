import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zero_vendor/models/User.dart';
import 'package:zero_vendor/services/authService.dart';
import 'package:zero_vendor/services/baseService.dart';
import 'dart:async';
import 'dart:convert';

class UserService extends BaseService {
  static Future<http.Response> _updateUserInfoRequest({body}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = await AuthService.getSavedAuth();
    String id = prefs.getString('id');
    print("User service class $id");

    Map<String, String> headers = {
      "Authorization": "Bearer ${user['token']}",
      "Content-Type": "application/json"
    };

    String url = BaseService.USER_URI + '/$id';
    print(url);

    return http.put(url, headers: headers, body: body);
  }

  static Future<http.Response> updateUser(String phone, String latitude,
      String longitude, String address, String pincode) async {
    var payload = json.encode({
      'phone': phone,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'pincode': pincode,
    });
    print(payload);
    http.Response response = await _updateUserInfoRequest(body: payload);
    return response;
  }

  static Future<http.Response> getUserInfoRequest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = await AuthService.getSavedAuth();
    String id = prefs.getString('id');
    print("User service class $id");

    Map<String, String> headers = {"Authorization": "Bearer ${user['token']}"};

    String url = BaseService.USER_URI + '/$id';
    print(url);

    return http.get(url, headers: headers);
  }

  static getUserInfoResponse() async {
    http.Response response = await getUserInfoRequest();
    return User.fromJson(jsonDecode(response.body));
  }
}
