import 'package:lunch_wallet/common/table.dart';

class MenuDto {
  int id;
  String shop;
  String name;
  String note;
  int price;
  String icon;

  MenuDto({this.id, this.shop, this.name, this.note, this.price, this.icon});

  factory MenuDto.parse(Map<String, dynamic> _record) => MenuDto(
    id: _record[ApplicationDatabase.cId],
    shop: _record[ApplicationDatabase.cShop],
    name: _record[ApplicationDatabase.cName],
    note: _record[ApplicationDatabase.cNote],
    price: _record[ApplicationDatabase.cPrice],
    icon: _record[ApplicationDatabase.cIcon],
  );

  Map<String, dynamic> toMap() => {
    ApplicationDatabase.cId: this.id,
    ApplicationDatabase.cShop: this.shop,
    ApplicationDatabase.cName: this.name,
    ApplicationDatabase.cNote: this.note,
    ApplicationDatabase.cPrice: this.price,
    ApplicationDatabase.cIcon: this.icon,
  };
}