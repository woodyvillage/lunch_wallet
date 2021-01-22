import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:lunch_wallet/util/resource.dart';
import 'package:lunch_wallet/view/contents/contents.dart';

class ApplicationFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 日本語のフォントが正しく表示される対応
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [Locale('ja', 'JP')],

      // アプリケーションテーマ
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData.dark(),

      // コンテンツ
      debugShowCheckedModeBanner: false,
      title: applicationName,
      home: ApplicationContents(),
    );
  }
}
