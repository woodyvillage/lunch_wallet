import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;

import 'package:lunch_wallet/common/bloc.dart';
import 'package:lunch_wallet/common/resource.dart';
import 'package:lunch_wallet/model/accounting.dart';
import 'package:lunch_wallet/view/catalog/palette.dart';

class WalletButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<ApplicationBloc>(context);

    return FloatingActionButton.extended(
      backgroundColor: Theme.of(context).primaryColorDark,
      icon: buttons[btnPay][settingIcon],
      label: buttons[btnPay][settingTitle],
      onPressed: () async {
        // 支払
        await payment(context, _bloc);
      },
    );
  }
}

class BoardButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: Theme.of(context).primaryColorDark,
      icon: buttons[btnAdd][settingIcon],
      label: buttons[btnAdd][settingTitle],
      onPressed: () {
        // 登録画面
        slideDialog.showSlideDialog(
          context: context,
          child: Palette(),
          barrierColor: Colors.black.withOpacity(0.7),
          pillColor: Theme.of(context).primaryColorDark,
          backgroundColor: Theme.of(context).canvasColor,
        );
      }
    );
  }
}