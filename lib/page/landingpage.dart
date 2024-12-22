import 'package:flutter/material.dart';
import 'loginpage.dart';

class LandingPage extends StatelessWidget {
  final List<String> slideTexts = [
    "NeoIEU",
    'İhtiyacınız Olan Bilgiler Yanınıza.',
  ];

  LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange, // Set background to orange
      body: PageView.builder(
        itemCount: slideTexts.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                slideTexts[index],
                style: TextStyle(
                  color: Colors.white, // Change text color to white
                  fontWeight: FontWeight.w900, // Bolder text
                  fontSize: 40, // Bigger text
                ),
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
                  child: Text(
                    'Başlayalım!',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
