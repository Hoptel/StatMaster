import 'dart:async';

import '../Preference.dart';

class RequestHelper {

  static const Map<String, String> postHeaders = {"Accept": "application/json", "Content-Type": "application/json"};

  static Future<Map<String, String>> getPostHeaders() async {
    Map<String, String> headers = await getAuthHeader();
    headers.addAll(postHeaders);
    return headers;
  }

  static Future<Map<String, String>> getAuthHeader() async {
    String accessToken = await Preference.getAccessToken();
    if (accessToken != null && accessToken != "") {
      return {
        "Authorization": "bearer $accessToken",
      };
    } else {
      return {};
    }
  }
}
