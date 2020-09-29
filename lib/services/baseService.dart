import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BaseService {
  static const BASE_URI = "http://192.168.1.5:3000/api/";
  static const AUTH_URI = "http://192.168.1.5:3000/api/signin";
  static const USER_URI = "http://192.168.1.5:3000/api/user";
  static const CATEGORY_URI = "http://192.168.1.5:3000/api/categories";
  static const ITEM_URI = "http://192.168.1.5:3000/api/product/create/";
  static final Map<String, String> headers = {
    "Content-Type": "application/json"
  };

  static Future<http.Response> makeUnauthenticatedRequest(String path,
      {String method = 'POST',
      body,
      mergeDefaultHeader = true,
      Map<String, String> extraHeaders}) async {
    try {
      extraHeaders ??= {};
      var sentHeaders =
          mergeDefaultHeader ? {...headers, ...extraHeaders} : extraHeaders;

      switch (method) {
        case 'POST':
          body ??= {};
          return http.post(path, headers: sentHeaders, body: body);
          break;

        default:
          print("");
          return http.post(path, headers: sentHeaders, body: body);
      }
    } catch (err) {
      print(err);
    }
  }

  static Future<bool> authenticate(
      String firstName, String lastName, String email, String password) async {
    var payload = json.encode({
      'name': firstName,
      'lastname': firstName,
      'email': email,
      'password': password
    });
    print(payload);

    http.Response response =
        await makeUnauthenticatedRequest(BASE_URI + 'signup', body: payload);

    Map<String, dynamic> responseMap = json.decode(response.body);
    print(responseMap);

    String role = responseMap['role'].toString();
    String userId = responseMap['id'].toString();
    bool success = userId != null;

    if (success) _saveCredentials(firstName, lastName, email, role, userId);
    return success;
  }

  static _saveCredentials(String firstName, String lastName, String email,
      String role, String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        "credentials",
        json.encode({
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "role": role,
          "userId": userId
        }));
  }
}
