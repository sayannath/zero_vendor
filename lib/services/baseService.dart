import 'package:http/http.dart' as http;

class BaseService {
  //static const AUTH_URI = "http://ec2-3-83-125-93.compute-1.amazonaws.com/api/signin";
  static const AUTH_URI = "http://localhost:3000/api/signin";

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
}