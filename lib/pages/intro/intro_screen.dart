import 'package:flutter/material.dart';
import 'package:moneyflow/pages/splash/splash_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();
    _nextScreen();
  }

  Future<void> _nextScreen() async {
    
    await Future.delayed(Duration(seconds: 2));
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return SplashScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: .center,
        children: [Center(child: CircleAvatar()), Text("Your Money, Your Control")],
      ),
    );
  }
}
