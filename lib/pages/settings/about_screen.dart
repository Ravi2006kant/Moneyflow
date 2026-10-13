import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("About Screen", style: TextStyle(fontWeight: .bold)),
      ),
      body: Text("About screen"),
    );
  }
}
