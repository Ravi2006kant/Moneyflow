import 'package:flutter/material.dart';
import 'package:moneyflow/route/route.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transactions", style: TextStyle(fontWeight: .bold)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.filter_alt_outlined)),
        ],
      ),

      body: Column(
        children: [
          DefaultTabController(
            length: 3,
            initialIndex: 0,
            child: TabBar(
              tabs: [
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(25),
                  child: Tab(
                    child: Text("All", style: TextStyle(color: Colors.green)),
                  ),
                ),
                Tab(text: "Income"),
                Tab(text: "Expenses"),
              ],
            ),
          ),

          Row(
            children: [
              DropdownButton(
                items: [DropdownMenuItem(child: Text("hel"))],
                onChanged: (context) {},
              ),
            ],
          ),

          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.green),
            ),
            onPressed: () {
              Navigator.pushNamed(context, AppRoute.addtransaction);
            },
            child: Text(
              "+ Add Transaction",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
