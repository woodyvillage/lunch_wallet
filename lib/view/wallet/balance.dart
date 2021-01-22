import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:lunch_wallet/common/advertisement.dart';
import 'package:lunch_wallet/common/bloc.dart';
import 'package:lunch_wallet/common/purchase_notifier.dart';
import 'package:lunch_wallet/dto/payment.dart';
import 'package:lunch_wallet/view/wallet/balancedetail.dart';
import 'package:lunch_wallet/view/wallet/balancepopup.dart';

class Balance extends StatefulWidget {
  @override
  _BalanceState createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  ApplicationBloc _bloc;
  List<GlobalKey> _keylist = [];

  @override
  void didChangeDependencies() {
    // 起動時の最初の一回
    super.didChangeDependencies();
    _bloc = Provider.of<ApplicationBloc>(context);
  }

  @override
  void initState() {
    super.initState();
    _flush();
  }

  _flush() async {
    // 起動時の最初の一回
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bloc.payment.add(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool _isInvalidAds = context.select(
        (PurchaseNotifier purchaseNotifier) => purchaseNotifier.isInvalidAds);

    return StreamBuilder(
        stream: _bloc.balance,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // GlobalKey生成
            for (int i = 0; i < snapshot.data.length; i++) {
              _keylist.add(GlobalKey());
            }
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ApplicationAdvertisement().getBanner(
                        width: MediaQuery.of(context).size.width,
                        isInvalidAds: _isInvalidAds,
                        index: index,
                        interval: 5,
                      ),
                      Card(
                        child: ListTile(
                          leading: circleAvatarItem(
                              context: context, data: snapshot.data[index]),
                          title: titleItem(data: snapshot.data[index]),
                          subtitle: subTitleItem(data: snapshot.data[index]),
                          trailing: MaterialButton(
                            key: _keylist[index],
                            padding: const EdgeInsets.all(0),
                            minWidth: 5,
                            child: Icon(Icons.more_vert),
                            onPressed: () {
                              PaymentDto _dto = PaymentDto(
                                id: snapshot.data[index].id,
                                name: snapshot.data[index].name,
                                date: snapshot.data[index].date,
                                price: snapshot.data[index].price,
                                mode: snapshot.data[index].mode,
                              );
                              showPopup(context, _bloc, _keylist[index], _dto);
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                });
          } else {
            return ListView();
          }
        });
  }
}
