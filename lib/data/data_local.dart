// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:spen_management/models/spend.dart';
import 'package:spen_management/models/spend_type.dart';
import 'package:sqflite/sqlite_api.dart';

class SQLManagement {
  final Database db;
  SQLManagement({
    required this.db,
  });

  Future<bool> createTable() async {
    String sql = '''CREATE TABLE IF NOT EXISTS SpendTable(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      idSpenType INTEGER,
      idSpenDate INTEGER,
      spendNote text,
      spendAmount int)
          ''';
    // ignore: prefer_interpolation_to_compose_strings
    String sql2 = '''CREATE TABLE IF NOT EXISTS SpendTypeTable(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      spendName text,
      icon text,
      type int)
          ''';
    String sql3 = '''CREATE TABLE IF NOT EXISTS SpendDateTable(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      spendDate text)
          ''';
    try {
      // await db.execute("Drop table SpendTable");
      // await db.execute("Drop table SpendTypeTable");
      await db.execute(sql);
      await db.execute(sql2);
      await db.execute(sql3);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
    return true;
  }

  Future<int> insert(dynamic model) async {
    var id = -1;
    try {
      id = await db.insert(
        "${model.runtimeType}Table",
        model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return id;
  }

  Future<List<SpendType>> getListSpendType(int type) async {
    var data = (await db.query('SpendTypeTable'))
        .where((element) => element['type'] == type);
    return data.map((e) => SpendType.fromMap(e)).toList();
  }

  Future<List<Spend>> getListSpend() async {
    var data = (await db.query('SpendTable'));
    return data.map((e) => Spend.fromMap(e)).toList();
  }
}
