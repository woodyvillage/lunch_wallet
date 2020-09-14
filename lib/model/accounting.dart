import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:lunch_wallet/common/bloc.dart';
import 'package:lunch_wallet/common/resource.dart';
import 'package:lunch_wallet/common/preference.dart';
import 'package:lunch_wallet/dao/payment.dart';
import 'package:lunch_wallet/dto/menu.dart';
import 'package:lunch_wallet/dto/payment.dart';
import 'package:lunch_wallet/model/dialog.dart';
import 'package:lunch_wallet/model/notification.dart';
import 'package:lunch_wallet/model/setting.dart';

int _possession = 0;
int _result;
String _setting;

final ApplicationPreference _pref = ApplicationPreference();

// 所持金を取得
Future inquiry() async {
  await _getPossession();
  return _possession;
}

_getPossession() async {
  await _pref.getPossession();
  _possession = _pref.getPossessionValue();
}

// 入金
deposit(BuildContext _context, ApplicationBloc _bloc) async {
  // 所持金
  await _getPossession();

  // 入金処理
  _result = await showSingleDialog(context: _context, title: depositName, value: null, initial: 0);
  if (_result != null && _result != 0) {
    _result ??= 0;
    _possession += _result;

    _insertFee(_result, false);

    await _pref.setPossession(_possession);
    _bloc.deposit.add(_possession);
    _bloc.payment.add(_result);
  }

  depositNotification(_context, (_result == null || _result == 0));
}

// 支払
payment(BuildContext _context, ApplicationBloc _bloc) async {
  // 所持金
  await _getPossession();

  // 下限金額
  int _min = settings[minFee][settingDefault];
  _setting = await getSetting(minFee);
  if (_setting != null ) {
    _min = int.parse(_setting);
  }
  print('payment:${settings[minFee][settingColumn]} -> $_min');

  // 上限金額
  int _max = settings[maxFee][settingDefault];
  _setting = await getSetting(maxFee);
  if (_setting != null && int.parse(_setting) < _min) {
    _max = int.parse(_setting);
  }
  print('payment:${settings[maxFee][settingColumn]} -> $_max');

  // 支払処理
  int _fee = _getPayment(_min, _max);
  print('payment:$_fee');

  if (_possession < _fee) {
    _fee = 0;
  } else {
    _possession -= _fee;

    _insertFee(_fee, true);

    await _pref.setPossession(_possession);
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
  var _dateFormat = DateFormat('yyyy年MM月dd日(E) hh:mm', 'ja_JP');
  var _date = _dateFormat.format(DateTime.now());

  // 明細
  var _name;
  if (isPayment) {
    _name = await getSetting(nameFee);
    _name ??= settings[nameFee][settingDefault];
  } else {
    _name = depositItem;
  }

  PaymentDto _dto = PaymentDto(date: _date, name: _name, price: _num);
  PaymentDao _dao = PaymentDao();
  await _dao.insert(_dto);
}

// 払戻
refund(BuildContext _context, ApplicationBloc _bloc, PaymentDto _dto) async {
  // 所持金
  await _getPossession();

  // 払戻処理
  bool action;
  if (_dto.name == depositItem) {
    _possession < _dto.price ? action = true : action = false;
    action == true ? _possession = _possession : _possession -= _dto.price;
  } else {
    action = false;
    _possession += _dto.price;
  }

  if (!action) {
    _deleteFee(_dto);
  }

  await _pref.setPossession(_possession);
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
  await _getPossession();

  // 訂正処理
  _result = await showSingleDialog(context: _context, title: _dto.name, value: _dto.price, initial: 0);
  print('_result:$_result');
  var _difference = 0;
  if (_result != null && _result != 0) {
    _difference = _dto.price - _result;
    if (_difference == 0) {
      // 変更していない
      _result = 0;
    } else if (_difference < 0 && _possession < _difference.abs()) {
      // 差額が所持金より多い
      _result = -1;
    } else {
      // 変更した
      _possession += _difference;
      _dto.price = _result;

      _updateFee(_dto);

      await _pref.setPossession(_possession);
      _bloc.deposit.add(_possession);
      _bloc.payment.add(_dto.price);
    }
  } else {
    // 変更していない
    _result = 0;
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
  await _getPossession();

  // 支払処理
  int _fee = _dto.price;
  print('catalogPayment:$_fee');

  if (_possession < _fee) {
    _fee = 0;
  } else {
    _possession -= _fee;

    _insertDto(_dto);

    await _pref.setPossession(_possession);
    _bloc.deposit.add(_possession);
    _bloc.payment.add(_fee);
  }

  receiptNotification(_context, _fee);
}

_insertDto(MenuDto dto) async {
  var _dateFormat = DateFormat('yyyy年MM月dd日(E) hh:mm', 'ja_JP');
  var _date = _dateFormat.format(DateTime.now());

  PaymentDto _dto = PaymentDto(date: _date, shop: dto.shop, name: dto.name, note: dto.note, price: dto.price);
  PaymentDao _dao = PaymentDao();
  await _dao.insert(_dto);
}