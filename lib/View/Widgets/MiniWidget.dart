import 'package:StatMaster/Utilities/Utilities.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Line.dart';

class MiniWidget extends StatelessWidget {
  MiniWidget({this.title = "", this.data});

  final String title;
  final Widget data;

  @override
  Widget build(BuildContext context) {
    double _resizeFactor = Utils.screenWidth(context) / 360;
    return Padding(
      padding: EdgeInsets.only(left: 6.0 * _resizeFactor, right: 6.0 * _resizeFactor),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 3.0 * _resizeFactor),
            child: Text(
              title,
              style: TextStyle(color: Color(0xff6f6f6f), fontSize: 9.0),
              textScaleFactor: _resizeFactor,
            ),
          ),
          Container(
            width: 62 * _resizeFactor,
            height: 36 * _resizeFactor,
            child: Card(
              margin: EdgeInsets.all(0.0),
              elevation: 0.0,
              color: Color(0xfff5f5f5),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              child: Center(child: data),
            ),
          ),
        ],
      ),
    );
  }
}

Widget miniWidgetDataNumber(double number) {
  number = number ?? 0;
  return Text(
    NumberFormat.decimalPattern().format(number),
    style: TextStyle(fontSize: 12.0, fontFamily: "MontSerrat", fontWeight: FontWeight.bold),
  );
}

Widget miniWidgetDataPercent(double value) {
  value = value ?? 0;
  return Row(
    textBaseline: TextBaseline.alphabetic,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.baseline,
    children: <Widget>[
      Text(
        "${NumberFormat('#,###.##').format(value)}",
        style: TextStyle(fontSize: 18.0, fontFamily: "MontSerrat"),
      ),
      Text(
        "%",
        style: TextStyle(fontSize: 9.0, fontFamily: "MontSerrat"),
      ),
    ],
  );
}

Widget miniWidgetDataOutOf(double value1, double value2) {
  value1 = value1 ?? 0;
  value2 = value2 ?? 0;
  return Stack(
    children: <Widget>[
      Align(
          alignment: Alignment(-0.5, -0.3),
          child: Text(
            NumberFormat('#,###.##').format(value1),
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, fontFamily: "MontSerrat"),
          )),
      Align(
          alignment: Alignment(0.5, 0.3),
          child: Text(
            NumberFormat('#,###.##').format(value2),
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, fontFamily: "MontSerrat"),
          )),
      Align(
        alignment: Alignment(0.05, 0.3),
        child: Line(
          rotation: 56.0,
          length: 10,
        ),
      ),
    ],
  );
}
