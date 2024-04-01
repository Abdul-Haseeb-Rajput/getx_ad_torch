import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_admob/home/home_controller.dart';
import 'package:getx_admob/home/network_connectivity.dart';
import 'package:getx_admob/image_paths/image_paths.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put<HomeController>(HomeController());
    final networkConnectivity =
        Get.put<NetworkConnectivity>(NetworkConnectivity());

    return Scaffold(
      backgroundColor: const Color(0xff181818),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              child: Obx(
                () {
                  return homeController.isTorchOn.value == true
                      ? Image.asset(ImagePath.torchOn)
                      : Image.asset(ImagePath.torchOff);
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            GestureDetector(
              onTap: () {
                homeController.toggleTorch();
              },
              child: Obx(
                () => Container(
                  clipBehavior: Clip.antiAlias,
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: homeController.isTorchOn.value
                        ? Colors.orange
                        : Colors.grey.shade300,
                  ),
                  child: Row(
                    mainAxisAlignment: homeController.isTorchOn.value
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      Container(
                        clipBehavior: Clip.antiAlias,
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Transform.translate(
                            offset: homeController.isTorchOn.value
                                ? const Offset(0, 0)
                                : const Offset(0, 0),
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: homeController.isTorchOn.value
                                    ? Colors.orange
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () {
              if (networkConnectivity.isConnected.value == true) {
                return FutureBuilder(
                  future: homeController.initBannerAd(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (homeController.isAdmobAdLoaded.value == true) {
                      return SizedBox(
                        height: AdSize.banner.height.toDouble(),
                        width: AdSize.banner.width.toDouble(),
                        child: AdWidget(
                          ad: homeController.bannerAd,
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
