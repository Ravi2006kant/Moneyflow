import 'package:flutter/material.dart';
import 'package:moneyflow/database/dbHelper.dart';
import 'package:moneyflow/pages/transaction/detail_transaction.dart';
import 'package:moneyflow/provider/transactionProvider.dart';
import 'package:provider/provider.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});
  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final balancein = TextEditingController();
  final notesCont = TextEditingController();
  final categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<DateTime?> datenow ;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Transaction", style: TextStyle(fontWeight: .bold)),
      ),
      body: SafeArea(
        child: Column(
          children: [
        
        
            TextField(
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
                border: OutlineInputBorder(borderSide: .none),
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

            SizedBox(height: 50),
            Row(
              mainAxisAlignment: .spaceEvenly,
              children: [
                ElevatedButton(
                  style: ButtonStyle(fixedSize: WidgetStatePropertyAll(Size.fromWidth(130)),
                    backgroundColor: WidgetStatePropertyAll(Colors.green),
                  ),
                  onPressed: () {
                    if(  balancein.text == "" || balancein.text.toString() == "0"){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Please enter amount") ));
                    }else{
                      Dbhelper.getInstance().addNote(note: notesCont.text,category: categoryController.text,amount: balancein.text, type: "Income");

                      Navigator.push(context, MaterialPageRoute(builder: (context) =>TransactionDetail(newid: 23,note: notesCont.text,category: categoryController.text,amount: balancein.text,)));
                    }
                  },
                  child: Text("Income", style: TextStyle(color: Colors.white,fontWeight: .bold)),
                ),
        
               ElevatedButton(
                  style: ButtonStyle(fixedSize: WidgetStatePropertyAll(Size.fromWidth(130)),
                    backgroundColor: WidgetStatePropertyAll(Colors.red),
                  ),
                  onPressed: () {
if(  balancein.text == "" || balancein.text.toString() == "0"){
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Please enter amount") ));
}else {
  Dbhelper.getInstance().addNote(note: notesCont.text,
      category: categoryController.text,
      amount: balancein.text,
      type: "Expense");
  Navigator.push(
      context, MaterialPageRoute(builder: (context) =>
      TransactionDetail(
        newid: 35,
    note: notesCont.text,
    category: categoryController.text,
    amount: balancein.text,)));
} },
                  child: Text("Expense", style: TextStyle(color: Colors.white,fontWeight: .bold)),
                ),
              ],),
            // ElevatedButton(
            //   style: ButtonStyle(fixedSize: WidgetStatePropertyAll(Size.fromWidth(130)),
            //     backgroundColor: WidgetStatePropertyAll(Colors.yellow),
            //   ),
            //   onPressed: () {
            //
            //     Dbhelper.getInstance().viewAllNotes();
            //     context.read<TransactionProvider>().loadTransactions();
            //   },
            //   child: Text("view", style: TextStyle(color: Colors.white,fontWeight: .bold)),
            // ),
          ],
        ),
      ),
    );
  }
}
