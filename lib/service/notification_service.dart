import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:todo_app/modules/todo.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  NotificationService() {
    _init();
  }

  void _init() {
    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
    );

    tz.initializeTimeZones();

    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleNotification(Todo todo) async {
    // Schedule only if due date is today
    final now = DateTime.now();
    if (todo.dueDate.year == now.year &&
        todo.dueDate.month == now.month &&
        todo.dueDate.day == now.day) {
      await _flutterLocalNotificationsPlugin.zonedSchedule(
        todo.id!,
        'Task Due Today',
        '${todo.title} is due today.',
        tz.TZDateTime.now(tz.local).add(Duration(seconds: 5)), // For demo, 5 seconds later
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'due_date_channel',
            'Due Date Notifications',
            channelDescription: 'Notifications when a task is due',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  Future<void> cancelNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }
}
