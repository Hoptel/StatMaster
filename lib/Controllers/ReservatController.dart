import 'package:StatMaster/Utilities/Conveyors/ReservatConveyor.dart';

import '../Utilities/Models/ForecastDay.dart';
import '../Utilities/Models/ForecastTotals.dart';
import 'package:preferences/preference_service.dart';
import 'package:scoped_model/scoped_model.dart';

class ReservatController extends Model {
  List<ForecastDay> forecastDayList = [];
  List<ForecastDay> forecastDayListOnly = [];
  ForecastTotals occData;

  bool forecastDayListLoaded = false;
  bool forecastDayListOnlyLoaded = false;
  int hotelrefno;
  double dailyAverage = 0.0;
  double dailyEmpty = 0.0;
  double weeklyAverage = 0.0;
  double weeklyEmpty = 0.0;
  double monthlyAverage = 0.0;
  double monthlyEmpty = 0.0;
  double yearlyAverage = 0.0;
  double yearlyEmpty = 0.0;
  double lastYearAverage = 0.0;
  double hotelCapRoom = 1.0;
  int occupancyChartType = 1;
  double forecastChartFull = 0.0;
  double forecastChartEmpty = 0.0;

  ReservatController() : this.hotelrefno = PrefService.getInt("hotelrefno");

  Future getOccupancyForecastsOnly({DateTime start, DateTime end}) async {
    forecastDayListOnly = await ReservatConveyor.getInstance().getForecastDay(start, end);
    forecastDayListOnlyLoaded = forecastDayListOnly.isNotEmpty;
    notifyListeners();
  }

  Future getOccupancyForecasts({DateTime start, DateTime end}) async {
    DateTime tempDate = DateTime.now();
    int timeDifferenceDay = tempDate.difference(DateTime(tempDate.year, 1, 1)).inDays - 1;
    int timeDifferenceWeek = (((timeDifferenceDay / 7).floor()) * 7) - 1;
    int monthDays =
        DateTime(tempDate.year, tempDate.month + 1, 1).difference(DateTime(tempDate.year, tempDate.month, 1)).inDays;
    int timeDifferenceMonth =
        (DateTime(tempDate.year, tempDate.month, 1).difference(DateTime(tempDate.year, 1, 1)).inDays) - 1;
    int yearDays = DateTime(tempDate.year + 1, 1, 1).difference(DateTime(tempDate.year, 1, 1)).inDays;
    int lastYearDays = DateTime(tempDate.year, 1, 1).difference(DateTime(tempDate.year - 1, 1, 1)).inDays;

    start = start ?? DateTime(tempDate.year - 1, 1, 1);
    end = end ?? DateTime(tempDate.year + 1, 1, 1);

    forecastDayList = await ReservatConveyor.getInstance().getForecastDay(start, end);
    if (forecastDayList != null) {
      forecastDayListLoaded = true;
      hotelCapRoom = forecastDayList.first.totalcaproom.toDouble();
      dailyAverage =
          (forecastDayList[(timeDifferenceDay)].totalcaproom - forecastDayList[(timeDifferenceDay)].totalemptyroom)
              .toDouble();
      dailyEmpty = hotelCapRoom - dailyAverage;
      for (int i = 0; i < 7; i++) {
        weeklyAverage += (forecastDayList[(timeDifferenceWeek + i)].totalcaproom -
            forecastDayList[(timeDifferenceWeek + i)].totalemptyroom);
      }
      weeklyAverage /= 7;
      weeklyEmpty = hotelCapRoom - weeklyAverage;
      for (int i = 0; i < monthDays; i++) {
        monthlyAverage += (forecastDayList[(timeDifferenceMonth + i)].totalcaproom -
            forecastDayList[(timeDifferenceMonth + i)].totalemptyroom);
      }
      monthlyAverage /= monthDays;
      monthlyEmpty = hotelCapRoom - monthlyAverage;
      for (int i = lastYearDays; i < forecastDayList.length; i++) {
        yearlyAverage += forecastDayList[i].totalcaproom - forecastDayList[i].totalemptyroom;
      }
      yearlyAverage /= yearDays;
      yearlyEmpty = hotelCapRoom - yearlyAverage;

      for (int i = 0; i < lastYearDays; i++) {
        lastYearAverage += forecastDayList[i].totalcaproom - forecastDayList[i].totalemptyroom;
      }
      lastYearAverage /= lastYearDays;
      getOccupancyNumbers();
    } else {
      print("Could Not Retrieve Occupancy data");
    }
    notifyListeners();
  }

  void getOccupancyNumbers() {
    switch (occupancyChartType) {
      case (2):
        forecastChartFull = weeklyAverage;
        forecastChartEmpty = weeklyEmpty;
        break;
      case (3):
        forecastChartFull = monthlyAverage;
        forecastChartEmpty = monthlyEmpty;
        break;
      case (4):
        forecastChartFull = yearlyAverage;
        forecastChartEmpty = yearlyEmpty;
        break;
      default:
        forecastChartFull = dailyAverage;
        forecastChartEmpty = dailyEmpty;
        break;
    }
    notifyListeners();
  }

  Future getOCCData(DateTime startDate, DateTime endDate) async {
    List<ForecastTotals> forecastTotals = await ReservatConveyor.getInstance().getForecastTotals(startDate, endDate);
    if (forecastTotals != null && forecastTotals.isNotEmpty) {
      occData = forecastTotals.first;
      notifyListeners();
    }
  }
}
