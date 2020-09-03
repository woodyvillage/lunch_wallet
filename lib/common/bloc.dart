import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:lunch_wallet/common/table.dart';

class ApplicationBloc {
  final _appDB = ApplicationDatabase.instance;

  // 入金額
  final _getDepositController = BehaviorSubject<int>();
  Sink<int> get deposit => _getDepositController.sink;

  // 支払額
  final _getPaymentController = BehaviorSubject<int>();
  Sink<int> get payment => _getPaymentController.sink;

  // 所持金
  final _setPossessionController = BehaviorSubject<int>();
  Stream<int> get possession => _setPossessionController.stream;

  // 支払明細
  final _setBalanceController = BehaviorSubject<List<Map<String, dynamic>>>();
  Stream<List<Map<String, dynamic>>> get balance => _setBalanceController.stream;

  List<Map<String, dynamic>> _balance;

  ApplicationBloc() {
    // 入金
    _getDepositController.stream.listen((_possession) async {
      print('ApplicationBloc._getDepositController(_possession): $_possession');
      _setPossessionController.sink.add(_possession);
    });

    // 支払
    _getPaymentController.stream.listen((_fee) async {
      print('ApplicationBloc._getPaymentController(_fee): $_fee');

      // 最新の収支リストを更新
      _balance = await _appDB.queryAllRows();
      _balance.forEach((row) => print(row));
      _setBalanceController.sink.add(_balance);
    });
  }

  void dispose() {
    _getDepositController.close();
    _getPaymentController.close();
    _setPossessionController.close();
    _setBalanceController.close();
  }
}