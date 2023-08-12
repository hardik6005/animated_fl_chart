import 'dart:developer';

import 'package:animated_fl_chart/animated_fl_chart.dart';
import 'package:flutter/material.dart';

enum RenderAnimationType { line, height }

class LineChart extends StatefulWidget {
  const LineChart(
    this.data, {
    this.chartRendererKey,
    super.key,
    this.swapAnimationDuration = const Duration(milliseconds: 500),
    this.swapAnimationCurve = Curves.linear,
    this.randerAnimation = false,
    this.initialShowingBarGroups,
/*
    this.renderAnimationType = RenderAnimationType.height,
*/
  }) : super(
        // duration: swapAnimationDuration,
        // curve: swapAnimationCurve,
        );

  final LineChartData data;

  final Key? chartRendererKey;

  final Duration? swapAnimationDuration;
  final Curve? swapAnimationCurve;
  final bool? randerAnimation;
  final List<LineChartBarData>? initialShowingBarGroups;

  @override
  State<StatefulWidget> createState() => LineChartState();
}

class LineChartState extends State<LineChart> {
  final Color leftBarColor = const Color(0xFFFFC300);
  final Color rightBarColor = const Color(0xFFE80054);
  final Color endBarColor = const Color(0xFF3BFF49);
  final Color avgColor = const Color(0xFFFF683B);

  List<LineChartBarData> initialShowingBarGroups = [];

  bool isPlaying = false;

  int touchedGroupIndex = -1;

  int spotLenght = 0;
  int spotIndex = 0;

  @override
  void initState() {
    super.initState();
    initialData();

    if (widget.randerAnimation!) {
      Future.delayed(const Duration(milliseconds: 150), () {
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
    List<LineChartBarData> barChartGroupData = [];

    log("HEREEEEE : ${widget.data.lineBarsData}");

    // if (widget.renderAnimationType.name == "height") {
    if (widget.initialShowingBarGroups == null ||
        widget.initialShowingBarGroups!.isEmpty) {
      widget.data.lineBarsData.asMap().forEach((key1, value) {
        List<AFlSpot> barChartRodData = [];
        widget.data.lineBarsData[key1].spots.asMap().forEach((key2, value) {
          barChartRodData.add(AFlSpot(
              widget.data.lineBarsData[key1].spots[key2].x,
              /* widget.data.lineBarsData[key1].spots[key2].y,*/ 0));
        });

        barChartGroupData.add(
            widget.data.lineBarsData[key1].copyWith(spots: barChartRodData));
      });
    } else {
      barChartGroupData.addAll(widget.initialShowingBarGroups!);
    }

    initialShowingBarGroups.addAll(barChartGroupData);

    /*} else {
      spotLenght = widget.data.lineBarsData[0].spots.length;
      renderLineMethod();
    }*/
  }

/*
  void renderLineMethod() {
    //widget.data.lineBarsData.asMap().forEach((key1, value) {
    List<AFlSpot> barChartRodData = [];
    // widget.data.lineBarsData[0].spots.asMap().forEach((key2, value) {
    Future.delayed(const Duration(milliseconds: 100), () {
      renderLineDelay(barChartRodData);
    });
    // });
    //});
  }

  renderLineDelay(List<AFlSpot> barChartRodData) {
    if (initialShowingBarGroups.isEmpty) {
      barChartRodData.add(AFlSpot(
        widget.data.lineBarsData[0].spots[spotIndex].x,
        widget.data.lineBarsData[0].spots[spotIndex].y,
      ));
      initialShowingBarGroups
          .add(widget.data.lineBarsData[0].copyWith(spots: barChartRodData));
    } else {
      initialShowingBarGroups[0].spots.add(AFlSpot(
            widget.data.lineBarsData[0].spots[spotIndex].x,
            widget.data.lineBarsData[0].spots[spotIndex].y,
          ));
    }
    if (spotIndex != spotLenght - 1) {
      spotIndex++;
      log("HARDDDD : " + initialShowingBarGroups.toString());
      renderLineMethod();
      setState(() {});
    }
  }

  */
  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
      widget.swapAnimationDuration! + const Duration(milliseconds: 50),
    );
    if (isPlaying) {
      await refreshState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LineChartWidget(
      LineChartData(
        maxY: widget.data.maxY,
        maxX: widget.data.maxX,
        minX: widget.data.minX,
        baselineX: widget.data.baselineX,
        baselineY: widget.data.baselineY,
        lineTouchData: widget.data.lineTouchData,
        titlesData: widget.data.titlesData,
        borderData: widget.data.borderData,
        gridData: widget.data.gridData,
        backgroundColor: widget.data.backgroundColor,
        extraLinesData: widget.data.extraLinesData,
        minY: widget.data.minY,
        rangeAnnotations: widget.data.rangeAnnotations,
        betweenBarsData: widget.data.betweenBarsData,
        clipData: widget.data.clipData,
        lineBarsData: widget.randerAnimation!
            ? isPlaying
                ? widget.data.lineBarsData
                : initialShowingBarGroups
            : widget.data.lineBarsData,
        showingTooltipIndicators: widget.data.showingTooltipIndicators,
      ),
      swapAnimationDuration: widget.swapAnimationDuration!,
      swapAnimationCurve: widget.swapAnimationCurve!,
      chartRendererKey: widget.chartRendererKey,
    );
  }
}
