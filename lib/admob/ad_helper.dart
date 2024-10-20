import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

enum BannerType { small, large }

AdHelper _adHelper = AdHelper();

AdHelper adHelper() {
  return _adHelper;
}

class AdHelper {
  bool _isAdInit = false;

  BannerAd? _bannerAd;

  void _loadBanner(
      Function(BannerAd) onBannerLoaded, BannerType bannerType) async {
    await _init();

    // if (_bannerAd != null) {
    //   await _bannerAd!.load();
    //   onBannerLoaded(_bannerAd!);
    //   return;
    // }

    _bannerAd = BannerAd(
      size: bannerType == BannerType.small ? AdSize.banner : AdSize.largeBanner,
      adUnitId: bannerType == BannerType.small
          ? _getSmallBannerId()
          : _getLargeBannerId(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          onBannerLoaded(ad as BannerAd);
        },
      ),
      request: const AdRequest(),
    );

    await _bannerAd!.load();
  }

  Future<void> _init() async {
    if (!_isAdInit) {
      await MobileAds.instance.initialize();
      _isAdInit = true;
    }
  }

//ATT 권한 요청
  Future<void> requestTrackingPermission() async {
    final trackingStatus =
        await AppTrackingTransparency.trackingAuthorizationStatus;

    if (trackingStatus == TrackingStatus.notDetermined) {
      final newStatus =
          await AppTrackingTransparency.requestTrackingAuthorization();
      print('Tracking permission: $newStatus');
    }
  }

//권한 동의에 따라 광고 요청
  void configureAdSettings(
      Function(BannerAd) onBannerLoaded, BannerType bannerType) async {
    final trackingStatus =
        await AppTrackingTransparency.trackingAuthorizationStatus;

    if (trackingStatus == TrackingStatus.authorized) {
      // 개인화된 광고 설정
      MobileAds.instance.updateRequestConfiguration(
        RequestConfiguration(
          tagForChildDirectedTreatment:
              TagForChildDirectedTreatment.unspecified,
          maxAdContentRating: MaxAdContentRating.g,
        ),
      );
    } else {
      // 비개인화된 광고 설정
      MobileAds.instance.updateRequestConfiguration(
        RequestConfiguration(
          tagForChildDirectedTreatment: TagForChildDirectedTreatment.no,
          maxAdContentRating: MaxAdContentRating.g,
        ),
      );
    }

    // 광고 로드 및 표시 (예시로 배너 광고)
    _loadBanner(onBannerLoaded, bannerType);
  }

//광고 id (작은 배너)
  String _getSmallBannerId() {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111'; // android 테스트 광고 id
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716'; // iOS 테스트 광고 id
    }
    throw StateError('Unsupported platform');
  }

//광고 id (큰 배너)
  String _getLargeBannerId() {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111'; // android 테스트 광고 id
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716'; // iOS 테스트 광고 id
    }
    throw StateError('Unsupported platform');
  }

  void dispose() {
    _isAdInit = false;
    _bannerAd?.dispose();
  }
}
