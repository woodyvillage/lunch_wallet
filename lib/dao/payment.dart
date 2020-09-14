import 'package:sqflite/sqflite.dart';

import 'package:lunch_wallet/common/table.dart';
import 'package:lunch_wallet/dto/payment.dart';

class PaymentDao {
  static final ApplicationDatabase instance = ApplicationDatabase.privateConstructor();

  Future<List<PaymentDto>> selectOrderDesc(String _column) async {
    Database _db = await instance.database;
    List<Map<String, dynamic>> _result = await _db.query(ApplicationDatabase.paymentTable, orderBy: _column + ' desc');
    List<PaymentDto> _payment = _result.isNotEmpty
      ? _result.map((item) => PaymentDto.parse(item)).toList()
      : [];
    return _payment;
  }

  Future<int> insert(PaymentDto _payment) async {
    Database _db = await instance.database;
    int _result = await _db.insert(ApplicationDatabase.paymentTable, _payment.toMap());
    return _result;
  }

  Future<int> delete(PaymentDto _payment) async {
    Database _db = await instance.database;
    int _result = await _db.delete(ApplicationDatabase.paymentTable, where: '${ApplicationDatabase.cId} = ?', whereArgs: [_payment.id]);
    return _result;
  }

  Future<int> update(PaymentDto _payment) async {
    Database _db = await instance.database;
    int _result = await _db.update(ApplicationDatabase.paymentTable, _payment.toMap(), where: '${ApplicationDatabase.cId} = ?', whereArgs: [_payment.id]);
    return _result;
  }
}