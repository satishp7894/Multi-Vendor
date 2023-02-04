import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/repository/api_repository.dart';
import 'package:eshoperapp/repository/local_repository.dart';
import 'package:eshoperapp/utils/check_internet.dart';
import 'package:get/get.dart';

class BrandProductController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;
  // final String brandId;

  BrandProductController(
      {required this.apiRepositoryInterface,
      required this.localRepositoryInterface});

  RxBool isLoadingBrandProduct= false.obs;
  var brandProductObj = MainResponse().obs;

  RxBool isLoadingGetAllBrand= false.obs;
  var getAllBrandObj = MainResponse().obs;

  RxBool isRefresh = false.obs;

  @override
  void onInit() {
    CheckInternet.checkInternet();
    // brandProduct(brandId, false);
    super.onInit();
  }



  getAllBrand() async {
    try {
      isLoadingGetAllBrand(false);
      // isRefresh(refresh);
      await apiRepositoryInterface.getAllBrand().then((value) {
        getAllBrandObj(value);
      });
    } finally {
      isLoadingGetAllBrand(true);
    }
  }
}
