import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:getx_admob/home/home_page.dart';
import 'package:getx_admob/home/network_dependency_injection.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  RequestConfiguration requestConfiguration = RequestConfiguration(
    testDeviceIds: ['0575CAB47D22DC86B10F328E6481D46D'],
  );
  await MobileAds.instance.updateRequestConfiguration(requestConfiguration);

  //
  NetworkDependencyInjection.init();
  //
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetMaterialApp(
        onInit: () {
          NetworkDependencyInjection.init();
        },
        debugShowCheckedModeBanner: false,
        title: 'Torch App',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
