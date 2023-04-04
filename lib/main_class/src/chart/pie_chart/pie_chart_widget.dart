import 'package:animated_fl_chart/main_class/src/chart/pie_chart/pie_chart_data.dart';
import 'package:animated_fl_chart/main_class/src/chart/pie_chart/pie_chart_renderer.dart';
import 'package:flutter/material.dart';

class PieChartWidget extends ImplicitlyAnimatedWidget {
  const PieChartWidget(
    this.data, {
    super.key,
    Duration swapAnimationDuration = defaultDuration,
    Curve swapAnimationCurve = Curves.linear,
  }) : super(
          duration: swapAnimationDuration,
          curve: swapAnimationCurve,
        );

  static const defaultDuration = Duration(milliseconds: 150);

  final PieChartData data;

  @override
  PieChartState createState() => PieChartState();
}

class PieChartState extends AnimatedWidgetBaseState<PieChartWidget> {
  PieChartDataTween? _pieChartDataTween;

  @override
  void initState() {
    _ambiguate(WidgetsBinding.instance)!.addPostFrameCallback((timeStamp) {
      if (mounted) {
        setState(() {});
      }
    });

    super.initState();
  }

  T? _ambiguate<T>(T? value) => value;

  @override
  Widget build(BuildContext context) {
    final showingData = _getData();

    return PieChartLeaf(
      data: _pieChartDataTween!.evaluate(animation),
      targetData: showingData,
    );
  }

  PieChartData _getData() {
    return widget.data;
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _pieChartDataTween = visitor(
      _pieChartDataTween,
      widget.data,
      (dynamic value) =>
          PieChartDataTween(begin: value as PieChartData, end: widget.data),
    ) as PieChartDataTween?;
  }
}

class BadgeWidgetsDelegate extends MultiChildLayoutDelegate {
  BadgeWidgetsDelegate({
    required this.badgeWidgetsCount,
    required this.badgeWidgetsOffsets,
  });
  final int badgeWidgetsCount;
  final Map<int, Offset> badgeWidgetsOffsets;

  @override
  void performLayout(Size size) {
    for (var index = 0; index < badgeWidgetsCount; index++) {
      final key = badgeWidgetsOffsets.keys.elementAt(index);

      final finalSize = layoutChild(
        key,
        BoxConstraints(
          maxWidth: size.width,
          maxHeight: size.height,
        ),
      );

      positionChild(
        key,
        Offset(
          badgeWidgetsOffsets[key]!.dx - (finalSize.width / 2),
          badgeWidgetsOffsets[key]!.dy - (finalSize.height / 2),
        ),
      );
    }
  }

  @override
  bool shouldRelayout(BadgeWidgetsDelegate oldDelegate) {
    return oldDelegate.badgeWidgetsOffsets != badgeWidgetsOffsets;
  }
}
