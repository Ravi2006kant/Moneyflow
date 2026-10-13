import 'package:flutter/material.dart';

class TransactionDetail extends StatefulWidget {
   TransactionDetail({super.key,required this.amount,this.note,this.category});
   String amount;
   String? note;
   String? category;
   DateTime? date;

  @override
  State<TransactionDetail> createState() => _TransactionDetailState();
}

class _TransactionDetailState extends State<TransactionDetail> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Transaction Detail", style: TextStyle(fontWeight: .bold)),
      ),
      body: Column(
        children: [

          TextField(

            keyboardType: .number,
            autocorrect: true,
            cursorColor: Colors.green,
            textAlign: .center,
            obscureText: false,
            style: TextStyle(fontSize: 25),
            decoration: InputDecoration(
              hintText:"\$ ${widget.amount}",
hintStyle: TextStyle(color: Colors.white,fontWeight: .bold),
filled: false,
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
          SizedBox(height: 20,),

          Row(
            mainAxisAlignment: .spaceEvenly,
            children: [
              ElevatedButton(
                style: ButtonStyle(fixedSize: WidgetStatePropertyAll(Size.fromWidth(130)),
                  backgroundColor: WidgetStatePropertyAll(Colors.green),
                ),
                onPressed: () {

                },
                child: Text("Edit", style: TextStyle(color: Colors.white,fontWeight: .bold)),
              ),

              ElevatedButton(
                style: ButtonStyle(fixedSize: WidgetStatePropertyAll(Size.fromWidth(130)),
                  backgroundColor: WidgetStatePropertyAll(Colors.red),
                ),
                onPressed: () {

                },
                child: Text("Delete", style: TextStyle(color: Colors.white,fontWeight: .bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
