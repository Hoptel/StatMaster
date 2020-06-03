import 'package:StatMaster/Utilities/DateTimeUtils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:StatMaster/Controllers/MainController.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:flutter/material.dart';
import '../../Utilities/Utilities.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

class DateFilterCard extends StatelessWidget {
  ///the format used for the date display in the card
  static const String cardDateFormat = "E, MMM d";
  static const double pWidth = 360;

  @override
  Widget build(BuildContext context) {
    double scaleFactor = Utils.screenWidth(context) / pWidth;
    MainController _mainController = MainController.getInstance();
    return ScopedModel<MainController>(
      model: _mainController,
      child: Container(
        color: Theme.of(context).bottomAppBarColor,
        height: scaleFactor * 90, //todo put this in a constant as widgetHeight
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(children: <Widget>[
                  filterButton(
                      context,
                      Text(
                        "Day",
                        textScaleFactor: scaleFactor,
                      ),
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),
                      callback: () {
                    _mainController.setFilterDates(oneDate: DateTime.now());
                  }),
                  SizedBox(
                    width: 2 * scaleFactor,
                  ),
                  filterButton(
                      context,
                      Text(
                        "Week",
                        textScaleFactor: scaleFactor,
                      ), callback: () {
                    _mainController.setFilterDates(
                        start: DateTimeUtils.getWeekStart(), end: DateTimeUtils.getWeekEnd());
                  }),
                  SizedBox(
                    width: 2 * scaleFactor,
                  ),
                  filterButton(
                      context,
                      Text(
                        "Month",
                        textScaleFactor: scaleFactor,
                      ), callback: () {
                    _mainController.setFilterDates(
                        start: DateTimeUtils.getMonthStart(), end: DateTimeUtils.getMonthEnd());
                  }),
                  SizedBox(
                    width: 2 * scaleFactor,
                  ),
                  filterButton(
                      context,
                      Text(
                        "Quarter",
                        textScaleFactor: scaleFactor,
                      ), callback: () {
                    _mainController.setFilterDates(
                        start: DateTimeUtils.getQuarterStart(), end: DateTimeUtils.getQuarterEnd());
                  }),
                  SizedBox(
                    width: 2 * scaleFactor,
                  ),
                  filterButton(
                      context,
                      Text("Year",
                      textScaleFactor: scaleFactor),
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0)),
                      callback: () {
                    _mainController.setFilterDates(
                        start: DateTimeUtils.getYearStart(), end: DateTimeUtils.getYearEnd());
                  })
                ]),
              ],
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 8.0 * scaleFactor),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(500),
                          onTap: () {
                            moveDate(false);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(scaleFactor * 8.0),
                            child: Icon(
                              FontAwesomeIcons.chevronLeft,
                              size: scaleFactor * 18,
                              color: Color(0xFF752222),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ScopedModelDescendant<MainController>(builder: (context, child, model) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              setCustomDates(context);
                            },
                            child: Text(
                              DateFormat(cardDateFormat).format(model.filterStartDate) +
                                  (model.filterEndDate != model.filterStartDate
                                      ? " - ${DateFormat(cardDateFormat).format(model.filterEndDate)}"
                                      : ""),
                              textScaleFactor: scaleFactor,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        ],
                      );
                    }),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0 * scaleFactor),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(500),
                          onTap: () {
                            moveDate(true);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(scaleFactor * 8.0),
                            child: Icon(
                              FontAwesomeIcons.chevronRight,
                              size: scaleFactor * 18,
                              color: Color(0xFF752222),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future setCustomDates(BuildContext context) async {
  MainController _mainController = MainController.getInstance();
  DateTime startFirst = _mainController.filterStartDate;
  DateTime endFirst = _mainController.filterEndDate;
  List<DateTime> dates = await DateRagePicker.showDatePicker(
      context: context,
      initialFirstDate: startFirst,
      initialLastDate: endFirst,
      firstDate: DateTime(2010),
      lastDate: DateTime(2030));
  if (dates != null && dates.length >= 2) {
    DateTime startDate = dates[0];
    DateTime endDate = dates[1];
    setDates(startDate, endDate);
  }
}

void setDates(DateTime startDate, DateTime endDate) {
  MainController _mainController = MainController.getInstance();
  if (startDate == endDate) {
    _mainController.setFilterDates(oneDate: startDate);
  } else {
    _mainController.setFilterDates(start: startDate, end: endDate);
  }
}

void moveDate(bool forward) {
  MainController _mainController = MainController.getInstance();
  DateTime startFirst = _mainController.filterStartDate;
  DateTime endFirst = _mainController.filterEndDate;
  Duration dateDiff = endFirst.add(Duration(days: 1)).difference(startFirst);
  setDates(forward ? startFirst.add(dateDiff) : startFirst.subtract(dateDiff),
      forward ? endFirst.add(dateDiff) : endFirst.subtract(dateDiff));
}

Widget filterButton(BuildContext context, Widget filterName,
    {BorderRadius borderRadius = const BorderRadius.all(Radius.circular(0.0)), Function callback}) {
  return Container(
    decoration: BoxDecoration(color: Theme.of(context).selectedRowColor, borderRadius: borderRadius),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: () {
          callback();
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: filterName,
        ),
      ),
    ),
  );
}
