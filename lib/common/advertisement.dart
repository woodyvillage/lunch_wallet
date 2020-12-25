import 'dart:io';
import 'package:flutter/material.dart';
import 'package:admob_flutter/admob_flutter.dart';

class ApplicationAdvertisement {
  String _getBannerAdUnitId() {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2248232694488898/1757465882';
    } else if (Platform.isIOS) {
      return null;
    }
    return null;
  }

  bool _isVisible(int _index, int _interval) {
    if (_index == null || _interval == null) {
      return true;
    } else {
      if (_index % _interval == 0) {
        return true;
      } else {
        return false;
      }
    }
  }

  Widget getBanner({
    @required double width,
    int index,
    int interval,
  }) {
    if (_isVisible(index, interval)) {
      return AdmobBanner(
        adUnitId: _getBannerAdUnitId(),
        adSize: AdmobBannerSize.ADAPTIVE_BANNER(
          width: width.toInt(),
        ),
      );
    } else {
      return Container();
    }
  }
}
