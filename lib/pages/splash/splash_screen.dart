import 'package:flutter/material.dart';
import 'package:moneyflow/pages/Home/home.dart';
import 'package:moneyflow/pages/intro/intro_screen.dart';
import 'package:moneyflow/pages/local_storage.dart';
import 'package:moneyflow/route/route.dart';

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

  Future<void> checkStatus() async {
    final introscreen = await LocalStorage.hasSeenIntro();
    if (!mounted) return;
    !introscreen
        ? Navigator.pushReplacementNamed(context, AppRoute.intro)
        : Navigator.pushReplacementNamed(context, AppRoute.home);
  }

  Future<void> _nextScreen() async {
    await Future.delayed(Duration(seconds: 1));
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return Home();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [CircleAvatar(), Text("Your Money, Your Control")],
      ),
    );
  }
}
