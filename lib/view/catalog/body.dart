import 'package:flutter/material.dart';

import 'package:lunch_wallet/view/catalog/billboard.dart';

class ApplicationCatalog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(0),
        height: MediaQuery.of(context).size.height,
        child: Billboard(),
      ),
    );
  }
}