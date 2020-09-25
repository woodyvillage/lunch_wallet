import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:lunch_wallet/util/table.dart';

class ApplicationDatabase {
  ApplicationDatabase.privateConstructor();
  static final ApplicationDatabase instance = ApplicationDatabase.privateConstructor();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, TableUtil.databaseName);
    return await openDatabase(path,
      version: TableUtil.databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future _onCreate(Database _db, int _version) async {
    print('create database version $_version');
    await _definition(_db, 1, _version);
  }

  Future _onUpgrade(Database _db, int _previous, int _current) async {
    print('update database version $_previous to $_current');
    await _definition(_db, _previous + 1, _current);
  }

  _definition(Database _db, int _previous, int _current) async {
    for (var i = _previous; i <= _current; i++) {
      var _queries = TableUtil.ddlScripts[i.toString()];
      for (String _query in _queries) {
        print(_query);
        await _db.execute(_query);
      }
    }
  }
}