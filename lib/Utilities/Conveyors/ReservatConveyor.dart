import 'dart:convert';

import 'package:StatMaster/Utilities/Conveyors/RequestHelper.dart';
import '../Models/ForecastDay.dart';
import '../Models/ForecastTotals.dart';
import 'Conveyor.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class ReservatConveyor extends Conveyor {
  static ReservatConveyor instance;

  static ReservatConveyor getInstance() {
    return instance != null ? instance : ReservatConveyor();
  }

  @override
  String getBlueprintName() {
    return "reservat";
  }

  Future<List<ForecastDay>> getForecastDay(DateTime startDate, DateTime endDate, {Map<String, String> headers}) async {
    Response response =
        await sendRequest(HttpMethod.GET, "/forecast/day", headers ?? await RequestHelper.getAuthHeader(), params: {
      "startdate": DateFormat("yyyy-MM-dd").format(startDate),
      "enddate": DateFormat("yyyy-MM-dd").format(endDate),
    });
      List<ForecastDay> returnList = [];
    for (var item in json.decode(response.body)['data']) {
      returnList.add(ForecastDay.fromJson(item as Map<String, dynamic>));
    }
    return response != null && response.statusCode == 200
        ? returnList
        : null;
  }

  Future<List<ForecastTotals>> getForecastTotals(DateTime startDate, DateTime endDate,
      {Map<String, String> headers}) async {
    Response response = await sendRequest(
        HttpMethod.GET, "/forecast/totals", headers ?? await RequestHelper.getAuthHeader(),
        params: {
          "startdate": DateFormat("yyyy-MM-dd").format(startDate),
          "enddate": DateFormat("yyyy-MM-dd").format(endDate),
        });
        List<ForecastTotals> returnList = [];
    for (var item in json.decode(response.body)['data']) {
      returnList.add(ForecastTotals.fromJson(item as Map<String, dynamic>));
    }
    return response != null && response.statusCode == 200
        ? returnList
        : null;
  }

  @override
  createObject(Map<String, dynamic> input) {
    return null;
  }
}
