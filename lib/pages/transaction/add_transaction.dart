import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:moneyflow/pages/balance/balance.dart';
import 'package:moneyflow/route/route.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final balancein = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<DateTime?> datenow;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Transaction", style: TextStyle(fontWeight: .bold)),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: .center,
            children: [
              // Expanded(
              //   child: TabBar(
              //     tabs: [
              //       Tab(text: "income"),
              //       Tab(text: "expense"),
              //     ],
              //   ),
              // ),
              SegmentedButton(
                multiSelectionEnabled: true,
                showSelectedIcon: true,
                segments: [
                  ButtonSegment(
                    value: 'income',
                    label: Text("Income"),
                    enabled: true,
                  ),
                  ButtonSegment(value: 'expense', label: Text("Expense")),
                ],
                selected: {TextSelectionHandleType.collapsed},
                onSelectionChanged: (value) {
                  // setState(() {
                  //   selectedType = value.first;
                  // });
                },
              ),
            ],
          ),
          SizedBox(height: 10),

          TextField(
            controller: balancein,
            keyboardType: .number,
            autocorrect: true,
            cursorColor: Colors.green,
            textAlign: .center,
            obscureText: false,
            style: TextStyle(fontSize: 25),
            decoration: InputDecoration(
              hintText: "\$ 0",
              border: OutlineInputBorder(borderSide: .none),
            ),
          ),

          TextField(
            keyboardType: .name,
            autocorrect: true,
            obscureText: false,

            decoration: InputDecoration(
              hintText: "Note",

              border: OutlineInputBorder(borderSide: .none, gapPadding: 0),
              // border: OutlineInputBorder(
              //   borderSide: BorderSide(
              //     strokeAlign: BorderSide.strokeAlignOutside,
              //   ),
              // ),
            ),
          ),
          Divider(
            height: 1,
            indent: 10,
            endIndent: 10,
            color: Theme.of(context).colorScheme.primary,
          ),
          TextField(
            keyboardType: .name,
            decoration: InputDecoration(
              hintText: "Category",

              border: OutlineInputBorder(borderSide: .none, gapPadding: 0),
            ),
          ),
          Divider(
            height: 1,
            indent: 10,
            endIndent: 10,
            color: Theme.of(context).colorScheme.primary,
          ),

          TextField(
            keyboardType: .name,
            decoration: InputDecoration(
              hintText: "Date",
              suffixIcon: IconButton(
                icon: Icon(Icons.calendar_month_outlined),
                onPressed: () {
                  datenow = showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now(),
                  );
                },
              ),

              border: OutlineInputBorder(borderSide: .none, gapPadding: 0),
            ),
          ),
          Divider(
            height: 1,
            indent: 10,
            endIndent: 10,
            color: Theme.of(context).colorScheme.primary,
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
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: .spaceEvenly,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.green),
                ),
                onPressed: () {
                  Balance.addIncome(int.parse(balancein.text));

                  Navigator.pushNamed(context, AppRoute.transactiondetail);
                },
                child: Text("Income", style: TextStyle(color: Colors.white)),
              ),

              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.red),
                ),
                onPressed: () {
                  Balance.addExpense(int.parse(balancein.text));

                  Navigator.pushNamed(context, AppRoute.transactiondetail);
                },
                child: Text("Expense", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
