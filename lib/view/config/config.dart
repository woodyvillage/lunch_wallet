import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:lunch_wallet/common/bloc.dart';
import 'package:lunch_wallet/model/accounting.dart';
import 'package:lunch_wallet/model/setting.dart';

class ApplicationConfig extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _appBloc = Provider.of<ApplicationBloc>(context);

    return Scaffold(
      // キーボードが表示されてもbottom overflowが発生しないようにする
      resizeToAvoidBottomPadding: false,

      body: ListView.builder(
        itemCount: settingListItem.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: Text(settingListItem[index][0]),
              subtitle: Text(settingListItem[index][1]),
              trailing:Icon(Icons.chevron_right),
              onTap: () {
                editSetting(context, _appBloc, index);
              }
          );
        },
      ),
    );
  }
}