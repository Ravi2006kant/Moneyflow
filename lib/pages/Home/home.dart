import 'package:flutter/material.dart';
import 'package:moneyflow/components/homeBottom.dart';
import 'package:moneyflow/pages/budget/budget_screen.dart';
import 'package:moneyflow/pages/dashboard/dashboard_screen.dart';
import 'package:moneyflow/pages/report/report_screen.dart';
import 'package:moneyflow/pages/settings/setting.dart';
import 'package:moneyflow/pages/transaction/transaction_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  List<Widget> pages = [
    DashboardScreen(),
    TransactionScreen(),
    BudgetScreen(),
    ReportScreen(),
    Setting(),
  ];

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: Homebottom(
        ind: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
      ),
    );
  }
}
