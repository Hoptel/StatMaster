//This class extends no type since the base table (Stats) is never used, if you want to add stats model and use it here, this class needs to extend ServiceFactory<Stats>

import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

import '../../Models/SingleDataResult.dart';
import '../../Models/stats/gen/Rev.dart';
import '../../Models/stats/gen/Sales.dart';
import '../RequestHelper.dart';
import '../ServiceFactory.dart';

class StatsService extends ServiceFactory {
  static StatsService instance;

  @override
  createObject(String input) {
    return null;
  }

  @override
  String getEndpointName() {
    return "stats";
  }

  static StatsService getInstance() {
    return instance != null ? instance : StatsService();
  }

  Future<Rev> getGenRev(DateTime startDate, DateTime endDate, {Map<String, String> headers}) async {
    Response response =
        await callService(HttpMethod.GET, "/gen/rev", headers ?? await RequestHelper.getAuthHeader(), params: {
      'startdate': DateFormat(serviceDateFormat).format(startDate),
      'enddate': DateFormat(serviceDateFormat).format(endDate)
    });
    return response != null && response.statusCode == 200
        ? SingleDataResult<Rev>.fromJson(json.decode(response.body)).data
        : null;
  }

  Future<Sales> getGenSales(DateTime startDate, DateTime endDate, {Map<String, String> headers}) async {
    Response response =
        await callService(HttpMethod.GET, "/gen/sales", headers ?? await RequestHelper.getAuthHeader(), params: {
      'startdate': DateFormat(serviceDateFormat).format(startDate),
      'enddate': DateFormat(serviceDateFormat).format(endDate)
    });
    return response != null && response.statusCode == 200
        ? SingleDataResult<Sales>.fromJson(json.decode(response.body)).data
        : null;
  }

  
}
