import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import 'package:lunch_wallet/util/resource.dart';
import 'package:lunch_wallet/view/config/buttonconfig.dart';
import 'package:lunch_wallet/view/config/switchconfig.dart';
import 'package:lunch_wallet/view/config/textconfig.dart';

class Config extends StatefulWidget {
  Config({Key key, this.index}) : super(key: key);
  final int index;

  @override
  _ConfigState createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (settings[widget.index][settingCaption]) {
      if (settings[widget.index][settingDetail] == '') {
        return Container(
          color: Theme.of(context).dividerColor,
          child: ListTile(
            title: Text(settings[widget.index][settingTitle]),
            onTap: () {},
          ),
        );
      } else {
        return Container(
          color: Theme.of(context).dividerColor,
          child: ListTile(
            title: Text(settings[widget.index][settingTitle]),
            subtitle: Text('${_packageInfo.appName}(${_packageInfo.version})'),
            onTap: () {},
          ),
        );
      }
    } else {
      if (settings[widget.index][settingDefault] == null) {
        return ButtonConfig(index: widget.index);
      } else if (settings[widget.index][settingDefault] is bool) {
        return SwitchConfig(index: widget.index);
      } else {
        return TextConfig(index: widget.index);
      }
    }
  }
}
