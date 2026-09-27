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
              // overlayColor: WidgetStatePropertyAll(Colors.red),//no use
              // indicator: BoxDecoration(
              //   color: Colors.red,
              //   borderRadius: BorderRadius.circular(25),
              // ),
              // automaticIndicatorColorAdjustment: true,
              tabs: [
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(25),
                  child: Tab(
                    text: "All",
                    // child: Container(
                    //   padding: EdgeInsets.symmetric(
                    //     horizontal: 15,
                    //     vertical: 5,
                    //   ),
                    //   decoration: BoxDecoration(
                    //     color: Colors.green,
                    //     borderRadius: BorderRadius.circular(25),
                    //   ),
                    //   child: Text(
                    //     "Hello",
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                  ),
                ),
                Tab(text: "Income"),
                Tab(text: "Expenses"),
              ],
            ),
          ),

          Row(
            children: [DropdownButton(items: [], onChanged: (context) {})],
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoute.addtransaction);
            },
            child: Text(
              "+ Add transaction",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
