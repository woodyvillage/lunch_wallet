import 'package:flutter/material.dart';

import 'package:lunch_wallet/common/bloc.dart';
import 'package:lunch_wallet/common/preference.dart';
import 'package:lunch_wallet/dao/menu.dart';
import 'package:lunch_wallet/dto/menu.dart';
import 'package:lunch_wallet/model/dialog.dart';
import 'package:lunch_wallet/model/notification.dart';
import 'package:lunch_wallet/util/resource.dart';

dynamic _result;

final ApplicationPreference _pref = ApplicationPreference();

// 設定値の取得
Future _getSetting(String _key, dynamic _value) async {
  _result = await _pref.getValue(_key, _value);
  _result ??= _value;
  return _result;
}

Future getSettingByName(String _key, dynamic _value) async {
  return await _getSetting(_key, _value);
}

Future getSettingByIndex(int _index) async {
  return await _getSetting(
      settings[_index][settingColumn], settings[_index][settingDefault]);
}

// 設定値の更新
Future _setSetting(String _key, dynamic _value) async {
  await _pref.setValue(_key, _value);
}

Future setSettingByName(String _key, dynamic _value) async {
  return await _setSetting(_key, _value);
}

setSetting(BuildContext _context, ApplicationBloc _bloc, int _index) async {
  dynamic _setting = await getSettingByIndex(_index);
  _result = await showSingleDialog(
    context: _context,
    title: settings[_index][settingTitle],
    value: _setting,
    initial: settings[_index][settingDefault],
  );
  if (_result != null && _result != '') {
    await _pref.setValue(settings[_index][settingColumn], _result);
  }

  settingNotification(_context, (_result == null || _result == ''));
}

setRangeSetting(
    BuildContext _context, ApplicationBloc _bloc, int _index) async {
  // 設定値
  int _value = await getSettingByIndex(_index);

  // 最小値
  int _minimum = 0;
  if (settings[_index][settingMinimum] != 0) {
    _minimum = await getSettingByIndex(settings[_index][settingMinimum]);
  }

  // 最大値
  int _maximum = 999999;
  if (settings[_index][settingMaximum] != 0) {
    _maximum = await getSettingByIndex(settings[_index][settingMaximum]);
  }

  print('editRangSetting: [min]:$_minimum [max]:$_maximum, [now]:$_value');

  int _buffer = await showSingleDialog(
      context: _context,
      title: settings[_index][settingTitle],
      value: _value,
      initial: settings[_index][settingDefault]);
  if (_buffer != null) {
    if (_minimum <= _buffer && _buffer <= _maximum) {
      await _pref.setValue(settings[_index][settingColumn], _buffer);
    } else {
      _buffer = null;
    }
  }

  settingNotification(_context, _buffer == null);
}

Future setCatalog(MenuDto _dto) async {
  MenuDao _dao = MenuDao();

  if (_dto.shop == null ||
      _dto.name == null ||
      _dto.note == null ||
      _dto.price == null) {
    return 1;
  }

  if (_dto.id == null) {
    // 新規登録
    var count = await _dao.selectConditionsCount(_dto);
    if (count == 0) {
      await _dao.insert(_dto);
      return 0;
    } else {
      return 2;
    }
  } else {
    // 更新登録
    var count = await _dao.selectIndexCount(_dto);
    if (count == 0) {
      await _dao.insert(_dto);
      return 0;
    } else {
      await _dao.update(_dto);
      return 0;
    }
  }
}

updSetting(int _index, dynamic _value) async {
  await _pref.setValue(settings[_index][settingColumn], _value);
}
