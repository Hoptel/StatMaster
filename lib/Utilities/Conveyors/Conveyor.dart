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
  String getBaseUrl() => 'http://10.0.2.2:5000/forest'; //Preference.getString(PreferenceKeys.sync_url);

  ///
  ///This is used to generate the API request's URL
  ///
  String getEndpointName();

  ///
  ///This is used to generate models and return them
  ///
  T createObject(Map<String, dynamic> input);

  ///
  ///These are the methods used to send the requests
  ///
  static Map<HttpMethod, dynamic> clientFunctions = {
  HttpMethod.GET: (url, headers, requestBody) => serviceClient.get(url, headers: headers),
  HttpMethod.HEAD: (url, headers, requestBody) => serviceClient.head(url, headers: headers),
  HttpMethod.POST: (url, headers, requestBody) => serviceClient.post(url, body: requestBody, headers: headers),
  HttpMethod.PUT: (url, headers, requestBody) => serviceClient.put(url, body: requestBody, headers: headers),
  HttpMethod.PATCH: (url, headers, requestBody) => serviceClient.patch(url, body: requestBody, headers: headers),
  HttpMethod.DELETE: (url, headers, requestBody) => serviceClient.delete(url, headers: headers),
  };

  static IOClient serviceClient;

  ///
  ///This method sends the request and returns the response, please don't put sensitive data in the bloody parameters
  ///
  Future<Response> callService(
      HttpMethod method,
      String moduleUrl,
      Map<String, String> headers, {
        requestBody,
        Map<String, dynamic> params,
        Map<String, dynamic> queries,
        String customUrl,
        Duration timeout = const Duration(seconds: 10),
      }) async {
    //create a new client if one doesn't exist
    serviceClient = serviceClient ?? IOClient();

    // get url
    String url = (customUrl ?? getBaseUrl()) + (getEndpointName() ?? "") + moduleUrl + fullArgsToString(params, queries);

    try {
      Future<Response> future;
      Response response;

      //print the HTTP request
      printRequest(url, method, headers, requestBody);

      //send the request
      future = clientFunctions[method](url, headers, requestBody);

      if (future != null) {
        //get the response.
        response = timeout != null ? await future.timeout(timeout) : await future;

        //print the response
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

  ///
  ///prints the request, duh
  ///
  static void printRequest(
      String url,
      HttpMethod method,
      headers,
      requestBody,
      ) {
    String httpMethod = method != null ? method.toString().substring(11) : ""; //"httpmethod." is 11 characters long
    String header = headers != null ? headers.toString() + "\n" : "";
    String returnString = "▲▲▲ $httpMethod $url\n$header\n";

    if (method == HttpMethod.POST && requestBody != null) {
      returnString += "Request Body: $requestBody\n";
    }

    Utils.logPrint(returnString);
  }

  ///
  /// print the response received from the service along with status code, url, and response.
  /// takes the response as a [String]
  ///
  void printResponse(HttpMethod method, String response, int statusCode, String url) {
    String returnString = "▼▼▼ $statusCode $url\nResponse Body: $response";

    Utils.logPrint(returnString);
  }

  ///
  /// print the response received from the service along with status code, url, and response.
  ///
  void printResponseLog(HttpMethod method, Response response, String url) {
    printResponse(method, response.body, response.statusCode, url);
  }

  ///
  /// @return the [query] param and the other params to be appended to the services
  ///
  /// @example {entity}/view/list?query=id:15,roomno:15D&allhotels=true&limit=50
  ///
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

  ///
  ///Converts the parameter map to a string that will be added to the URL
  ///
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

  ///
  ///Same as [argsToString] but works with the query parameter only (why the API has a query parameter idk)
  /// 
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
