import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reports", style: TextStyle(fontWeight: .bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          DropdownButton(
            
            items: [
              DropdownMenuItem(child: Text("month")),
              
            ],
            onChanged: (context) {},
          ),
        ],
      ),
    );
  }
}
