// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // import 'package:reminder_app/models/reminder.dart';
//
// import '../modal/reminder_modal.dart';
//
// import 'package:flutter/foundation.dart';
//
// class NotificationHelper {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   Future<void> initialize() async {
//     final androidInit = AndroidInitializationSettings('app_icon');
//     final iOSInit = IOSInitializationSettings();
//     final initSettings =
//     InitializationSettings(android: androidInit, iOS: iOSInit);
//     await flutterLocalNotificationsPlugin.initialize(initSettings);
//   }
//
//   Future<void> scheduleNotification(Reminder reminder, title, time) async {
//     final androidDetails = AndroidNotificationDetails(
//       'channel_id',
//       'channel_name',
//       // 'channel_description',
//       importance: Importance.high,
//       priority: Priority.high,
//       ticker: 'ticker',
//     );
//     final iOSDetails = IOSNotificationDetails();
//     final platformDetails = NotificationDetails(android: androidDetails, iOS: iOSDetails);
//     await flutterLocalNotificationsPlugin.schedule(
//       reminder.id,
//       reminder.title,
//       'Reminder time is up!',
//       reminder.time,
//       platformDetails,
//       payload: reminder.id.toString(),
//     );
//   }
//
//   Future<void> cancelNotification(int notificationId) async {
//     await flutterLocalNotificationsPlugin.cancel(notificationId);
//   }
// }
//
//
// class Reminder {
//   int id;
//   String title;
//   DateTime time;
//
//   Reminder({required this.title, required this.time, required this.id});
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'title': title,
//       'time': time.toIso8601String(),
//     };
//   }
//
//   factory Reminder.fromMap(Map<String, dynamic> map) {
//     return Reminder(
//       id: map['id'],
//       title: map['title'],
//       time: DateTime.parse(map['time']),
//     );
//   }
// }
