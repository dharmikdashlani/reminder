import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modal/reminder_modal.dart';
import '../provider/reminder_provider.dart';
import '../view/screens/remider_form.dart';

class ReminderList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final reminderProvider = Provider.of<ReminderProvider>(context);
    final reminders = reminderProvider.reminders;

    return ListView.builder(
      itemCount: reminders.length,
      itemBuilder: (context, index) {
        final reminder = reminders[index];

        return Dismissible(
          key: Key(reminder.id.toString()),
          onDismissed: (_) =>
              reminderProvider.deleteReminder(reminder.id),
          child: ListTile(
            title: Text(reminder.title),
            subtitle: Text(reminder.time.toString()),
            onTap: () => _showEditForm(context, reminder),
          ),
        );
      },
    );
  }

  void _showEditForm(BuildContext context, Reminder reminder) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Reminder'),
          content: ReminderForm(
            onSubmit: (updatedReminder) {
              reminder.title = updatedReminder.title;
              reminder.time = updatedReminder.time;
              Provider.of<ReminderProvider>(context, listen: false)
                  .updateReminder(reminder);
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }
}