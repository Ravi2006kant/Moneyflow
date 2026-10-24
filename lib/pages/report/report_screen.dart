import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:moneyflow/components/expensePieChart.dart';
import 'package:moneyflow/pages/report/calculator.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reports", style: TextStyle(fontWeight: .bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ExpensePieChart()
          // DropdownButton(
          //
          //   items: [
          //     DropdownMenuItem(child: Text("month")),
          //
          //   ],
          //   onChanged: (context) {},
          // ),
        ],
      ),

    );
  }
}
