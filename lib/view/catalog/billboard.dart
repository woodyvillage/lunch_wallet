import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sticky_and_expandable_list/sticky_and_expandable_list.dart';

import 'package:lunch_wallet/common/bloc.dart';
import 'package:lunch_wallet/common/notifier.dart';
import 'package:lunch_wallet/dto/catalog.dart';
import 'package:lunch_wallet/dto/menu.dart';
import 'package:lunch_wallet/model/accounting.dart';

class Billboard extends StatefulWidget {
  @override
  _BillboardState createState() => _BillboardState();
}

class _BillboardState extends State<Billboard> {
  ApplicationBloc _bloc;
  List<CatalogDto> _catalogList;

  @override 
  void didChangeDependencies() {
    // 起動時の最初の一回
    super.didChangeDependencies();
    _bloc = Provider.of<ApplicationBloc>(context);
  }

  @override
  void initState() {
    super.initState();
    _getCatalog();
  }

  _getCatalog() async {
    _catalogList = context.read<CatalogNotifier>().getAllCatalog();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _catalogList = context.select((CatalogNotifier counter) => counter.catalogList);
    if (_catalogList != null) {
      return SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverExpandableList(
              builder: SliverExpandableChildDelegate<MenuDto, CatalogDto>(
              sectionList: _catalogList,
                headerBuilder: _buildHeader,
                addAutomaticKeepAlives : true,
                itemBuilder: (context, sectionIndex, itemIndex, index) {
                  return ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      child: (_catalogList[sectionIndex].items[itemIndex].icon != null)
                        ? Image.file(
                          File(_catalogList[sectionIndex].items[itemIndex].icon),
                          fit: BoxFit.cover,
                        )
                        : Image.asset(
                          'images/noimage.png',
                          fit: BoxFit.cover,
                        ),
                    ),
                    title: Text(_catalogList[sectionIndex].items[itemIndex].name),
                    subtitle: Text(_catalogList[sectionIndex].items[itemIndex].note),
                    trailing: CircleAvatar(
                      radius: 30,
                      child: Text(_catalogList[sectionIndex].items[itemIndex].price.toString()),
                    ),
                    onLongPress: () async {
                      await catalogPayment(context, _bloc, _catalogList[sectionIndex].items[itemIndex]);
                    }
                  );
                },
              ),
            ),
          ],
        ),
      );
    } else {
      return SafeArea(
        child: Container(),
      );
    }
  }

  Widget _buildHeader(BuildContext context, int sectionIndex, int index) {
    CatalogDto _supplier = _catalogList[sectionIndex];
    return InkWell(
      child: Container(
        color: Theme.of(context).toggleableActiveColor,
        height: 48,
        padding: EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child: Text(
          _supplier.shopname,
          style: TextStyle(color: Colors.white),
        ),
      ),
      onTap: () {
        setState(() {
          _supplier.setSectionExpanded(!_supplier.isSectionExpanded());
        });
      },
    );
  }
}