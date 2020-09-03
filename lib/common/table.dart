import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class ApplicationDatabase {
  static final _databaseName = "ApplicationDatabase.db";
  static final _databaseVersion = 1;

  static final table = 'lunch_wallet';
  static final columnId = '_id';
  static final columnDate = 'date';
  static final columnFee = 'fee';
  static final columnKey = 'key';

  // ApplicationDatabaseクラスをシングルトンにするためのコンストラクタ
  ApplicationDatabase._privateConstructor();
  static final ApplicationDatabase instance = ApplicationDatabase._privateConstructor();

  // DBにアクセスするためのメソッド
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // 初の場合はDBを作成する
    _database = await _initDatabase();
    return _database;
  }

  // データベースを開く。データベースがない場合は作る関数
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory(); // アプリケーション専用のファイルを配置するディレクトリへのパスを返す
    String path = join(documentsDirectory.path, _databaseName); // joinはセパレーターでつなぐ関数
    // pathのDBを開く。なければonCreateの処理がよばれる。onCreateでは_onCreateメソッドを呼び出している
    return await openDatabase(path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // DBを作成するメソッド
  Future _onCreate(Database db, int version) async {
    // ダブルクォートもしくはシングルクォート3つ重ねることで改行で文字列を作成できる。$変数名は、クラス内の変数のこと（文字列の中で使える）
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnDate TEXT NOT NULL,
        $columnFee INTEGER NOT NULL
      )
      '''
    );
  }

  // 挿入
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database; //DBにアクセスする
    return await db.insert(table, row); //テーブルにマップ型のものを挿入。追加時のrowIDを返り値にする
  }

  // 全件取得
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database; //DBにアクセスする
    return await db.query(table, orderBy: '_id desc'); //全件取得
  }

  // // データ件数取得
  // Future<int> queryRowCount() async {
  //   Database db = await instance.database; //DBにアクセスする
  //   return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  // }

  // 更新
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database; //DBにアクセスする
    int id = row[columnId]; //引数のマップ型のcolumnIDを取得
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // 削除
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}