import 'package:sqflite/sqflite.dart';

import 'package:lunch_wallet/common/table.dart';
import 'package:lunch_wallet/dto/menu.dart';

class MenuDao {
  static final ApplicationDatabase instance = ApplicationDatabase.privateConstructor();

  Future<int> selectCount() async {
    Database _db = await instance.database;
    return Sqflite.firstIntValue(await _db.query(ApplicationDatabase.menuTable, columns: ['count(*)']));
  }

  Future<List<MenuDto>> selectUnique(String _column) async {
    Database _db = await instance.database;
    List<Map<String, dynamic>> _result = await _db.query(ApplicationDatabase.menuTable, distinct:true, groupBy: _column);
    List<MenuDto> _menu = _result.isNotEmpty
      ? _result.map((item) => MenuDto.parse(item)).toList()
      : [];
    return _menu;
  }

  Future<List<MenuDto>> select(String _column, String _value) async {
    Database _db = await instance.database;
    List<Map<String, dynamic>> _result = await _db.query(ApplicationDatabase.menuTable, where: '$_column = ?', whereArgs: [_value]);
    List<MenuDto> _menu = _result.isNotEmpty
      ? _result.map((item) => MenuDto.parse(item)).toList()
      : [];
    return _menu;
  }

  Future<int> insert(MenuDto _menu) async {
    Database _db = await instance.database;
    int _result = await _db.insert(ApplicationDatabase.menuTable, _menu.toMap());
    return _result;
  }

  Future<int> selectConditionsCount(MenuDto _dto) async {
    Database _db = await instance.database;
    return Sqflite.firstIntValue(await _db.query(ApplicationDatabase.menuTable,
      columns: ['count(*)'],
      where: '${ApplicationDatabase.cShop} = ? and ${ApplicationDatabase.cName} = ? and ${ApplicationDatabase.cNote} = ? and ${ApplicationDatabase.cPrice} = ?',
      whereArgs: [_dto.shop, _dto.name, _dto.note, _dto.price],
    ));
  }
}