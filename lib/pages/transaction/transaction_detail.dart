import 'package:flutter/material.dart';

class TransactionDetail extends StatelessWidget {
  const TransactionDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Transaction Details")),
      body: Column(
        children: [
          Text(""),
          Container(color: Colors.red, child: Text("Expense")),
          TextField(),
          TextField(),
          // ListTile(
          //   leading: TextField(),
          //   trailing: Icon(Icons.calendar_month_rounded),
          // ),
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
            onPressed: () {},
            child: Text("Edit", style: TextStyle(color: Colors.white)),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.red),
            ),
            onPressed: () {},
            child: Text("Delete", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
