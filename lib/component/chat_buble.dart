import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 136, 135, 135),
          borderRadius: BorderRadius.circular(12),
          ),
      child: Text(
        message,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}