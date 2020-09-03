import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:lunch_wallet/common/bloc.dart';
import 'package:lunch_wallet/model/accounting.dart';

class DepositButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<ApplicationBloc>(context);

    return RaisedButton.icon(
      color: Colors.green,
      textColor: Colors.white,
      icon: Icon(
        Icons.add,
        color: Colors.white,
      ),
      label: Text('入金'),
      onPressed: () async {
        // 入金
        await deposit(context, bloc);
      },
    );
  }
}