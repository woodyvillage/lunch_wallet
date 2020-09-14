import 'package:sticky_and_expandable_list/sticky_and_expandable_list.dart';

import 'package:lunch_wallet/dto/menu.dart';

class CatalogDto implements ExpandableListSection<MenuDto> {
  bool expanded;
  List<MenuDto> items;
  String shopname;

  @override
  List<MenuDto> getItems() {
    return items;
  }

  @override
  bool isSectionExpanded() {
    return expanded;
  }

  @override
  void setSectionExpanded(bool expanded) {
    this.expanded = expanded;
  }
}