import 'package:fl_chart_app/presentation/samples/bar/bar_chart_sample1.dart';
import 'package:fl_chart_app/util/app_helper.dart';

import 'bar/bar_chart_sample2.dart';

import 'chart_sample.dart';

class ChartSamples {
  static final Map<ChartType, List<ChartSample>> samples = {
    ChartType.line: [],
    ChartType.bar: [
      BarChartSample(1, (context) => BarChartSample1()),
      BarChartSample(2, (context) => BarChartSample2()),
    ],
    ChartType.pie: [],
  };
}
