import 'dart:io';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';

import 'package:lunch_wallet/util/resource.dart';

class ApplicationAdvertisement {
  String _getBannerAdUnitId() {
    if (Platform.isAndroid) {
      // return testCode;
      return liveCode;
    } else if (Platform.isIOS) {
      return null;
    }
    return null;
  }

  bool _isVisible(int _index, int _interval) {
    if (_getBannerAdUnitId() != liveCode) {
      return false;
    }

    return _index == null && _interval == null
        ? true
        : _index % _interval == 0
            ? true
            : false;
  }

  Widget getBanner({
    @required double width,
    @required bool isInvalidAds,
    int index,
    int interval,
  }) {
    if (_isVisible(index, interval)) {
      if (!isInvalidAds) {
        return AdmobBanner(
          adUnitId: _getBannerAdUnitId(),
          adSize: AdmobBannerSize.ADAPTIVE_BANNER(
            width: width.toInt(),
          ),
        );
      } else {
        return Container();
      }
    } else {
      return Container();
    }
  }
}
