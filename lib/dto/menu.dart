import 'package:lunch_wallet/util/table.dart';

class MenuDto {
  int id;
  String shop;
  String name;
  String note;
  int price;
  String icon;

  MenuDto({this.id, this.shop, this.name, this.note, this.price, this.icon});

  factory MenuDto.parse(Map<String, dynamic> _record) => MenuDto(
    id: _record[TableUtil.cId],
    shop: _record[TableUtil.cShop],
    name: _record[TableUtil.cName],
    note: _record[TableUtil.cNote],
    price: _record[TableUtil.cPrice],
    icon: _record[TableUtil.cIcon],
  );

  Map<String, dynamic> toMap() => {
    TableUtil.cId: this.id,
    TableUtil.cShop: this.shop,
    TableUtil.cName: this.name,
    TableUtil.cNote: this.note,
    TableUtil.cPrice: this.price,
    TableUtil.cIcon: this.icon,
  };

  bool check() {
    if (this.shop == null || this.name == null || this.price == null) {
      return false;
    } else {
      return true;
    }
  }
}