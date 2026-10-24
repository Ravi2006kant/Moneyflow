import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Amountbox extends StatefulWidget {
  const Amountbox({super.key});

  @override
  State<Amountbox> createState() => _AmountboxState();
}

class _AmountboxState extends State<Amountbox> {
  final txtController = TextEditingController();

  @override
  void dispose() {
    txtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.green,
      content: Container(
        height: 185,
        width: 185,
        color: Colors.green,
        child: Column(
          mainAxisAlignment: .spaceAround,
          children: [
            SizedBox(height: 10),
            Text(
              "Enter Amount",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: .bold,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              keyboardType: .number,
              controller: txtController,
              enabled: true,
              style: TextStyle(color: Colors.black,fontWeight: .bold),
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                focusColor: Colors.white,

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: Colors.white),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.white)),
              onPressed: () {

                // await input();
                //
                // if (!context.mounted) return;
                //
                // Navigator.pushAndRemoveUntil(
                //   context,
                //   MaterialPageRoute(builder: (_) => Home()),
                //       (route) => false,
                // );
              },
              child: Text("Save", style: TextStyle(color: Colors.green,fontWeight: .bold)),
            ),
          ],
        ),
      ),
      actions: [],
    );
  }
}
