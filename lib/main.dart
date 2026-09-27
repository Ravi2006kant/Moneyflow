import 'package:flutter/material.dart';
import 'package:moneyflow/app.dart';
import 'package:moneyflow/pages/local_storage.dart';
import 'package:moneyflow/provider/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const App(),
    ),
  );
}
