// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:provider/provider.dart';
// import 'package:reminder/view/screens/remider_form.dart';
// import 'package:reminder/provider/reminder_provider.dart';
//
// import '../../globals/list.dart';
// import '../../helper/notification_helper.dart';
// import '../../modal/reminder_modal.dart';
//
// class HomePage extends StatelessWidget {
//
//   // final List<Reminder> _reminders = [];
//   // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   //     FlutterLocalNotificationsPlugin();
//   //
//   // @override
//   // void initState() {
//   //   // super.initState();
//   //   final androidInit = AndroidInitializationSettings('app_icon');
//   //   final iOSInit = IOSInitializationSettings();
//   //   final initSettings =
//   //       InitializationSettings(android: androidInit, iOS: iOSInit);
//   //   flutterLocalNotificationsPlugin.initialize(initSettings);
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     final notificationHelper = NotificationHelper();
//     notificationHelper.initialize();
//
//     final reminderProvider = Provider.of<ReminderProvider>(context);
//     reminderProvider.loadReminders();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Reminders'),
//       ),
//       body: Column(
//         children: [
//           ReminderForm(
//             onSubmit: (reminder) {
//               reminderProvider.addReminder(reminder);
//               notificationHelper.scheduleNotification(
//                   reminder.id, reminder.title, reminder.time);
//             },
//           ),
//           SizedBox(height: 16),
//           Expanded(child: ReminderList()),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:reminder/view/screens/remider_form.dart';

class HomePage extends StatefulWidget {
  const HomePage({required Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
    // var initializationSettingsIOS = IOSInitializationSettings(
    //     onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    // var initializationSettings = InitializationSettings(
    //     android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    // flutterLocalNotificationsPlugin.initialize(initializationSettings,
    //     onSelectNotification: onSelectNotification);
  }

  Future<void> scheduleNotification(
      DateTime scheduledNotificationDateTime, String notificationTitle) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'channel_id', 'channel_name',
        importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        notificationTitle,
        '',
        scheduledNotificationDateTime,
        platformChannelSpecifics,
        payload: 'Test Payload');
  }

  Future<void> _cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    // Do something when the notification is tapped
  }

  Future<void> onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // Do something when the notification is received while the app is in the foreground
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminder App'),
      ),
      body: Center(
        child: Text('Add reminders here'),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        ReminderForm;
      }),
    );
  }
}
