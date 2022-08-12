import 'package:eshoperapp/models/category_product.dart';
import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/repository/api_repository.dart';
import 'package:eshoperapp/repository/local_repository.dart';
import 'package:eshoperapp/utils/check_internet.dart';
import 'package:get/get.dart';

class CategoryProductController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;
  final String categoryId;

  CategoryProductController(
      {required this.apiRepositoryInterface,
      required this.localRepositoryInterface,required this.categoryId});

  RxBool isLoadingCategoryProduct= false.obs;
  var categoryProductObj = CategoryProduct().obs;

  @override
  void onInit() {
    CheckInternet.checkInternet();

    super.onInit();
  }


  categoryProduct(String categoryId) async {
    try {
      isLoadingCategoryProduct(true);
      await apiRepositoryInterface.categoryProduct(categoryId).then((value) {
        categoryProductObj(value);
      });
    } finally {
      isLoadingCategoryProduct(false);
    }
  }
}
