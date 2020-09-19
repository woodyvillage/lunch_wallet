import 'package:lunch_wallet/util/table.dart';

class PaymentDto {
  int id;
  String date;
  String name;
  String note;
  String shop;
  int price;
  String icon;
  int mode;

  PaymentDto({this.id, this.date, this.name, this.note, this.shop, this.price, this.icon, this.mode});

  factory PaymentDto.parse(Map<String, dynamic> _record) => PaymentDto(
    id: _record[TableUtil.cId],
    date: _record[TableUtil.cDate],
    name: _record[TableUtil.cName],
    note: _record[TableUtil.cNote],
    shop: _record[TableUtil.cShop],
    price: _record[TableUtil.cPrice],
    icon: _record[TableUtil.cIcon],
    mode: _record[TableUtil.cMode],
  );

  Map<String, dynamic> toMap() => {
    TableUtil.cId: this.id,
    TableUtil.cDate: this.date,
    TableUtil.cName: this.name,
    TableUtil.cNote: this.note,
    TableUtil.cShop: this.shop,
    TableUtil.cPrice: this.price,
    TableUtil.cIcon: this.icon,
    TableUtil.cMode: this.mode,
  };

  bool check() {
    if (this.shop == null || this.name == null || this.price == null) {
      return false;
    } else {
      return true;
    }
  }
}