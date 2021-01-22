import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import 'package:lunch_wallet/model/dialog.dart';
import 'package:lunch_wallet/util/resource.dart';

dynamic _result;

// 広告抑止オプション
Future<void> purchaseAdvertisement(
    BuildContext _context, dynamic _purchase) async {
  List<String> _name = _purchase[0].title.split('(');
  _result = await showMessageDialog(
      context: _context,
      title: purchaseName,
      value: purchaseApproval +
          '\n\n商品：' +
          _name[0] +
          '\n金額：' +
          _purchase[0].price,
      cancel: true);
  if (_result != null && _result) {
    await Purchases.purchasePackage(_purchase[0].package);
  }
}

Future<void> purchaseInvalid(BuildContext _context) async {
  _result = await showMessageDialog(
      context: _context,
      title: purchaseName,
      value: 'すでにこの有料オプションは購入済です',
      cancel: false);
}
