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
  Future<List<Map<String, dynamic>>> fetchBreakdown() async {
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


      Container(
      width: 320,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ?  Colors.grey.shade800
            : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white12
              : Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: Theme.of(context).brightness == Brightness.dark
                  ? 0.15
                  : 0.06,
            ),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Net Saving',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            NumberFormat.currency(
              locale: 'en_IN',
              symbol: '₹',
              decimalDigits: 2,
            ).format(totalBalance),
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: totalBalance >= 0
                  ? Colors.green.shade600
                  : Colors.red.shade600,
            ),
          ),

          const SizedBox(height: 10),

          Divider(
            color: Theme.of(context).dividerColor,
            height: 1,
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _buildAmountItem(
                  icon: Icons.arrow_upward_rounded,
                  label: 'Income',
                  amount: income,
                  color: Colors.green,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _buildAmountItem(
                  icon: Icons.arrow_downward_rounded,
                  label: 'Expenses',
                  amount: expenses,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    ),


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


                  // This widget must use the selected month's data
                  // if it is expected to update with the selector.
                  ExpensePieChart(month: monthKey),
                ],
              ),
            ),



            // const Padding(
            //   padding: EdgeInsets.all(16),
            //   child: Align(
            //     alignment: Alignment.centerLeft,
            //     child: Text(
            //       'Monthly Trend Bar Charts',
            //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),

    );

  }
  Widget _buildAmountItem({
    required IconData icon,
    required String label,
    required double amount,
    required Color color,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isDark ? 0.15 : 0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              NumberFormat.currency(
                locale: 'en_IN',
                symbol: '₹',
                decimalDigits: 2,
              ).format(amount),
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
