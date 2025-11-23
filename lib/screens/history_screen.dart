import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  const Icon(Icons.history, color: Colors.blue, size: 32),
                  const SizedBox(width: 12),
                  const Text(
                    'Conversion History',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2F3E),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.delete_outline,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            // History List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                children: const [
                  HistoryCard(
                    category: 'Length',
                    from: '100 Meters',
                    to: '328.08 Feet',
                    time: '2 hours ago',
                    color: Color(0xFF4A90E2),
                  ),
                  HistoryCard(
                    category: 'Weight',
                    from: '50 Kilograms',
                    to: '110.23 Pounds',
                    time: '5 hours ago',
                    color: Color(0xFFFF9F43),
                  ),
                  HistoryCard(
                    category: 'Temperature',
                    from: '25 Celsius',
                    to: '77 Fahrenheit',
                    time: 'Yesterday',
                    color: Color(0xFF26D0CE),
                  ),
                  HistoryCard(
                    category: 'Volume',
                    from: '1 Liter',
                    to: '0.26 Gallons',
                    time: '2 days ago',
                    color: Color(0xFF9B59B6),
                  ),
                  HistoryCard(
                    category: 'Currency',
                    from: '100 USD',
                    to: '92.50 EUR',
                    time: '3 days ago',
                    color: Color(0xFFFFD700),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HistoryCard extends StatelessWidget {
  final String category;
  final String from;
  final String to;
  final String time;
  final Color color;

  const HistoryCard({
    super.key,
    required this.category,
    required this.from,
    required this.to,
    required this.time,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2F3E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 50,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: TextStyle(
                    color: color,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$from → $to',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(color: Colors.white38, fontSize: 12),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, color: Colors.white30, size: 16),
        ],
      ),
    );
  }
}
