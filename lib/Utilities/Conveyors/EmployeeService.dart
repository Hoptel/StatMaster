import 'dart:async';
import 'dart:convert';

import '../../Models/ListDataResult.dart';
import '../../Models/hr/Employee.dart';
import '../../Models/hr/EmployeeHotel.dart';
import '../RequestHelper.dart';
import '../ServiceFactory.dart';
import 'package:http/http.dart';

class EmployeeService extends ServiceFactory<Employee> {
  static EmployeeService instance;

  static EmployeeService getInstance() {
    return instance != null ? instance : EmployeeService();
  }

  @override
  Employee createObject(String input) {
    return Employee.fromJson(json.decode(input));
  }

  @override
  String getEndpointName() {
    return 'employee';
  }

  Future<List<EmployeeHotel>> getEmpHotelList({Map<String, String> headers,int id} ) async {
    Response response = await callService(
        HttpMethod.GET, "/hotel/list", headers ?? await RequestHelper.getAuthHeader());

    return response != null && response.statusCode == 200
        ? ListDataResult<EmployeeHotel>.fromJson(json.decode(response.body)).data
        : null;
  }

  
}
