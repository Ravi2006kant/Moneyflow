
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ExpensePieChart extends StatelessWidget {
  const ExpensePieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: PieChart(
        PieChartData(
          sectionsSpace: 3,
          centerSpaceRadius: 35,
          sections: [
            PieChartSectionData(
              value: 40,
              title: '40%',
              color: Colors.green,
              radius: 50,
            ),
            PieChartSectionData(
              value: 30,
              title: '30%',
              color: Colors.orange,
              radius: 50,
            ),
            PieChartSectionData(
              value: 20,
              title: '20%',
              color: Colors.blue,
              radius: 50,
            ),
            PieChartSectionData(
              value: 10,
              title: '10%',
              color: Colors.grey,
              radius: 50,
            ),
          ],
        ),
      ),
    );
  }
}
