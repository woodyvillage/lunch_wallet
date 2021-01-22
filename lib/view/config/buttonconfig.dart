import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:lunch_wallet/common/bloc.dart';
import 'package:lunch_wallet/common/data.dart';
import 'package:lunch_wallet/common/purchase_notifier.dart';
import 'package:lunch_wallet/model/purchasing.dart';
import 'package:lunch_wallet/util/resource.dart';

class ButtonConfig extends StatefulWidget {
  ButtonConfig({Key key, this.index}) : super(key: key);
  final int index;

  @override
  _ButtonConfigState createState() => _ButtonConfigState();
}

class _ButtonConfigState extends State<ButtonConfig> {
  ApplicationBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = Provider.of<ApplicationBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    bool _isInvalidAds = context.select(
        (PurchaseNotifier purchaseNotifier) => purchaseNotifier.isInvalidAds);
    dynamic _purchase = context.select(
        (PurchaseNotifier purchaseNotifier) => purchaseNotifier.purchaseList);
    return ListTile(
      title: Text(settings[widget.index][settingTitle]),
      subtitle: Text(settings[widget.index][settingDetail]),
      trailing: RaisedButton(
        child: Text(settings[widget.index][settingColumn]),
        splashColor: Colors.blueGrey,
        disabledColor: Colors.grey[500],
        onPressed: () async {
          setState(() {
            ApplicationData _data = ApplicationData();
            if (widget.index == noAds) {
              _isInvalidAds
                  ? purchaseInvalid(context)
                  : purchaseAdvertisement(context, _purchase);
            } else if (widget.index == hasimport) {
              _data.importData(context, _bloc);
            } else {
              _data.exportData(context);
            }
          });
        },
      ),
    );
  }
}
