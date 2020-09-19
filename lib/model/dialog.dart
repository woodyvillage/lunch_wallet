import 'package:flutter/material.dart';

import 'package:lunch_wallet/view/dialog/numberdialog.dart';
import 'package:lunch_wallet/view/dialog/textdialog.dart';

// 入力ダイアログ表示
Future showSingleDialog({
  @required BuildContext context,
  @required String title,
  dynamic value,
  dynamic initial,
  TransitionBuilder builder,
}) {
  Widget dialog;
  if (initial is int) {
    // null：初期表示なし
    dialog = NumberDialog(title: title, value: value);
  } else if (initial is String) {
    // null：初期表示なし
    dialog = TextDialog(title: title, value: value);
  }
  return showDialog(
    context: context,
    useRootNavigator: true,
    builder: (BuildContext context) {
      return builder == null ? dialog : builder(context, dialog);
    },
  );
}