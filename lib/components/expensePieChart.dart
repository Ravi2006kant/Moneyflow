import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneyflow/database/dbHelper.dart';

class ExpensePieChart extends StatelessWidget {
  final String month;

  ExpensePieChart({
    super.key,
    required this.month,
  });

  static const Map<String, Color> categoryColors = {
    'food': Colors.green,
    'travel': Colors.blue,
    'shopping': Colors.orange,
    'bills': Colors.purple,
    'other': Colors.grey,
  };

  static const Map<String, IconData> categoryIcons = {
    'food': Icons.restaurant,
    'travel': Icons.directions_bus,
    'shopping': Icons.shopping_bag,
    'bills': Icons.receipt_long,
    'other': Icons.category,
  };

  final NumberFormat currencyFormat = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 2,
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, double>>(
      future: Dbhelper
          .getInstance()
          .getExpenseCategoryTotalsByMonth(month),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 220,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Unable to load expense breakdown.'),
          );
        }

        final categoryTotals = snapshot.data ??
            <String, double>{};

        final totalExpenses = categoryTotals.values.fold<double>(
          0.0,
              (total, amount) => total + amount,
        );

        if (totalExpenses <= 0) {
          return const SizedBox(
            height: 220,
            child: Center(
              child: Text(
                'No expenses recorded this month.',
              ),
            ),
          );
        }

        final entries = categoryTotals.entries
            .where((entry) => entry.value > 0)
            .toList();

        final sections = entries.map((entry) {
          final percentage =
              (entry.value / totalExpenses) * 100;

          return PieChartSectionData(
            value: entry.value,
            title: '${percentage.toStringAsFixed(1)}%',
            color: categoryColors[entry.key] ?? Colors.grey,
            radius: 55,
            titleStyle: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          );
        }).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                height: 220,
                child: PieChart(
                  PieChartData(
                    sections: sections,
                    sectionsSpace: 3,
                    centerSpaceRadius: 35,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Text(
              'Total Expenses: '
                  '${currencyFormat.format(totalExpenses)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            ...categoryTotals.entries.map((entry) {
              final category = entry.key;
              final amount = entry.value;

              final percentage = totalExpenses > 0
                  ? (amount / totalExpenses) * 100
                  : 0.0;

              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Icon(
                      categoryIcons[category] ??
                          Icons.category,
                      color: categoryColors[category],
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: Text(
                        category[0].toUpperCase() +
                            category.substring(1),
                      ),
                    ),

                    Text(
                      currencyFormat.format(amount),
                    ),

                    const SizedBox(width: 12),

                    SizedBox(
                      width: 60,
                      child: Text(
                        '${percentage.toStringAsFixed(1)}%',
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        );
      },
    );
  }
}