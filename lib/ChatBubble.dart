import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isBot;

  const ChatBubble({required this.message, required this.isBot, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isBot ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: isBot ? Colors.orange[100] : Colors.blue[100],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: isBot ? const Radius.circular(0) : const Radius.circular(12),
            bottomRight: isBot ? const Radius.circular(12) : const Radius.circular(0),
          ),
        ),
        child: Text(
          message,
          style: TextStyle(color: isBot ? Colors.black : Colors.white),
        ),
      ),
    );
  }
}