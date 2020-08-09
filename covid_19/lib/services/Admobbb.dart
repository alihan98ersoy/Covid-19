import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';


class AdvertService {
  static final AdvertService _instance = AdvertService._internal();
  factory AdvertService() => _instance;

  MobileAdTargetingInfo targetingInfo;

  MobileAdTargetingInfo getTargetinfo(){
    return targetingInfo;
  }

  String getAdMobAppId() {
    return Platform.isAndroid
        ? "ca-app-pub-8845518388017503~4241538977"
        : "ca-app-pub-8845518388017503~2703789112";
  }

  final String _bannerAd = Platform.isAndroid
      ? "ca-app-pub-8845518388017503/2747482141"
      : "ca-app-pub-8845518388017503/3414235557";

  final String _Intersinitial = Platform.isAndroid
      ? "ca-app-pub-8845518388017503/9859685408"
      : "ca-app-pub-8845518388017503/8993579886";

  final String _videoid = Platform.isAndroid
      ? "ca-app-pub-8845518388017503/1789623698"
      : "ca-app-pub-8845518388017503/6396170851";

  final String _testbanner = BannerAd.testAdUnitId;
  final String _testIntersinitial = InterstitialAd.testAdUnitId;

  String getVideoid(){
    return _videoid;
  }

  AdvertService._internal() {
    targetingInfo = MobileAdTargetingInfo();
  }

  showBanner() {
    BannerAd banner = BannerAd(
      adUnitId: _bannerAd,
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      },
    );

    banner
      ..load()
      ..show(
        // Positions the banner ad 60 pixels from the bottom of the screen
        anchorOffset: 100.0,
        // Positions the banner ad 10 pixels from the center of the screen to the right
        horizontalCenterOffset: 10.0,
        // Banner Position
        anchorType: AnchorType.bottom,
      );

    banner.dispose();
  }

  showIntersinitial() {
    InterstitialAd interstitialAd = InterstitialAd(
      adUnitId: _Intersinitial,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event is $event");
      },
    );
    interstitialAd
      ..load()
      ..show(
        anchorType: AnchorType.bottom,
        anchorOffset: 0.0,
        horizontalCenterOffset: 0.0,
      );

    interstitialAd.dispose();
  }
}
