import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:lunch_wallet/common/bloc.dart';
import 'package:lunch_wallet/model/accounting.dart';
import 'package:lunch_wallet/util/resource.dart';

class WalletButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<ApplicationBloc>(context);

    return RaisedButton.icon(
      color: Colors.green,
      textColor: Colors.white,
      icon: buttons[btnDep][settingIcon],
      label: buttons[btnDep][settingTitle],
      onPressed: () async {
        // 入金
        await deposit(context, bloc);
      },
    );
  }
}