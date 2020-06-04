import 'dart:math';

/// Gauge chart , where the data does not cover a full revolution in the chart.
///
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import '../../Utilities/Utilities.dart';
import 'package:intl/intl.dart';

class GaugeChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final int width;
  static const double _dScreenWidth = 400;

  final Duration animationDuration;

  final double strokeWidth;

  /// 1 is a full circle, 0.5 is a half circle
  final double arcAmount;

  GaugeChart(
    this.seriesList, {
    this.animate = true,
    this.width = 10,
    this.arcAmount = 0.5,
    this.animationDuration = const Duration(seconds: 1),
    this.strokeWidth = 2.0,
  });

  factory GaugeChart.withValue(int valueFull, int valueEmpty,
      {Color fullColor = Colors.blue, Color emptyColor = Colors.grey, bool animate = true, int width = 12
      /*bool animateOnce = true*/
      }) {
    List<GaugeSegment> segs = [
      GaugeSegment(
          "full", valueFull, charts.Color(r: fullColor.red, g: fullColor.green, b: fullColor.blue, a: fullColor.alpha)),
      GaugeSegment("empty", valueEmpty,
          charts.Color(r: emptyColor.red, g: emptyColor.green, b: emptyColor.blue, a: emptyColor.alpha))
    ];
    return new GaugeChart(
      _createData(segs),
      animate: animate,
      width: width,
      arcAmount: 0.67,
    );
  }

  factory GaugeChart.withValueSplit(
    int valueFull,
    int valueEmpty, {
    Color fullColor = Colors.blue,
    Color emptyColor = Colors.grey,
    bool animate = true,
    int segments = 2,
    double colorBrighteningPercentage = 0.1,
    int width = 10,
  }) {
    assert(segments >= 2);
    List<GaugeSegment> segs = [];
    //how much value each segment contains
    int segmentAmount = (valueFull + valueEmpty) ~/ segments;
    //which segment is going to be the last full one
    int lastFullSegment = valueFull != 0 ? (valueFull / segmentAmount).ceil() : 1;
    //how much to fill the last segment
    int lastSegmentFill = valueFull - (segmentAmount * (lastFullSegment - 1));
    for (int i = 1; i <= lastFullSegment; i++) {
      Color newcol = Color.fromARGB(
          fullColor.alpha,
          (fullColor.red + ((255 - fullColor.red) * colorBrighteningPercentage * (lastFullSegment - i)).round()),
          (fullColor.green + ((255 - fullColor.green) * colorBrighteningPercentage * (lastFullSegment - i)).round()),
          (fullColor.blue + ((255 - fullColor.blue) * colorBrighteningPercentage * (lastFullSegment - i)).round()));
      segs.add(GaugeSegment("full$i", i != lastFullSegment ? segmentAmount : lastSegmentFill,
          charts.Color(r: newcol.red, g: newcol.green, b: newcol.blue, a: newcol.alpha)));
    }
    segs.add(GaugeSegment("empty", valueEmpty,
        charts.Color(r: emptyColor.red, g: emptyColor.green, b: emptyColor.blue, a: emptyColor.alpha)));
    return new GaugeChart(
      _createData(segs),
      animate: animate,
      arcAmount: 0.67,
    );
  }

  @override
  Widget build(BuildContext context) {
    double _resizeFactor = Utils.screenWidth(context) / GaugeChart._dScreenWidth;
    return new charts.PieChart(seriesList,
        animate: animate,
        animationDuration: animationDuration,
        layoutConfig: charts.LayoutConfig(
          leftMarginSpec: charts.MarginSpec.fromPercent(minPercent: 0, maxPercent: 0),
          rightMarginSpec: charts.MarginSpec.fromPercent(minPercent: 0, maxPercent: 0),
          topMarginSpec: charts.MarginSpec.fromPercent(minPercent: 0, maxPercent: 0),
          bottomMarginSpec: charts.MarginSpec.fromPercent(minPercent: 0, maxPercent: 0),
        ),
        defaultRenderer: new charts.ArcRendererConfig(
            strokeWidthPx: _resizeFactor * strokeWidth,
            arcWidth: (_resizeFactor * width).floor(),
            startAngle: 1.5 * pi - (arcAmount * pi), //start at the 90 degree point when [arcAmount] is 0 and 270 when 1
            arcLength: arcAmount * 2 * pi)); //the length is [arcAmount] * a circle
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<GaugeSegment, String>> _createData(List<GaugeSegment> data) {
    return [
      new charts.Series<GaugeSegment, String>(
        id: 'Segments',
        domainFn: (GaugeSegment segment, _) => segment.segment,
        measureFn: (GaugeSegment segment, _) => segment.size,
        colorFn: (GaugeSegment segment, _) => segment.color,
        data: data,
      )
    ];
  }
}

/// Sample data type.
class GaugeSegment {
  final String segment;
  final int size;
  final charts.Color color;

  GaugeSegment(this.segment, this.size, this.color);
}

Widget GaugeChartWithNumber(
    double valueFull, double valueEmpty, Color fullColor, Color emptyColor, BuildContext context,
    {int width = 5, double textSize = 17}) {
  double _resizeFactor = Utils.screenWidth(context) / GaugeChart._dScreenWidth;
  return Container(
    child: Stack(
      children: <Widget>[
        GaugeChart.withValue(valueFull.floor(), valueEmpty.floor(),
            fullColor: fullColor, emptyColor: emptyColor, width: width),
        Center(
            child: Text(
          "${NumberFormat("##.#").format(valueFull / (valueFull + valueEmpty) * 100)}%",
          textScaleFactor: _resizeFactor,
          style: TextStyle(
            fontSize: textSize,
            fontFamily: "MontSerrat",
          ),
        )),
      ],
    ),
  );
}

Widget GaugeChartWithNumberSplit(double valueFull, double valueEmpty, double valueLastYear, double valueThisYear,
    double cap, Color fullColor, Color emptyColor,
    {double width = 400.0, double height = 400.0}) {
  return SizedBox(
    width: width,
    height: height,
    child: Stack(
      children: <Widget>[
        GaugeChart.withValueSplit(
          valueFull.round(),
          valueEmpty.round(),
          fullColor: fullColor,
          emptyColor: emptyColor,
          segments: 5,
          colorBrighteningPercentage: 0.13,
        ),
        Align(
            alignment: Alignment(0, -0.04),
            child: Row(
              textBaseline: TextBaseline.alphabetic,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: <Widget>[
                Text(
                  "${valueFull != 0 ? NumberFormat('#,###.##').format((valueFull / (cap) * 100)) : 0}",
                  style: TextStyle(fontSize: 42.0, fontFamily: "MontSerrat"),
                ),
                Text(
                  "%",
                  style: TextStyle(fontSize: 18.0, fontFamily: "MontSerrat"),
                ),
              ],
            )),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Last Year",
                    style: TextStyle(color: Color(0xff6f6f6f), fontSize: 9.0),
                  ),
                  Container(
                    width: 97,
                    height: 72,
                    child: Card(
                      margin: EdgeInsets.all(0.0),
                      color: Color(0xffA0A0A0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                      child: Center(
                        child: Row(
                          textBaseline: TextBaseline.alphabetic,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: <Widget>[
                            Text(
                              "${NumberFormat('#,###.##').format((valueLastYear / (cap) * 100))}",
                              style: TextStyle(fontSize: 32.0, fontFamily: "MontSerrat", color: Colors.white),
                            ),
                            Text(
                              "%",
                              style: TextStyle(fontSize: 16.0, fontFamily: "MontSerrat", color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "This Year",
                    style: TextStyle(color: Color(0xff6f6f6f), fontSize: 9.0),
                  ),
                  Container(
                    width: 97,
                    height: 72,
                    child: Card(
                      margin: EdgeInsets.all(0.0),
                      color: Color(0xfff5f5f5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                      child: Center(
                        child: Row(
                          textBaseline: TextBaseline.alphabetic,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: <Widget>[
                            Text(
                              "${NumberFormat('#,###.##').format((valueThisYear / (cap) * 100))}",
                              style: TextStyle(fontSize: 28.0, fontFamily: "MontSerrat"),
                            ),
                            Text(
                              "%",
                              style: TextStyle(fontSize: 12.0, fontFamily: "MontSerrat"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Target",
                    style: TextStyle(color: Color(0xff6f6f6f), fontSize: 9.0),
                  ),
                  Container(
                    width: 97,
                    height: 72,
                    child: Card(
                      margin: EdgeInsets.all(0.0),
                      color: Color(0xff6f6f6f),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                      child: Center(
                        child: Row(
                          textBaseline: TextBaseline.alphabetic,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: <Widget>[
                            Text(
                              "${NumberFormat('#,###.##').format(75)}",
                              style: TextStyle(fontSize: 28.0, fontFamily: "MontSerrat", color: Colors.white),
                            ),
                            Text(
                              "%",
                              style: TextStyle(fontSize: 12.0, fontFamily: "MontSerrat", color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    ),
  );
}
