import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:lunch_wallet/common/bloc.dart';
import 'package:lunch_wallet/model/accounting.dart';
import 'package:lunch_wallet/util/resource.dart';

class WalletText extends StatefulWidget {
  @override
  _WalletTextState createState() => _WalletTextState();
}

class _WalletTextState extends State<WalletText> {
  ApplicationBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = Provider.of<ApplicationBloc>(context);
  }

  @override
  void initState() {
    super.initState();
    _getPreference();
  }

  _getPreference() async {
    int _possession = await inquiry();
    // 起動時の最初の一回
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bloc.deposit.add(_possession);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // キャプション
          Text(
            walletPossession,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 22,
            ),
          ),
          Padding(padding: const EdgeInsets.symmetric(vertical: 1)),
          // 残高
          StreamBuilder(
            stream: _bloc.possession,
            builder: (context, snapshot) {
              return Text(
                '${snapshot.data}円',
                style: const TextStyle(fontSize: 20),
              );
            },
          ),
        ],
      ),
    );
  }
}