import 'package:eshoperapp/pages/myorder/myorder_controller.dart';
import 'package:get/get.dart';

class MyOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyOrderController(
        localRepositoryInterface: Get.find(),
        apiRepositoryInterface: Get.find()));
  }
}
