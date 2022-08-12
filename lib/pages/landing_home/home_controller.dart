import 'package:eshoperapp/models/cart.dart';
import 'package:eshoperapp/models/check_login.dart';
import 'package:eshoperapp/models/get_slider.dart';
import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/models/product.dart';
import 'package:eshoperapp/models/user.dart';
import 'package:eshoperapp/repository/api_repository.dart';
import 'package:eshoperapp/repository/local_repository.dart';
import 'package:eshoperapp/routes/navigation.dart';
import 'package:eshoperapp/utils/check_internet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class HomeController extends GetxController {
  final ApiRepositoryInterface apiRepositoryInterface;
  final LocalRepositoryInterface localRepositoryInterface;
  var tabIndex = 0;
  RxBool isCartLoad = false.obs;
  // Rx<CheckLoginData> user = CheckLoginData.empty().obs;
  var cartList = <Cart>[].obs;
  RxBool isLoading = true.obs;
  PageController pageController = PageController();

  var productList = <Product>[].obs;

  RxDouble totalAmount = 0.0.obs;
  var total;
  RxList selectedCarts = [].obs;

  RxBool isLoadingGetSlider = false.obs;
  var getSliderObj = GetSlider().obs;

  RxBool isLoadingAllProducts = false.obs;
  var allProductsObj = MainResponse().obs;

  RxBool isLoadingNewProducts = false.obs;
  var newProductsObj = MainResponse().obs;

  RxBool isLoadingGetBrand = false.obs;
  var getBrandObj = MainResponse().obs;

  RxBool isLoadingBestSellerProducts = false.obs;
  var bestSellerProductObj = MainResponse().obs;

  RxString customerId = "".obs;

  final List<String> img = [
    'https://images.template.net/wp-content/uploads/2016/11/15115545/Free-Marketing-Product-Sale-Banner.jpg',
    'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/facebook-cover-sale-banner-design-template-724adcb8d9a5e63bd0c602643186454d_screen.jpg?ts=1608557087',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTU7RiD0MiS3zu_IjZA6cCNtPpNgm6rk2spsaKCw40OxTLdH72Renkgm21Cd09TxM0vevE&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4A_THdCJyuCOmGkN11OR4gGjyBJuBgEpGmQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHTzusfPqz1-dogbofS9mxWdCAegcO8i7D3w&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJOCHxQGCUwAE1Ybn6vTcIz4JZnjnNJU5s5Q&usqp=CAU'
  ];

  HomeController({required this.apiRepositoryInterface,
    required this.localRepositoryInterface});

  @override
  void onInit() {
    CheckInternet.checkInternet();
    getSlider();
    getBrand();
    bestSellerProduct();
    allProducts();
    newProducts();
    loadUser();
    // fetchProduct();
    super.onInit();
  }



  loadUser() async {

    try {
      await localRepositoryInterface.getUser().then((value) {
        print("getUser customerId ${value!.customerId}");
        if (value.customerId != null) {
          customerId(value.customerId);
        }else{
          customerId("");
        }
      });
    } on Exception {
      //isLoadingCustomerProfile(false);

      return MainResponse();
    }
    // localRepositoryInterface.getUser().then((value) => user(value!));
  }
  void logout() async {
    final token = await localRepositoryInterface.getToken();
    await apiRepositoryInterface.logout(token);
    await localRepositoryInterface.clearAllData();
    Get.offAllNamed(Routes.login);
  }

  void changeTabIndex(int index) {
    tabIndex = index;
    pageController.jumpToPage(index);
    update();
  }

  void removeProduct(int index) {
 //   cartList.removeAt(index);
    update();
  }

  getSlider() async {
    try {
      isLoadingGetSlider(true);
      await apiRepositoryInterface.getSlider().then((value) {
        getSliderObj(value);
      });
    } finally {

      isLoadingGetSlider(false);
    }
  }

  allProducts() async {
    try {
      isLoadingAllProducts(true);
      await apiRepositoryInterface.allProducts().then((value) {
        allProductsObj(value);
      });
    } finally {

      isLoadingAllProducts(false);
    }
  }

  newProducts() async {
    try {
      isLoadingNewProducts(true);
      await apiRepositoryInterface.newProducts().then((value) {
        newProductsObj(value);
      });
    } finally {

      isLoadingNewProducts(false);
    }
  }

  getBrand() async {
    try {
      isLoadingGetBrand(true);
      await apiRepositoryInterface.getBrand().then((value) {
        getBrandObj(value);
      });
    } finally {

      isLoadingGetBrand(false);
    }
  }

  bestSellerProduct() async {
    try {
      isLoadingBestSellerProducts(true);
      await apiRepositoryInterface.bestSellerProduct().then((value) {
        bestSellerProductObj(value);
      });
    } finally {

      isLoadingBestSellerProducts(false);
    }
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


  void fetchCartList() async {
    final token = await localRepositoryInterface.getToken();
    try {
      isCartLoad(true);
      var carts = await apiRepositoryInterface.getCartList(token);
      print('Cartlist called');
      if (carts != null) {
        cartList(carts);
      }
    } finally {
      isCartLoad(false);
      refreshTotal();
    }
  }

  void refreshTotal() async {
    total = 0.0;
    cartList.forEach((element) {
      if (selectedCarts.contains(element.id)) {
        total += element.amount;
      }
    });
    totalAmount(total);
  }

  void addToCard(int? id) async {
    final token = await localRepositoryInterface.getToken();
    if (token != null) {
      if (!isCartLoad.value) {
        var result = await apiRepositoryInterface.addToCart(token, id);

        fetchCartList();
        if (result == true) {
          Get.snackbar('Added to cart successfully!', '',
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
              borderRadius: 0,
              backgroundColor: Colors.black.withOpacity(0.8),
              isDismissible: true,
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.all(5)
            // animationDuration: Duration(seconds: 1),
            // duration: Duration(seconds: 2),
          );
        }
      }
    } else {
      Get.offNamed(Routes.login);
    }
  }

  bool get isAllCartSelected =>
      selectedCarts.length == cartList.length ? true : false;

  void removeProductFromCart(int? id) async {
    final token = await localRepositoryInterface.getToken();

    await apiRepositoryInterface.deleteCart(token, id);
    fetchCartList();
  }

  void clearCart() {
    cartList.clear();
  }


}
