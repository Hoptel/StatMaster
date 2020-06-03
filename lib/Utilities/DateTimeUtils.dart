class DateTimeUtils {

  ///returns the DateTime for monday in this week.
  static DateTime getWeekStart() {
    DateTime _currentDate = DateTime.now();
    //remove a duration of [_currentDate.weekday] from the dateTime, -1 is so that we return to day 1 which is monday rather than day 0
    return _currentDate.subtract(Duration(days: _currentDate.weekday - 1));
  }

  ///returns the DateTime for the Sunday in this week.
  static DateTime getWeekEnd() {
    return getWeekStart().add(Duration(days: 6));
  }

  ///returns the DateTime for the start of the month.
  static DateTime getMonthStart() {
    DateTime _currentDate = DateTime.now();
    return DateTime(_currentDate.year, _currentDate.month, 1);
  }

  ///returns the DateTime for the end of the month.
  static DateTime getMonthEnd() {
    DateTime _currentDate = DateTime.now();
    return DateTime(_currentDate.year, _currentDate.month + 1, 1).subtract(Duration(days: 1));
  }

  ///returns the DateTime for the start of the quarter.
  static DateTime getQuarterStart() {
    DateTime _currentDate = DateTime.now();
    //this formula gets the quarter from the current month.
    int _quarter = ((_currentDate.month - 1) / 3 + 1).floor();
    //take the quarter, remove 1 (to get the previous quarter), multiply by 3 to get the last month of that quarter,
    //add 1 to get the first month of this quarter.
    return DateTime(_currentDate.year, (_quarter - 1) * 3 + 1, 1);
  }

  ///returns the DateTime for the end of the quarter.
  static DateTime getQuarterEnd() {
    DateTime _currentDate = DateTime.now();
    //this formula gets the quarter from the current month.
    int _quarter = ((_currentDate.month - 1) / 3 + 1).floor();
    //take the last month of the quarter, add 1 month to it, subtract 1 day to get the last day of the last month.
    return DateTime(_currentDate.year, (_quarter * 3) + 1, 1).subtract(Duration(days: 1));
  }

  ///returns the DateTime for the start of the year.
  static DateTime getYearStart() {
    DateTime _currentDate = DateTime.now();
    return DateTime(_currentDate.year, 1, 1);
  }

  ///returns the DateTime for the end of the year.
  static DateTime getYearEnd() {
    DateTime _currentDate = DateTime.now();
    return DateTime(_currentDate.year, 12, 31);
  }
}
