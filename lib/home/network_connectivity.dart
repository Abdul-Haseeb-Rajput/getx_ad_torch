import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:getx_admob/home/home_controller.dart';

class NetworkConnectivity extends GetxController {
  final homeController = Get.put<HomeController>(HomeController());
  final Connectivity connectivity = Connectivity();
  RxBool isConnected = false.obs;

  @override
  void onInit() {
    connectivity.onConnectivityChanged.listen(updateConnectionStatus);
    super.onInit();
  }

  void updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.wifi) {
      isConnected.value = true;
      homeController.initBannerAd();
    } else if (connectivityResult == ConnectivityResult.none) {
      isConnected.value = false;

    } else {
      if (Get.isSnackbarOpen) {
        isConnected.value = true;
        homeController.initBannerAd();
      }
    }
  }
}
