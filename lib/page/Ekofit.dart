import 'package:flutter/material.dart';

class Ekofit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft, // Align the title to the left
          child: Text(
            'Ekofit Randevusu',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        backgroundColor: Colors.orange, // Customize the AppBar color
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'lib/media/ekofit.png', // Display the image
              fit: BoxFit.contain, // Make the image cover the entire screen
            ),
          ),
        ],
      ),
    );
  }
}
