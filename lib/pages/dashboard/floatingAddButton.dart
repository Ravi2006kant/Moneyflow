import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/transactionProvider.dart';
import '../../route/route.dart';

class Floatingaddbutton extends StatelessWidget {
  const Floatingaddbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(elevation: 0,foregroundColor: Colors.white,backgroundColor: Colors.green,onPressed: () {

      Navigator.pushNamed(
        context,
        AppRoute.addtransaction,
      ).then((_) {
        if (!context.mounted) return;

        context.read<TransactionProvider>().loadTransactions();
      });
    },child: Icon(Icons.add),

    );
  }
}
