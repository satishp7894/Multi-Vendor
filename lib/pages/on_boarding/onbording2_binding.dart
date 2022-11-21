import 'package:eshoperapp/pages/on_boarding/onboarding2_controller.dart';
import 'package:get/get.dart';

class OnBoarding2Binding extends Bindings {
  @override
  void dependencies() {
    Get.put(() => OnBoarding2Controller(
        localRepositoryInterface: Get.find(),
        // apiRepositoryInterface:  Get.find()
    ));
  }
}
