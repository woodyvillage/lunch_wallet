import 'package:flutter/material.dart';

import 'package:lunch_wallet/view/wallet/amounttext.dart';
import 'package:lunch_wallet/view/wallet/depositbutton.dart';

class Wallet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      itemExtent: 70,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              ),
            ),
            Expanded(
              flex: 40,
              child: AmountText(),
            ),
            Expanded(
              flex: 20,
              child: DepositButton(),
            ),
          ],
        ),
      ],
    );
  }
}