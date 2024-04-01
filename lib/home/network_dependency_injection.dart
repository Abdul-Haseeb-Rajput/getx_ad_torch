import 'package:get/get.dart';
import 'package:getx_admob/home/network_connectivity.dart';

class NetworkDependencyInjection {
  static void init() {
    Get.put<NetworkConnectivity>(NetworkConnectivity(),permanent: true);
  }
}
