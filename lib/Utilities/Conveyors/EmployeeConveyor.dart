import 'dart:async';
import 'dart:convert';

import 'package:StatMaster/Utilities/Conveyors/Conveyor.dart';

import '../Models/Employee.dart';
import '../Models/EmployeeHotel.dart';
import 'RequestHelper.dart';
import 'Conveyor.dart';
import 'package:http/http.dart';

class EmployeeConveyor extends Conveyor<Employee> {
  static EmployeeConveyor instance;

  static EmployeeConveyor getInstance() {
    return instance != null ? instance : EmployeeConveyor();
  }

  @override
  Employee createObject(Map<String, dynamic> input) {
    return Employee.fromJson(input);
  }

  @override
  String getBlueprintName() {
    return 'employee';
  }

  Future<List<EmployeeHotel>> getEmpHotelList({Map<String, String> headers,int id} ) async {
    Response response = await sendRequest(
        HttpMethod.GET, "/hotels", headers ?? await RequestHelper.getAuthHeader());
        List<EmployeeHotel> returnList = [];
    for (var item in json.decode(response.body)['data']) {
      returnList.add(EmployeeHotel.fromJson(item as Map<String, dynamic>));
    }
    return response != null && response.statusCode == 200
        ? returnList
        : null;
  }

  
}
