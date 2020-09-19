import 'package:sqflite/sqflite.dart';

import 'package:lunch_wallet/common/table.dart';
import 'package:lunch_wallet/dto/payment.dart';
import 'package:lunch_wallet/util/table.dart';

class PaymentDao {
  static final ApplicationDatabase instance = ApplicationDatabase.privateConstructor();

  Future<List<PaymentDto>> selectOrderDesc(String _column) async {
    Database _db = await instance.database;
    List<Map<String, dynamic>> _result = await _db.query(TableUtil.paymentTable, orderBy: _column + ' desc');
    List<PaymentDto> _dto = _result.isNotEmpty
      ? _result.map((item) => PaymentDto.parse(item)).toList()
      : [];
    return _dto;
  }

  Future<int> insert(PaymentDto _dto) async {
    Database _db = await instance.database;
    int _result = await _db.insert(TableUtil.paymentTable, _dto.toMap());
    return _result;
  }

  Future<int> delete(PaymentDto _dto) async {
    Database _db = await instance.database;
    int _result = await _db.delete(TableUtil.paymentTable, where: '${TableUtil.cId} = ?', whereArgs: [_dto.id]);
    return _result;
  }

  Future<int> update(PaymentDto _dto) async {
    Database _db = await instance.database;
    int _result = await _db.update(TableUtil.paymentTable, _dto.toMap(), where: '${TableUtil.cId} = ?', whereArgs: [_dto.id]);
    return _result;
  }
}