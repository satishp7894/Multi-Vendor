import 'package:get/get.dart';

import 'categories_controller.dart';
class CategoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CatergoriesController(
        localRepositoryInterface: Get.find(),
        apiRepositoryInterface: Get.find()));
  }
}
