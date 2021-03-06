import 'package:flutter/material.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:provider/provider.dart';

import 'package:lunch_wallet/common/bloc.dart';
import 'package:lunch_wallet/common/catalog_notifier.dart';
import 'package:lunch_wallet/common/purchase_notifier.dart';
import 'package:lunch_wallet/common/setting_notifier.dart';
import 'package:lunch_wallet/view/frame.dart';

void main() {
  // 広告初期化
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize();

  runApp(
    MultiProvider(
      providers: [
        Provider<ApplicationBloc>(create: (_) => ApplicationBloc()),
        ChangeNotifierProvider<CatalogNotifier>(
            create: (_) => CatalogNotifier()),
        ChangeNotifierProvider<SettingNotifier>(
            create: (_) => SettingNotifier()),
        ChangeNotifierProvider<PurchaseNotifier>(
            create: (_) => PurchaseNotifier()),
      ],
      child: ApplicationFrame(),
    ),
  );
}
