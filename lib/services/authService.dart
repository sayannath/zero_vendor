import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zero_vendor/services/baseService.dart';

class AuthService extends BaseService {
  static Map<String, dynamic> _authDetails;
  static const String authNamespace = "auth";
  static const BASE_URI = "http://192.168.1.5:3000/api/";
  static const AUTH_URI = "http://192.168.1.5:3000/api/signin";
  static const USER_URI = "http://192.168.1.5:3000/api/user";
  static const CATEGORY_URI = "http://192.168.1.5:3000/api/categories";
  static const ITEM_URI = "http://192.168.1.5:3000/api/product/create/";

  // ignore: missing_return
  static Future<http.Response> makeAuthenticatedRequest(String path,
      {String method = 'POST',
      body,
      mergeDefaultHeader = true,
      Map<String, String> extraHeaders}) async {
    try {
      Map<String, dynamic> auth = await getSavedAuth();

      extraHeaders ??= {};
      var sentHeaders = mergeDefaultHeader
          ? {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${auth['access']}"
            }
          : extraHeaders;

      switch (method) {
        case 'POST':
          body ??= {};
          return http.post(path, headers: sentHeaders, body: body);

        case 'GET':
          body ??= {};
          return http.get(path, headers: sentHeaders);

        default:
          print("");
          return http.post(path, headers: sentHeaders, body: body);
      }
    } catch (err) {
      print(err);
    }
  }

  static Future<Map<String, dynamic>> getSavedAuth() async {
    if (AuthService._authDetails != null) {
      return _authDetails;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> auth = prefs.getString(authNamespace) != null
        ? json.decode(prefs.getString(authNamespace))
        : null;
    AuthService._authDetails = auth;
    print('Saved');
    return auth;
  }

  static Future<bool> authenticate(String email, String password) async {
    var payload = json.encode({'email': email, 'password': password});
    print(payload);

    http.Response response = await BaseService.makeUnauthenticatedRequest(
        BaseService.AUTH_URI,
        body: payload);

    Map<String, dynamic> responseMap = json.decode(response.body);
    print(responseMap);

    String token = responseMap['token'];
    String role = responseMap['role'].toString();
    String userId = responseMap['_id'].toString();
    print(role);
    bool success = token != null;

    if (success) _saveToken(token, email, role, userId);
    return success;
  }

  static _saveToken(String token, String email, String role, String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(authNamespace,
        json.encode({"email": email, "token": token, "role": role}));
    prefs.setString("id", id);
  }

  static clearAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    _authDetails = null;
    print('Cleared');
  }
}
