import 'package:flutter/material.dart';
import '../services/history_service.dart';
import '../models/conversion_history.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => HistoryScreenState();
}

class HistoryScreenState extends State<HistoryScreen>
    with AutomaticKeepAliveClientMixin {
  List<ConversionHistory> _history = [];
  bool _isLoading = true;

  @override
  bool get wantKeepAlive => false; // Don't keep alive so it refreshes

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  void refresh() {
    if (mounted) {
      _loadHistory();
    }
  }

  Future<void> _loadHistory() async {
    setState(() {
      _isLoading = true;
    });
    final history = await HistoryService.getHistory();
    setState(() {
      _history = history;
      _isLoading = false;
    });
  }

  Future<void> _clearAllHistory() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2A2F3E),
        title: const Text(
          'Clear History',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Are you sure you want to delete all conversion history?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Clear', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await HistoryService.clearHistory();
      _loadHistory();
    }
  }

  Future<void> _deleteHistoryItem(int index) async {
    await HistoryService.deleteHistoryItem(index);
    _loadHistory();
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Length':
        return const Color(0xFF4A90E2);
      case 'Weight':
        return const Color(0xFFFF9F43);
      case 'Temperature':
        return const Color(0xFF26D0CE);
      case 'Volume':
        return const Color(0xFF9B59B6);
      case 'Area':
        return const Color(0xFF7ED321);
      case 'Time':
        return const Color(0xFF1ABC9C);
      default:
        return Colors.blue;
    }
  }

  String _formatValue(double value) {
    if (value.abs() < 0.0001 && value != 0) {
      return value.toStringAsExponential(4);
    }
    if (value == value.roundToDouble()) {
      return value.toStringAsFixed(0);
    }
    String result = value.toStringAsFixed(6);
    result = result.replaceAll(RegExp(r'0+$'), '');
    result = result.replaceAll(RegExp(r'\.$'), '');
    return result;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
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
                  if (_history.isNotEmpty)
                    GestureDetector(
                      onTap: _clearAllHistory,
                      child: Container(
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
                    ),
                ],
              ),
            ),

            // History List
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.blue),
                    )
                  : _history.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.history,
                            size: 80,
                            color: Colors.white.withAlpha((0.2 * 255).round()),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No conversion history yet',
                            style: TextStyle(
                              color: Colors.white.withAlpha(
                                (0.4 * 255).round(),
                              ),
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Start converting to see your history here',
                            style: TextStyle(
                              color: Colors.white.withAlpha(
                                (0.3 * 255).round(),
                              ),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: _loadHistory,
                      backgroundColor: const Color(0xFF2A2F3E),
                      color: Colors.blue,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        itemCount: _history.length,
                        itemBuilder: (context, index) {
                          final item = _history[index];
                          return Dismissible(
                            key: Key(
                              '${item.timestamp.toIso8601String()}_$index',
                            ),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.only(right: 20),
                              alignment: Alignment.centerRight,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            onDismissed: (direction) {
                              _deleteHistoryItem(index);
                            },
                            child: HistoryCard(
                              category: item.category,
                              from:
                                  '${_formatValue(item.fromValue)} ${item.fromUnit}',
                              to: '${_formatValue(item.toValue)} ${item.toUnit}',
                              time: item.getTimeAgo(),
                              color: _getCategoryColor(item.category),
                            ),
                          );
                        },
                      ),
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
        ],
      ),
    );
  }
}
