import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:lunch_wallet/common/bloc.dart';
import 'package:lunch_wallet/common/preference.dart';
import 'package:lunch_wallet/dao/payment.dart';
import 'package:lunch_wallet/dto/menu.dart';
import 'package:lunch_wallet/dto/payment.dart';
import 'package:lunch_wallet/model/dialog.dart';
import 'package:lunch_wallet/model/notification.dart';
import 'package:lunch_wallet/model/setting.dart';
import 'package:lunch_wallet/util/resource.dart';
import 'package:lunch_wallet/util/table.dart';

int _possession = 0;
dynamic _result;

final ApplicationPreference _pref = ApplicationPreference();

// 所持金を取得
Future inquiry() async {
  _possession = await getSettingByName('savings', _possession);
  _possession ??= 0;
  return _possession;
}

// 入金
deposit(BuildContext _context, ApplicationBloc _bloc) async {
  // 所持金
  await inquiry();

  // 入金処理
  _result = await showSingleDialog(context: _context, title: depositName, value: null, initial: 0);
  if (_result != null && _result != 0) {
    _result ??= 0;
    _possession += _result;

    _insertFee(_result, false);

    await setSettingByName('savings', _possession);
    _bloc.deposit.add(_possession);
    _bloc.payment.add(_result);
  }

  depositNotification(_context, (_result == null || _result == 0));
}

// 支払
payment(BuildContext _context, ApplicationBloc _bloc) async {
  // 所持金
  await inquiry();

  // 下限金額
  int _min;
  _min = await _pref.getValue(settings[minFee][settingColumn], _min);
  _min ??= settings[minFee][settingDefault];
  print('payment:${settings[minFee][settingColumn]} -> $_min');

  // 上限金額
  int _max;
  _max = await _pref.getValue(settings[maxFee][settingColumn], _min);
  _max ??= settings[maxFee][settingDefault];
  print('payment:${settings[maxFee][settingColumn]} -> $_max');

  // 支払処理
  int _fee = _getPayment(_min, _max);
  print('payment:$_fee');

  if (_possession < _fee) {
    _fee = 0;
  } else {
    _possession -= _fee;

    _insertFee(_fee, true);

    await setSettingByName('savings', _possession);
    _bloc.deposit.add(_possession);
    _bloc.payment.add(_fee);
  }

  receiptNotification(_context, _fee);
}

int _getPayment(int _min, int _max) {
  var _fractionalFormat = DateFormat('S', 'ja_JP');
  var _seed = _fractionalFormat.format(DateTime.now());

  int _next = _min + (Random(int.parse(_seed)).nextInt(_max-_min));
  return (_next / 10).floor() * 10;
}

_insertFee(int _num, bool isPayment) async {
  var _dateFormat = DateFormat('yyyy年MM月dd日(E) HH:mm', 'ja_JP');
  var _date = _dateFormat.format(DateTime.now());

  // 明細
  String _name;
  int _mode;
  if (isPayment) {
    _name = await _pref.getValue(settings[nameFee][settingColumn], settings[nameFee][settingDefault]);
    _name ??= settings[nameFee][settingDefault];
    _mode = TableUtil.payment;
  } else {
    _name = await getSettingByIndex(nameDeposit);
    _mode = TableUtil.deposit;
  }

  PaymentDto _dto = PaymentDto(date: _date, name: _name, price: _num, mode: _mode);
  PaymentDao _dao = PaymentDao();
  await _dao.insert(_dto);
}

// 払戻
refund(BuildContext _context, ApplicationBloc _bloc, PaymentDto _dto) async {
  // 所持金
  await inquiry();

  // 払戻処理
  bool action;
  if (_dto.mode == TableUtil.deposit) {
    _possession < _dto.price ? action = true : action = false;
    action == true ? _possession = _possession : _possession -= _dto.price;
  } else {
    action = false;
    _possession += _dto.price;
  }

  if (!action) {
    _deleteFee(_dto);
  }

  await setSettingByName('savings', _possession);
  _bloc.deposit.add(_possession);
  _bloc.payment.add(_dto.price);

  refundNotification(_context, action);
}

_deleteFee(PaymentDto _dto) async {
  PaymentDao _dao = PaymentDao();
  await _dao.delete(_dto);
}

// 訂正
correct(BuildContext _context, ApplicationBloc _bloc, PaymentDto _dto) async {
  // 所持金
  await inquiry();

  // 訂正処理
  _result = await showSingleDialog(context: _context, title: _dto.name, value: _dto.price, initial: 0);
  print('_result:$_result');
  var _difference = 0;
  _difference = _dto.price - _result;
  if (_difference == 0) {
    // 変更していない
    _result = 0;
  }
  if (_dto.mode == TableUtil.deposit) {
    if (_difference < 0) {
      // 入金額を増やす
      _possession += _difference.abs();
      _dto.price = _result;
    } else if (_difference > 0 && _possession < _difference.abs()) {
      // 入金額を減らす、差額が所持金より多い
      _result = -1;
    } else {
      // 入金額を減らす
      _possession -= _difference;
      _dto.price = _result;
    }
  } else {
    if (_difference > 0) {
      // 支払額を減らす
      _possession += _difference.abs();
      _dto.price = _result;
    } else if (_difference < 0 && _possession < _difference.abs()) {
      // 支払額を増やす、差額が所持金より多い
      _result = -1;
    } else {
      // 支払額を増やす
      _possession += _difference;
      _dto.price = _result;
    }
  }

  if (_result != null && _result > 0) {
    _updateFee(_dto);

    await setSettingByName('savings', _possession);
    _bloc.deposit.add(_possession);
    _bloc.payment.add(_dto.price);
  }

  correctNotification(_context, _result);
}

_updateFee(PaymentDto _dto) async {
  PaymentDao _dao = PaymentDao();
  await _dao.update(_dto);
}

// カタログ支払
catalogPayment(BuildContext _context, ApplicationBloc _bloc, MenuDto _dto) async {
  // 所持金
  await inquiry();

  // 支払処理
  int _fee = _dto.price;
  print('catalogPayment:$_fee');

  if (_possession < _fee) {
    _fee = 0;
  } else {
    _possession -= _fee;

    _insertByMenuDto(_dto);

    await setSettingByName('savings', _possession);
    _bloc.deposit.add(_possession);
    _bloc.payment.add(_fee);
  }

  receiptNotification(_context, _fee);
}

_insertByMenuDto(MenuDto dto) async {
  var _dateFormat = DateFormat('yyyy年MM月dd日(E) hh:mm', 'ja_JP');
  var _date = _dateFormat.format(DateTime.now());

  PaymentDto _dto = PaymentDto(date: _date, shop: dto.shop, name: dto.name, note: dto.note, price: dto.price, mode: TableUtil.catalog);
  PaymentDao _dao = PaymentDao();
  await _dao.insert(_dto);
}

// マニュアル支払
Future manualPayment(ApplicationBloc _bloc, PaymentDto _dto) async {
  // 所持金
  await inquiry();

  // 支払処理
  int _fee = _dto.price;
  print('manualPayment:$_fee');

  if (_possession < _fee) {
    _fee = 0;
  } else {
    _possession -= _fee;

    _insertByPaymentDto(_dto);

    await setSettingByName('savings', _possession);
    _bloc.deposit.add(_possession);
    _bloc.payment.add(_fee);
  }
}

_insertByPaymentDto(PaymentDto dto) async {
  var _dateFormat = DateFormat('yyyy年MM月dd日(E) hh:mm', 'ja_JP');
  var _date = _dateFormat.format(DateTime.now());

  PaymentDto _dto = PaymentDto(date: _date, shop: dto.shop, name: dto.name, note: dto.note, price: dto.price, mode: TableUtil.payment);
  PaymentDao _dao = PaymentDao();
  await _dao.insert(_dto);
}