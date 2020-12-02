import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

//
_setNotification({
  @required BuildContext context,
  @required String message,
  @required bool isError,
}) {
  if (isError) {
    Flushbar(
      margin: EdgeInsets.all(8),
      message: message,
      icon: Icon(
        Icons.error_outline,
        size: 28,
        color: Colors.red[300],
      ),
      duration: Duration(seconds: 2),
      leftBarIndicatorColor: Colors.red,
      forwardAnimationCurve: Curves.easeOutExpo,
      reverseAnimationCurve: Curves.easeOutExpo,
    )..show(context);
  } else {
    Flushbar(
      margin: EdgeInsets.all(8),
      message: message,
      icon: Icon(
        Icons.info_outline,
        size: 28,
        color: Colors.blue[300],
      ),
      duration: Duration(seconds: 2),
      leftBarIndicatorColor: Colors.blue,
      forwardAnimationCurve: Curves.easeOutExpo,
      reverseAnimationCurve: Curves.easeOutExpo,
    )..show(context);
  }
}

//
depositNotification(BuildContext _context, bool _iserror) {
  _setNotification(
    context: _context,
    message: _iserror ? '入金を行いませんでした' : '入金を行いました',
    isError: _iserror,
  );
}

//
receiptNotification(BuildContext _context, int _fee) {
  _setNotification(
    context: _context,
    message: _fee == 0 ? '残高が足りませんでした' : '支払いました',
    isError: (_fee == 0),
  );
}

//
refundNotification(BuildContext _context, bool _iserror) {
  _setNotification(
    context: _context,
    message: _iserror ? '残高が不足します' : '支払履歴を削除しました',
    isError: _iserror,
  );
}

//
correctNotification(BuildContext _context, int _value) {
  if (_value == 0) {
    _setNotification(
      context: _context,
      message: '訂正を行いませんでした',
      isError: true,
    );
  } else if (_value < 0) {
    _setNotification(
      context: _context,
      message: '残高が足りませんでした',
      isError: true,
    );
  } else {
    _setNotification(
      context: _context,
      message: '支払額を訂正しました',
      isError: false,
    );
  }
}

//
settingNotification(BuildContext _context, bool _iserror) {
  _setNotification(
    context: _context,
    message: _iserror ? '設定を変更しませんでした' : '設定を変更しました',
    isError: _iserror,
  );
}

//
catalogNotification(BuildContext _context) {
  _setNotification(
    context: _context,
    message: 'メニューを追加しました',
    isError: false,
  );
}
