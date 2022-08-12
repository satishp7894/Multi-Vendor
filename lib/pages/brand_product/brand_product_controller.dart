import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/repository/api_repository.dart';
import 'package:eshoperapp/repository/local_repository.dart';
import 'package:eshoperapp/utils/check_internet.dart';
import 'package:get/get.dart';

class BrandProductController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;
  final String brandId;

  BrandProductController(
      {required this.apiRepositoryInterface,
      required this.localRepositoryInterface,required this.brandId});

  RxBool isLoadingBrandProduct= false.obs;
  var brandProductObj = MainResponse().obs;
  @override
  void onInit() {
    CheckInternet.checkInternet();
    brandProduct(brandId);
    super.onInit();
  }


  brandProduct(String brandId) async {
    try {
      isLoadingBrandProduct(true);
      await apiRepositoryInterface.brandProduct(brandId).then((value) {
        brandProductObj(value);
      });
    } finally {
      isLoadingBrandProduct(false);
    }
  }
}
