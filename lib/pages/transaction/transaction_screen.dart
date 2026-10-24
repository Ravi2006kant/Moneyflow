import 'package:flutter/material.dart';
import 'package:moneyflow/provider/transactionProvider.dart';
import 'package:moneyflow/route/route.dart';
import 'package:provider/provider.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  void initState() {
    super.initState();

    context.read<TransactionProvider>().loadTransactions();
  }

  Widget buildTransactionList(
    List<Map<String, Object?>> transactions,
    String filter,
  ) {
    final filteredTransactions = transactions.where((transaction) {
      final type = (transaction['type'] ?? '').toString().toLowerCase();

      if (filter == 'income') {
        return type == 'income';
      }

      if (filter == 'expense') {
        return type == 'expense' || type == 'expenses';
      }

      return true;
    }).toList();

    if (filteredTransactions.isEmpty) {
      return const Center(child: Text('No transactions found'));
    }

    return ListView.builder(
      itemCount: filteredTransactions.length,
      itemBuilder: (context, index) {
        final transaction = filteredTransactions[index];

        final title = (transaction['notes'] ?? 'Transaction').toString();

        final category = (transaction['category'] ?? 'Other').toString();

        final amount = transaction['amount'] ?? 0;

        final type = (transaction['type'] ?? '').toString().toLowerCase();

        final isIncome = type == 'income';

        final date = (transaction['date'] ?? '').toString();

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: isIncome
                  ? Colors.green.withValues(alpha: 0.12)
                  : Colors.red.withValues(alpha: 0.12),
              child: Icon(
                isIncome ? Icons.arrow_upward : Icons.arrow_downward,
                color: isIncome ? Colors.green : Colors.red,
              ),
            ),
            title: Text(
              title == "" ? "Transaction" : title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(date.isEmpty ? category : '$category • $date'),
            trailing: Text(
              '${isIncome ? '+' : '-'}₹$amount',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: isIncome ? Colors.green : Colors.red,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransactionProvider>();
    final transactions = provider.transactions;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Transactions',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.filter_alt_outlined),
            ),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.green,
            labelColor: Colors.green,
            labelStyle: TextStyle(fontWeight: .bold, fontSize: 17),
            unselectedLabelStyle: TextStyle(fontWeight: .w500, fontSize: 15),
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Income'),
              Tab(text: 'Expenses'),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  buildTransactionList(transactions, 'all'),
                  buildTransactionList(transactions, 'income'),
                  buildTransactionList(transactions, 'expense'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
