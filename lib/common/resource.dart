import 'package:flutter/material.dart';

import 'package:lunch_wallet/view/catalog/body.dart';
import 'package:lunch_wallet/view/config/body.dart';
import 'package:lunch_wallet/view/wallet/body.dart';

// 固定文言
final applicationName = 'ランチウォレット';
final walletPossession = 'ウォレット残高';
final depositName = '入金額';
final depositItem = 'ウォレットに入金';

// 要素定義
final settingTitle = 0;
final settingDetail = 1;
final settingIcon = 1;
final settingColumn = 2;
final settingColor = 2;
final settingDefault = 3;
final settingFunction = 3;
final settingCaption = 4;
final settingMinimum = 5;
final settingMaximum = 6;

// drawer内に表示するメニュー
final contents = [
  ['ウォレット', Icons.show_chart, Colors.teal, ApplicationWallet()],
  ['ランチメニュー', Icons.fastfood, Colors.deepOrange, ApplicationCatalog()],
  ['設定', Icons.settings, Colors.orange, ApplicationSetting()],
];

// buttonのリソース
final buttons = [
  [Text('入金'), Icon(Icons.add)],
  [Text('支払'), Icon(Icons.restaurant)],
  [Text('追加'), Icon(Icons.create)],
  ['編集', Icon(Icons.edit, color: Colors.white,)],
  ['削除', Icon(Icons.delete, color: Colors.white,)],
  [Text('登録'), Icon(Icons.check_circle)],
  [Text('取消'), Icon(Icons.cancel)],
];
final btnDep = 0;
final btnPay = 1;
final btnAdd = 2;
final btnMod = 3;
final btnDel = 4;
final btnReg = 5;
final btnCan = 6;

// setting画面内に表示する項目
final settings = [
  ['自動支払機能', Icons.payment , '', '', true],
  ['最低金額', '自動支払機能での最低支払額を設定', 'minFee', 700, false, 0, 2],
  ['最高金額', '自動支払機能での最高支払額を設定', 'maxFee', 900, false, 1, 0],
  ['明細名', '自動支払機能での明細の件名を設定', 'nameFee', 'ランチ代', false, null, null],
];
final minFee = 1;
final maxFee = 2;
final nameFee = 3;

// pallet画面内に表示する項目
final catalogs = [
  ['ショップ', '店名 *'],
  ['メニュー', 'メニュー *'],
  ['備考', ''],
  ['値段', '値段 *'],
];
final catShop = 0;
final catName = 1;
final catNote = 2;
final catPrice = 3;