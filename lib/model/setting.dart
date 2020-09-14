import 'package:flutter/material.dart';

import 'package:lunch_wallet/common/bloc.dart';
import 'package:lunch_wallet/common/resource.dart';
import 'package:lunch_wallet/common/preference.dart';
import 'package:lunch_wallet/dao/menu.dart';
import 'package:lunch_wallet/dto/menu.dart';
import 'package:lunch_wallet/model/dialog.dart';
import 'package:lunch_wallet/model/notification.dart';

final ApplicationPreference _pref = ApplicationPreference();

Future getSetting(int _index) async {
  await _pref.getSetting(_index);
  return _pref.getSettingValue();
}

editSetting(BuildContext _context, ApplicationBloc _bloc, int _index) async {
  var _value = await getSetting(_index);
  _value ??= settings[_index][settingDefault];

  String _word;
  var _result = await showSingleDialog(context: _context, title: settings[_index][settingTitle], value: _value, initial: settings[_index][settingDefault]);
  if (_result != null) {
    _word = _result.toString();
  }

  if (_word != '' && _word != '') {
    await _pref.setSetting(_index, _word);
  }

  settingNotification(_context, (_word == null || _word == ''));
}

editRangeSetting(BuildContext _context, ApplicationBloc _bloc, int _index) async {
  var _buffer;

  // 設定値
  int _value = 0;
  _buffer = await getSetting(_index);
  _buffer ??= settings[_index][settingDefault];
  if (_buffer is String) {
      if (_buffer == null || _buffer == 'null') {
        _value = settings[_index][settingDefault];
      } else {
        _value = int.parse(_buffer);
      }
  } else {
    _value = _buffer;
  }

  // 最小値
  int _minimum = 0;
  if (settings[_index][settingMinimum] != 0) {
    _buffer = await getSetting(settings[_index][settingMinimum]);
    _buffer ??= settings[settings[_index][settingMinimum]][settingDefault];
    if (_buffer is String) {
      if (_buffer == null || _buffer == 'null') {
        _minimum = settings[settings[_index][settingMinimum]][settingDefault];
      } else {
        _minimum = int.parse(_buffer);
      }
    } else {
      _minimum = _buffer;
    }
  }

  // 最大値
  int _maximum = 0;
  if (settings[_index][settingMaximum] != 0) {
    _buffer = await getSetting(settings[_index][settingMaximum]);
    _buffer ??= settings[settings[_index][settingMaximum]][settingDefault];
    if (_buffer is String) {
      _buffer == 'null' ? _buffer = settings[settings[_index][settingMaximum]][settingDefault] : _buffer.toString();
    } else {
      _maximum = _buffer;
    }
  }

  print('editRangSetting: [min]:$_minimum [max]:$_maximum, [now]:$_value');

  _buffer = await showSingleDialog(context: _context, title: settings[_index][settingTitle], value: _value, initial: settings[_index][settingDefault]);
  if (_buffer != null ) {
    if (_minimum <= _buffer && _buffer <= _maximum) {
      await _pref.setSetting(_index, _buffer.toString());
    } else {
      _buffer = null;
    }
  }

  settingNotification(_context, _buffer == null);
}

Future editCatalog(BuildContext _context, MenuDto _dto) async {
  MenuDao _dao = MenuDao();

  if (_dto.shop == null || _dto.name == null || _dto.note == null || _dto.price == null) {
    return 1;
  }

  var count = await _dao.selectConditionsCount(_dto);
  if (count == 0) {
    await _dao.insert(_dto);
    return 0;
  } else {
    return 2;
  }
}