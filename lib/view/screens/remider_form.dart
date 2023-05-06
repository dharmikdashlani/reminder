import 'package:flutter/material.dart';

import '../../modal/reminder_modal.dart';

class ReminderForm extends StatefulWidget {
  final Function onSubmit;

  ReminderForm({required this.onSubmit});

  @override
  _ReminderFormState createState() => _ReminderFormState();
}

class _ReminderFormState extends State<ReminderForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  DateTime? _dateTime;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: 'Reminder Title',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a title';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
              );

              if (pickedDate == null) {
                return;
              }

              final pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );

              if (pickedTime == null) {
                return;
              }

              setState(() {
                _dateTime = DateTime(
                  pickedDate.year,
                  pickedDate.month,
                  pickedDate.day,
                  pickedTime.hour,
                  pickedTime.minute,
                );
              });
            },
            child: Text(
              _dateTime == null
                  ? 'Pick a date and time'
                  : 'Picked Date & Time: ${_dateTime.toString()}',
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate() && _dateTime != null) {
                _submitForm();
              }
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    final reminder = Reminder(
      id: DateTime.now().millisecondsSinceEpoch,
      title: _titleController.text,
      time: _dateTime!,
    );
    widget.onSubmit(reminder);
    _titleController.clear();
    setState(() {
      _dateTime = null;
    });
  }
}
