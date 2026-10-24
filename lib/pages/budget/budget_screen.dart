
import 'package:flutter/material.dart';
import 'package:moneyflow/database/dbHelper.dart';
import 'package:moneyflow/provider/budgetprovider.dart';
import 'package:provider/provider.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  late Future<double> monthBudget;

  DateTime selectedMonth = DateTime.now();

  String get monthKey =>
      '${selectedMonth.year}-${selectedMonth.month.toString().padLeft(2, '0')}';

  @override
  void initState() {
    super.initState();
    monthBudget = loadMonthlyBudget();
    context.read<BudgetProvider>().loadBudget();
  }

  Future<double> loadMonthlyBudget() {
    return Dbhelper.getInstance().getTotalBudgetForMonth(monthKey);
  }

  Future<void> refreshData() async {
    final future = loadMonthlyBudget();

    setState(() {
      monthBudget = future;
    });

    await context.read<BudgetProvider>().loadBudget();
  }

  String monthName(int month) {
    const months = [
      'January', 'February', 'March', 'April',
      'May', 'June', 'July', 'August',
      'September', 'October', 'November', 'December',
    ];

    return months[month - 1];
  }

  double toDouble(dynamic value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }

  bool isSelectedMonth(dynamic value) {
    if (value == null) return false;

    final month = value.toString().trim();

    // Supports YYYY-MM and month names such as October.
    return month == monthKey ||
        month.toLowerCase() ==
            monthName(selectedMonth.month).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final budgetData = context.watch<BudgetProvider>().budget;

    final selectedBudgets = budgetData.where((budget) {
      return isSelectedMonth(budget['month']);
    }).toList();

    // Uses a stored 'spent' value if your provider supplies one.
    // For accurate spending, this must come from monthly expense
    // transactions, not merely from the budget record.
    final spent = selectedBudgets.fold<double>(
      0,
          (sum, budget) => sum + toDouble(budget['spent']),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Budgets',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: RefreshIndicator(
        onRefresh: refreshData,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
          children: [
            // Monthly summary
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary,
                    theme.colorScheme.primary.withValues(alpha: 0.78),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month_rounded,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${monthName(selectedMonth.month)} ${selectedMonth.year}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      IconButton(
                        tooltip: 'Select month',
                        onPressed: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: selectedMonth,
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2100),
                            helpText: 'Select a month',
                          );

                          if (picked != null && mounted) {
                            setState(() {
                              selectedMonth =
                                  DateTime(picked.year, picked.month);
                              monthBudget = loadMonthlyBudget();
                            });
                          }
                        },
                        icon: const Icon(
                          Icons.edit_calendar_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  const Text(
                    'Total Budget',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 5),

                  FutureBuilder<double>(
                    future: monthBudget,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text(
                          'Unable to load budget',
                          style: TextStyle(color: Colors.white),
                        );
                      }

                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const SizedBox(
                          height: 35,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                        );
                      }

                      return Text(
                        '₹${(snapshot.data ?? 0).toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  Row(
                    children: [
                      Expanded(
                        child: _summaryItem(
                          title: 'Spent',
                          amount: spent,
                          icon: Icons.trending_down_rounded,
                        ),
                      ),
                      Container(
                        height: 48,
                        width: 1,
                        color: Colors.white30,
                      ),
                      Expanded(
                        child: FutureBuilder<double>(
                          future: monthBudget,
                          builder: (context, snapshot) {
                            final total = snapshot.data ?? 0;
                            final remaining = total - spent;

                            return _summaryItem(
                              title: 'Remaining',
                              amount: remaining,
                              icon: Icons.account_balance_wallet_outlined,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // Category budget heading
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Category Budgets',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '${selectedBudgets.length} budgets',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            if (selectedBudgets.isEmpty)
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 35,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.account_balance_wallet_outlined,
                      size: 48,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'No budgets for this month',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Create a budget to start tracking your spending.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...selectedBudgets.map((budget) {
                final category =
                    budget['category']?.toString() ?? 'Uncategorized';

                final limit = toDouble(budget['spendingLimit']);
                final categorySpent = toDouble(budget['spent']);

                final progress = limit > 0
                    ? (categorySpent / limit).clamp(0.0, 1.0)
                    : 0.0;

                final isOverBudget = categorySpent > limit && limit > 0;

                final remaining = limit - categorySpent;

                final progressColor = isOverBudget
                    ? Colors.red
                    : theme.colorScheme.primary;

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 0,
                  color: theme.colorScheme.surfaceContainerLow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: theme.colorScheme.outlineVariant,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 46,
                              width: 46,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Icon(
                                Icons.pie_chart_outline_rounded,
                                color: theme.colorScheme.onPrimaryContainer,
                              ),
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    category,
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Monthly limit',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme
                                          .colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Text(
                              '₹${limit.toStringAsFixed(0)}',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Spent ₹${categorySpent.toStringAsFixed(0)}',
                              style: theme.textTheme.bodyMedium,
                            ),
                            Text(
                              '${(progress * 100).toStringAsFixed(0)}%',
                              style: TextStyle(
                                color: progressColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 8,
                            backgroundColor:
                            theme.colorScheme.surfaceContainerHighest,
                            color: progressColor,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          isOverBudget
                              ? 'Over budget by ₹${(-remaining).toStringAsFixed(0)}'
                              : '₹${remaining.toStringAsFixed(0)} remaining',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: isOverBudget
                                ? Colors.red
                                : theme.colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.pushNamed(context, '/addbudget');

          if (!mounted) return;

          await refreshData();
        },
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add Budget'),
      ),
    );
  }

  Widget _summaryItem({
    required String title,
    required double amount,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 17, color: Colors.white70),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '₹${amount.toStringAsFixed(2)}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
