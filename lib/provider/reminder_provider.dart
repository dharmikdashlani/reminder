import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../database/reminder_sql_database.dart';
import '../modal/reminder_modal.dart';

class ReminderProvider with ChangeNotifier {
  List<Reminder> _reminders = [];

  List<Reminder> get reminders => _reminders;

  Future<void> loadReminders() async {
    _reminders = await DatabaseProvider.db.getReminders();
    notifyListeners();
  }

  Future<void> addReminder(Reminder reminder) async {
    await DatabaseProvider.db.addReminder(reminder);
    _reminders.add(reminder);
    notifyListeners();
  }

  Future<void> updateReminder(Reminder reminder) async {
    await DatabaseProvider.db.updateReminder(reminder);
    _reminders[_reminders.indexWhere((r) => r.id == reminder.id)] = reminder;
    notifyListeners();
  }

  Future<void> deleteReminder(int id) async {
    await DatabaseProvider.db.deleteReminder(id);
    _reminders.removeWhere((r) => r.id == id);
    notifyListeners();
  }
}
