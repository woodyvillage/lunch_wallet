import 'package:flutter/material.dart';
import 'package:popup_menu/popup_menu.dart';

import 'package:lunch_wallet/common/bloc.dart';
import 'package:lunch_wallet/common/resource.dart';
import 'package:lunch_wallet/dto/payment.dart';
import 'package:lunch_wallet/model/accounting.dart';

void showPopup(BuildContext _context, ApplicationBloc _bloc, GlobalKey _key, PaymentDto _dto) {
  PopupMenu _menu = PopupMenu(
    context: _context,
    backgroundColor: Colors.teal,
    lineColor: Colors.tealAccent,
    maxColumn: 2,
    items: [
      MenuItem(
        title: buttons[btnMod][settingTitle],
        textStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        image: buttons[btnMod][settingIcon],
        list: [_context, _bloc, _dto],
      ),
      MenuItem(
        title: buttons[btnDel][settingTitle],
        textStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        image: buttons[btnDel][settingIcon],
        list: [_context, _bloc, _dto],
      ),
    ],
    onClickMenu: popupMenuSelected,
  );
  _menu.show(widgetKey: _key);
}

void popupMenuSelected(MenuItemProvider _menu) async {
  List _item = _menu.menuList;
  switch(_menu.menuTitle) {
    case '編集':
      await correct(_item[0], _item[1], _item[2]);
      break;
    case '削除':
      await refund(_item[0], _item[1], _item[2]);
      break;
  }
}