import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

import 'package:lunch_wallet/common/resource.dart';
import 'package:lunch_wallet/view/contents/button.dart';

class ApplicationContents extends StatefulWidget {
  @override
  _ApplicationContentsState createState() => _ApplicationContentsState();
}

class _ApplicationContentsState extends State<ApplicationContents> {
  List<ScreenHiddenDrawer> _menuitems = List();

  @override
  void initState() {
    super.initState();

    for (List content in contents) {
      _menuitems.add(
        new ScreenHiddenDrawer(
          new ItemHiddenMenu(
            name: content[settingTitle].toString(),
            baseStyle: TextStyle(
              color: Colors.white70,
              fontSize: 20,
            ),
            selectedStyle: TextStyle(
              color: Colors.white70,
              fontSize: 20,
            ),
            colorLineSelected: content[settingColor],
            icon: Icon(
              content[settingIcon],
              color: Colors.white70,
            ),
          ),
          content[settingFunction],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      backgroundColorMenu: Colors.blueGrey,
      backgroundColorAppBar: Theme.of(context).primaryColor,
      slidePercent: 60,
      contentCornerRadius: 20,
      screens: _menuitems,
      enableShadowItensMenu: true,
      disableAppBarDefault: false,
      actionsAppBar: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          color: Theme.of(context).primaryColor,
          onPressed: () {},
        ),
      ],
      elevationAppBar: 14,
      tittleAppBar: Text(applicationName),
      isTitleCentered: true,
      paymentActionButton: WalletButton(),
      shopActionButton: BoardButton(),
    );
  }
}