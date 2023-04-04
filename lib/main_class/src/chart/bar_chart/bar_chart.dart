import 'package:animated_fl_chart/animated_fl_chart.dart';
import 'package:flutter/material.dart';

class BarChart extends StatefulWidget {
  const BarChart(this.data,
      {this.chartRendererKey,
      super.key,
      this.swapAnimationDuration = const Duration(milliseconds: 150),
      this.swapAnimationCurve = Curves.linear,
      this.randerAnimation = false,
      this.initialShowingBarGroups})
      : super(
        // duration: swapAnimationDuration,
        // curve: swapAnimationCurve,
        );

  /// Determines how the [BarChartWidget] should be look like.
  final BarChartData data;

  /// We pass this key to our renderers which are supposed to
  /// render the chart itself (without anything around the chart).
  final Key? chartRendererKey;

  final Duration? swapAnimationDuration;
  final Curve? swapAnimationCurve;
  final bool? randerAnimation;
  final List<BarChartGroupData>? initialShowingBarGroups;

  @override
  State<StatefulWidget> createState() => BarChartState();
}

class BarChartState extends State<BarChart> {
  final Color leftBarColor = const Color(0xFFFFC300);
  final Color rightBarColor = const Color(0xFFE80054);
  final Color endBarColor = const Color(0xFF3BFF49);
  final Color avgColor = const Color(0xFFFF683B);

  List<BarChartGroupData> initialShowingBarGroups = [];

  final Duration animDuration = const Duration(milliseconds: 250);
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    initialData();

    if (widget.randerAnimation!) {
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          isPlaying = !isPlaying;
          if (isPlaying) {
            refreshState();
          }
        });
      });
    }
  }

  void initialData() {
    // log("DATA : " + widget.data.barGroups.toString());
    List<BarChartGroupData> barChartGroupData = [];
    if (widget.initialShowingBarGroups == null ||
        widget.initialShowingBarGroups!.isEmpty) {
      widget.data.barGroups.asMap().forEach((key1, value) {
        List<BarChartRodData> barChartRodData = [];
        widget.data.barGroups[key1].barRods.asMap().forEach((key2, value) {
          barChartRodData.add(widget.data.barGroups[key1].barRods[key2]
              .copyWith(fromY: 0, toY: 0));
        });

        barChartGroupData.add(
            widget.data.barGroups[key1].copyWith(barRods: barChartRodData));
      });
    } else {
      barChartGroupData.addAll(widget.initialShowingBarGroups!);
    }

    // log("DATA_INITIAL : " + barChartGroupData.toString());

    initialShowingBarGroups = barChartGroupData;
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
      animDuration + const Duration(milliseconds: 50),
    );
    if (isPlaying) {
      await refreshState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BarChartWidget(
      BarChartData(
        maxY: widget.data.maxY,
        barTouchData: widget.data.barTouchData,
        titlesData: widget.data.titlesData,
        borderData: widget.data.borderData,
        barGroups: widget.randerAnimation!
            ? isPlaying
                ? widget.data.barGroups
                : initialShowingBarGroups
            : widget.data.barGroups,
        gridData: widget.data.gridData,
        alignment: widget.data.alignment,
        backgroundColor: widget.data.backgroundColor,
        baselineY: widget.data.baselineY,
        extraLinesData: widget.data.extraLinesData,
        groupsSpace: widget.data.groupsSpace,
        minY: widget.data.minY,
        rangeAnnotations: widget.data.rangeAnnotations,
      ),
      swapAnimationDuration: animDuration,
      swapAnimationCurve: widget.swapAnimationCurve!,
      chartRendererKey: widget.chartRendererKey,
    );
  }
}
