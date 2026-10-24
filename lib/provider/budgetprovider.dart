import 'package:flutter/foundation.dart';
import 'package:moneyflow/database/dbHelper.dart';

class BudgetProvider extends ChangeNotifier {
  List<Map<String, Object?>> budget = [];
  Future<void> loadBudget() async {
    budget = await Dbhelper.getInstance().fetchBudget();
    notifyListeners();
  }
}
