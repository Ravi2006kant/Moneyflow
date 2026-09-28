import 'package:flutter/material.dart';
import 'package:moneyflow/pages/Home/home.dart';
import 'package:moneyflow/pages/intro/intro_screen.dart';
import 'package:moneyflow/pages/local_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _nextScreen();
  }

  Future<void> _nextScreen() async {
    final introscreen = await LocalStorage.hasSeenIntro();
    await Future.delayed(Duration(seconds: 3));

    if (!mounted) return;
   if (introscreen) {
  // Intro HAS been seen → Home
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => Home(),
    ),
  );
} else {
  // Intro has NOT been seen → Intro
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => IntroScreen(),
    ),
  );
}

    // Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8cc777),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CircleAvatar(
              radius: 55,
              backgroundImage: AssetImage("assets/images/logo.png"),
            ),
          ),
          Text(
            "MoneyFlow",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Your Money, Your Control",
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
