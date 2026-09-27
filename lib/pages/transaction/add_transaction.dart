import 'package:flutter/material.dart';
import 'package:moneyflow/route/route.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Transaction", style: TextStyle(fontWeight: .bold)),
      ),
      body: Column(
        children: [
          Row(
            children: [
              // Expanded(
              //   child: TabBar(
              //     tabs: [
              //       Tab(text: "income"),
              //       Tab(text: "expense"),
              //     ],
              //   ),
              // ),

              // SegmentedButton(
              //   segments: [
              //     ButtonSegment(value: 'income', label: Text("Income")),
              //     ButtonSegment(value: 'expense', label: Text("Expense")),
              //   ],
              //   selected: {TextSelectionHandleType.collapsed},
              //   onSelectionChanged: (value) {
              //     // setState(() {
              //     //   selectedType = value.first;
              //     // });
              //   },
              // ),
            ],
          ),
          Text("Balance", style: TextStyle(fontSize: 25)),
          TextField(
            keyboardType: .name,
            decoration: InputDecoration(hintText: "Category"),
          ),

          TextField(
            keyboardType: .name,
            decoration: InputDecoration(hintText: "Note"),
          ),
          // GridView.builder(
          //   itemCount: 3,
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 3,
          //   ),
          //   itemBuilder: (context, index) {
          //     return Container();
          //   },
          // ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.green),
            ),
            onPressed: () {
              Navigator.pushNamed(context, AppRoute.transactiondetail);
            },
            child: Text(
              "Save Transaction",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
