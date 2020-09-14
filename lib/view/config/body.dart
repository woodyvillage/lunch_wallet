import 'package:flutter/material.dart';

import 'package:lunch_wallet/common/resource.dart';
import 'package:lunch_wallet/view/config/config.dart';

class ApplicationSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        itemCount: settings.length,
        itemBuilder: (context, index) {
          return Config(index: index);
        },
      ),
    );
  }
}