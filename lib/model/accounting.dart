import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:lunch_wallet/common/bloc.dart';
import 'package:lunch_wallet/common/dialog.dart';
import 'package:lunch_wallet/common/preference.dart';
import 'package:lunch_wallet/common/table.dart';
import 'package:lunch_wallet/model/notification.dart';
import 'package:lunch_wallet/model/setting.dart';

int _possession = 0;
int _difference = 0;
String _setting;
int _value;

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
  await _getPossession();
  await _inputValue(_context, null);

  // 入金処理
  _value = _value ??= 0;
  _possession += _value;

  await _pref.setPossession(_possession);
  _bloc.deposit.add(_possession);
  depositNotification(_context, _value);
}

_inputValue(BuildContext _context, int _initial) async {
  _value = await showDepositDialog(context: _context, value: _initial);
}

// 支払
payment(BuildContext _context, ApplicationBloc _bloc) async {
  await _getPossession();

  int _min; 
  await _getSetting(MIN_FEE);
  _setting = _setting ??= settingListItem[MIN_FEE][3];
  _min = int.parse(_setting);
  print('payment:${settingListItem[MIN_FEE][2]} -> $_min');

  int _max; 
  await _getSetting(MAX_FEE);
  _setting = _setting ??= settingListItem[MAX_FEE][3];
  _max = int.parse(_setting);
  print('payment:${settingListItem[MAX_FEE][2]} -> $_max');

  _getPayment(_min, _max);

  // 支払処理
  if (_possession < _value) {
    _value = 0;
  } else {
    _possession -= _value;

    _insertFee(_value);

    await _pref.setPossession(_possession);
    _bloc.deposit.add(_possession);
    _bloc.payment.add(_value);
  }

  receiptNotification(_context, _value);
}

_getPayment(int _min, int _max) {
  var _fractionalFormat = DateFormat('S', "ja_JP");
  var _seed = _fractionalFormat.format(DateTime.now());

  int _next = _min + (Random(int.parse(_seed)).nextInt(_max-_min));
  _value = (_next / 10).floor() * 10;
}

_insertFee(int _value) async {
  // 年月日
  var _dateFormat = DateFormat('yyyy年MM月dd日(E) hh:mm', "ja_JP");
  var _date = _dateFormat.format(DateTime.now());

  // ローカルDBに格納
  Map<String, dynamic> _feeData = {
    ApplicationDatabase.columnDate: _date,
    ApplicationDatabase.columnFee: _value,
  };

  final _db = ApplicationDatabase.instance;
  await _db.insert(_feeData);
}

// 払戻
refund(BuildContext _context, ApplicationBloc _bloc, int _id, int _fee) async {
  await _getPossession();

  // 払戻処理
  _possession += _fee;

  _deleteFee(_id);

  await _pref.setPossession(_possession);
  _bloc.deposit.add(_possession);
  _bloc.payment.add(_fee);

  refundNotification(_context);
}

_deleteFee(int _id) async {
  final _db = ApplicationDatabase.instance;
  await _db.delete(_id);
}

// 訂正
correct(BuildContext _context, ApplicationBloc _bloc, int _id, int _fee) async {
  await _getPossession();
  await _inputValue(_context, _fee);

  int _result;
  if (_value == null) {
    // 変更していない
    _result = 0;
  } else {
    // 訂正処理
    _difference = _fee - _value;
    if (_difference == 0) {
      // 変更していない
      _result = 0;
    } else if (_difference < 0 && _possession < _difference.abs()) {
      // 差額が所持金より多い
      _result = -1;
    } else {
      // 変更した
      _result = 1;

      //
      _possession += _difference;

      _updateFee(_id, _possession);

      await _pref.setPossession(_possession);
      _bloc.deposit.add(_possession);
      _bloc.payment.add(_value);
    }
  }

  correctNotification(_context, _result);
}

_updateFee(int _id, int _value) async {
  Map<String, dynamic> _feeData = {
    ApplicationDatabase.columnId: _id,
    ApplicationDatabase.columnFee: _value,
  };

  final _db = ApplicationDatabase.instance;
  await _db.update(_feeData);
}

editSetting(BuildContext _context, ApplicationBloc _bloc, int _index) async {
  await _getSetting(_index);
  _setting = _setting ??= settingListItem[_index][3];

  await _inputValue(_context, int.parse(_setting));
  _value = _value ??= 0;

  await _pref.setSetting(_index, _value.toString());

  settingNotification(_context, _value);
}

_getSetting(int _index) async {
  await _pref.getSetting(_index);
  _setting = _pref.getSettingValue();
}