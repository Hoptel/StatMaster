import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'MiniWidget.dart';
import 'package:flutter/material.dart';
import '../../Utilities/Utilities.dart';
import 'SuperSlider.dart';

enum ChartCardWidth { fullWidth, halfWidth }

///The vertical card's aspect ratio (height/width)
const double aspectRatio = 1.075;

///The horizontal card's aspect ratio (height/width)
const double aspectRatioFull = 0.512;

///The design width of the vertical card (used as a reference for scale factor)
const double defaultWidthHalf = 160.0;

///The design width of the horizontal card (used as a reference for scale factor)
const double defaultWidthFull = 336.0;

class ChartCard extends StatelessWidget {
  ChartCard(
    this.mainWidget, {
    this.cardWidth = ChartCardWidth.halfWidth,
    this.miniWidgets,
    this.icon = FontAwesomeIcons.chartBar,
    this.title = "Title",
    this.bottomSafeSpace = 4.0,
    this.key,
    this.animationInterval = const Duration(seconds: 5),
  });

  ///Width of the card (vertical or horizontal card).
  final ChartCardWidth cardWidth;

  ///The small info containers at the bottom.
  final List<MiniWidget> miniWidgets;

  ///The icon to be displayed both at the top left of the card and in the AppDrawer
  final IconData icon;

  ///The title of the card.
  final String title;

  ///The main Chart to display.
  final Widget mainWidget;

  ///The margin to add to the bottom (so that the main widget or mini widgets don't interfere with the card's rounding).
  final double bottomSafeSpace;

  ///The key for the chart card (needed to identify it)
  final Key key;

  ///How much time between automatic animations (null = no animation)
  final Duration animationInterval;

  @override
  Widget build(BuildContext context) {
    bool _hasMiniWidgets = !(miniWidgets == null || miniWidgets == []);
    double _cardWidth = getCardWidth(cardWidth, Utils.screenWidth(context));
    double _resizeFactor = _cardWidth / (cardWidth == ChartCardWidth.halfWidth ? defaultWidthHalf : defaultWidthFull);
    return Container(
      width: _cardWidth,
      height: _cardWidth * (cardWidth == ChartCardWidth.halfWidth ? aspectRatio : aspectRatioFull),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: Padding(
          padding: EdgeInsets.only(bottom: bottomSafeSpace * _resizeFactor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(6.0 * _resizeFactor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          icon,
                          size: 14 * _resizeFactor,
                        ),
                        Container(
                          width: 8.0 * _resizeFactor,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            title,
                            style: TextStyle(
                              fontFamily: "Lato",
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                            textScaleFactor: _resizeFactor,
                          ),
                        ),
                      ],
                    ),
                    /*Icon(
                      FontAwesomeProIcons.slidersH,
                      size: 14 * _resizeFactor,
                    ),*/
                  ],
                ),
              ),
              Expanded(
                flex: 47,
                child: mainWidget,
              ),
              Visibility(
                visible: _hasMiniWidgets,
                child: Expanded(
                    flex: 53,
                    child: SuperSlider(
                      paginationSize: 2 * _resizeFactor,
                      paginationHeightCompact: 2 * _resizeFactor,
                      height: 68 * _resizeFactor,
                      paginationTopOnly: true,
                      autoPlay: animationInterval != null,
                      autoPlayInterval: animationInterval ?? Duration(seconds: 5),
                      autoPlayAnimationDuration: const Duration(milliseconds: 300),
                      circlePagination: false,
                      expand: true,
                      compact: true,
                      selectedColor: const Color(0xff707070),
                      unselectedColor: const Color(0xffDBDBDB),
                      items: getRowList(miniWidgets ?? []),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///Returns what the width of the card should be based on the screen width and the card type.
  double getCardWidth(ChartCardWidth widthType, double screenWidth) {
    if (widthType == ChartCardWidth.fullWidth) {
      return (screenWidth - 24);
    } else {
      return ((screenWidth / 2) - 20);
    }
  }

  ///Return the rows of miniWidgets
  static List<Row> getRowList(List<Widget> widgetList, {int itemsPerRow = 2}) {
    List<Row> listofRows = new List<Row>();
    int modulo = widgetList.length % itemsPerRow;
    if (modulo == 0) {
      listofRows.addAll(getNRowList(widgetList, widgetList.length, itemsPerRow));
    } else {
      listofRows.addAll(getNRowList(widgetList, widgetList.length - modulo, itemsPerRow));
      listofRows.add(new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widgetList.getRange(widgetList.length - modulo, widgetList.length).toList()));
    }
    return listofRows;
  }

  ///
  ///gets rows for a multiple of [n] number of items, THIS METHOD IS ONLY MEANT TO BE CALLED BY [getRowList], USE THAT INSTEAD
  ///
  static List<Row> getNRowList(List<Widget> widgetList, int length, int n) {
    List<Row> listofNRows = new List<Row>();
    for (int i = 0; i < length; i += n) {
      Row rowToAdd = new Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: widgetList.getRange(i, i + n).toList(),
      );
      listofNRows.add(rowToAdd);
    }
    return listofNRows;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChartCard &&
          runtimeType == other.runtimeType &&
          cardWidth == other.cardWidth &&
          miniWidgets == other.miniWidgets &&
          title == other.title &&
          mainWidget == other.mainWidget &&
          bottomSafeSpace == other.bottomSafeSpace;

  @override
  int get hashCode =>
      cardWidth.hashCode ^ miniWidgets.hashCode ^ title.hashCode ^ mainWidget.hashCode ^ bottomSafeSpace.hashCode;
}
