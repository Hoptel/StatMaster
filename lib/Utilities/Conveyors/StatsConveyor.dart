//This class extends no type since the base table (Stats) is never used, if you want to add stats model and use it here, this class needs to extend ServiceFactory<Stats>

import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

import '../Models/Rev.dart';
import '../Models/Sales.dart';
import 'RequestHelper.dart';
import 'Conveyor.dart';

class StatsConveyor extends Conveyor {
  static StatsConveyor instance;

  @override
  createObject(input) {
    return null;
  }

  @override
  String getBlueprintName() {
    return "stat";
  }

  static StatsConveyor getInstance() {
    return instance != null ? instance : StatsConveyor();
  }

  Future<Rev> getGenRev(DateTime startDate, DateTime endDate, {Map<String, String> headers}) async {
    Response response =
        await sendRequest(HttpMethod.GET, "/gen/revenue", headers ?? await RequestHelper.getAuthHeader(), params: {
      'startdate': DateFormat(serviceDateFormat).format(startDate),
      'enddate': DateFormat(serviceDateFormat).format(endDate)
    });
    return response != null && response.statusCode == 200
        ? Rev.fromJson(json.decode(response.body)['data'])
        : null;
  }

  Future<Sales> getGenSales(DateTime startDate, DateTime endDate, {Map<String, String> headers}) async {
    Response response =
        await sendRequest(HttpMethod.GET, "/gen/sales", headers ?? await RequestHelper.getAuthHeader(), params: {
      'startdate': DateFormat(serviceDateFormat).format(startDate),
      'enddate': DateFormat(serviceDateFormat).format(endDate)
    });
    return response != null && response.statusCode == 200
        ? Sales.fromJson(json.decode(response.body)['data'])
        : null;
  }

  
}
