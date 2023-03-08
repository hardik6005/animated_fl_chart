import 'package:animated_fl_chart/animated_fl_chart.dart';

extension SideTitlesExtension on AxisTitles {
  double get totalReservedSize {
    var size = 0.0;
    if (showAxisTitles) {
      size += axisNameSize;
    }
    if (showSideTitles) {
      size += sideTitles.reservedSize;
    }
    return size;
  }
}
