import 'package:sqflite/sqflite.dart';

import 'package:lunch_wallet/common/table.dart';
import 'package:lunch_wallet/dto/menu.dart';
import 'package:lunch_wallet/util/table.dart';

class MenuDao {
  static final ApplicationDatabase instance = ApplicationDatabase.privateConstructor();

  Future<int> selectConditionsCount(MenuDto _dto) async {
    Database _db = await instance.database;
    return Sqflite.firstIntValue(await _db.query(TableUtil.menuTable,
      columns: ['count(*)'],
      where: '${TableUtil.cShop} = ? and ${TableUtil.cName} = ? and ${TableUtil.cNote} = ? and ${TableUtil.cPrice} = ?',
      whereArgs: [_dto.shop, _dto.name, _dto.note, _dto.price],
    ));
  }

  Future<List<MenuDto>> select(String _column, String _value) async {
    Database _db = await instance.database;
    List<Map<String, dynamic>> _result = await _db.query(TableUtil.menuTable, where: '$_column = ?', whereArgs: [_value]);
    List<MenuDto> _menu = _result.isNotEmpty
      ? _result.map((item) => MenuDto.parse(item)).toList()
      : [];
    return _menu;
  }

  Future<List<MenuDto>> selectUnique(String _column) async {
    Database _db = await instance.database;
    List<Map<String, dynamic>> _result = await _db.query(TableUtil.menuTable, distinct:true, groupBy: _column);
    List<MenuDto> _menu = _result.isNotEmpty
      ? _result.map((item) => MenuDto.parse(item)).toList()
      : [];
    return _menu;
  }

  Future<int> selectIndexCount(MenuDto _dto) async {
    Database _db = await instance.database;
    return Sqflite.firstIntValue(await _db.query(TableUtil.menuTable, columns: ['count(*)'], where: '${TableUtil.cId} = ?', whereArgs: [_dto.id]));
  }

  Future<int> insert(MenuDto _menu) async {
    Database _db = await instance.database;
    int _result = await _db.insert(TableUtil.menuTable, _menu.toMap());
    return _result;
  }

  Future<int> update(MenuDto _dto) async {
    Database _db = await instance.database;
    int _result = await _db.update(TableUtil.menuTable, _dto.toMap(), where: '${TableUtil.cId} = ?', whereArgs: [_dto.id]);
    return _result;
  }
}