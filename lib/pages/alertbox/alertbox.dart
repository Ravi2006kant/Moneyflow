import 'package:flutter/material.dart';
import 'package:moneyflow/pages/Home/home.dart';
import 'package:moneyflow/pages/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Alertbox extends StatefulWidget {
  const Alertbox({super.key});

  @override
  State<Alertbox> createState() => _AlertboxState();
}

class _AlertboxState extends State<Alertbox> {
  final txtController = TextEditingController();

  Future<void> input() async {
    await LocalStorage.prefs.setString('userName', txtController.text.trim());
    await LocalStorage.prefs.setBool('isFirstTime', false);
  }

  @override
  void dispose() {
    txtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.primary,
      content: Container(
        height: 150,
        width: 150,
        child: Column(
          children: [
            Text(
              "Enter You Name",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: .bold,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              keyboardType: .name,

              controller: txtController,
              enabled: true,
              style: TextStyle(fontWeight: .bold),
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
              onPressed: () {
                input();
                Navigator.pop(context);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
                Navigator.pop(context);
              },
              child: Text("Save", style: TextStyle(fontWeight: .bold)),
            ),
          ],
        ),
      ),
      actions: [],
    );
  }
}
