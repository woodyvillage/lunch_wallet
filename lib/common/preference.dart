import 'package:shared_preferences/shared_preferences.dart';

class ApplicationPreference {
  Future getValue(String _key, dynamic _value) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    if (_value is bool){
      _value = _pref.getBool(_key);
    } else if (_value is int) {
      _value = _pref.getInt(_key);
    } else if (_value is String) {
      _value = _pref.getString(_key);
    }

    print('ApplicationPreference.getValue(): $_key -> $_value');
    return _value;
  }

  setValue(String _key, dynamic _value) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    if (_value is bool){
      await _pref.setBool(_key, _value);
    } else if (_value is int) {
      await _pref.setInt(_key, _value);
    } else if (_value is String) {
      await _pref.setString(_key, _value);
    }

    print('ApplicationPreference.setValue(): $_key -> $_value');
  }
}