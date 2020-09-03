import 'dart:async';
import 'package:flutter/material.dart';

import 'package:lunch_wallet/view/wallet/depositdialog.dart';

// 入金ダイアログ表示
Future showDepositDialog({
  @required BuildContext context,
  int value,
  TransitionBuilder builder,
}) {
  final Widget dialog = DepositDialog(initial: value);
  return showDialog(
    context: context,
    useRootNavigator: true,
    builder: (BuildContext context) {
      return builder == null ? dialog : builder(context, dialog);
    },
  );
}