import 'package:eshoperapp/repository/api_repository.dart';
import 'package:eshoperapp/repository/local_repository.dart';
import 'package:eshoperapp/routes/navigation.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;
  SplashController({required this.localRepositoryInterface, required this.apiRepositoryInterface});

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() async {
    await Future.delayed(
      const Duration(seconds: 3),
    );

    Get.offNamed(Routes.onBoarding1,
        // transition: Transition.rightToLeft,duration: const Duration(milliseconds: 3000)
    );
    // final token = await localRepositoryInterface.getUser();
    // if (token != null) {
    //   Get.offNamed(Routes.landingHome);
    //
    // } else{
    //   Get.offNamed(Routes.login);
    // }

  }



}
