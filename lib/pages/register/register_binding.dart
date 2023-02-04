import 'package:eshoperapp/pages/login/login_controller.dart';
import 'package:eshoperapp/pages/register/register_controller.dart';
import 'package:get/get.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController(
        localRepositoryInterface: Get.find(), apiRepositoryInterface: Get.find(),
    ));
  }
}
