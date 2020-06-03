import 'dart:convert';

class ResponseBody {
  final bool success;
  final String msg;
  final List<dynamic> spuriousParameters;
  final dynamic data; //Either 1 object or a list of objects
  final int count;

  ResponseBody({
    this.success,
    this.msg,
    this.spuriousParameters,
    this.data,
    this.count,
  });

  factory ResponseBody.fromJson(Map<String, dynamic> json) {
    return ResponseBody(
      success: json['success'],
      msg: json['msg'],
      spuriousParameters: json['spuriousparameters'],
      data: json['data'],
      count: json['count'],
    );
  }
}
