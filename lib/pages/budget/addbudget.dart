import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:moneyflow/database/dbHelper.dart';
import 'package:moneyflow/pages/transaction/detail_transaction.dart';

//content at last

class Addbudget extends StatefulWidget {
  const Addbudget({super.key});
  @override
  State<Addbudget> createState() => _AddBudget();
}

List<String> month = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

class _AddBudget extends State<Addbudget> {
  int selectedAlert = 80;

  final budgetname = TextEditingController();
  final spendlimit = TextEditingController();
  var selectedCategory;
  final categoryController = TextEditingController();
  final List<Map<String, dynamic>> categories = [
    {
      'name': 'Food',
      'backgroundColor': const Color(0xFFFFF0E6),
      'iconColor': const Color(0xFFE87532),
      'icon': Icons.restaurant,
    },
    {
      "name": "Travel",
      "backgroundColor": const Color(0xFFE6F2FF),
      "iconColor": const Color(0xFF2878C8),
      'icon': Icons.flight,
    },
    {
      "name": "Salary",
      "backgroundColor": const Color(0xFFE3F8EB),
      "iconColor": const Color(0xFF218653),
      'icon': Icons.account_balance_wallet_rounded,
    },
    {
      "name": "Shopping",
      "backgroundColor": const Color(0xFFF1E8FF),
      "iconColor": const Color(0xFF8050C8),
      'icon': Icons.shopping_bag,
    },
    {
      "name": "Bills",
      "backgroundColor": const Color(0xFFFDE8EB),
      "iconColor": const Color(0xFFD6455D),
      'icon': Icons.receipt_long,
    },
    {
      "name": "Others",
      "backgroundColor": const Color(0xFFE7EDF2),
      "iconColor": const Color(0xFF526579),
      'icon': Icons.category,
    },
  ];

  String dropdownValue = month.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Budget", style: TextStyle(fontWeight: .bold)),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.wallet, color: Colors.green),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Text(
                  "Budget Name (optional)",
                  style: TextStyle(fontWeight: .bold),
                ),
              ),

              SizedBox(
                height: 50,
                width: 390,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: budgetname,
                    keyboardType: .text,
                    autocorrect: true,
                    showCursor: true,

                    cursorColor: Colors.green,
                    textAlign: .center,
                    obscureText: false,
                    style: TextStyle(fontSize: 17,fontWeight: .bold),
                    decoration: InputDecoration(
                      hintText: "Monthly Budget Name",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(borderSide: .none),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10, top: 5),
                child: Text(
                  "Select Category",
                  style: TextStyle(fontWeight: .bold),
                ),
              ),

              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 6,
                padding: EdgeInsets.symmetric(horizontal: 5),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.3,
                  crossAxisCount: 3,
                ),
                itemBuilder: ((context, index) {
                  final category = categories[index];
                  return InkWell(
                    onTap: () {
                      selectedCategory = category['name'];
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: category['backgroundColor'],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Column(
                        mainAxisAlignment: .center,
                        children: [
                          Icon(
                            category['icon'] as IconData,
                            size: 35,
                            color: category['iconColor'],
                          ),
                          SizedBox(height: 5),
                          Center(
                            child: Text(
                              category['name'] as String,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                                fontWeight: .bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Text(
                  "Monthly Spending Limit",
                  style: TextStyle(fontWeight: .bold),
                ),
              ),

              SizedBox(
                height: 50,
                width: 390,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: spendlimit,
                    keyboardType: .text,
                    autocorrect: true,
                    showCursor: true,

                    cursorColor: Colors.green,
                    textAlign: .center,
                    obscureText: false,
                    style: TextStyle(fontSize: 17,fontWeight: .bold),
                    decoration: InputDecoration(
                      hintText: "Maximum amount",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(borderSide: .none),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Text(
                  "Budget Month",
                  style: TextStyle(fontWeight: .bold),
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: dropdownValue,

                    isExpanded: true,
                    hint: const Text('Select Month'),
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    borderRadius: BorderRadius.circular(12),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.teal,
                      fontWeight: .bold,
                    ),
                    items: month.map((String month) {
                      return DropdownMenuItem<String>(
                        value: month,
                        child: Text(month),
                      );
                    }).toList(),
                    onChanged: (String? newMonth) {
                      setState(() {
                        dropdownValue = newMonth!;
                      });
                    },
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Text(
                  "Alert when budget reaches",
                  style: TextStyle(fontWeight: .bold),
                ),
              ),

              Row(
                children: [80, 90, 100].map((percent) {
                  final isSelected = selectedAlert == percent;

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ChoiceChip(
                        label: SizedBox(
                          width: double.infinity,
                          child: Text(
                            '$percent%',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        selected: isSelected,
                        showCheckmark: false,
                        backgroundColor: Colors.grey,
                        selectedColor: Colors.green,
                        labelStyle: TextStyle(
                          color: isSelected
                              ? Theme.of(context).colorScheme.onPrimary
                              : Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: Colors.white),
                        ),
                        onSelected: (selected) {
                          setState(() {
                            selectedAlert = percent;
                          });
                        },
                      ),
                    ),
                  );
                }).toList(),
              ),

              // Row(
              //   mainAxisAlignment: .spaceEvenly,
              //   children: [
              //     ChoiceChip(label: Text("Slecting"), selected: (){})
              //     // ElevatedButton(
              //     //   style: ButtonStyle(
              //     //     backgroundColor: WidgetStatePropertyAll(Colors.red),
              //     //   ),
              //     //   onPressed: () {},
              //     //   child: Text("80%"),
              //     // ),
              //     // ElevatedButton(onPressed: () {}, child: Text("90%")),
              //     // ElevatedButton(onPressed: () {}, child: Text("100%")),
              //   ],
              // ),
              SizedBox(height: 15),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.green),
                  ),
                  onPressed: () async {
                    final name = budgetname.text.trim();
                    final category = selectedCategory;
                    final limit = double.tryParse(spendlimit.text.trim());
                    await Dbhelper.getInstance().fetchBudget();
                    if (category == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select a category'),
                        ),
                      );
                      return;
                    }

                    if (limit == null || limit <= 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Enter a valid budget amount'),
                        ),
                      );
                      return;
                    }

                    await Dbhelper.getInstance().addbudget(
                      selectedAlert,
                      budgetName: name.isEmpty ? 'BUDGET' : name,
                      category: category,
                      spendingLimit: limit,
                      month: dropdownValue,
                    );

                    if (!mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.green,

// shape: BoxBorder.fromBorderSide(BorderSide(style: .solid)),
                        content: Text(
                          'Budget saved successfully',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: .bold,
                          ),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Save Budget",
                    style: TextStyle(color: Colors.white, fontWeight: .bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
first dont lets give space in the string waste space cause it will cause error is particular widget adn things

shrink wrap is let you occupt only the space which is needed

flexibke is not forcing to cover the whole screen while expanded force to cover the whole screen

choice chip for selecting buttons from several options


*/
