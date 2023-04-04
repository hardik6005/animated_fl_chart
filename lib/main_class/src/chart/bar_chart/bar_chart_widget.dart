import 'package:animated_fl_chart/animated_fl_chart.dart';
import 'package:animated_fl_chart/main_class/src/chart/bar_chart/bar_chart_renderer.dart';
import 'package:animated_fl_chart/main_class/src/chart/base/axis_chart/axis_chart_scaffold_widget.dart';
import 'package:flutter/cupertino.dart';

class BarChartWidget extends ImplicitlyAnimatedWidget {
  const BarChartWidget(
    this.data, {
    this.chartRendererKey,
    super.key,
    Duration swapAnimationDuration = const Duration(milliseconds: 150),
    Curve swapAnimationCurve = Curves.linear,
  }) : super(
          duration: swapAnimationDuration,
          curve: swapAnimationCurve,
        );

  final BarChartData data;

  final Key? chartRendererKey;

  @override
  BarChartWidgetState createState() => BarChartWidgetState();
}

class BarChartWidgetState extends AnimatedWidgetBaseState<BarChartWidget> {
  BarChartDataTween? _barChartDataTween;

  BaseTouchCallback<BarTouchResponse>? _providedTouchCallback;

  final Map<int, List<int>> _showingTouchedTooltips = {};

  @override
  Widget build(BuildContext context) {
    final showingData = _getData();

    return AxisChartScaffoldWidget(
      data: showingData,
      chart: BarChartLeaf(
        data: _withTouchedIndicators(_barChartDataTween!.evaluate(animation)),
        targetData: _withTouchedIndicators(showingData),
        key: widget.chartRendererKey,
      ),
    );
  }

  BarChartData _withTouchedIndicators(BarChartData barChartData) {
    if (!barChartData.barTouchData.enabled ||
        !barChartData.barTouchData.handleBuiltInTouches) {
      return barChartData;
    }

    final newGroups = <BarChartGroupData>[];
    for (var i = 0; i < barChartData.barGroups.length; i++) {
      final group = barChartData.barGroups[i];

      newGroups.add(
        group.copyWith(
          showingTooltipIndicators: _showingTouchedTooltips[i],
        ),
      );
    }

    return barChartData.copyWith(
      barGroups: newGroups,
    );
  }

  BarChartData _getData() {
    final barTouchData = widget.data.barTouchData;
    if (barTouchData.enabled && barTouchData.handleBuiltInTouches) {
      _providedTouchCallback = barTouchData.touchCallback;
      return widget.data.copyWith(
        barTouchData: widget.data.barTouchData
            .copyWith(touchCallback: _handleBuiltInTouch),
      );
    }
    return widget.data;
  }

  void _handleBuiltInTouch(
    AFlTouchEvent event,
    BarTouchResponse? touchResponse,
  ) {
    _providedTouchCallback?.call(event, touchResponse);

    if (!event.isInterestedForInteractions ||
        touchResponse == null ||
        touchResponse.spot == null) {
      setState(_showingTouchedTooltips.clear);
      return;
    }
    setState(() {
      final spot = touchResponse.spot!;
      final groupIndex = spot.touchedBarGroupIndex;
      final rodIndex = spot.touchedRodDataIndex;

      _showingTouchedTooltips.clear();
      _showingTouchedTooltips[groupIndex] = [rodIndex];
    });
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _barChartDataTween = visitor(
      _barChartDataTween,
      widget.data,
      (dynamic value) =>
          BarChartDataTween(begin: value as BarChartData, end: widget.data),
    ) as BarChartDataTween?;
  }
}
