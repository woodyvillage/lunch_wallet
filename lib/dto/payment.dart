import 'package:lunch_wallet/common/table.dart';

class PaymentDto {
  int id;
  String date;
  String name;
  String note;
  String shop;
  int price;
  String icon;

  PaymentDto({this.id, this.date, this.name, this.note, this.shop, this.price, this.icon});

  factory PaymentDto.parse(Map<String, dynamic> _record) => PaymentDto(
    id: _record[ApplicationDatabase.cId],
    date: _record[ApplicationDatabase.cDate],
    name: _record[ApplicationDatabase.cName],
    note: _record[ApplicationDatabase.cNote],
    shop: _record[ApplicationDatabase.cShop],
    price: _record[ApplicationDatabase.cPrice],
    icon: _record[ApplicationDatabase.cIcon],
  );

  Map<String, dynamic> toMap() => {
    ApplicationDatabase.cId: this.id,
    ApplicationDatabase.cDate: this.date,
    ApplicationDatabase.cName: this.name,
    ApplicationDatabase.cNote: this.note,
    ApplicationDatabase.cShop: this.shop,
    ApplicationDatabase.cPrice: this.price,
    ApplicationDatabase.cIcon: this.icon,
  };
}