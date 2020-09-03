import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:lunch_wallet/common/bloc.dart';
import 'package:lunch_wallet/model/accounting.dart';

class Button extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<ApplicationBloc>(context);

    return FloatingActionButton.extended(
      backgroundColor: Theme.of(context).primaryColorDark,
      icon: Icon(Icons.restaurant),
      label: Text('支払'),
      onPressed: () async {
        // 支払
        await payment(context, bloc);
      },
    );
  }
}