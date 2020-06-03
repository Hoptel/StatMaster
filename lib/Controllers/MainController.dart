import 'package:scoped_model/scoped_model.dart';

import 'EmployeeController.dart';
import 'LoginController.dart';
import 'ReservatController.dart';
import 'StatsController.dart';

///This controller is dealing with all other controllers and general settings, it splits the controllers into 3, 1 part
///that gets data on every change, [_reservatController] for example, the second only needs data once,
///[_employeeController] is an example. the third is persistent and never changing, such as [_loginController]
///This controller allows the developer to set, reset, or access values within all controllers for the application.
class MainController extends Model {
  static MainController instance;
  bool _dataRetrieved = false;

  bool isLoading = false;

  static MainController getInstance() {
    if (instance == null) {
      instance = MainController();
    }
    return instance;
  }

  ReservatController _reservatController;
  StatsController _statsController;
  EmployeeController _employeeController;
  LoginController _loginController;

  ReservatController get reservatController => _reservatController;

  void setReservatController(ReservatController value, {bool flush = false}) {
    if (_reservatController == null || flush) {
      _reservatController = value;
    }
  }

  StatsController get statsController => _statsController;

  void setStatsController(StatsController value, {bool flush = false}) {
    if (_statsController == null || flush) {
      _statsController = value;
    }
  }

  EmployeeController get employeeController => _employeeController;

  void setEmployeeController(EmployeeController value, {bool flush = false}) {
    if (_employeeController == null || flush) {
      _employeeController = value;
      _dataRetrieved = false;
    }
  }

  LoginController get loginController => _loginController;

  void setLoginController(LoginController value, {bool flush = false}) {
    if (_loginController == null || flush) {
      _loginController = value;
      notifyListeners();
    }
  }

  void resetControllers() {
    setReservatController(ReservatController(), flush: true);
    setEmployeeController(EmployeeController(), flush: true);
  }

  //the start date for the stats
  DateTime filterStartDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  //the end date (inclusive) for the stats
  DateTime filterEndDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  ///This method is called when a change in the filter date happens, note that either the [start], [end], or [oneDate]
  ///must not be null. If [oneDate] is not null then both will be set to it, ignoring their own dates. Otherwise each
  ///will be set on its own.
  Future setFilterDates({DateTime start, DateTime end, DateTime oneDate}) async {
    setLoading();
    assert(start != null || end != null || oneDate != null);
    filterStartDate = oneDate ?? start ?? filterStartDate;
    filterEndDate = oneDate ?? end ?? filterEndDate;
    await getAppData();
    setLoading();
    notifyListeners();
  }

  ///A method to retrieve all data needed by the app (mainly for the widgets), this allows the app to load new data when
  ///date selection changes.
  Future getAppData({bool getAll = false}) async {
    //todo split these into asynchronous functions (none of them need to wait for each other)
    await _reservatController.getOCCData(filterStartDate, filterEndDate);
    //for the forecast chart, only use the end date if the dates are 7 or more days apart
    await _reservatController.getOccupancyForecastsOnly(
        start: filterStartDate,
        end: filterEndDate.difference(filterStartDate).compareTo(Duration(days: 7)) < 0
            ? filterStartDate.add(Duration(days: 6))
            : filterEndDate);
    await _statsController.getRevData(filterStartDate, filterEndDate);
    await _statsController.getSalesData(filterStartDate, filterEndDate);
    //only get the following if they've not been retrieved already, or we're performing a reset
    if (getAll || !_dataRetrieved) {
      await _employeeController.resetData();
    }
  }

  void setLoading({bool set}) {
    isLoading = set ?? !isLoading;
    notifyListeners();
  }
}
