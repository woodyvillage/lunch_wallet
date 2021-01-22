import 'package:purchases_flutter/purchases_flutter.dart';

import 'package:lunch_wallet/dto/purchase.dart';
import 'package:lunch_wallet/util/resource.dart';

class PurchaseDao {
  Future<List<PurchaseDto>> getPurchase() async {
    var purchase = <PurchaseDto>[];

    await Purchases.setup(purchaseCode);
    PurchaserInfo _purchaserInfo = await Purchases.getPurchaserInfo();
    Offerings _offerings = await Purchases.getOfferings();
    List<Package> _packages = _offerings.current.availablePackages;

    for (Package _package in _packages) {
      var _purchase = PurchaseDto()
        ..title = _package.product.title
        ..description = _package.product.description
        ..product = _package.identifier
        ..price = _package.product.priceString
        ..isActive =
            _purchaserInfo.entitlements.all[_package.identifier] == null
                ? false
                : _purchaserInfo.entitlements.all[_package.identifier].isActive
        ..package = _package;
      purchase.add(_purchase);
    }

    return purchase;
  }
}
