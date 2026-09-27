import 'package:flutter/material.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Budgets", style: TextStyle(fontWeight: .bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 150,
            margin: EdgeInsets.all(25),
            decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(25)),
            child: Column(children: [Row(children: [Text("helo")],), Row(), Row()]),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: ((context, index) {
                return ListTile(title: Text("fgh"),);
              }),
            ),
          ),
        ],
      ),
    );
  }
}
