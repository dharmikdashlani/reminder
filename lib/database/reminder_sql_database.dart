import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:reminder/globals/list.dart';
import '../modal/reminder_modal.dart';
// import 'package:reminder/g';

class DatabaseProvider {
  static const String _databaseName = 'reminder.db';
  static const int _databaseVersion = 1;

  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  late Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE reminders(
            id INTEGER PRIMARY KEY,
            title TEXT,
            time TEXT
          )
        ''');
      },
    );
  }

  Future<List<Reminder>> getReminders() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('reminders');

    return List.generate(maps.length, (i) {
      return Reminder(
        id: maps[i]['id'],
        title: maps[i]['title'],
        time: DateTime.parse(maps[i]['time']),
      );
    });
  }

  Future<Reminder> addReminder(Reminder reminder) async {
    final db = await database;
    final id = await db.insert('reminders', reminder.toMap());

    return reminder.copyWith(id: id, title: 'Hello', time: DateTime.now());
  }

  Future<void> updateReminder(Reminder reminder) async {
    final db = await database;

    await db.update(
      'reminders',
      reminder.toMap(),
      where: 'id = ?',
      whereArgs: [reminder.id],
    );
  }

  Future<void> deleteReminder(int id) async {
    final db = await database;

    await db.delete(
      'reminders',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
