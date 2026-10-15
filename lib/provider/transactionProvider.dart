import 'package:flutter/cupertino.dart';
import 'package:moneyflow/database/dbHelper.dart';

class TransactionProvider extends ChangeNotifier {
  List<Map<String, Object?>> transactions = [];

  Future<void> loadTransactions() async {
    transactions = await Dbhelper.getInstance().viewAllNotes();
   print("provider");
    print( transactions);
    notifyListeners();
  }
}