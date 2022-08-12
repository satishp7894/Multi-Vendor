import 'package:eshoperapp/pages/login/login_controller.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(
        localRepositoryInterface: Get.find(), apiRepositoryInterface: Get.find(),
    ));
  }
}
