import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:restaurant_app/utils/notification_helper.dart';

class ReminderProvider extends ChangeNotifier {
  static const _key = 'dailyReminder';
  bool _isEnabled = false;

  bool get isEnabled => _isEnabled;

  Future<void> loadReminder() async {
    final prefs = await SharedPreferences.getInstance();
    _isEnabled = prefs.getBool(_key) ?? false;
    notifyListeners();
  }

  Future<void> toggleReminder(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    _isEnabled = value;
    await prefs.setBool(_key, value);

    await NotificationHelper.scheduleDailyReminder(value);
    notifyListeners();
  }
}
