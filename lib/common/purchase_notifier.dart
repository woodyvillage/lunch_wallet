import 'package:flutter/material.dart';

import 'package:lunch_wallet/dao/purchase.dart';
import 'package:lunch_wallet/dto/purchase.dart';

class PurchaseNotifier extends ChangeNotifier {
  List<PurchaseDto> _purchaseList;
  List<PurchaseDto> get purchaseList => _purchaseList;
  bool _isInvalidAds;
  bool get isInvalidAds => _isInvalidAds;

  getPurchase() async {
    PurchaseDao _dao = PurchaseDao();
    _purchaseList = await _dao.getPurchase();

    _isInvalidAds = false;
    for (PurchaseDto _purchase in _purchaseList) {
      _isInvalidAds = _purchase.isActive == true ? true : _isInvalidAds;
    }
    notifyListeners();
  }
}
