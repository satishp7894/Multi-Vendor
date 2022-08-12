import 'package:eshoperapp/models/product.dart';
import 'package:eshoperapp/repository/api_repository.dart';
import 'package:eshoperapp/repository/local_repository.dart';
import 'package:eshoperapp/routes/navigation.dart';
import 'package:get/get.dart';

class MyOrderController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;

  var productList = <Product>[].obs;
  RxBool isLoading = true.obs;
  MyOrderController({required this.localRepositoryInterface, required this.apiRepositoryInterface});

  @override
  void onReady() {

    super.onReady();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchProduct();
  }

  void fetchProduct() async {
    final token = await localRepositoryInterface.getToken();
    isLoading(false);
    try {
      var products = await apiRepositoryInterface.fetchingProdcut(token);
      if (products != null) {
        productList(products);
      }
    } finally {
      isLoading(true);
    }
  }





}
