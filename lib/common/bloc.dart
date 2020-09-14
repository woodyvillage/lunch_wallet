import 'package:rxdart/rxdart.dart';

import 'package:lunch_wallet/common/table.dart';
import 'package:lunch_wallet/dao/payment.dart';
import 'package:lunch_wallet/dto/payment.dart';

class ApplicationBloc {
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
  final _setBalanceController = BehaviorSubject<List<PaymentDto>>();
  Stream<List<PaymentDto>> get balance => _setBalanceController.stream;

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
      PaymentDao _dao = PaymentDao();
      List<PaymentDto> _dto = await _dao.selectOrderDesc(ApplicationDatabase.cId);
      _setBalanceController.sink.add(_dto);
    });
  }

  void dispose() {
    _getDepositController.close();
    _getPaymentController.close();
    _setPossessionController.close();
    _setBalanceController.close();
  }
}