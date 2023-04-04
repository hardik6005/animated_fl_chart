import 'package:animated_fl_chart/animated_fl_chart.dart';
import 'package:flutter/material.dart';

class PieChart extends StatefulWidget {
  const PieChart(this.data,
      {super.key,
      this.randerAnimation = false,
      this.swapAnimationDuration = const Duration(milliseconds: 150),
      this.swapAnimationCurve = Curves.linear});

  final PieChartData data;
  final bool randerAnimation;
  final Duration swapAnimationDuration;
  final Curve swapAnimationCurve;

  @override
  State<StatefulWidget> createState() => PieChartState();
}

class PieChartState extends State<PieChart> {
  final Color leftBarColor = const Color(0xFFFFC300);
  final Color rightBarColor = const Color(0xFFE80054);
  final Color endBarColor = const Color(0xFF3BFF49);
  final Color avgColor = const Color(0xFFFF683B);

  List<PieChartSectionData> initialData = [];

  final Duration animDuration = const Duration(milliseconds: 500);
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();

    initialDataSet();

    if (widget.randerAnimation) {
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
    return PieChartWidget(
      PieChartData(
        borderData: widget.data.borderData,
        startDegreeOffset: widget.data.startDegreeOffset,
        sectionsSpace: widget.data.sectionsSpace,
        centerSpaceColor: widget.data.centerSpaceColor,
        centerSpaceRadius: widget.data.centerSpaceRadius,
        pieTouchData: widget.data.pieTouchData,
        sections: widget.randerAnimation
            ? isPlaying
                ? widget.data.sections
                : initialData
            : widget.data.sections,
      ),
      swapAnimationDuration: animDuration,
    );
  }

  void initialDataSet() {
    initialData.add(widget.data.sections[0].copyWith(value: 1, title: ""));
  }
}
