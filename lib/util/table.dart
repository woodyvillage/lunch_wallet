class TableUtil {
  static final databaseName = 'ApplicationDatabase._db';
  static final databaseVersion = 2;

  static final paymentTable = 'payment';
  static final menuTable = 'menu';

  static final cId = '_id';
  static final cShop = 'shop';
  static final cName = 'name';
  static final cNote = 'note';
  static final cDate = 'date';
  static final cPrice = 'price';
  static final cIcon = 'icon';
  static final cMode = 'mode';

  static final deposit = 0;
  static final payment = 1;
  static final catalog = 2;

  static final ddlScripts = {
    '1' : ['CREATE TABLE $paymentTable ($cId INTEGER PRIMARY KEY, $cDate TEXT NOT NULL, $cName TEXT NOT NULL, $cNote TEXT, $cShop TEXT, $cPrice INTEGER NOT NULL, $cIcon TEXT, $cMode int);'],
    '2' : ['CREATE TABLE $menuTable ($cId INTEGER PRIMARY KEY, $cShop TEXT NOT NULL, $cName TEXT NOT NULL, $cNote TEXT, $cPrice INTEGER NOT NULL, $cIcon TEXT);'],
  };
}