import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:animated_fl_chart/animated_fl_chart.dart';
import 'package:animated_fl_chart/main_class/src/chart/line_chart/line_chart_helper.dart';
import 'package:animated_fl_chart/main_class/src/extensions/color_extension.dart';
import 'package:animated_fl_chart/main_class/src/extensions/gradient_extension.dart';
import 'package:animated_fl_chart/main_class/src/utils/lerp.dart';
import 'package:flutter/material.dart' hide Image;

class LineChartData extends AxisChartData with EquatableMixin {
  LineChartData({
    List<LineChartBarData>? lineBarsData,
    List<BetweenBarsData>? betweenBarsData,
    AFlTitlesData? titlesData,
    ExtraLinesData? extraLinesData,
    LineTouchData? lineTouchData,
    List<ShowingTooltipIndicators>? showingTooltipIndicators,
    AFlGridData? gridData,
    super.borderData,
    RangeAnnotations? rangeAnnotations,
    double? minX,
    double? maxX,
    super.baselineX,
    double? minY,
    double? maxY,
    super.baselineY,
    FlClipData? clipData,
    super.backgroundColor,
  })  : lineBarsData = lineBarsData ?? const [],
        betweenBarsData = betweenBarsData ?? const [],
        lineTouchData = lineTouchData ?? LineTouchData(),
        showingTooltipIndicators = showingTooltipIndicators ?? const [],
        super(
          gridData: gridData ?? AFlGridData(),
          touchData: lineTouchData ?? LineTouchData(),
          titlesData: titlesData ?? AFlTitlesData(),
          rangeAnnotations: rangeAnnotations ?? RangeAnnotations(),
          clipData: clipData ?? FlClipData.none(),
          extraLinesData: extraLinesData = extraLinesData ?? ExtraLinesData(),
          minX: minX ??
              LineChartHelper.calculateMaxAxisValues(lineBarsData ?? const [])
                  .minX,
          maxX: maxX ??
              LineChartHelper.calculateMaxAxisValues(lineBarsData ?? const [])
                  .maxX,
          minY: minY ??
              LineChartHelper.calculateMaxAxisValues(lineBarsData ?? const [])
                  .minY,
          maxY: maxY ??
              LineChartHelper.calculateMaxAxisValues(lineBarsData ?? const [])
                  .maxY,
        );

  final List<LineChartBarData> lineBarsData;

  final List<BetweenBarsData> betweenBarsData;

  final LineTouchData lineTouchData;

  final List<ShowingTooltipIndicators> showingTooltipIndicators;

  @override
  LineChartData lerp(BaseChartData a, BaseChartData b, double t) {
    if (a is LineChartData && b is LineChartData) {
      return LineChartData(
        minX: lerpDouble(a.minX, b.minX, t),
        maxX: lerpDouble(a.maxX, b.maxX, t),
        baselineX: lerpDouble(a.baselineX, b.baselineX, t),
        minY: lerpDouble(a.minY, b.minY, t),
        maxY: lerpDouble(a.maxY, b.maxY, t),
        baselineY: lerpDouble(a.baselineY, b.baselineY, t),
        backgroundColor: Color.lerp(a.backgroundColor, b.backgroundColor, t),
        borderData: AFlBorderData.lerp(a.borderData, b.borderData, t),
        clipData: b.clipData,
        extraLinesData:
            ExtraLinesData.lerp(a.extraLinesData, b.extraLinesData, t),
        gridData: AFlGridData.lerp(a.gridData, b.gridData, t),
        titlesData: AFlTitlesData.lerp(a.titlesData, b.titlesData, t),
        rangeAnnotations:
            RangeAnnotations.lerp(a.rangeAnnotations, b.rangeAnnotations, t),
        lineBarsData:
            lerpLineChartBarDataList(a.lineBarsData, b.lineBarsData, t),
        betweenBarsData:
            lerpBetweenBarsDataList(a.betweenBarsData, b.betweenBarsData, t),
        lineTouchData: b.lineTouchData,
        showingTooltipIndicators: b.showingTooltipIndicators,
      );
    } else {
      throw Exception('Illegal State');
    }
  }

  LineChartData copyWith({
    List<LineChartBarData>? lineBarsData,
    List<BetweenBarsData>? betweenBarsData,
    AFlTitlesData? titlesData,
    RangeAnnotations? rangeAnnotations,
    ExtraLinesData? extraLinesData,
    LineTouchData? lineTouchData,
    List<ShowingTooltipIndicators>? showingTooltipIndicators,
    AFlGridData? gridData,
    AFlBorderData? borderData,
    double? minX,
    double? maxX,
    double? baselineX,
    double? minY,
    double? maxY,
    double? baselineY,
    FlClipData? clipData,
    Color? backgroundColor,
  }) {
    return LineChartData(
      lineBarsData: lineBarsData ?? this.lineBarsData,
      betweenBarsData: betweenBarsData ?? this.betweenBarsData,
      titlesData: titlesData ?? this.titlesData,
      rangeAnnotations: rangeAnnotations ?? this.rangeAnnotations,
      extraLinesData: extraLinesData ?? this.extraLinesData,
      lineTouchData: lineTouchData ?? this.lineTouchData,
      showingTooltipIndicators:
          showingTooltipIndicators ?? this.showingTooltipIndicators,
      gridData: gridData ?? this.gridData,
      borderData: borderData ?? this.borderData,
      minX: minX ?? this.minX,
      maxX: maxX ?? this.maxX,
      baselineX: baselineX ?? this.baselineX,
      minY: minY ?? this.minY,
      maxY: maxY ?? this.maxY,
      baselineY: baselineY ?? this.baselineY,
      clipData: clipData ?? this.clipData,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  List<Object?> get props => [
        lineBarsData,
        betweenBarsData,
        titlesData,
        extraLinesData,
        lineTouchData,
        showingTooltipIndicators,
        gridData,
        borderData,
        rangeAnnotations,
        minX,
        maxX,
        baselineX,
        minY,
        maxY,
        baselineY,
        clipData,
        backgroundColor,
      ];
}

class LineChartBarData with EquatableMixin {
  LineChartBarData({
    List<AFlSpot>? spots,
    bool? show,
    Color? color,
    this.gradient,
    double? barWidth,
    bool? isCurved,
    double? curveSmoothness,
    bool? preventCurveOverShooting,
    double? preventCurveOvershootingThreshold,
    bool? isStrokeCapRound,
    bool? isStrokeJoinRound,
    BarAreaData? belowBarData,
    BarAreaData? aboveBarData,
    FlDotData? dotData,
    List<int>? showingIndicators,
    this.dashArray,
    Shadow? shadow,
    bool? isStepLineChart,
    LineChartStepData? lineChartStepData,
  })  : spots = spots ?? const [],
        show = show ?? true,
        color =
            color ?? ((color == null && gradient == null) ? Colors.cyan : null),
        barWidth = barWidth ?? 2.0,
        isCurved = isCurved ?? false,
        curveSmoothness = curveSmoothness ?? 0.35,
        preventCurveOverShooting = preventCurveOverShooting ?? false,
        preventCurveOvershootingThreshold =
            preventCurveOvershootingThreshold ?? 10.0,
        isStrokeCapRound = isStrokeCapRound ?? false,
        isStrokeJoinRound = isStrokeJoinRound ?? false,
        belowBarData = belowBarData ?? BarAreaData(),
        aboveBarData = aboveBarData ?? BarAreaData(),
        dotData = dotData ?? FlDotData(),
        showingIndicators = showingIndicators ?? const [],
        shadow = shadow ?? const Shadow(color: Colors.transparent),
        isStepLineChart = isStepLineChart ?? false,
        lineChartStepData = lineChartStepData ?? LineChartStepData() {
    AFlSpot? mostLeft;
    AFlSpot? mostTop;
    AFlSpot? mostRight;
    AFlSpot? mostBottom;

    AFlSpot? firstValidSpot;
    try {
      firstValidSpot =
          this.spots.firstWhere((element) => element != AFlSpot.nullSpot);
    } catch (e) {}
    if (firstValidSpot != null) {
      for (final spot in this.spots) {
        if (spot.isNull()) {
          continue;
        }
        if (mostLeft == null || spot.x < mostLeft.x) {
          mostLeft = spot;
        }

        if (mostRight == null || spot.x > mostRight.x) {
          mostRight = spot;
        }

        if (mostTop == null || spot.y > mostTop.y) {
          mostTop = spot;
        }

        if (mostBottom == null || spot.y < mostBottom.y) {
          mostBottom = spot;
        }
      }
      mostLeftSpot = mostLeft!;
      mostTopSpot = mostTop!;
      mostRightSpot = mostRight!;
      mostBottomSpot = mostBottom!;
    }
  }

  final List<AFlSpot> spots;

  late final AFlSpot mostLeftSpot;

  late final AFlSpot mostTopSpot;

  late final AFlSpot mostRightSpot;

  late final AFlSpot mostBottomSpot;

  final bool show;

  final Color? color;

  final Gradient? gradient;

  final double barWidth;

  final bool isCurved;

  final double curveSmoothness;

  final bool preventCurveOverShooting;

  final double preventCurveOvershootingThreshold;

  final bool isStrokeCapRound;

  final bool isStrokeJoinRound;

  final BarAreaData belowBarData;

  final BarAreaData aboveBarData;

  final FlDotData dotData;

  final List<int> showingIndicators;

  final List<int>? dashArray;

  final Shadow shadow;

  final bool isStepLineChart;

  final LineChartStepData lineChartStepData;

  static LineChartBarData lerp(
    LineChartBarData a,
    LineChartBarData b,
    double t,
  ) {
    return LineChartBarData(
      show: b.show,
      barWidth: lerpDouble(a.barWidth, b.barWidth, t),
      belowBarData: BarAreaData.lerp(a.belowBarData, b.belowBarData, t),
      aboveBarData: BarAreaData.lerp(a.aboveBarData, b.aboveBarData, t),
      curveSmoothness: b.curveSmoothness,
      isCurved: b.isCurved,
      isStrokeCapRound: b.isStrokeCapRound,
      isStrokeJoinRound: b.isStrokeJoinRound,
      preventCurveOverShooting: b.preventCurveOverShooting,
      preventCurveOvershootingThreshold: lerpDouble(
        a.preventCurveOvershootingThreshold,
        b.preventCurveOvershootingThreshold,
        t,
      ),
      dotData: FlDotData.lerp(a.dotData, b.dotData, t),
      dashArray: lerpIntList(a.dashArray, b.dashArray, t),
      color: Color.lerp(a.color, b.color, t),
      gradient: Gradient.lerp(a.gradient, b.gradient, t),
      spots: lerpFlSpotList(a.spots, b.spots, t),
      showingIndicators: b.showingIndicators,
      shadow: Shadow.lerp(a.shadow, b.shadow, t),
      isStepLineChart: b.isStepLineChart,
      lineChartStepData:
          LineChartStepData.lerp(a.lineChartStepData, b.lineChartStepData, t),
    );
  }

  LineChartBarData copyWith({
    List<AFlSpot>? spots,
    bool? show,
    Color? color,
    Gradient? gradient,
    double? barWidth,
    bool? isCurved,
    double? curveSmoothness,
    bool? preventCurveOverShooting,
    double? preventCurveOvershootingThreshold,
    bool? isStrokeCapRound,
    bool? isStrokeJoinRound,
    BarAreaData? belowBarData,
    BarAreaData? aboveBarData,
    FlDotData? dotData,
    List<int>? dashArray,
    List<int>? showingIndicators,
    Shadow? shadow,
    bool? isStepLineChart,
    LineChartStepData? lineChartStepData,
  }) {
    return LineChartBarData(
      spots: spots ?? this.spots,
      show: show ?? this.show,
      color: color ?? this.color,
      gradient: gradient ?? this.gradient,
      barWidth: barWidth ?? this.barWidth,
      isCurved: isCurved ?? this.isCurved,
      curveSmoothness: curveSmoothness ?? this.curveSmoothness,
      preventCurveOverShooting:
          preventCurveOverShooting ?? this.preventCurveOverShooting,
      preventCurveOvershootingThreshold: preventCurveOvershootingThreshold ??
          this.preventCurveOvershootingThreshold,
      isStrokeCapRound: isStrokeCapRound ?? this.isStrokeCapRound,
      isStrokeJoinRound: isStrokeJoinRound ?? this.isStrokeJoinRound,
      belowBarData: belowBarData ?? this.belowBarData,
      aboveBarData: aboveBarData ?? this.aboveBarData,
      dashArray: dashArray ?? this.dashArray,
      dotData: dotData ?? this.dotData,
      showingIndicators: showingIndicators ?? this.showingIndicators,
      shadow: shadow ?? this.shadow,
      isStepLineChart: isStepLineChart ?? this.isStepLineChart,
      lineChartStepData: lineChartStepData ?? this.lineChartStepData,
    );
  }

  @override
  List<Object?> get props => [
        spots,
        show,
        color,
        gradient,
        barWidth,
        isCurved,
        curveSmoothness,
        preventCurveOverShooting,
        preventCurveOvershootingThreshold,
        isStrokeCapRound,
        isStrokeJoinRound,
        belowBarData,
        aboveBarData,
        dotData,
        showingIndicators,
        dashArray,
        shadow,
        isStepLineChart,
        lineChartStepData,
      ];
}

class LineChartStepData with EquatableMixin {
  LineChartStepData({this.stepDirection = stepDirectionMiddle});

  static const stepDirectionForward = 0.0;

  static const stepDirectionMiddle = 0.5;

  static const stepDirectionBackward = 1.0;

  final double stepDirection;

  static LineChartStepData lerp(
    LineChartStepData a,
    LineChartStepData b,
    double t,
  ) {
    return LineChartStepData(
      stepDirection: lerpDouble(a.stepDirection, b.stepDirection, t)!,
    );
  }

  @override
  List<Object?> get props => [stepDirection];
}

class BarAreaData with EquatableMixin {
  BarAreaData({
    bool? show,
    Color? color,
    this.gradient,
    BarAreaSpotsLine? spotsLine,
    double? cutOffY,
    bool? applyCutOffY,
  })  : show = show ?? false,
        color = color ??
            ((color == null && gradient == null)
                ? Colors.blueGrey.withOpacity(0.5)
                : null),
        spotsLine = spotsLine ?? BarAreaSpotsLine(),
        cutOffY = cutOffY ?? 0,
        applyCutOffY = applyCutOffY ?? false,
        assert(applyCutOffY == true ? cutOffY != null : true);
  final bool show;

  final Color? color;

  final Gradient? gradient;

  final BarAreaSpotsLine spotsLine;

  final double cutOffY;

  final bool applyCutOffY;

  static BarAreaData lerp(BarAreaData a, BarAreaData b, double t) {
    return BarAreaData(
      show: b.show,
      spotsLine: BarAreaSpotsLine.lerp(a.spotsLine, b.spotsLine, t),
      color: Color.lerp(a.color, b.color, t),
      gradient: Gradient.lerp(a.gradient, b.gradient, t),
      cutOffY: lerpDouble(a.cutOffY, b.cutOffY, t),
      applyCutOffY: b.applyCutOffY,
    );
  }

  @override
  List<Object?> get props => [
        show,
        color,
        gradient,
        spotsLine,
        cutOffY,
        applyCutOffY,
      ];
}

class BetweenBarsData with EquatableMixin {
  BetweenBarsData({
    required this.fromIndex,
    required this.toIndex,
    Color? color,
    this.gradient,
  }) : color = color ??
            ((color == null && gradient == null)
                ? Colors.blueGrey.withOpacity(0.5)
                : null);

  final int fromIndex;

  final int toIndex;

  final Color? color;

  final Gradient? gradient;

  static BetweenBarsData lerp(BetweenBarsData a, BetweenBarsData b, double t) {
    return BetweenBarsData(
      fromIndex: b.fromIndex,
      toIndex: b.toIndex,
      color: Color.lerp(a.color, b.color, t),
      gradient: Gradient.lerp(a.gradient, b.gradient, t),
    );
  }

  @override
  List<Object?> get props => [
        fromIndex,
        toIndex,
        color,
        gradient,
      ];
}

class BarAreaSpotsLine with EquatableMixin {
  BarAreaSpotsLine({
    bool? show,
    AFlLine? flLineStyle,
    CheckToShowSpotLine? checkToShowSpotLine,
    bool? applyCutOffY,
  })  : show = show ?? false,
        flLineStyle = flLineStyle ?? AFlLine(),
        checkToShowSpotLine = checkToShowSpotLine ?? showAllSpotsBelowLine,
        applyCutOffY = applyCutOffY ?? true;

  final bool show;

  final AFlLine flLineStyle;

  final CheckToShowSpotLine checkToShowSpotLine;

  final bool applyCutOffY;

  static BarAreaSpotsLine lerp(
    BarAreaSpotsLine a,
    BarAreaSpotsLine b,
    double t,
  ) {
    return BarAreaSpotsLine(
      show: b.show,
      checkToShowSpotLine: b.checkToShowSpotLine,
      flLineStyle: AFlLine.lerp(a.flLineStyle, b.flLineStyle, t),
      applyCutOffY: b.applyCutOffY,
    );
  }

  @override
  List<Object?> get props => [
        show,
        flLineStyle,
        checkToShowSpotLine,
        applyCutOffY,
      ];
}

typedef CheckToShowSpotLine = bool Function(AFlSpot spot);

bool showAllSpotsBelowLine(AFlSpot spot) {
  return true;
}

typedef GetDotColorCallback = Color Function(AFlSpot, double, LineChartBarData);

Color _defaultGetDotColor(AFlSpot _, double xPercentage, LineChartBarData bar) {
  if (bar.gradient != null && bar.gradient is LinearGradient) {
    return lerpGradient(
      bar.gradient!.colors,
      bar.gradient!.getSafeColorStops(),
      xPercentage / 100,
    );
  }
  return bar.gradient?.colors.first ?? bar.color ?? Colors.blueGrey;
}

Color _defaultGetDotStrokeColor(
  AFlSpot spot,
  double xPercentage,
  LineChartBarData bar,
) {
  Color color;
  if (bar.gradient != null && bar.gradient is LinearGradient) {
    color = lerpGradient(
      bar.gradient!.colors,
      bar.gradient!.getSafeColorStops(),
      xPercentage / 100,
    );
  } else {
    color = bar.gradient?.colors.first ?? bar.color ?? Colors.blueGrey;
  }
  return color.darken();
}

typedef GetDotPainterCallback = FlDotPainter Function(
  AFlSpot,
  double,
  LineChartBarData,
  int,
);

FlDotPainter _defaultGetDotPainter(
  AFlSpot spot,
  double xPercentage,
  LineChartBarData bar,
  int index, {
  double? size,
}) {
  return FlDotCirclePainter(
    radius: size,
    color: _defaultGetDotColor(spot, xPercentage, bar),
    strokeColor: _defaultGetDotStrokeColor(spot, xPercentage, bar),
  );
}

class FlDotData with EquatableMixin {
  FlDotData({
    bool? show,
    CheckToShowDot? checkToShowDot,
    GetDotPainterCallback? getDotPainter,
  })  : show = show ?? true,
        checkToShowDot = checkToShowDot ?? showAllDots,
        getDotPainter = getDotPainter ?? _defaultGetDotPainter;

  final bool show;

  final CheckToShowDot checkToShowDot;

  final GetDotPainterCallback getDotPainter;

  static FlDotData lerp(FlDotData a, FlDotData b, double t) {
    return FlDotData(
      show: b.show,
      checkToShowDot: b.checkToShowDot,
      getDotPainter: b.getDotPainter,
    );
  }

  @override
  List<Object?> get props => [
        show,
        checkToShowDot,
        getDotPainter,
      ];
}

abstract class FlDotPainter with EquatableMixin {
  void draw(Canvas canvas, AFlSpot spot, Offset offsetInCanvas);

  Size getSize(AFlSpot spot);
}

class FlDotCirclePainter extends FlDotPainter {
  FlDotCirclePainter({
    Color? color,
    double? radius,
    Color? strokeColor,
    double? strokeWidth,
  })  : color = color ?? Colors.green,
        radius = radius ?? 4.0,
        strokeColor = strokeColor ?? Colors.green.darken(),
        strokeWidth = strokeWidth ?? 1.0;

  Color color;

  double radius;

  Color strokeColor;

  double strokeWidth;

  @override
  void draw(Canvas canvas, AFlSpot spot, Offset offsetInCanvas) {
    if (strokeWidth != 0.0 && strokeColor.opacity != 0.0) {
      canvas.drawCircle(
        offsetInCanvas,
        radius + (strokeWidth / 2),
        Paint()
          ..color = strokeColor
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke,
      );
    }
    canvas.drawCircle(
      offsetInCanvas,
      radius,
      Paint()
        ..color = color
        ..style = PaintingStyle.fill,
    );
  }

  @override
  Size getSize(AFlSpot spot) {
    return Size(radius * 2, radius * 2);
  }

  @override
  List<Object?> get props => [
        color,
        radius,
        strokeColor,
        strokeWidth,
      ];
}

class FlDotSquarePainter extends FlDotPainter {
  FlDotSquarePainter({
    Color? color,
    double? size,
    Color? strokeColor,
    double? strokeWidth,
  })  : color = color ?? Colors.green,
        size = size ?? 4.0,
        strokeColor = strokeColor ?? Colors.green.darken(),
        strokeWidth = strokeWidth ?? 1.0;

  Color color;

  double size;

  Color strokeColor;

  double strokeWidth;

  @override
  void draw(Canvas canvas, AFlSpot spot, Offset offsetInCanvas) {
    if (strokeWidth != 0.0 && strokeColor.opacity != 0.0) {
      canvas.drawRect(
        Rect.fromCircle(
          center: offsetInCanvas,
          radius: (size / 2) + (strokeWidth / 2),
        ),
        Paint()
          ..color = strokeColor
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke,
      );
    }
    canvas.drawRect(
      Rect.fromCircle(
        center: offsetInCanvas,
        radius: size / 2,
      ),
      Paint()
        ..color = color
        ..style = PaintingStyle.fill,
    );
  }

  @override
  Size getSize(AFlSpot spot) {
    return Size(size, size);
  }

  @override
  List<Object?> get props => [
        color,
        size,
        strokeColor,
        strokeWidth,
      ];
}

class FlDotCrossPainter extends FlDotPainter {
  FlDotCrossPainter({
    Color? color,
    double? size,
    double? width,
  })  : color = color ?? Colors.green,
        size = size ?? 8.0,
        width = width ?? 2.0;

  Color color;

  double size;

  double width;

  @override
  void draw(Canvas canvas, AFlSpot spot, Offset offsetInCanvas) {
    final path = Path()
      ..moveTo(offsetInCanvas.dx, offsetInCanvas.dy)
      ..relativeMoveTo(-size / 2, -size / 2)
      ..relativeLineTo(size, size)
      ..moveTo(offsetInCanvas.dx, offsetInCanvas.dy)
      ..relativeMoveTo(size / 2, -size / 2)
      ..relativeLineTo(-size, size);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width
      ..color = color;

    canvas.drawPath(path, paint);
  }

  @override
  Size getSize(AFlSpot spot) {
    return Size(size, size);
  }

  @override
  List<Object?> get props => [
        color,
        size,
        width,
      ];
}

typedef CheckToShowDot = bool Function(AFlSpot spot, LineChartBarData barData);

bool showAllDots(AFlSpot spot, LineChartBarData barData) {
  return true;
}

abstract class AFlLineLabel with EquatableMixin {
  AFlLineLabel({
    required this.show,
    required this.padding,
    required this.style,
    required this.alignment,
  });

  final bool show;

  final EdgeInsetsGeometry padding;

  final TextStyle? style;

  final Alignment alignment;

  @override
  List<Object?> get props => [
        show,
        padding,
        style,
        alignment,
      ];
}

class LineTouchData extends FlTouchData<LineTouchResponse> with EquatableMixin {
  LineTouchData({
    bool? enabled,
    BaseTouchCallback<LineTouchResponse>? touchCallback,
    MouseCursorResolver<LineTouchResponse>? mouseCursorResolver,
    Duration? longPressDuration,
    LineTouchTooltipData? touchTooltipData,
    GetTouchedSpotIndicator? getTouchedSpotIndicator,
    double? touchSpotThreshold,
    CalculateTouchDistance? distanceCalculator,
    bool? handleBuiltInTouches,
    GetTouchLineY? getTouchLineStart,
    GetTouchLineY? getTouchLineEnd,
  })  : touchTooltipData = touchTooltipData ?? LineTouchTooltipData(),
        getTouchedSpotIndicator =
            getTouchedSpotIndicator ?? defaultTouchedIndicators,
        touchSpotThreshold = touchSpotThreshold ?? 10,
        distanceCalculator = distanceCalculator ?? _xDistance,
        handleBuiltInTouches = handleBuiltInTouches ?? true,
        getTouchLineStart = getTouchLineStart ?? defaultGetTouchLineStart,
        getTouchLineEnd = getTouchLineEnd ?? defaultGetTouchLineEnd,
        super(
          enabled ?? true,
          touchCallback,
          mouseCursorResolver,
          longPressDuration,
        );

  final LineTouchTooltipData touchTooltipData;

  final GetTouchedSpotIndicator getTouchedSpotIndicator;

  final double touchSpotThreshold;

  final CalculateTouchDistance distanceCalculator;

  final bool handleBuiltInTouches;

  final GetTouchLineY getTouchLineStart;

  final GetTouchLineY getTouchLineEnd;

  LineTouchData copyWith({
    bool? enabled,
    BaseTouchCallback<LineTouchResponse>? touchCallback,
    MouseCursorResolver<LineTouchResponse>? mouseCursorResolver,
    Duration? longPressDuration,
    LineTouchTooltipData? touchTooltipData,
    GetTouchedSpotIndicator? getTouchedSpotIndicator,
    double? touchSpotThreshold,
    CalculateTouchDistance? distanceCalculator,
    GetTouchLineY? getTouchLineStart,
    GetTouchLineY? getTouchLineEnd,
    bool? handleBuiltInTouches,
  }) {
    return LineTouchData(
      enabled: enabled ?? this.enabled,
      touchCallback: touchCallback ?? this.touchCallback,
      mouseCursorResolver: mouseCursorResolver ?? this.mouseCursorResolver,
      longPressDuration: longPressDuration ?? this.longPressDuration,
      touchTooltipData: touchTooltipData ?? this.touchTooltipData,
      getTouchedSpotIndicator:
          getTouchedSpotIndicator ?? this.getTouchedSpotIndicator,
      touchSpotThreshold: touchSpotThreshold ?? this.touchSpotThreshold,
      distanceCalculator: distanceCalculator ?? this.distanceCalculator,
      getTouchLineStart: getTouchLineStart ?? this.getTouchLineStart,
      getTouchLineEnd: getTouchLineEnd ?? this.getTouchLineEnd,
      handleBuiltInTouches: handleBuiltInTouches ?? this.handleBuiltInTouches,
    );
  }

  @override
  List<Object?> get props => [
        enabled,
        touchCallback,
        mouseCursorResolver,
        longPressDuration,
        touchTooltipData,
        getTouchedSpotIndicator,
        touchSpotThreshold,
        distanceCalculator,
        handleBuiltInTouches,
        getTouchLineStart,
        getTouchLineEnd,
      ];
}

typedef GetTouchedSpotIndicator = List<TouchedSpotIndicatorData?> Function(
  LineChartBarData barData,
  List<int> spotIndexes,
);

typedef GetTouchLineY = double Function(
  LineChartBarData barData,
  int spotIndex,
);

typedef CalculateTouchDistance = double Function(
  Offset touchPoint,
  Offset spotPixelCoordinates,
);

double _xDistance(Offset touchPoint, Offset spotPixelCoordinates) {
  return (touchPoint.dx - spotPixelCoordinates.dx).abs();
}

List<TouchedSpotIndicatorData> defaultTouchedIndicators(
  LineChartBarData barData,
  List<int> indicators,
) {
  return indicators.map((int index) {
    var lineColor = barData.gradient?.colors.first ?? barData.color;
    if (barData.dotData.show) {
      lineColor = _defaultGetDotColor(barData.spots[index], 0, barData);
    }
    const lineStrokeWidth = 4.0;
    final flLine = AFlLine(color: lineColor, strokeWidth: lineStrokeWidth);

    var dotSize = 10.0;
    if (barData.dotData.show) {
      dotSize = 4.0 * 1.8;
    }

    final dotData = FlDotData(
      getDotPainter: (spot, percent, bar, index) =>
          _defaultGetDotPainter(spot, percent, bar, index, size: dotSize),
    );

    return TouchedSpotIndicatorData(flLine, dotData);
  }).toList();
}

double defaultGetTouchLineStart(LineChartBarData barData, int spotIndex) {
  return -double.infinity;
}

double defaultGetTouchLineEnd(LineChartBarData barData, int spotIndex) {
  return barData.spots[spotIndex].y;
}

class LineTouchTooltipData with EquatableMixin {
  LineTouchTooltipData({
    Color? tooltipBgColor,
    double? tooltipRoundedRadius,
    EdgeInsets? tooltipPadding,
    double? tooltipMargin,
    FLHorizontalAlignment? tooltipHorizontalAlignment,
    double? tooltipHorizontalOffset,
    double? maxContentWidth,
    GetLineTooltipItems? getTooltipItems,
    bool? fitInsideHorizontally,
    bool? fitInsideVertically,
    bool? showOnTopOfTheChartBoxArea,
    double? rotateAngle,
    BorderSide? tooltipBorder,
  })  : tooltipBgColor = tooltipBgColor ?? Colors.blueGrey.darken(15),
        tooltipRoundedRadius = tooltipRoundedRadius ?? 4,
        tooltipPadding = tooltipPadding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        tooltipMargin = tooltipMargin ?? 16,
        tooltipHorizontalAlignment =
            tooltipHorizontalAlignment ?? FLHorizontalAlignment.center,
        tooltipHorizontalOffset = tooltipHorizontalOffset ?? 0,
        maxContentWidth = maxContentWidth ?? 120,
        getTooltipItems = getTooltipItems ?? defaultLineTooltipItem,
        fitInsideHorizontally = fitInsideHorizontally ?? false,
        fitInsideVertically = fitInsideVertically ?? false,
        showOnTopOfTheChartBoxArea = showOnTopOfTheChartBoxArea ?? false,
        rotateAngle = rotateAngle ?? 0.0,
        tooltipBorder = tooltipBorder ?? BorderSide.none,
        super();

  final Color tooltipBgColor;

  final double tooltipRoundedRadius;

  final EdgeInsets tooltipPadding;

  final double tooltipMargin;

  final FLHorizontalAlignment tooltipHorizontalAlignment;

  final double tooltipHorizontalOffset;

  final double maxContentWidth;

  final GetLineTooltipItems getTooltipItems;

  final bool fitInsideHorizontally;

  final bool fitInsideVertically;

  final bool showOnTopOfTheChartBoxArea;

  final double rotateAngle;

  final BorderSide tooltipBorder;

  @override
  List<Object?> get props => [
        tooltipBgColor,
        tooltipRoundedRadius,
        tooltipPadding,
        tooltipMargin,
        tooltipHorizontalAlignment,
        tooltipHorizontalOffset,
        maxContentWidth,
        getTooltipItems,
        fitInsideHorizontally,
        fitInsideVertically,
        showOnTopOfTheChartBoxArea,
        rotateAngle,
        tooltipBorder,
      ];
}

typedef GetLineTooltipItems = List<LineTooltipItem?> Function(
  List<LineBarSpot> touchedSpots,
);

List<LineTooltipItem> defaultLineTooltipItem(List<LineBarSpot> touchedSpots) {
  return touchedSpots.map((LineBarSpot touchedSpot) {
    final textStyle = TextStyle(
      color: touchedSpot.bar.gradient?.colors.first ??
          touchedSpot.bar.color ??
          Colors.blueGrey,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    return LineTooltipItem(touchedSpot.y.toString(), textStyle);
  }).toList();
}

class LineBarSpot extends AFlSpot with EquatableMixin {
  LineBarSpot(
    this.bar,
    this.barIndex,
    AFlSpot spot,
  )   : spotIndex = bar.spots.indexOf(spot),
        super(spot.x, spot.y);

  final LineChartBarData bar;

  final int barIndex;

  final int spotIndex;

  @override
  List<Object?> get props => [
        bar,
        barIndex,
        spotIndex,
        x,
        y,
      ];
}

class TouchLineBarSpot extends LineBarSpot {
  TouchLineBarSpot(
    super.bar,
    super.barIndex,
    super.spot,
    this.distance,
  );

  final double distance;
}

class LineTooltipItem with EquatableMixin {
  LineTooltipItem(
    this.text,
    this.textStyle, {
    this.textAlign = TextAlign.center,
    this.textDirection = TextDirection.ltr,
    this.children,
  });

  final String text;

  final TextStyle textStyle;

  final TextAlign textAlign;

  final TextDirection textDirection;

  final List<TextSpan>? children;

  @override
  List<Object?> get props => [
        text,
        textStyle,
        textAlign,
        textDirection,
        children,
      ];
}

class TouchedSpotIndicatorData with EquatableMixin {
  TouchedSpotIndicatorData(this.indicatorBelowLine, this.touchedSpotDotData);

  final AFlLine indicatorBelowLine;

  final FlDotData touchedSpotDotData;

  @override
  List<Object?> get props => [
        indicatorBelowLine,
        touchedSpotDotData,
      ];
}

class ShowingTooltipIndicators with EquatableMixin {
  ShowingTooltipIndicators(this.showingSpots);

  final List<LineBarSpot> showingSpots;

  @override
  List<Object?> get props => [showingSpots];
}

class LineTouchResponse extends BaseTouchResponse {
  LineTouchResponse(this.lineBarSpots) : super();

  final List<TouchLineBarSpot>? lineBarSpots;

  LineTouchResponse copyWith({
    List<TouchLineBarSpot>? lineBarSpots,
  }) {
    return LineTouchResponse(
      lineBarSpots ?? this.lineBarSpots,
    );
  }
}

class LineChartDataTween extends Tween<LineChartData> {
  LineChartDataTween({required LineChartData begin, required LineChartData end})
      : super(begin: begin, end: end);

  @override
  LineChartData lerp(double t) => begin!.lerp(begin!, end!, t);
}
