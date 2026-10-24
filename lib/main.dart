import 'package:flutter/material.dart';
import 'package:moneyflow/app.dart';
import 'package:moneyflow/pages/local_storage.dart';
import 'package:moneyflow/provider/budgetprovider.dart';
import 'package:moneyflow/provider/theme_provider.dart';
import 'package:moneyflow/provider/transactionProvider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  final savedTheme = await LocalStorage.getDarkMode();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(initialTheme: savedTheme),
        ),
        ChangeNotifierProvider(create: (_) => TransactionProvider()),
        ChangeNotifierProvider(create: (_)=>BudgetProvider())
      ],
      child: const App(),
    ),
  );
}
