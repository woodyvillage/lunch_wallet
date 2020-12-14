import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_ex/path_provider_ex.dart';

import 'package:lunch_wallet/common/bloc.dart';
import 'package:lunch_wallet/common/preference.dart';
import 'package:lunch_wallet/common/table.dart';
import 'package:lunch_wallet/model/notification.dart';
import 'package:lunch_wallet/util/resource.dart';
import 'package:lunch_wallet/util/table.dart';

class ApplicationData {
  Future<String> get _localPath async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    return documentsDirectory.path;
  }

  Future<String> get _externalPath async {
    List<StorageInfo> _storageInfo;
    try {
      _storageInfo = await PathProviderEx.getStorageInfo();
    } on PlatformException {}

    return _storageInfo.length > 1 ? _storageInfo[1].appFilesDir : null;
  }

  Future<File> get _localFile async {
    final _path = await _externalPath;
    return _path == null ? null : File('$_path/lunch_wallet');
  }

  Future<bool> write(String _value) async {
    try {
      final file = await _localFile;
      file.writeAsString('$_value', flush: true);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> read() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      return null;
    }
  }

  void exportData(BuildContext _context) async {
    final ApplicationDatabase instance =
        ApplicationDatabase.privateConstructor();
    instance.database = null;

    String _localpath = await _localPath;
    File _file = File('$_localpath/${TableUtil.databaseName}');
    String _externalpath = await _externalPath;
    _file.copy('$_externalpath/${TableUtil.databaseName}');

    await instance.database;

    final ApplicationPreference _pref = ApplicationPreference();
    int _saving = await _pref.getValue('savings', 0);
    int _min = await _pref.getValue(
        settings[minFee][settingColumn], settings[minFee][settingDefault]);
    int _max = await _pref.getValue(
        settings[maxFee][settingColumn], settings[maxFee][settingDefault]);
    String _nameFee = await _pref.getValue(
        settings[nameFee][settingColumn], settings[nameFee][settingDefault]);
    String _nameDeposit = await _pref.getValue(
        settings[nameDeposit][settingColumn],
        settings[nameDeposit][settingDefault]);
    bool _isAuto = await _pref.getValue(
        settings[isAuto][settingColumn], settings[isAuto][settingDefault]);

    bool _result =
        await write('$_min,$_max,$_nameFee,$_nameDeposit,$_isAuto,$_saving');

    exportNotification(_context, _result);
  }

  importData(BuildContext _context, ApplicationBloc _bloc) async {
    final ApplicationDatabase instance =
        ApplicationDatabase.privateConstructor();
    instance.database = null;

    String _externalpath = await _externalPath;
    File _file = File('$_externalpath/${TableUtil.databaseName}');
    String _localpath = await _localPath;
    _file.copy('$_localpath/${TableUtil.databaseName}');

    await instance.database;

    String _buffer = await read();
    if (_buffer == null) {
      importNotification(_context, false);
      return;
    }
    List<String> _array = _buffer.split(',');

    final ApplicationPreference _pref = ApplicationPreference();
    if (_array[0] != null && _array[0] != 'null') {
      await _pref.setValue(
          settings[minFee][settingColumn], int.parse(_array[0]));
    }
    if (_array[1] != null && _array[1] != 'null') {
      await _pref.setValue(
          settings[maxFee][settingColumn], int.parse(_array[1]));
    }
    if (_array[2] != null && _array[2] != 'null') {
      await _pref.setValue(settings[nameFee][settingColumn], _array[2]);
    }
    if (_array[3] != null && _array[3] != 'null') {
      await _pref.setValue(settings[nameDeposit][settingColumn], _array[3]);
    }
    if (_array[4] != null && _array[4] != 'null') {
      _array[4] == true.toString()
          ? await _pref.setValue(settings[isAuto][settingColumn], true)
          : await _pref.setValue(settings[isAuto][settingColumn], false);
    }
    if (_array[5] != null && _array[5] != 'null') {
      await _pref.setValue('savings', int.parse(_array[5]));
    }

    _bloc.deposit.add(int.parse(_array[5]));
    _bloc.payment.add(0);

    importNotification(_context, true);
  }
}
