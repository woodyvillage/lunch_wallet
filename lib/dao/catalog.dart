import 'package:lunch_wallet/dao/menu.dart';
import 'package:lunch_wallet/dto/catalog.dart';
import 'package:lunch_wallet/dto/menu.dart';
import 'package:lunch_wallet/util/table.dart';

class CatalogDao {
  Future<List<CatalogDto>> getAllSupplierMenu() async {
    var _catalog = List<CatalogDto>();

    MenuDao _dao = MenuDao();
    List<MenuDto> _supplierDto = await _dao.selectUnique(TableUtil.cShop);

    for (int i = 0; i < _supplierDto.length; i++) {
      List<MenuDto> _menudto = await _dao.select(TableUtil.cShop, _supplierDto[i].shop);
      var supplier = CatalogDto()
        ..shopname = _supplierDto[i].shop
        ..items = _menudto
        ..expanded = true;
      _catalog.add(supplier);
    }

    return _catalog;
  }
}