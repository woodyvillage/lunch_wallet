import 'package:flutter/material.dart';

import 'package:lunch_wallet/view/wallet/walletdisplay.dart';
import 'package:lunch_wallet/view/wallet/walletbutton.dart';

class Wallet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      itemExtent: 70,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // アクセント
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(color: Theme.of(context).primaryColorDark),
              ),
            ),
            // 残高表示
            Expanded(
              flex: 40,
              child: WalletText(),
            ),
            // 入金ボタン
            Expanded(
              flex: 20,
              child: WalletButton(),
            ),
          ],
        ),
      ],
    );
  }
}