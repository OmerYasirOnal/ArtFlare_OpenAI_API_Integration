import 'package:get/get.dart';
import 'dart:io' show Platform;
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobController extends GetxController {
  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  final bannerAd = BannerAd(
          size: AdSize.banner,
          adUnitId: Platform.isAndroid
              ? 'ca-app-pub-9920930529636149/7402809920'
              : 'ca-app-pub-9920930529636149/4518993260',
          listener: const BannerAdListener(),
          request: const AdRequest())
      .obs;

  Future<void> loadBanner() async {
    await bannerAd.value.load();
  }

  Future<void> _createInterstitialAd() async {
    InterstitialAd.load(
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-9920930529636149/7402809920'
            : 'ca-app-pub-9920930529636149/4518993260',
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts < 3) {
              _createInterstitialAd();
            }
          },
        ));
  }

  void showInterstitialAd() async {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  void onInit() {
    super.onInit();
    MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
        testDeviceIds: Platform.isAndroid
            ? ["064E21036684F9AA5AECA3D68D472ECF"]
            : ["333f643dc275856d9b85bdf8279819eb"]));
    _createInterstitialAd();
  }
}
