import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;

import 'package:lunch_wallet/common/bloc.dart';
import 'package:lunch_wallet/common/setting_notifier.dart';
import 'package:lunch_wallet/model/accounting.dart';
import 'package:lunch_wallet/util/resource.dart';
import 'package:lunch_wallet/view/dialog/catalogpalette.dart';
import 'package:lunch_wallet/view/dialog/paymentpalette.dart';

class WalletButton extends StatefulWidget {
  @override
  _WalletButtonState createState() => _WalletButtonState();
}

class _WalletButtonState extends State<WalletButton> {
  ApplicationBloc _bloc;

  @override
  void didChangeDependencies() {
    // 起動時の最初の一回
    super.didChangeDependencies();
    _bloc = Provider.of<ApplicationBloc>(context);
  }

  @override
  void initState() {
    super.initState();
    _getPreference();
  }

  _getPreference() async {
    context.read<SettingNotifier>().changeMode();
    setState(() {});
  }

  _payment(bool _mode) async {
    if (_mode) {
      // 自動支払
      await payment(context, _bloc);
    } else {
      // 通常支払
      slideDialog.showSlideDialog(
        context: context,
        child: PaymentPalette(),
        barrierColor: Colors.black.withOpacity(0.7),
        backgroundColor: Theme.of(context).canvasColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool _mode = context.select((SettingNotifier counter) => counter.autoPayment);
    _mode ??= true;

    return FloatingActionButton.extended(
      backgroundColor: Theme.of(context).primaryColorDark,
      icon: buttons[btnPay][settingIcon],
      label: buttons[btnPay][settingTitle],
      onPressed: () async {
        // 支払
        await _payment(_mode);
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
          child: CatalogPalette(),
          barrierColor: Colors.black.withOpacity(0.7),
          backgroundColor: Theme.of(context).canvasColor,
        );
      }
    );
  }
}