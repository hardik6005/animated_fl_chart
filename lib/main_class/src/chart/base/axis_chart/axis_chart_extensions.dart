import 'package:animated_fl_chart/animated_fl_chart.dart';

extension FlSpotListExtension on List<AFlSpot> {
  /// Splits a line by [AFlSpot.nullSpot] values inside it.
  List<List<AFlSpot>> splitByNullSpots() {
    final barList = <List<AFlSpot>>[[]];

    // handle nullability by splitting off the list into multiple
    // separate lists when separated by nulls
    for (final spot in this) {
      if (spot.isNotNull()) {
        barList.last.add(spot);
      } else if (barList.last.isNotEmpty) {
        barList.add([]);
      }
    }
    // remove last item if one or more last spots were null
    if (barList.last.isEmpty) {
      barList.removeLast();
    }
    return barList;
  }
}
