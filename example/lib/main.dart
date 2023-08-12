import 'package:fl_chart_app/presentation/pages/home_page.dart';
import 'package:fl_chart_app/presentation/resources/app_colors.dart';
import 'package:flutter/material.dart';


import 'package:fl_chart_app/util/web/non_web_url_strategy.dart'
    if (dart.library.html) 'package:fl_chart_app/util/web/web_url_strategy.dart';

void main() {
  configureWebUrl();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Animated FL Chart",
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.pageBackground,
      ),
      home: const HomePage(),
    );
  }
}
