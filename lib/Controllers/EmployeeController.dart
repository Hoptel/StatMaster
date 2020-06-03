import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:hotech_flutter_utilities/Constants.dart';
import 'package:hotech_flutter_utilities/Preference.dart';
import 'package:hotech_flutter_utilities/model/hr/Employee.dart';
import 'package:hotech_flutter_utilities/model/hr/EmployeeHotel.dart';
import 'package:hotech_flutter_utilities/model/tools/Rafile.dart';
import 'package:hotech_flutter_utilities/service/hr/EmployeeService.dart';
import 'package:hotech_flutter_utilities/service/rafile/RafileService.dart';
import 'package:scoped_model/scoped_model.dart';

class EmployeeController extends Model {
  Map<String, Employee> employeeData = {};
  Employee currentEmployee;
  List<EmployeeHotel> employeeHotels = [];
  Map<String, FileImage> employeeImages = {};
  FileImage currentImage;

  bool employeeDataLoaded = false;
  bool _employeeDataLoading = false;
  bool employeeHotelsLoaded = false;
  bool employeeImagesLoaded = false;

  Future getEmployeeData() async {
    if (!employeeDataLoaded && !_employeeDataLoading) {
      _employeeDataLoading = true;
      List<String> loginList = await Preference.getSecureLoginMap().then((value) => value.keys.toList());
      for (String code in loginList) {
        List<Employee> employeeList = await EmployeeService.getInstance().getViewList(
            params: {DBConst.FDN_MATCH: true, DBConst.FDN_ALLHOTELS: true}, queries: {DBConst.FDN_CODE: code});
        if (employeeList.isNotEmpty) {
          employeeData[code] = (employeeList.first);
        } else {
          employeeData[code] = Employee(jsonMap: {code: code});
        }
      }
      currentEmployee = await getCurrentEmployee();
      _employeeDataLoading = false;
      if (employeeData.isNotEmpty) {
        employeeDataLoaded = true;
        notifyListeners();
      }
    }
  }

  Future<Employee> getCurrentEmployee() async {
    int identifier = await Preference.getUserID();
    Employee currentEmp;
    for (Employee emp in employeeData.values) {
      if (emp.id == identifier) {
        currentEmp = emp;
        break;
      }
    }
    return currentEmp;
  }

  Future getEmployeeHotels() async {
    if (!employeeHotelsLoaded) {
      employeeHotels = await EmployeeService.getInstance().getEmpHotelList();
      if (employeeHotels.isNotEmpty) {
        employeeHotels = employeeHotels.where((employeeHotel) {
          return employeeHotel.hotelrefno != -1;
        }).toList();
        employeeHotelsLoaded = true;
        notifyListeners();
      }
    }
  }

  Future getEmployeeImages() async {
    if (!employeeImagesLoaded) {
      for (Employee employee in employeeData.values) {
        List<Rafile> files =
            await RafileService().getViewList(queries: {DBConst.FDN_MASTERID: employee.mid, DBConst.FDN_CODE: "PHOTO"});
        if (files.isNotEmpty) {
          Rafile file = files?.first;
          File downloadFile = await RafileService.getInstance()
              .download(file, employee.mid, params: {DBConst.FDN_MID: employee.mid, DBConst.FDN_CODE: file.code});
          employeeImages[employee.code] = FileImage(downloadFile);
        }
        if (employeeImages.isNotEmpty) {
          employeeImagesLoaded = true;
          currentImage = employeeImages[currentEmployee.code];
          notifyListeners();
        }
      }
    }
  }

  Future getAllEmployeeData() async {
    await getEmployeeHotels();
    await getEmployeeData();
    await getEmployeeImages();
  }

  Future resetData() async {
    employeeDataLoaded = false;
    employeeHotelsLoaded = false;
    employeeImagesLoaded = false;
    employeeData = {};
    employeeImages = {};
    currentImage = null;
    await getAllEmployeeData();
  }
}
