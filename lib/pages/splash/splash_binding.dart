import 'package:eshoperapp/pages/splash/splash_controller.dart';
import 'package:get/get.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController(
        localRepositoryInterface: Get.find(), apiRepositoryInterface:  Get.find()));
  }
}
