import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:lunch_wallet/common/bloc.dart';
import 'package:lunch_wallet/model/accounting.dart';

class AmountText extends StatefulWidget {
  @override
  _AmountTextState createState() => _AmountTextState();
}

class _AmountTextState extends State<AmountText> {
  ApplicationBloc bloc;

  @override 
  void didChangeDependencies() {
    // 起動時の最初の一回
    super.didChangeDependencies();
    bloc = Provider.of<ApplicationBloc>(context);
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
      bloc.deposit.add(_possession);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'ウォレット残高',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 22,
            ),
          ),
          Padding(padding: const EdgeInsets.symmetric(vertical: 1)),
          StreamBuilder(
            stream: bloc.possession,
            builder: (context, snapshot) {
              return Text(
                '${snapshot.data}円',
                style: TextStyle(fontSize: 20),
              );
            },
          ),
        ],
      ),
    );
  }
}