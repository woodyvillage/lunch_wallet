import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:lunch_wallet/common/bloc.dart';
import 'package:lunch_wallet/common/resource.dart';
import 'package:lunch_wallet/model/setting.dart';

class Config extends StatelessWidget {
  Config({Key key, this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    final _appBloc = Provider.of<ApplicationBloc>(context);

    if (settings[index][settingCaption]) {
      return Container(
        color: Theme.of(context).dividerColor,
        child: ListTile(
          title: Text(settings[index][settingTitle]),
          onTap: () {}
        ),
      );
    } else {
      if (settings[index][settingDetail] == null) {
        // noteがない形式
        return ListTile(
          title: Text(settings[index][settingTitle]),
          trailing: Icon(Icons.chevron_right),
          onTap: () {
            if (settings[index][settingMinimum] == null || settings[index][settingMaximum] == null) {
              editSetting(context, _appBloc, index);
            } else {
              editRangeSetting(context, _appBloc, index);
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
              editSetting(context, _appBloc, index);
            } else {
              editRangeSetting(context, _appBloc, index);
            }
          }
        );
      }
    }
  }
}