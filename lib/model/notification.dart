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
      message: message,
      icon: Icon(
        Icons.error_outline,
        size: 28.0,
        color: Colors.red[300],
        ),
      duration: Duration(seconds: 3),
      leftBarIndicatorColor: Colors.red,
    )..show(context);
  } else {
    Flushbar(
      message: message,
      icon: Icon(
        Icons.error_outline,
        size: 28.0,
        color: Colors.blue[300],
        ),
      duration: Duration(seconds: 3),
      leftBarIndicatorColor: Colors.blue,
    )..show(context);
  }
}

// 
depositNotification(BuildContext _context, int _value) {
  if (_value == 0) {
    _setNotification(
      context: _context,
      message: '入金を行いませんでした',
      isError: true,
    );
  } else {
    _setNotification(
      context: _context,
      message: '入金を行いました',
      isError: false,
    );
  }
}

// 
receiptNotification(BuildContext _context, int _value) {
  if (_value == 0) {
    _setNotification(
      context: _context,
      message: '残高が足りませんでした',
      isError: true,
    );
  } else {
    _setNotification(
      context: _context,
      message: '食費を支払いました',
      isError: false,
    );
  }
}

// 
refundNotification(BuildContext _context) {
  _setNotification(
    context: _context,
    message: '支払履歴を削除しました',
    isError: false,
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
settingNotification(BuildContext _context, int _value) {
  if (_value == 0) {
    _setNotification(
      context: _context,
      message: '設定を変更しませんでした',
      isError: true,
    );
  } else {
    _setNotification(
      context: _context,
      message: '設定を変更しました',
      isError: false,
    );
  }
}
