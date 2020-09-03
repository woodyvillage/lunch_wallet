import 'package:flutter/material.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:provider/provider.dart';

import 'package:lunch_wallet/common/bloc.dart';
import 'package:lunch_wallet/model/accounting.dart';

class Balance extends StatefulWidget {
  @override
  _BalanceState createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  ApplicationBloc _bloc;
  BuildContext _context;
  List<GlobalKey> _keylist = [];
  List<int> _selected = [];
  // int _selectedIndex;
  // int _selectedId;
  // int _selectedFee;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    _bloc = Provider.of<ApplicationBloc>(context);
    // 初回描画のためにBLOCに投入
    _bloc.payment.add(0);

    return StreamBuilder(
      stream: _bloc.balance,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // GlobalKey生成
          for (int i = 0; i < snapshot.data.length; i++) {
            _keylist.add(GlobalKey());
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text((snapshot.data[index])['date']),
                  subtitle: Text((snapshot.data[index])['fee'].toString()+'円'),
                  trailing: MaterialButton(
                    key: _keylist[index],
                    padding: const EdgeInsets.all(0),
                    minWidth: 5,
                    child: Icon(Icons.more_vert),
                    onPressed: () {
                      // _selectedIndex = index;
                      // _selectedId = (snapshot.data[index])['_id'];
                      // _selectedFee = (snapshot.data[index])['fee'];
                      _selected = [index, (snapshot.data[index])['_id'], (snapshot.data[index])['fee']];
                      showPopup();
                    },
                  ),
                ),
              );
            }
          );
        }else{
          return null;
        }
      }
    );
  }

  void showPopup() {
    PopupMenu.context = _context;
    PopupMenu _menu = PopupMenu(
      backgroundColor: Colors.teal,
      lineColor: Colors.tealAccent,
      maxColumn: 2,
      items: [
        MenuItem(
          title: '編集',
          textStyle: TextStyle(
            color: Colors.teal[100],
            fontWeight: FontWeight.w400,
          ),
          image: Icon(
            Icons.edit,
            color: Colors.teal[100],
          )
        ),
        MenuItem(
          title: '削除',
          textStyle: TextStyle(
            color: Colors.teal[100],
            fontWeight: FontWeight.w400,
          ),
          image: Icon(
            Icons.delete,
            color: Colors.teal[100],
          )
        ),
      ],
      onClickMenu: popupMenuSelected, 
    );
    _menu.show(widgetKey: _keylist[_selected[0]]);
  }

  void popupMenuSelected(MenuItemProvider item) async {
    switch(item.menuTitle) {
      case '編集':
        await correct(_context, _bloc, _selected[1], _selected[2]);
        break;
      case '削除':
        await refund(_context, _bloc, _selected[1], _selected[2]);
        break;
    }
  }
}