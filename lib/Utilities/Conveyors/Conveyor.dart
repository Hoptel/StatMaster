import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Utilities.dart';

///
/// Defines what methods the app can use to call an API
///
enum HttpMethod {GET, HEAD, POST, PUT, PATCH, DELETE}

const String serviceDateFormat = "yyyy-MM-dd";
const String serviceTimeFormat = "HH:mm";
const String serviceDateTimeFormat = "$serviceDateFormat $serviceTimeFormat";

abstract class Conveyor<T> {
  ///
  /// this returns the API's URL
  ///
  static const String serverUrl = 'http://10.0.2.2:5000/forest';

  ///
  ///This is used to get the API's module or blueprint URL
  ///
  String getBlueprintName();

  ///
  ///This is used to generate models and return them
  ///
  T createObject(Map<String, dynamic> input);

  ///
  ///These are the methods used to send the requests
  ///
  static Map<HttpMethod, dynamic> clientFunctions = {
  HttpMethod.GET: (url, headers, requestBody) => httpClient.get(url, headers: headers),
  HttpMethod.HEAD: (url, headers, requestBody) => httpClient.head(url, headers: headers),
  HttpMethod.POST: (url, headers, requestBody) => httpClient.post(url, body: requestBody, headers: headers),
  HttpMethod.PUT: (url, headers, requestBody) => httpClient.put(url, body: requestBody, headers: headers),
  HttpMethod.PATCH: (url, headers, requestBody) => httpClient.patch(url, body: requestBody, headers: headers),
  HttpMethod.DELETE: (url, headers, requestBody) => httpClient.delete(url, headers: headers),
  };

  static IOClient httpClient;

  ///
  ///This method sends the request and returns the response, please don't put sensitive data in the bloody parameters
  ///
   Future<Response> sendRequest(
      HttpMethod method,
      String endpointPath,
      Map<String, String> headers, {
        requestBody,
        Map<String, dynamic> params,
        Map<String, dynamic> queries,
        Duration timeout = const Duration(seconds: 8),
      }) async {
    httpClient = httpClient ?? IOClient();

    String url = (serverUrl + (getBlueprintName() ?? "") + endpointPath + fullArgsToString(params, queries));

    try {
      Future<Response> future;
      Response response;
      printRequest(url, method, headers, requestBody);

      future = clientFunctions[method](url, headers, requestBody);

      if (future != null) {
        response = await future.timeout(timeout);

        if (response != null && Utils.isDEBUG) {
          printResponseLog(method, response, url);
          return response;
        }
      }
    } catch (exception) {
      if (Utils.isDEBUG){
      print(exception);
      Fluttertoast.showToast(msg: "${exception.toString()}");
      }
    }
    return null;
  }

  static void sendRequestIsolate(Conveyor conveyor, HttpMethod method, String endpointPath, Map<String, String> headers, 
  {requestBody, Map<String, dynamic> params, Map<String, dynamic> queries, Duration timeout})
  {
    conveyor.sendRequest(method, endpointPath, headers, requestBody: requestBody, params: params, queries: queries, timeout: timeout);
  }

  static void printRequest(
      String url,
      HttpMethod method,
      headers,
      requestBody,
      ) {
    String httpMethod = method != null ? method.toString().substring(11) : "";
    String header = headers != null ? headers.toString() + "\n" : "";
    String returnString = "▲▲▲ $httpMethod $url\n$header\n";

    if (method == HttpMethod.POST && requestBody != null) {
      returnString += "Request Body: $requestBody\n";
    }

    print(returnString);
  }

  void printResponse(HttpMethod method, String response, int statusCode, String url) {
    String returnString = "▼▼▼ $statusCode $url\nResponse Body: $response";

    print(returnString);
  }

  void printResponseLog(HttpMethod method, Response response, String url) {
    printResponse(method, response.body, response.statusCode, url);
  }

  static String fullArgsToString(Map<String, dynamic> params, Map<String, dynamic> queries) {
    String returnString = "";
    String paramsStr = argsToString(params);
    String queriesStr = queryArgToString(queries);
    if (paramsStr != "") {
      paramsStr = "?$paramsStr";
      returnString = paramsStr;
      if (queriesStr != "") {
        returnString = "$returnString&" + queriesStr;
      }
    } else if (queriesStr != "") {
      queriesStr = "?$queriesStr";
      returnString = queriesStr;
    }
    return returnString;
  }

  static String argsToString(Map<String, dynamic> params) {
    String ret = "";
    if (params == null) {
      return ret;
    }
    params.forEach((key, value) {
      ret = "${ret != "" ? ret + "&" : ret}$key=$value";
    });
    return ret != "" ? "$ret" : ret;
  }

  static String queryArgToString(Map<String, dynamic> params) {
    String returnString = "";
    if (params == null) {
      return returnString;
    }
    params.forEach((key, value) {
      returnString = "${returnString != "" ? returnString + "," : returnString}$key:$value";
    });
    return returnString != "" ? "query=$returnString" : returnString;
  }
}
