import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  final String categoryName;
  final Color color;

  const CategoryScreen({
    super.key,
    required this.categoryName,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1F2E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(categoryName, style: const TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Text(
          categoryName,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }
}
