import 'package:eshoperapp/pages/login/login_controller.dart';
import 'package:eshoperapp/pages/setting/setting_controller.dart';
import 'package:get/get.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingController(
        localRepositoryInterface: Get.find(), apiRepositoryInterface: Get.find(),
    ));
  }
}
