import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseDto {
  String title;
  String description;
  String product;
  String price;
  bool isActive;
  Package package;

  PurchaseDto({
    this.title,
    this.description,
    this.product,
    this.price,
    this.isActive,
    this.package,
  });
}
