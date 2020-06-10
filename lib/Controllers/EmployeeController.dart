import 'dart:async';
import 'dart:io';

import 'package:StatMaster/Utilities/Conveyors/DBFileConveyor.dart';
import 'package:StatMaster/Utilities/Conveyors/EmployeeConveyor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '../Utilities/Preference.dart';
import '../Utilities/Models/Employee.dart';
import '../Utilities/Models/EmployeeHotel.dart';
import '../Utilities/Models/DBFile.dart';
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
        List<Employee> employeeList = await EmployeeConveyor.getInstance().sendGet(
            queries: {"code": code});
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
    print("IDENIDENIDENIDEN");
    print(identifier);
    Employee currentEmp;
    for (Employee emp in employeeData.values) {
      print (emp.userid);
      if (emp.userid == identifier) {
        currentEmp = emp;
        break;
      }
    }
    return currentEmp;
  }

  Future getEmployeeHotels() async {
    if (!employeeHotelsLoaded) {
      employeeHotels = await EmployeeConveyor.getInstance().getEmpHotelList();
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
        List<DBFile> files =
            await DBFileConveyor().sendGet(queries: {"masterid": employee.guid, "code": "PHOTO"});
        if (files.isNotEmpty) {
          DBFile file = files?.first;
          File downloadFile = await DBFileConveyor.getInstance()
              .download(employee.guid, file.code);
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
