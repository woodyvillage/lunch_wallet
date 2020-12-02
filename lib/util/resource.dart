import 'package:flutter/material.dart';

import 'package:lunch_wallet/view/catalog/body.dart';
import 'package:lunch_wallet/view/config/body.dart';
import 'package:lunch_wallet/view/wallet/body.dart';

// 固定文言
final applicationName = 'ランチウォレット';
final walletPossession = 'ウォレット残高';
final depositName = '入金額';

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
final settingParent = 7;

// drawer内に表示するメニュー
final contents = [
  [
    'ウォレット',
    Icons.show_chart,
    Colors.teal,
    ApplicationWallet(),
  ],
  [
    'メニュー',
    Icons.fastfood,
    Colors.deepOrange,
    ApplicationCatalog(),
  ],
  [
    '設定',
    Icons.settings,
    Colors.orange,
    ApplicationSetting(),
  ],
];

// buttonのリソース
final buttons = [
  [
    Text('入金'),
    Icon(Icons.add),
  ],
  [
    Text('支払'),
    Icon(Icons.restaurant),
  ],
  [
    Text('追加'),
    Icon(Icons.create),
  ],
  [
    '編集',
    Icon(
      Icons.edit,
      color: Colors.white,
    ),
  ],
  [
    '削除',
    Icon(
      Icons.delete,
      color: Colors.white,
    ),
  ],
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
  ['入金', '', '', '', true, null, null, null],
  ['明細名', null, 'nameDeposit', 'ウォレットに入金', false, null, null, null],
  ['支払', '', '', '', true, null, null, null],
  ['自動支払', '支払額を自動計算します', 'isAuto', true, false, null, null, null],
  ['自動支払機能', '', '', '', true, null, null, null],
  ['最低金額', '自動支払機能での最低支払額', 'minFee', 700, false, 0, 6, 3],
  ['最高金額', '自動支払機能での最高支払額', 'maxFee', 900, false, 5, 0, 3],
  ['明細名', null, 'nameFee', 'ランチ代', false, null, null, 3],
  ['データ', '', '', '', true, null, null, null],
  ['読み込み', 'データを引き継ぐことができます', 'hasImport', null, false, null, null, null],
  ['書き出し', 'データを外部記憶装置に書き出します', 'hasExport', null, false, null, null, null],
];
final nameDeposit = 1;
final isAuto = 3;
final minFee = 5;
final maxFee = 6;
final nameFee = 7;
final hasimport = 9;
final hasExport = 10;

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
