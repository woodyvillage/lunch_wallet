import 'package:flutter/material.dart';

import 'package:lunch_wallet/view/wallet/balance.dart';
import 'package:lunch_wallet/view/wallet/wallet.dart';

class ApplicationWallet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          // ウォレット
          Container(
            margin: const EdgeInsets.all(10),
            height: 70,
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