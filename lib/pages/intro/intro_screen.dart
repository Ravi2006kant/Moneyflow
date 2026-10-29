import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moneyflow/pages/splash/splash_screen.dart';
import 'package:moneyflow/pages/username/showDialog.dart';

import '../Home/home.dart';
import '../local_storage.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;

  final List<Map<String, String>> pages = [
    {
      'image': 'assets/svg/track.svg',
      'title': 'Track Your Money',
      'description': 'Keep your income and expenses organized in one place.',
    },
    {
      'image': 'assets/svg/funding.svg',
      'title': 'Understand Your Spending',
      'description': 'Discover where your money goes every month.',
    },
    {
      'image': 'assets/svg/budget.svg',
      'title': 'Manage Your Budget',
      'description': 'Set budgets and stay in control of your spending.',
    },
    {
      'image': 'assets/svg/saving.svg',
      'title': 'Grow Your Savings',
      'description': 'Build better financial habits and reach your goals.',
    },
  ];

  void nextPage() {
    if (currentPage < pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Replace this with your actual HomeScreen.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Showdialog()),
      );
    }
  }

  void skipOnboarding() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const Showdialog()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _nextScreen();
  }

  Future<void> _nextScreen() async {
   await LocalStorage.setIntroSeen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: skipOnboarding,
                child: const Text('Skip',style: TextStyle(fontWeight: .bold),),
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final page = pages[index];

                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          page['image']!,
                          height: 250,
                          fit: BoxFit.contain,
                        ),

                        const SizedBox(height: 35),

                        Text(
                          page['title']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 15),

                        Text(
                          page['description']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Page indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                    (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: currentPage == index ? 24 : 8,
                  decoration: BoxDecoration(
                    color: currentPage == index
                        ? Colors.green
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Next / Get Started button
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    currentPage == pages.length - 1 ? 'Get Started' : 'Next',
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
