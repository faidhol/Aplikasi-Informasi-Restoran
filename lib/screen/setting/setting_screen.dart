import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/theme/theme_provider.dart';
import 'package:restaurant_app/provider/setting/reminder_provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final reminderProvider = context.watch<ReminderProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Dark Theme'),
            value: themeProvider.isDarkTheme,
            onChanged: themeProvider.toggleTheme,
          ),
          SwitchListTile(
            title: const Text('Daily Reminder (11:00 AM)'),
            value: reminderProvider.isEnabled,
            onChanged: reminderProvider.toggleReminder,
          ),
        ],
      ),
    );
  }
}
