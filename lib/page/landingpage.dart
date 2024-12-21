import 'package:flutter/material.dart';
import 'loginpage.dart';

class LandingPage extends StatelessWidget {
  final List<String> slideTexts = [
    "MyIEU'ye Hoş Geldiniz!",
    'İhtiyacınız Olan Bilgiler Yanınıza.',
    'Lütfen Giriş Yapın.',
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
                style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
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
