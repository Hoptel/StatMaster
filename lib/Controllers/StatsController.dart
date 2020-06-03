import '../Utilities/Models/stats/gen/Rev.dart';
import '../Utilities/Models/stats/gen/Sales.dart';
import 'package:hotech_flutter_utilities/service/stats/StatsService.dart';
import 'package:scoped_model/scoped_model.dart';

///Controls the stats gen rev and sales data (it gets the data from HF-Utilities library and puts it in variables)

class StatsController extends Model {
  Rev revData;
  Sales salesData;
  bool revDataLoaded = false;
  bool revDataLoading = false;
  bool salesDataLoaded = false;
  bool salesDataLoading = false;

  Future getRevData(DateTime startDate, DateTime endDate) async {
    if (!revDataLoaded && !revDataLoading) {
      revDataLoading = true;
      notifyListeners();
      revData = await StatsService.getInstance().getGenRev(startDate, endDate);
      if (revData != null) {
        revDataLoaded = true;
      }
      revDataLoading = false;
      notifyListeners();
    }
  }

  Future getSalesData(DateTime startDate, DateTime endDate) async {
    if (!salesDataLoaded && !salesDataLoading) {
      salesDataLoading = true;
      notifyListeners();
      salesData = await StatsService.getInstance().getGenSales(startDate, endDate);
      if (salesData != null) {
        salesDataLoaded = true;
      }
      salesDataLoading = false;
      notifyListeners();
    }
  }
}
