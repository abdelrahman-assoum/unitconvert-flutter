import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/conversion_history.dart';

class HistoryService {
  static const String _historyKey = 'conversion_history';
  static const int _maxHistoryItems = 100;

  static Future<void> addConversion(ConversionHistory conversion) async {
    final prefs = await SharedPreferences.getInstance();
    final history = await getHistory();

    // Add new conversion at the beginning
    history.insert(0, conversion);

    // Limit history size
    if (history.length > _maxHistoryItems) {
      history.removeRange(_maxHistoryItems, history.length);
    }

    // Save to preferences
    final jsonList = history.map((h) => h.toJson()).toList();
    await prefs.setString(_historyKey, jsonEncode(jsonList));
  }

  static Future<List<ConversionHistory>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_historyKey);

    if (jsonString == null) {
      return [];
    }

    try {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => ConversionHistory.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
  }

  static Future<void> deleteHistoryItem(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final history = await getHistory();

    if (index >= 0 && index < history.length) {
      history.removeAt(index);
      final jsonList = history.map((h) => h.toJson()).toList();
      await prefs.setString(_historyKey, jsonEncode(jsonList));
    }
  }
}
