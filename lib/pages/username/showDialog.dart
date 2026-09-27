import 'package:flutter/material.dart';
import 'package:moneyflow/pages/alertbox/alertbox.dart';

class Showdialog extends StatefulWidget {
  const Showdialog({super.key});

  @override
  State<Showdialog> createState() => _ShowdialogState();
}

class _ShowdialogState extends State<Showdialog> {
  Future<void> dialog() async {
    await showDialog(
      barrierDismissible: false,
      barrierColor: Colors.green.shade200,
      context: context,
      builder: (context) {
        return PopScope(canPop: false, child: Alertbox());
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => dialog());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
