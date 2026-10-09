import 'package:flutter/material.dart';

class EmptyPlaceholderPage extends StatelessWidget {
  final String title;

  const EmptyPlaceholderPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A6556),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: const SizedBox.expand(),
    );
  }
}
