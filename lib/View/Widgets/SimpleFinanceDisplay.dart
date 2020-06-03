import 'package:StatMaster/Utilities/Utilities.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class SimpleFinanceDisplay extends StatelessWidget {
  ///The main number to display
  final double value;

  ///The caption above the [value]
  final String valueCaption;

  ///The caption that appears next to [comparisonValue]
  final String comparisonCaption;

  ///whether to display the comparison or not
  final bool useComparison;

  ///The percentage or value to show in the comparison section
  final double comparisonValue;

  ///Whether to use a percentage or an actual number in the comparison section
  final bool comparePercentage;

  ///which icon to use for the currency below [comparisonCaption]
  final IconData currencyIcon;

  ///Swap colors so that a negative comparison is green
  final bool greenNegative;

  SimpleFinanceDisplay({
    this.value = 0.0,
    this.valueCaption = "Total",
    this.comparisonCaption = "Yesterday",
    this.useComparison = true,
    this.comparisonValue = 0.0,
    this.comparePercentage = true,
    this.currencyIcon = FontAwesomeIcons.dollarSign,
    this.greenNegative = false,
  });
  @override
  Widget build(BuildContext context) {
    double _resizeFactor = Utils.screenWidth(context) / 360.0; //360 is the width of the screen in design
    return Stack(
      children: <Widget>[
        useComparison
            ? getComparisonValueWidget(comparisonCaption, comparisonValue, _resizeFactor, greenNegative)
            : Container(),
        getMainValueWidget(valueCaption, currencyIcon, value, _resizeFactor),
      ],
    );
  }
}

Widget getComparisonValueWidget(String caption, double value, double scaleFactor, bool greenNegative) {
  Color color = value == 0
      ? Color(0xFFE7C504)
      : greenNegative
          ? value < 0 ? Color(0xff154A0D) : Color(0xFF752222)
          : value > 0 ? Color(0xff154A0D) : Color(0xFF752222);
  IconData icon = value == 0
      ? FontAwesomeIcons.caretRight
      : value > 0 ? FontAwesomeIcons.caretUp : FontAwesomeIcons.caretDown;
  return Align(
    alignment: Alignment(0.8, -1),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          caption,
          style: TextStyle(fontSize: 9),
          textScaleFactor: scaleFactor,
        ),
        Icon(
          icon,
          color: color,
          size: 9 * scaleFactor,
        ),
        Text(
          "${value.abs()}%",
          textScaleFactor: scaleFactor,
          style: TextStyle(fontSize: 9, color: color, fontWeight: FontWeight.bold, fontFamily: "MontSerrat"),
        )
      ],
    ),
  );
}

Widget getMainValueWidget(String caption, IconData icon, double value, double scaleFactor) {
  return Align(
    alignment: Alignment(-0.6, 0.3),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              caption,
              style: TextStyle(
                fontSize: 9,
                color: Color(0xff9a9a9a),
              ),
              textScaleFactor: scaleFactor,
            ),
            Padding(
              padding: EdgeInsets.only(top: 6.0 * scaleFactor),
              child: Icon(
                icon,
                size: 14.0 * scaleFactor,
                color: Color(0xff9a9a9a),
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
              top: (6.0 + 9.0 + 5.0) * scaleFactor), //6 is column padding, 9 is textsize, and 5 is magic number
          child: Text(
            NumberFormat.decimalPattern().format(value),
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, fontFamily: "MontSerrat"),
            textScaleFactor: scaleFactor,
          ),
        ),
      ],
    ),
  );
}
