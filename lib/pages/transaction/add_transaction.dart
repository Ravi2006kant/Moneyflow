import 'package:flutter/material.dart';
import 'package:moneyflow/database/dbHelper.dart';
import 'package:moneyflow/pages/transaction/detail_transaction.dart';


class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});
  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final balancein = TextEditingController();
  final notesCont = TextEditingController();
  final categoryController = TextEditingController();
  var selectedCategory;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    balancein.dispose();
    notesCont.dispose();
    categoryController.dispose();

  }

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
  //
  // Future<void> dialog() async {
  //   await showDialog(
  //     barrierDismissible: true,
  //
  //     context: context,
  //     builder: (context) {
  //       return PopScope(canPop: false, child: Amountbox());
  //     },
  //   );
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) => dialog());
  // }
  DateTime? selectedDate;
  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(

      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
    );

    setState(() {
      selectedDate = pickedDate;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Transaction", style: TextStyle(fontWeight: .bold)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            SizedBox(
              width: 250,
              child: TextField(
                controller: balancein,
                keyboardType: .number,
                autocorrect: true,
                showCursor: true,

                cursorColor: Colors.green,
                textAlign: .center,
                obscureText: false,
                style: TextStyle(fontSize: 25),
                decoration: InputDecoration(
                  hintText: "\₹ 0",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),

                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.green,width: 3),
                  ),
                ),
              ),
            ),

            TextField(
              controller: notesCont,
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
              controller: categoryController,
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
                hintText: selectedDate != null
                    ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                    : 'No date selected',
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_month_outlined),

                  onPressed: () {
                    _selectDate();
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
            SizedBox(height: 10,),
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
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: .spaceEvenly,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    fixedSize: WidgetStatePropertyAll(Size.fromWidth(130)),
                    backgroundColor: WidgetStatePropertyAll(Colors.green),
                  ),
                  onPressed: () {
                    if (balancein.text == "" ||
                        balancein.text.toString() == "0") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please enter amount")),
                      );
                    } else {
                      Dbhelper.getInstance().addNote(
                        note: notesCont.text,
                        category: categoryController.text,
                        amount: balancein.text,
                        type: "Income",
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TransactionDetail(
                            newid: 23,
                            note: notesCont.text,
                            category: categoryController.text,
                            amount: balancein.text,
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(
                    "Income",
                    style: TextStyle(color: Colors.white, fontWeight: .bold),
                  ),
                ),

                ElevatedButton(
                  style: ButtonStyle(
                    fixedSize: WidgetStatePropertyAll(Size.fromWidth(130)),
                    backgroundColor: WidgetStatePropertyAll(Colors.red),
                  ),
                  onPressed: () {
                    if (balancein.text == "" ||
                        balancein.text.toString() == "0") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please enter amount")),
                      );
                    } else {
                      Dbhelper.getInstance().addNote(
                        note: notesCont.text,
                        category: categoryController.text,
                        amount: balancein.text,
                        type: "Expense",
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TransactionDetail(
                            newid: 35,
                            note: notesCont.text,
                            category: categoryController.text,
                            amount: balancein.text,
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(
                    "Expense",
                    style: TextStyle(color: Colors.white, fontWeight: .bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
