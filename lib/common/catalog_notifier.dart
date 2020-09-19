import 'package:flutter/material.dart';

import 'package:lunch_wallet/dao/catalog.dart';
import 'package:lunch_wallet/dto/catalog.dart';

class CatalogNotifier extends ChangeNotifier {
  List<CatalogDto> _catalogList;
  List<CatalogDto> get catalogList => _catalogList;

  getAllCatalog() async {
    CatalogDao _dao = CatalogDao();
    _catalogList = await _dao.getAllSupplierMenu();

    notifyListeners();
  }
}