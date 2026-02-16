import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationHelper {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const settings = InitializationSettings(android: androidSettings);

    await _notifications.initialize(settings);

    tz.initializeTimeZones();
  }

  static Future<bool> _requestNotificationPermission() async {
    final androidImplementation = _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    final isGranted =
        await androidImplementation?.areNotificationsEnabled() ?? false;

    if (isGranted) return true;

    return await androidImplementation?.requestNotificationsPermission() ??
        false;
  }

  static Future<bool> _requestExactAlarmPermission() async {
    final androidImplementation = _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    return await androidImplementation?.requestExactAlarmsPermission() ?? false;
  }

  static Future<bool> scheduleDailyReminder(bool isEnabled) async {
    final notificationPermission = await _requestNotificationPermission();
    final exactAlarmPermission = await _requestExactAlarmPermission();

    if (!notificationPermission || !exactAlarmPermission) {
      return false;
    }

    if (!isEnabled) {
      await _notifications.cancel(0);
      return true;
    }

    final now = tz.TZDateTime.now(tz.local);

    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      11,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await _notifications.zonedSchedule(
      0,
      'Lunch Time 🍽️',
      'Jangan lupa makan siang di restoran favoritmu!',
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_reminder_channel',
          'Daily Reminder',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );

    return true;
  }
}
