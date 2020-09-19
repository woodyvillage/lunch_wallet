import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:lunch_wallet/common/bloc.dart';
import 'package:lunch_wallet/model/setting.dart';
import 'package:lunch_wallet/util/resource.dart';

class TextConfig extends StatelessWidget {
  TextConfig({Key key, this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<ApplicationBloc>(context);

    if (settings[index][settingDetail] == null) {
      // noteがない形式
      return ListTile(
        title: Text(settings[index][settingTitle]),
        trailing: Icon(Icons.chevron_right),
        onTap: () {
          if (settings[index][settingMinimum] == null || settings[index][settingMaximum] == null) {
            setSetting(context, _bloc, index);
          } else {
            setRangeSetting(context, _bloc, index);
          }
        }
      );
    } else {
      // noteがある形式
      return ListTile(
        title: Text(settings[index][settingTitle]),
        subtitle: Text(settings[index][settingDetail]),
        trailing: Icon(Icons.chevron_right),
        onTap: () {
          if (settings[index][settingMinimum] == null || settings[index][settingMaximum] == null) {
            setSetting(context, _bloc, index);
          } else {
            setRangeSetting(context, _bloc, index);
          }
        }
      );
    }
  }
}