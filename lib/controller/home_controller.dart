import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

const tablename = "data";
const id = "id";
const title = "title";

class HomeController {
  static List<Map> datas = [];
  static late Database database;

  static Future<void> initDb() async {
    if (kIsWeb) {
      // Change default factory on the web
      databaseFactory = databaseFactoryFfiWeb;
    }
    database = await openDatabase(
      "data.db",
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE $tablename($id INTEGER PRIMARY KEY AUTOINCREMENT, $title TEXT NOT NULL)",
        );
      },
    );
  }

  static Future<void> getData() async {
    datas = await database.query(tablename, columns: [id, title]);
    log(datas.toString());
  }

  static Future<void> addData(String value) async {
    await database.insert(tablename, {title: value});

    await getData();
  }

  static Future<void> deleteData(int dataid) async {
    await database.delete(tablename, where: '$id = ?', whereArgs: [dataid]);
    await getData();
  }

  static Future<void> updateData(int dataid, String newValue) async {
    await database.update(
      tablename,
      {title: newValue},
      where: '$id = ?',
      whereArgs: [dataid],
    );
    await getData();
  }
}
