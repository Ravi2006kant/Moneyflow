import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneyflow/components/expensePieChart.dart';
import 'package:moneyflow/database/dbHelper.dart';
import 'package:provider/provider.dart';

import '../../provider/transactionProvider.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

double getAmount(Map<String, Object?> transaction) {
  final amount = transaction['amount'];

  if (amount is num) {
    return amount.toDouble();
  }

  return double.tryParse(amount?.toString() ?? '') ?? 0.0;
}

double calculateTotal(
  List<Map<String, Object?>> transactions,
  String targetType,
) {
  return transactions.fold<double>(0.0, (total, transaction) {
    final type = (transaction['type'] ?? '').toString().toLowerCase();

    final isTargetType = targetType == 'income'
        ? type == 'income'
        : type == 'expense' || type == 'expenses';

    return isTargetType ? total + getAmount(transaction) : total;
  });
}

class _ReportScreenState extends State<ReportScreen> {
  DateTime selectedMonth = DateTime.now();

  String get monthKey => DateFormat('yyyy-MM').format(selectedMonth);
Future<List<Map<String,dynamic>>> fetchBreakdown() async{
  final result = await Dbhelper.getInstance().getTransactionsByCategories();
  print(result);
 return result;

}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransactionProvider>();

    // Filter transactions to the selected month.
    final transactions = provider.transactions.where((transaction) {
      final rawDate = transaction['date'];

      if (rawDate == null) return false;

      DateTime? transactionDate;

      try {
        transactionDate = DateTime.parse(rawDate.toString());
      } catch (_) {
        return false;
      }

      return transactionDate.year == selectedMonth.year &&
          transactionDate.month == selectedMonth.month;
    }).toList();

    final income = calculateTotal(transactions, 'income');
    final expenses = calculateTotal(transactions, 'expense');
    final totalBalance = income - expenses;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reports',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Month selector
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      selectedMonth = DateTime(
                        selectedMonth.year,
                        selectedMonth.month - 1,
                      );
                    });
                  },
                  icon: const Icon(Icons.chevron_left),
                ),
                Text(
                  DateFormat('MMMM yyyy').format(selectedMonth),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Prevent selecting a future month.
                    final currentMonth = DateTime.now();

                    if (selectedMonth.year < currentMonth.year ||
                        (selectedMonth.year == currentMonth.year &&
                            selectedMonth.month < currentMonth.month)) {
                      setState(() {
                        selectedMonth = DateTime(
                          selectedMonth.year,
                          selectedMonth.month + 1,
                        );
                      });
                    }
                  },
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),

            // Financial summary
            Container(
              height: 120,
              width: 300,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Net Saving'),
                  const SizedBox(height: 6),
                  Text(
                    NumberFormat.currency(
                      locale: 'en_IN',
                      symbol: '₹',
                      decimalDigits: 2,
                    ).format(totalBalance),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Income: ₹${income.toStringAsFixed(2)}'),
                      Text('Expense: ₹${expenses.toStringAsFixed(2)}'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Expense breakdown
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Expense Breakdown',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  // This widget must use the selected month's data
                  // if it is expected to update with the selector.
                  ExpensePieChart(
                    month: monthKey,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Padding(
              padding: EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Monthly Trend Bar Charts',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final db = Dbhelper.getInstance();
          fetchBreakdown();

          final incomeTotal = await db.getTotalByMonth('income', monthKey);

          final expenseTotal = await db.getTotalByMonth('expense', monthKey);
        },
        child: const Icon(Icons.calculate),
      ),
    );
  }
}
