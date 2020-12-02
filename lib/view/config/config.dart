import 'package:flutter/material.dart';

import 'package:lunch_wallet/util/resource.dart';
import 'package:lunch_wallet/view/config/buttonconfig.dart';
import 'package:lunch_wallet/view/config/switchconfig.dart';
import 'package:lunch_wallet/view/config/textconfig.dart';

class Config extends StatelessWidget {
  Config({Key key, this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    if (settings[index][settingCaption]) {
      return Container(
        color: Theme.of(context).dividerColor,
        child: ListTile(
          title: Text(settings[index][settingTitle]),
          onTap: () {},
        ),
      );
    } else {
      if (settings[index][settingDefault] == null) {
        return ButtonConfig(index: index);
      } else if (settings[index][settingDefault] is bool) {
        return SwitchConfig(index: index);
      } else {
        return TextConfig(index: index);
      }
    }
  }
}
