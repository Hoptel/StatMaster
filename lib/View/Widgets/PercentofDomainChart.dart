import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PercentOfDomainBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final bool muchData;

  PercentOfDomainBarChart(this.seriesList, {this.animate = true, this.muchData = false});

  factory PercentOfDomainBarChart.withData(List<FData> data) {
    return new PercentOfDomainBarChart(
      _createData(data),
      animate: true,
      muchData: (data.length > 10),
    );
  }

  factory PercentOfDomainBarChart.fromSampleData() {
    return new PercentOfDomainBarChart(
      _createData(<FData>[
        FData(74, 26, DateTime.parse("2019-09-16")),
        FData(21, 79, DateTime.parse("2019-09-17")),
        FData(51, 49, DateTime.parse("2019-09-18")),
        FData(22, 79, DateTime.parse("2019-09-19")),
        FData(53, 49, DateTime.parse("2019-09-20")),
        FData(99, 01, DateTime.parse("2019-09-21")),
        FData(0, 100, DateTime.parse("2019-09-22")),
        FData(22, 78, DateTime.parse("2019-09-23")),
        FData(23, 77, DateTime.parse("2019-09-24")),
        FData(24, 76, DateTime.parse("2019-09-25")),
        FData(25, 75, DateTime.parse("2019-09-26")),
        FData(26, 74, DateTime.parse("2019-09-27")),
        FData(27, 73, DateTime.parse("2019-09-28")),
        FData(22, 78, DateTime.parse("2019-09-29")),
        FData(23, 77, DateTime.parse("2019-09-30")),
        FData(24, 76, DateTime.parse("2019-10-01")),
        FData(25, 75, DateTime.parse("2019-10-02")),
        FData(26, 74, DateTime.parse("2019-10-03")),
        FData(27, 73, DateTime.parse("2019-10-04")),
        FData(22, 78, DateTime.parse("2019-10-05")),
        FData(23, 77, DateTime.parse("2019-10-06")),
        FData(24, 76, DateTime.parse("2019-10-07")),
        FData(25, 75, DateTime.parse("2019-10-08")),
        FData(26, 74, DateTime.parse("2019-10-09")),
        FData(27, 73, DateTime.parse("2019-10-10")),
        FData(23, 77, DateTime.parse("2019-10-11")),
        FData(24, 76, DateTime.parse("2019-10-12")),
        FData(25, 75, DateTime.parse("2019-10-13")),
        FData(26, 74, DateTime.parse("2019-10-14")),
        FData(80, 20, DateTime.parse("2019-10-15")),
      ]),
      muchData: true, //this is true if there are more than 10 items in the chart
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.stacked,
      // Configures a [PercentInjector] behavior that will calculate measure
      // values as the percentage of the total of all data that shares a
      // domain value.
      behaviors: [new charts.PercentInjector(totalType: charts.PercentInjectorTotalType.domain)],
      // Configure the axis spec to show percentage values.
      primaryMeasureAxis:
          muchData ? new charts.PercentAxisSpec() : new charts.PercentAxisSpec(renderSpec: charts.NoneRenderSpec()),
      domainAxis: muchData
          ? new charts.OrdinalAxisSpec(
              // Make sure that we draw the domain axis line.
              showAxisLine: true,
              // But don't draw anything else.
              renderSpec: new charts.NoneRenderSpec())
          : null,
      barRendererDecorator: new charts.BarLabelDecorator<String>(),
    );
  }

  static List<charts.Series<PODD, String>> _createData(List<FData> data,
      {Color emptyColor = const Color(0x10ffffff), Color fullColor = Colors.green}) {
    List<PODD> fullData = [];
    List<PODD> emptyData = [];
    bool manyItems = data.length > 10;
    for (FData item in data) {
      fullData.add(PODD(DateFormat("dd/MM").format(item.date), item.full,
          ((item.empty > 0 ? item.full / item.empty : item.full / 1) * 100).toInt(),
          color: getColor(fullColor)));
      emptyData.add(PODD(DateFormat("dd/MM").format(item.date), item.empty,
          ((item.empty > 0 ? item.full / item.empty : item.full / 1) * 100).toInt(),
          color: getColor(emptyColor)));
    }

    return [
      new charts.Series<PODD, String>(
        id: 'empty',
        domainFn: (PODD item, _) => item.name,
        measureFn: (PODD item, _) => item.value,
        colorFn: (PODD item, _) => item.color,
        data: emptyData,
        labelAccessorFn: (PODD item, _) => "",
      ),
      new charts.Series<PODD, String>(
        id: 'full',
        domainFn: (PODD item, _) => item.name,
        measureFn: (PODD item, _) => item.value,
        colorFn: (PODD item, _) => item.color,
        data: fullData,
        labelAccessorFn: (PODD item, _) => manyItems ? "" : "${item.percentage}%",
      ),
    ];
  }
}

//percent of domain data
class PODD {
  final String name;
  final int value;
  final charts.Color color;
  final int percentage;

  PODD(this.name, this.value, this.percentage, {this.color});
}

//forecast data
class FData {
  final int full;
  final int empty;
  final DateTime date;

  FData(this.full, this.empty, this.date);
}

charts.Color getColor(Color matColor) {
  return charts.Color(r: matColor.red, g: matColor.green, b: matColor.blue, a: matColor.alpha);
}
