import 'dart:convert';

import 'package:hotech_flutter_utilities/Constants.dart';
import 'package:hotech_flutter_utilities/model/ListDataResult.dart';
import 'package:hotech_flutter_utilities/model/reserv/ForecastDay.dart';
import 'package:hotech_flutter_utilities/model/reserv/ForecastTotals.dart';
import 'package:hotech_flutter_utilities/model/reserv/Reservat.dart';
import 'package:hotech_flutter_utilities/service/LoginHelper.dart';
import 'package:hotech_flutter_utilities/service/RESTResponse.dart';
import 'package:hotech_flutter_utilities/service/ServiceFactory.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class ReservatService extends ServiceFactory<Reservat> {
  static ReservatService instance;

  static ReservatService getInstance() {
    return instance != null ? instance : ReservatService();
  }

  @override
  String getTableName() {
    return DBConst.TBL_RESERVAT;
  }

  Future<List<ForecastDay>> getForecastDay(DateTime startDate, DateTime endDate, {Map<String, String> headers}) async {
    Response response =
        await callService(HttpMethod.GET, Consts.PATH_FORECAST_DAY, headers ?? await LoginHelper.getHeaders(), params: {
      DBConst.FDN_STARTDATE: DateFormat(Consts.dbDateFormat).format(startDate),
      DBConst.FDN_ENDDATE: DateFormat(Consts.dbDateFormat).format(endDate),
      Consts.PARAM_LIMIT: 0,
    });
    return response != null && RESTResponseType.isSuccessful(response.statusCode)
        ? ListDataResult<ForecastDay>.fromJson(json.decode(response.body)).data
        : null;
  }

  Future<List<ForecastTotals>> getForecastTotals(DateTime startDate, DateTime endDate,
      {Map<String, String> headers}) async {
    Response response = await callService(
        HttpMethod.GET, Consts.PATH_FORECAST_TOTALS, headers ?? await LoginHelper.getHeaders(),
        params: {
          DBConst.FDN_STARTDATE: DateFormat(Consts.dbDateFormat).format(startDate),
          DBConst.FDN_ENDDATE: DateFormat(Consts.dbDateFormat).format(endDate),
          Consts.PARAM_LIMIT: 0,
        });
    return response != null && RESTResponseType.isSuccessful(response.statusCode)
        ? ListDataResult<ForecastTotals>.fromJson(json.decode(response.body)).data
        : null;
  }
}
