import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:restaurant_app/utils/notification_helper.dart';

typedef ReminderScheduler = Future<bool> Function(bool isEnabled);

class ReminderProvider extends ChangeNotifier {
  ReminderProvider({ReminderScheduler? reminderScheduler})
    : _reminderScheduler =
          reminderScheduler ?? NotificationHelper.scheduleDailyReminder;

  static const _key = 'dailyReminder';
  final ReminderScheduler _reminderScheduler;
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

    await _reminderScheduler(value);
    notifyListeners();
  }
}
