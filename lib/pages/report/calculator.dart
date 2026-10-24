import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: Container()),
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.all(10),

              decoration: BoxDecoration(color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(20)),
              child: GridView.builder(
                itemCount: 16,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemBuilder: (context, index) {
                  return Container(margin: EdgeInsets.all(5),color: Colors.purple,child: Text(index.toString()),);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
