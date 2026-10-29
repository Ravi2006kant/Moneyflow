import 'package:flutter/material.dart';
import 'package:moneyflow/pages/dashboard/floatingAddButton.dart';
import 'package:moneyflow/pages/local_storage.dart';
import 'package:moneyflow/provider/transactionProvider.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? username;
  static const String currencySymbol = '₹';

  @override
  void initState() {
    super.initState();
    context.read<TransactionProvider>().loadTransactions();
    user();
  }

  void user() {
   final name  = LocalStorage.prefs.getString('userName');
    setState(() {
      username = name ?? 'User';
    });
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
      final type = (transaction['type'] ?? '')
          .toString()
          .toLowerCase();

      final isTargetType = targetType == 'income'
          ? type == 'income'
          : type == 'expense' || type == 'expenses';

      return isTargetType ? total + getAmount(transaction) : total;
    });
  }

  String formatAmount(double amount) {
    return amount.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransactionProvider>();
    final transactions = provider.transactions;
    final income = calculateTotal(transactions, 'income');
    final expenses = calculateTotal(transactions, 'expense');
    final totalBalance = income - expenses;

    // Show the five most recent transactions.
    final recentTransactions = transactions.take(10).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(
          'Good Morning, ${username ?? '...'}',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(
        //       Icons.notifications,
        //       color: Colors.white,
        //     ),
        //     onPressed: () {},
        //   ),
        // ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Total balance card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF134E4A),
                    Color(0xFF0F766E),
                    Color(0xFF2DD4BF),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Balance',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.refresh_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          await context
                              .read<TransactionProvider>()
                              .loadTransactions();
                        },
                      ),
                    ],
                  ),
                  Text(
                    '$currencySymbol ${formatAmount(totalBalance)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // Income and expense cards
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 15,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                       gradient: LinearGradient(colors:[
                         Color(0xFF0B7559),
                         Color(0xFF0FAA80),
                         Color(0xFF10B981),
                       ]),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Income',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '$currencySymbol ${formatAmount(income)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color(0xFFA72525),
                        Color(0xFFE61F1F),
                        Color(0xFFEF4444),]),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Expense',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '$currencySymbol ${formatAmount(expenses)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Recent transactions heading
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: Text(
                'Recent Transactions',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),

            // Recent transactions list
            Expanded(
              child: recentTransactions.isEmpty
                  ? const Center(
                child: Text('No transactions yet'),
              )
                  : ListView.builder(
                itemCount: recentTransactions.length,
                itemBuilder: (context, index) {
                  final transaction =
                  recentTransactions[index];

                  final title =
                  (transaction['notes'] ?? 'Transaction')
                      .toString();

                  final category =
                  (transaction['category'] ?? 'Other')
                      .toString();

                  final type =
                  (transaction['type'] ?? '')
                      .toString()
                      .toLowerCase();

                  final isIncome = type == 'income';
                  final amount = getAmount(transaction);

                  final date =
                  (transaction['date'] ?? '').toString();

                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 4,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: isIncome
                            ? Colors.green.withValues(alpha: 0.12)
                            : Colors.red.withValues(alpha: 0.12),
                        child: Icon(
                          isIncome
                              ? Icons.arrow_upward
                              : Icons.arrow_downward,
                          color: isIncome
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                      title: Text(
                        title.isEmpty ? 'Transaction' : title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        date.isEmpty
                            ? category
                            : '$category • $date',
                      ),
                      trailing: Text(
                        '${isIncome ? '+' : '-'}$currencySymbol ${formatAmount(amount)}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isIncome
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: Floatingaddbutton(),
    );
  }
}
