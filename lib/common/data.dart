import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:lunch_wallet/common/preference.dart';
import 'package:lunch_wallet/util/resource.dart';

class ApplicationData {
  Future<String> get _localPath async {
    final directory = await getExternalStorageDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/lunch_wallet');
  }

  Future<File> write(String _value) async {
    final file = await _localFile;
    var result = file.writeAsString('$_value', flush: true);
    return result;
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

  void exportData() async {
    final ApplicationPreference _pref = ApplicationPreference();
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

    write('$_min,$_max,$_nameFee,$_nameDeposit,$_isAuto');
  }

  importData() async {
    String _buffer = await read();
    if (_buffer == null) {
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
  }
}
