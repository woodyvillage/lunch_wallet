import 'package:flutter/material.dart';

import 'package:lunch_wallet/view/balance/balance.dart';
import 'package:lunch_wallet/view/wallet/wallet.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          // 残高
          Container(
            margin: const EdgeInsets.all(10),
            height: 70.0,
            child: Wallet(),
          ),
          // 収支
          Container(
            height: MediaQuery.of(context).size.height - 170,
            child: Balance(),
          ),
        ],
      ),
    );
  }
}