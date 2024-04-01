import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:torch_light/torch_light.dart';

abstract mixin class PostsRepo {
  Future<dynamic> fetchData();
}

class HomeController extends GetxController {
  // admob variable
  RxBool isAdmobAdLoaded = false.obs;

  RxBool isTorchOn = false.obs;

  //
  late BannerAd bannerAd;
  // Specify test device IDs
  List<String> testDeviceIds = ['0575CAB47D22DC86B10F328E6481D46D'];

  @override
  void onInit() {
    super.onInit();
    initBannerAd();
  }

  // Toggle torch
  void toggleTorch() async {
    try {
      final isTorchAvailable = await TorchLight.isTorchAvailable();
      if (isTorchAvailable) {
        if (!isTorchOn.value) {
          await TorchLight.enableTorch();
          isTorchOn.value = true;
        } else if (isTorchOn.value) {
          await TorchLight.disableTorch();
          isTorchOn.value = false;
        }
      }
    } on Exception catch (error) {
      // Handle error
      print(error.toString());
    }
  }

  // banner ad initialize
  Future<void> initBannerAd() async {
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: "ca-app-pub-3940256099942544/9214589741",
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            isAdmobAdLoaded.value = true;
          },
          onAdFailedToLoad: (ad, error) {
            ad.dispose();
            isAdmobAdLoaded.value = false;
            print(error.toString());
          },
        ),
        request: const AdRequest());
    await bannerAd.load();
  }
}
