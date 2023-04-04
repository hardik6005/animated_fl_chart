import 'package:fl_chart_app/presentation/samples/bar/bar_chart_sample1.dart';
import 'package:fl_chart_app/presentation/samples/line/line_chart_sample1.dart';
import 'package:fl_chart_app/presentation/samples/line/line_chart_sample2.dart';
import 'package:fl_chart_app/presentation/samples/line/line_chart_sample7.dart';
import 'package:fl_chart_app/presentation/samples/pie/pie_chart_sample2.dart';
import 'package:fl_chart_app/util/app_helper.dart';

import 'bar/bar_chart_sample2.dart';

import 'chart_sample.dart';
import 'line/line_chart_sample3.dart';
import 'line/line_chart_sample4.dart';
import 'line/line_chart_sample5.dart';
import 'line/line_chart_sample6.dart';

class ChartSamples {
  static final Map<ChartType, List<ChartSample>> samples = {
    ChartType.line: [
      LineChartSample(1, (context) => LineChartSample1()),
      LineChartSample(2, (context) => LineChartSample2()),
      LineChartSample(3, (context) => LineChartSample3()),
      LineChartSample(4, (context) => LineChartSample4()),
      LineChartSample(5, (context) => LineChartSample5()),
      LineChartSample(6, (context) => LineChartSample6()),
      LineChartSample(7, (context) => LineChartSample7()),
    ],
    ChartType.bar: [
      BarChartSample(1, (context) => BarChartSample1()),
      BarChartSample(2, (context) => BarChartSample2()),
    ],
    ChartType.pie: [
      PieChartSample(7, (context) => PieChartSample2()),
    ],
  };
}
