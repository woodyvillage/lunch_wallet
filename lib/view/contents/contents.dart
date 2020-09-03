import 'package:flutter/material.dart';

import 'package:lunch_wallet/view/contents/body.dart';
import 'package:lunch_wallet/view/contents/button.dart';
// import 'package:lunch_wallet/view/contents/header.dart';

// class ApplicationContents extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // キーボードが表示されてもbottom overflowが発生しないようにする
//       resizeToAvoidBottomPadding: false,

//       appBar: ApplicationHeader(),
//       body: Body(),
//       floatingActionButton: Button(),
//     );
//   }
// }

import 'package:lunch_wallet/view/config/config.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

class ApplicationContents extends StatefulWidget {
  @override
  _ApplicationContentsState createState() => _ApplicationContentsState();
}

class _ApplicationContentsState extends State<ApplicationContents> {
  List<ScreenHiddenDrawer> itens = new List();

  @override
  void initState() {
    super.initState();
    itens.add(
      new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: 'ウォレット',
          baseStyle: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 20,
          ),
          colorLineSelected: Colors.teal,
          icon: Icon(
            Icons.show_chart,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
        Body(),
      ),
    );
    itens.add(
      new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "設定",
          baseStyle: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 20,
          ),
          colorLineSelected: Colors.orange,
          icon: Icon(
            Icons.settings,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
        ApplicationConfig(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      backgroundColorMenu: Colors.blueGrey,
      backgroundColorAppBar: Theme.of(context).primaryColor,
      slidePercent: 60.0,
      contentCornerRadius: 20.0,
      screens: itens,
      enableShadowItensMenu: true,
      disableAppBarDefault: false,
      actionsAppBar: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          color: Theme.of(context).primaryColor,
          onPressed: () {},
        ),
      ],
      elevationAppBar: 14.0,
      tittleAppBar: Text('ランチウォレット'),
      isTitleCentered: true,
      floatingActionButton: Button(),
    );
  }
}