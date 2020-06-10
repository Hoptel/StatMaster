import 'package:StatMaster/Controllers/EmployeeController.dart';
import 'package:StatMaster/Controllers/MainController.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Controllers/ReservatController.dart';
import '../../Controllers/StatsController.dart';
import '../Widgets/ChartCard.dart';
import '../Widgets/DateFilterCard.dart';
import '../Widgets/Drawer.dart';
import '../Widgets/GaugeChart.dart';
import '../Widgets/LoadingOverlay.dart';
import '../Widgets/MiniWidget.dart';
import '../Widgets/PercentofDomainChart.dart';
import '../Widgets/SimpleFinanceDisplay.dart';
import 'package:flutter/material.dart';
import '../../Utilities/Utilities.dart';
import '../../Utilities/Models/ForecastDay.dart';
import 'package:scoped_model/scoped_model.dart';

// ignore: must_be_immutable
class WidgetsScreen extends StatelessWidget {
  /// This map defines where each chart card is on screen.
  ///
  /// The screen is split into infinite rows (1, 2, 3, 4, etc..) and 2 columns (A, B).
  ///
  /// A full width Card will only have a number, while a half width card will have a number and a letter.
  Map<String, ChartCard> positions = {};

  @override
  Widget build(BuildContext context) {
    MainController.getInstance().setEmployeeController(EmployeeController());
    MainController.getInstance().setReservatController(ReservatController());
    MainController.getInstance().setStatsController(StatsController());
    ReservatController reservatController = MainController.getInstance().reservatController;
    StatsController statsController = MainController.getInstance().statsController;
    //data for forecast, occupancy, and employee
    MainController.getInstance().getAppData();
    double _screenHeight = Utils.screenRealEstate(context, includeBottomPadding: false);

    return Scaffold(
      //the toolbar on the top of the screen
      appBar: AppBar(
        title: Text("Statmaster"),
        leading: Builder(builder: (BuildContext context) {
          //the drawer icon
          return IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        }),
      ),

      drawer: AppDrawer(),
      body: ScopedModel<MainController>(
        model: MainController.getInstance(),
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            DateFilterCard(),
            ScopedModel<StatsController>(
              model: statsController,
              child: ScopedModel<ReservatController>(
                  model: reservatController,
                  child: ScopedModelDescendant<MainController>(builder: (context, child, model) {
                    return Container(
                      height: _screenHeight - (Utils.screenWidth(context) / DateFilterCard.pWidth * 90),
                      child: model.isLoading == true
                          ? LoadingOverlay()
                          : createChartCardListView(<ChartCard>[
                              //todo split these into different readable methods
                              ChartCard(
                                ScopedModelDescendant<ReservatController>(builder: (context, child, model) {
                                  return model.forecastDayListOnlyLoaded
                                      ? PercentOfDomainBarChart.withData(createFDataList(model.forecastDayListOnly,
                                          items: model.forecastDayListOnly.length))
                                      : Container();
                                }),
                                cardWidth: ChartCardWidth.fullWidth,
                                title: "Forecast",
                              ),
                              ChartCard(
                                ScopedModelDescendant<ReservatController>(builder: (context, child, model) {
                                  return model.occData != null
                                      ? GaugeChartWithNumber(model.occData.occrate, 100.0 - model.occData.occrate,
                                          Colors.green[800], Color(0x10ffffff), context)
                                      : Container();
                                }),
                                cardWidth: ChartCardWidth.halfWidth,
                                icon: FontAwesomeIcons.tachometerAlt,
                                title: "Occupancy",
                                miniWidgets: <MiniWidget>[
                                  MiniWidget(
                                      title: "Day Use",
                                      data: ScopedModelDescendant<ReservatController>(builder: (context, child, model) {
                                        return model.occData != null
                                            ? miniWidgetDataNumber(model.occData.huroom?.toDouble())
                                            : Container();
                                      })),
                                  MiniWidget(
                                      title: "Arrivals",
                                      data: ScopedModelDescendant<ReservatController>(builder: (context, child, model) {
                                        return model.occData != null
                                            ? miniWidgetDataNumber(model.occData.ciroom?.toDouble())
                                            : Container();
                                      })),
                                  MiniWidget(
                                      title: "Departures",
                                      data: ScopedModelDescendant<ReservatController>(builder: (context, child, model) {
                                        return model.occData != null
                                            ? miniWidgetDataNumber(model.occData.coroom?.toDouble())
                                            : Container();
                                      })),
                                ],
                              ),
                              ChartCard(
                                ScopedModelDescendant<StatsController>(builder: (context, child, model) {
                                  return model.revDataLoaded
                                      ? SimpleFinanceDisplay(
                                          value: model.revData.revenue,
                                          valueCaption: "Revenue Total",
                                          useComparison: false,
                                        )
                                      : Container();
                                }),
                                title: "Revenue",
                                icon: FontAwesomeIcons.moneyBillWave,
                                miniWidgets: <MiniWidget>[
                                  MiniWidget(
                                      title: "Room Revenue",
                                      data: ScopedModelDescendant<StatsController>(builder: (context, child, model) {
                                        return model.revDataLoaded
                                            ? miniWidgetDataNumber(model.revData.roomrev)
                                            : Container();
                                      })),
                                  MiniWidget(
                                      title: "RevPAR",
                                      data: ScopedModelDescendant<StatsController>(builder: (context, child, model) {
                                        return model.revDataLoaded
                                            ? miniWidgetDataNumber(model.revData.revpar)
                                            : Container();
                                      })),
                                  MiniWidget(
                                      title: "RevADR",
                                      data: ScopedModelDescendant<StatsController>(builder: (context, child, model) {
                                        return model.revDataLoaded
                                            ? miniWidgetDataNumber(model.revData.revadr)
                                            : Container();
                                      })),
                                ],
                              ),
                              ChartCard(ScopedModelDescendant<StatsController>(builder: (context, child, model) {
                                return model.salesDataLoaded
                                    ? SimpleFinanceDisplay(
                                        value: model.salesData.salesrev,
                                        valueCaption: "TotalSales",
                                        useComparison: false,
                                      )
                                    : Container();
                              }),
                                  title: "Sales",
                                  icon: FontAwesomeIcons.receipt,
                                  miniWidgets: <MiniWidget>[
                                    MiniWidget(
                                        title: "Room",
                                        data: ScopedModelDescendant<StatsController>(builder: (context, child, model) {
                                          return model.salesDataLoaded
                                              ? miniWidgetDataNumber(model.salesData.salesroom?.toDouble())
                                              : Container();
                                        })),
                                    MiniWidget(
                                        title: "Room Night",
                                        data: ScopedModelDescendant<StatsController>(builder: (context, child, model) {
                                          return model.salesDataLoaded
                                              ? miniWidgetDataNumber(model.salesData.salesrn?.toDouble())
                                              : Container();
                                        })),
                                    MiniWidget(
                                        title: "Sale Pax",
                                        data: ScopedModelDescendant<StatsController>(builder: (context, child, model) {
                                          return model.salesDataLoaded
                                              ? miniWidgetDataNumber(model.salesData.salespax?.toDouble())
                                              : Container();
                                        })),
                                  ]),
                            ]),
                    );
                  })),
            ),
          ],
        ),
      ),
    );
  }

  Widget createChartCardListView(List<ChartCard> chartCards) {
    ChartCard temp;
    List<Widget> widgetList = [];
    //go through all the chartCards
    for (ChartCard item in chartCards) {
      bool isfound = false;
      //for each chartCard, go through the list of already defined positions
      for (ChartCard itemToCompare in positions.values) {
        //if a card with the same title is found, break the search and move on to the next card
        if (itemToCompare.title == item.title) {
          isfound = true;
          break;
        }
      }
      //if the cycle is over and none is found, then find an empty postion for it
      if (!isfound) {
        findEmptyPosition(item);
      }
    }
    //go through all positions
    for (int i = 0; i < positions.length; i++) {
      //if a card is full
      if (positions.containsKey("$i")) {
        //just add it to the list
        widgetList.add(Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[positions["$i"]]));
      }
      //otherwise, if it is in A position
      else if (positions.containsKey("${i}A")) {
        //find B position if it exists
        if (positions.containsKey("${i}B")) {
          //and put both in a row
          widgetList.add(Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[positions["${i}A"], positions["${i}B"]],
          ));
        }
        //if there is no B position
        else {
          //put the A position card alone in temp variable
          temp = positions["${i}A"];
        }
      }
    }
    //add the temp stored card in a row of its own at the very end
    if (temp != null) {
      widgetList.add(Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[temp],
        ),
      ));
    }
    return ListView(
      children: widgetList,
    );
  }

  /// Finds if a hole has been made and returns its value.
  ///
  /// A hole is made if the last half width card is placed in a row of its own (side A) followed by a full width card.
  String findHole() {
    for (int i = 0; i < positions.length; i++) {
      if (positions.containsKey("$i")) {
        continue;
      } else if (positions.containsKey("${i}A") &&
          !positions.containsKey("${i}B") &&
          positions.containsKey("${i + 1}")) {
        return "${i}B";
      }
    }
    return null;
  }

  /// Finds the very last Full Width ChartCard and returns its position string.
  String findLastFullWidth({int startingPosition = 0}) {
    List<int> fullPositions = [];
    for (int i = startingPosition; i < positions.length; i++) {
      if (positions.containsKey("$i")) {
        fullPositions.add(i);
      }
    }
    fullPositions.sort();
    return fullPositions.last.toString();
  }

  /// Finds an unoccupied position and assigns the card to it.
  void findEmptyPosition(ChartCard card) {
    int i = 0;
    if (card.cardWidth == ChartCardWidth.halfWidth) {
      while (true) {
        if (!positions.containsKey("$i")) {
          if (!positions.containsKey("${i}B")) {
            if (!positions.containsKey("${i}A")) {
              positions["${i}A"] = card;
              break;
            }
            positions["${i}B"] = card;
            break;
          }
        }

        i++;
      }
    } else {
      while (true) {
        if (!positions.containsKey("$i")) {
          if (!positions.containsKey("${i}B")) {
            if (!positions.containsKey("${i}A")) {
              positions["$i"] = card;
              break;
            } else {
              i++;
              continue;
            }
          }
        }
        i++;
      }
    }
  }
}

List<FData> createFDataList(List<ForecastDay> forecasts, {int items = 7, int todayItem = 0}) {
  items = items.abs();
  todayItem = todayItem.abs();
  List<FData> dataList = [];

  for (int i = todayItem; i < todayItem + items; i++) {
    FData item = FData(forecasts[i].totalroom, forecasts[i].totalemptyroom,
        DateTime(forecasts[i].ayear, forecasts[i].amonth, forecasts[i].aday));
    dataList.add(item);
  }
  return dataList;
}
