class ConversionHistory {
  final String category;
  final double fromValue;
  final String fromUnit;
  final double toValue;
  final String toUnit;
  final DateTime timestamp;

  ConversionHistory({
    required this.category,
    required this.fromValue,
    required this.fromUnit,
    required this.toValue,
    required this.toUnit,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'fromValue': fromValue,
      'fromUnit': fromUnit,
      'toValue': toValue,
      'toUnit': toUnit,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory ConversionHistory.fromJson(Map<String, dynamic> json) {
    return ConversionHistory(
      category: json['category'] as String,
      fromValue: (json['fromValue'] as num).toDouble(),
      fromUnit: json['fromUnit'] as String,
      toValue: (json['toValue'] as num).toDouble(),
      toUnit: json['toUnit'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  String getTimeAgo() {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks week${weeks > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months month${months > 1 ? 's' : ''} ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years year${years > 1 ? 's' : ''} ago';
    }
  }
}
