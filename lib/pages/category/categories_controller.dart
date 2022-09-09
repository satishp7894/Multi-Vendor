import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/models/product.dart';
import 'package:eshoperapp/repository/api_repository.dart';
import 'package:eshoperapp/repository/local_repository.dart';
import 'package:eshoperapp/utils/check_internet.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CatergoriesController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;
  CatergoriesController(
      {required this.apiRepositoryInterface,
      required this.localRepositoryInterface});

  RxList categoriesList = [].obs;
  RxBool isLoading = false.obs;
  RxBool isCategoryProductsLoading = false.obs;
  var categoryProducts = <Product>[].obs;

  RxBool isLoadingGetCategory = false.obs;
  var getCategoryObj = MainResponse().obs;


  RxBool isRefresh = false.obs;
  final box = GetStorage();

  RxBool isGrid = false.obs;
  void changeGridMode(bool val) {
    box.write('gridmode', !val);
    isGrid(!val);
  }

  void initGridMode() => isGrid(box.read('gridmode') ?? false);

  @override
  void onInit() {
    getCategory(false);
    super.onInit();
  }

  getCategory(bool refresh) async {
    try {
      isLoadingGetCategory(true);
      isRefresh(refresh);
      await apiRepositoryInterface.getCategory().then((value) {
        getCategoryObj(value);
      });
    } finally {

      isLoadingGetCategory(false);
    }
  }

  loadCategories() {
    try {
      isLoading(true);
      apiRepositoryInterface.getCategories()
          .then((value) => categoriesList(value));
    } finally {
      isLoading(false);
    }
  }

  loadCategoryProducts(String? categoryName) async {
    print('load');
    try {
      isCategoryProductsLoading(true);
      await apiRepositoryInterface.getCategorieProduct(categoryName)
          .then((value) {
        categoryProducts(value!);
        print(categoryProducts(value));
      });
    } finally {
      isCategoryProductsLoading(false);
    }
  }
}
