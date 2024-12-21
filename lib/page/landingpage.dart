import 'package:flutter/material.dart';
import 'loginpage.dart';

class LandingPage extends StatelessWidget {
  final List<String> slideTexts = [
    'Welcome to MyApp!',
    'Discover exciting features.',
    'Start your journey now.',
  ];

  LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: slideTexts.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                slideTexts[index],
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              if (index == slideTexts.length - 1)
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text('Get Started'),
                ),
            ],
          );
        },
      ),
    );
  }
}
