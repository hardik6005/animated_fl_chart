import 'package:fl_chart_app/presentation/charts/barChart/bar_chart_sample1.dart';
import 'package:fl_chart_app/presentation/charts/barChart/bar_chart_sample2.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              BarChartSample1(),
              const SizedBox(height: 10,),
              BarChartSample2(),
            ],
          ),
        ),
      ),
      appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: const Text("Bar Chart"),
            ),
    );
  }
}
