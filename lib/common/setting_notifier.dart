import 'package:flutter/material.dart';

import 'package:lunch_wallet/model/setting.dart';
import 'package:lunch_wallet/util/resource.dart';

class SettingNotifier extends ChangeNotifier {
  bool _isAuto;
  bool get autoPayment => _isAuto;

  changeMode() async {
    _isAuto = await getSettingByIndex(isAuto);

    notifyListeners();
  }
}