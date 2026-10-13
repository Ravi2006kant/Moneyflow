import 'package:flutter/material.dart';

class TransactionDetail extends StatefulWidget {
  const TransactionDetail({super.key});

  @override
  State<TransactionDetail> createState() => _TransactionDetailState();
}

class _TransactionDetailState extends State<TransactionDetail> {
  final balancein = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<DateTime?> datenow;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Transaction Detail", style: TextStyle(fontWeight: .bold)),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: .center,
            children: [
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
