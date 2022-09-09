import 'package:eshoperapp/models/cart.dart';
import 'package:eshoperapp/models/carts.dart';
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
  var cartList = <Carts>[].obs;
  RxString imagePath = "".obs;
  RxBool isLoading = true.obs;
  PageController pageController = PageController();

  var productList = <Product>[].obs;

  RxDouble totalAmount = 0.0.obs;
  // var total;
  RxList selectedCarts = [].obs;

  RxBool isLoadingGetSlider = false.obs;
  var getSliderObj = GetSlider().obs;

  RxBool isLoadingAllProducts = false.obs;
  var allProductsObj = MainResponse().obs;

  RxBool isLoadingNewProducts = false.obs;
  var newProductsObj = MainResponse().obs;

  RxBool isLoadingGetCartItems = false.obs;
  var getCartItemsObj = MainResponse().obs;

  RxBool isLoadingGetBrand = false.obs;
  var getBrandObj = MainResponse().obs;

  RxBool isLoadingBestSellerProducts = false.obs;
  var bestSellerProductObj = MainResponse().obs;

  RxString customerId = "".obs;

  RxBool isRefresh = false.obs;

  List productIds = [];

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
    newProducts(false);
    loadUser(true);

    // fetchProduct();
    super.onInit();
  }

  void selectAllCart(List<Carts> getCartData) {

      selectedCarts([]);
      getCartData.forEach((element) {
        selectedCarts.add(element.cartId);
      });
    // }
    refreshTotal();
  }


  loadUser(isBoll) async {

    try {
      await localRepositoryInterface.getUser().then((value) {
        print("getUser customerId ${value!.customerId}");
        if (value.customerId != null) {
          customerId(value.customerId);
          getCartItems(value.customerId!, isBoll);
        }else{
          customerId("");
          getCartItems("", isBoll);
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
   cartList.removeAt(index);
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

  newProducts(bool refresh) async {
    try {
      isLoadingNewProducts(true);
      isRefresh(refresh);
      await apiRepositoryInterface.newProducts().then((value) {
        newProductsObj(value);
      });
    } finally {

      isLoadingNewProducts(false);
    }
  }

  getCartItems(String customerId, bool isBool) async {
    try {
      isLoadingGetCartItems(true);
      await apiRepositoryInterface.getCartItems(customerId).then((value) {
        getCartItemsObj(value);
        MainResponse? mainResponse = getCartItemsObj.value;
        List<Carts>? getCartData = [];
        String? imageUrl = mainResponse.imageUrl ?? "";

        if(mainResponse.data != null){
          mainResponse.data!.forEach((v) {
            getCartData.add(Carts.fromJson(v));
          });
          cartList(getCartData);
          imagePath(imageUrl);

          if(isBool){
            selectAllCart(getCartData);

            productIds.clear();
            getCartData.forEach((element) {
              productIds.add(element.productId);
            });
          }

        }
        // refreshTotal();
      });
    } finally {
      isLoadingGetCartItems(false);
      // refreshTotal();
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

  // void fetchProduct() async {
  //   final token = await localRepositoryInterface.getToken();
  //   isLoading(false);
  //   try {
  //     var products = await apiRepositoryInterface.fetchingProdcut(token);
  //     if (products != null) {
  //       productList(products);
  //     }
  //   } finally {
  //     isLoading(true);
  //   }
  // }


  void fetchCartList() async {
    final token = await localRepositoryInterface.getToken();
    try {
      isCartLoad(true);
      var carts = await apiRepositoryInterface.getCartList(token);
      print('Cartlist called');
      if (carts != null) {
        // cartList(carts);
      }
    } finally {
      isCartLoad(false);
      // refreshTotal();
    }
  }

  void refreshTotal() async {
   double total = 0.0;
   // print("cartList total ------------- ${cartList[0].totalAmt!}");
    cartList.forEach((element) {
      if (selectedCarts.contains(element.cartId)) {
        total += double.parse(element.totalAmt!);
        print("total ------------- ${element.totalAmt!}");
        print("total ------------- $total");
      }
    });
    totalAmount(total);
    // update();
  }

  // void addToCard(int? id) async {
  //   final token = await localRepositoryInterface.getToken();
  //   if (token != null) {
  //     if (!isCartLoad.value) {
  //       var result = await apiRepositoryInterface.addToCart(token, id);
  //
  //       fetchCartList();
  //       if (result == true) {
  //         Get.snackbar('Added to cart successfully!', '',
  //             snackPosition: SnackPosition.BOTTOM,
  //             colorText: Colors.white,
  //             borderRadius: 0,
  //             backgroundColor: Colors.black.withOpacity(0.8),
  //             isDismissible: true,
  //             margin: EdgeInsets.all(0),
  //             padding: EdgeInsets.all(5)
  //           // animationDuration: Duration(seconds: 1),
  //           // duration: Duration(seconds: 2),
  //         );
  //       }
  //     }
  //   } else {
  //     Get.offNamed(Routes.login);
  //   }
  // }

  void addToCard(String productId,String quantity) async {
    // var result = await apiRepositoryInterface.updateProductQty(token, id, quantity);

    MainResponse? mainResponse  = await apiRepositoryInterface.addToCart(customerId.value, productId,quantity);
    if (mainResponse!.status!) {
      getCartItems(customerId.value, true);
      Get.snackbar('Success', mainResponse.message!,duration: const Duration(seconds: 8), snackPosition: SnackPosition.BOTTOM,);
      // Get.offAllNamed(Routes.landingHome);

    } else {
      Get.snackbar('Error', mainResponse.message!,duration: const Duration(seconds: 8), snackPosition: SnackPosition.BOTTOM,);
    }

    // if (result == true) {
    //   AppWidget.snacbar('Added to cart successfully!');
    //   homecontroller.getCartItems(customerId);
    // }
  }

  // bool get isAllCartSelected =>
  //     selectedCarts.length == cartList.length ? true : false;

   isAllCartSelected(List<Carts> getCartData) {
    print("selectedCarts.length ${selectedCarts.length}");
    print("getCartData.length ${getCartData.length}");
  return  selectedCarts.length == getCartData.length ? true : false;
    // if (homecontroller.selectedCarts.length == getCartData.length) {
    //   homecontroller.selectedCarts([]);
    // } else {
    //   homecontroller.selectedCarts([]);
    //   getCartData.forEach((element) {
    //     homecontroller.selectedCarts.add(element.cartId);
    //   });
    // }
    // homecontroller.refreshTotal();
  }

  // void removeProductFromCart(int? id) async {
  //   final token = await localRepositoryInterface.getToken();
  //
  //   await apiRepositoryInterface.deleteCart(token, id);
  //   fetchCartList();
  // }

  Future<bool> removeFromCart(String productId, String customerId, int? cartIndex) async {
    // var result = await apiRepositoryInterface.updateProductQty(token, id, quantity);

    MainResponse? mainResponse  = await apiRepositoryInterface.removeFromCart(customerId, productId);
    if (mainResponse!.status!) {
      removeProduct(cartIndex!);
      getCartItems(customerId, false);
      
      Get.snackbar('Success', mainResponse.message!,duration: const Duration(seconds: 8), snackPosition: SnackPosition.BOTTOM,);
      // Get.offAllNamed(Routes.landingHome);
      return true;

    } else {
      Get.snackbar('Error', mainResponse.message!,duration: const Duration(seconds: 8), snackPosition: SnackPosition.BOTTOM,);
      return false;
    }

    // if (result == true) {
    //   AppWidget.snacbar('Added to cart successfully!');
    //   homecontroller.getCartItems(customerId);
    // }
  }

  void checkOut(String productIds) async {
    // var result = await apiRepositoryInterface.updateProductQty(token, id, quantity);

    MainResponse? mainResponse  = await apiRepositoryInterface.addOrder(customerId.value, productIds);
    if (mainResponse!.status!) {
      getCartItems(customerId.value, false);

      Get.snackbar('Success', mainResponse.message!,duration: const Duration(seconds: 8), snackPosition: SnackPosition.BOTTOM,);
      // Get.offAllNamed(Routes.landingHome);

    } else {
      Get.snackbar('Error', mainResponse.message!,duration: const Duration(seconds: 8), snackPosition: SnackPosition.BOTTOM,);
    }

    // if (result == true) {
    //   AppWidget.snacbar('Added to cart successfully!');
    //   homecontroller.getCartItems(customerId);
    // }
  }

  void emptyCart( String customerId) async {
    // var result = await apiRepositoryInterface.updateProductQty(token, id, quantity);

    MainResponse? mainResponse  = await apiRepositoryInterface.emptyCart(customerId);
    if (mainResponse!.status!) {
      getCartItems(customerId, false);
      cartList.clear();
      Get.snackbar('Success', mainResponse.message!,duration: const Duration(seconds: 8), snackPosition: SnackPosition.BOTTOM,);
      // Get.offAllNamed(Routes.landingHome);

    } else {
      Get.snackbar('Error', mainResponse.message!,duration: const Duration(seconds: 8), snackPosition: SnackPosition.BOTTOM,);
    }

    // if (result == true) {
    //   AppWidget.snacbar('Added to cart successfully!');
    //   homecontroller.getCartItems(customerId);
    // }
  }

  // void clearCart() {
  //   cartList.clear();
  // }


}
