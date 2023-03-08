import 'package:animated_fl_chart/animated_fl_chart.dart';
import 'package:flutter/widgets.dart';

extension FlBorderDataExtension on AFlBorderData {
  EdgeInsets get allSidesPadding {
    return EdgeInsets.only(
      left: show ? border.left.width : 0.0,
      top: show ? border.top.width : 0.0,
      right: show ? border.right.width : 0.0,
      bottom: show ? border.bottom.width : 0.0,
    );
  }
}
