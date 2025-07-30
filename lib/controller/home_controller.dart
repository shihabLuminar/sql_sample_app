import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
      onCreate: (db, version) {
        db.execute(
          "create table $tablename($id integer primary key autoincrement, $title text not null)",
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

  static void deleteData() {}
  static void updateData() {}
}
