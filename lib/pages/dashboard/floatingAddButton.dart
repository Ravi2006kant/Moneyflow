import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Floatingaddbutton extends StatelessWidget {
  const Floatingaddbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(elevation: 0,foregroundColor: Colors.white,backgroundColor: Colors.green,onPressed: () {

      Navigator.pushNamed(context, '/addtransaction');
    },child: Icon(Icons.add),

    );
  }
}
