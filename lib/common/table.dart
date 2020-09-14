import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class ApplicationDatabase {
  static final _databaseName = 'ApplicationDatabase.db';
  static final _databaseVersion = 2;

  static final paymentTable = 'payment';
  static final menuTable = 'menu';

  static final cId = '_id';
  static final cShop = 'shop';
  static final cName = 'name';
  static final cNote = 'note';
  static final cDate = 'date';
  static final cPrice = 'price';
  static final cIcon = 'icon';

  final ddlScripts = {
    '1' : ['CREATE TABLE $paymentTable ($cId INTEGER PRIMARY KEY, $cDate TEXT NOT NULL, $cName TEXT NOT NULL, $cNote TEXT, $cShop TEXT, $cPrice INTEGER NOT NULL, $cIcon TEXT);'],
    '2' : ['CREATE TABLE $menuTable ($cId INTEGER PRIMARY KEY, $cShop TEXT NOT NULL, $cName TEXT NOT NULL, $cNote TEXT, $cPrice INTEGER NOT NULL, $cIcon TEXT);'],
  };

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
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future _onCreate(Database db, int version) async {
    print('create database version $version');
    await _definition(db, 1, version);
  }

  Future _onUpgrade(Database db, int previous, int current) async {
    print('update database version $previous to $current');
    await _definition(db, previous, current);
  }

  _definition(Database db, int previous, int current) async {
    for (var i = previous; i <= _databaseVersion; i++) {
      var queries = ddlScripts[i.toString()];
      for (String query in queries) {
        print(query);
        await db.execute(query);
      }
    }
  }
}