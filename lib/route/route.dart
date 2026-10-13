import 'package:flutter/cupertino.dart';
import 'package:moneyflow/pages/Home/home.dart';
import 'package:moneyflow/pages/settings/about_screen.dart';
import 'package:moneyflow/pages/budget/budget_screen.dart';
import 'package:moneyflow/pages/intro/intro_screen.dart';
import 'package:moneyflow/pages/report/report_screen.dart';
import 'package:moneyflow/pages/settings/currency_screen.dart';
import 'package:moneyflow/pages/settings/export_data.dart';
import 'package:moneyflow/pages/settings/language_screen.dart';
import 'package:moneyflow/pages/settings/notification_screen.dart';
import 'package:moneyflow/pages/settings/setting.dart';
import 'package:moneyflow/pages/splash/splash_screen.dart';
import 'package:moneyflow/pages/transaction/add_transaction.dart';
import 'package:moneyflow/pages/transaction/detail_transaction.dart';
import 'package:moneyflow/pages/transaction/transaction_screen.dart';
import 'package:moneyflow/pages/username/showDialog.dart';

class AppRoute {
  static const home = '/';
  static const splash = '/splash';
  static const intro = '/intro';
  static const username = '/username';
  static const transaction = '/transaction';
  static const addtransaction = '/addtransaction';
  static const transactiondetail = 'transactionDetail';
  static const budget = '/budget';
  static const report = '/report';
  static const setting = '/setting';
  static const language = '/language';
  static const currency = '/currency';
  static const export = '/export';
  static const notification = '/notification';
  static const about = '/about';

  static Map<String, WidgetBuilder> routes = {
    username: (_) => Showdialog(),
    intro: (_) => IntroScreen(),
    splash: (_) => SplashScreen(),
    home: (_) => Home(),
    transaction: (_) => TransactionScreen(),
    budget: (_) => BudgetScreen(),
    report: (_) => ReportScreen(),
    setting: (_) => Setting(),
    addtransaction: (_) => AddTransaction(),
    transactiondetail: (_) => TransactionDetail(),
    about: (_) => AboutScreen(),
    export: (context) => ExportData(),
    notification: (context) => NotificationScreen(),
    language: (context) => LanguageScreen(),
    currency: (context) => CurrencyScreen(),
  };
}
