import 'package:shared_preferences/shared_preferences.dart';

import 'package:lunch_wallet/model/setting.dart';

class ApplicationPreference {
  // 所持金
  int _possession = 0;
  String _value;

  getPossession() async {
    // SharedPreferencesに保存されている所持金を取得
    SharedPreferences pref = await SharedPreferences.getInstance();
    _possession = pref.getInt('savings');
    _possession = _possession ??= 0;
    print('ApplicationPreference.getPossession(): $_possession');
  }

  int getPossessionValue() {
    return _possession;
  }

  setPossession(int _value) async {
    // SharedPreferencesに保存されている所持金を更新
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('savings', _value);
    print('ApplicationPreference.setPossession(): $_value');
  }

  getSetting(int _index) async {
    // SharedPreferencesに保存されている所持金を取得
    SharedPreferences pref = await SharedPreferences.getInstance();
    _value = pref.getString(settingListItem[_index][2]);
    print('ApplicationPreference.getSetting(): ${settingListItem[_index][2]} -> $_value');
  }

  String getSettingValue() {
    return _value;
  }

  setSetting(int _index, String _value) async {
    // SharedPreferencesに保存されている所持金を更新
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(settingListItem[_index][2], _value);
    print('ApplicationPreference.setSetting(): ${settingListItem[_index][2]} -> $_value');
  }
}