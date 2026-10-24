import 'package:flutter/material.dart';
import 'package:moneyflow/route/route.dart';
import 'package:moneyflow/provider/theme_provider.dart';
import 'package:moneyflow/theme/theme.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Money Flow',
      routes: AppRoute.routes,
      initialRoute: AppRoute.splash,
      theme: lightmode,
      darkTheme: darkmode,
      themeMode: themeProvider.isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light,
    );
  }
}
