import 'package:eshoperapp/config/theme.dart';
import 'package:eshoperapp/constants/app_costants.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/categories.dart';
import '../../utils/snackbar_dialog.dart';

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
  RxDouble totalMRP = 0.0.obs;
  RxDouble totalDISCOUNT = 0.0.obs;
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

  RxBool isLoadingChooseColor = false.obs;
  var chooseColorObj = MainResponse().obs;


  RxBool isLoadingNewLaunch = false.obs;
  var newLaunchObj = MainResponse().obs;

  RxBool isLoadingHomeCategory = false.obs;
  var getHomeCategoryObj = MainResponse().obs;

  RxBool isLoadingHomeDesigner = false.obs;
  var getHomeDesignerObj = MainResponse().obs;

  RxBool isLoadingCategoryByAge = false.obs;
  var getCategoryByAgeObj = MainResponse().obs;

  RxBool isLoadingFestiveFashion = false.obs;
  var getFestiveFashionObj = MainResponse().obs;

  RxBool isLoadingTrendingBrand = false.obs;
  var trendingBrandObj = MainResponse().obs;

  RxBool isLoadingOfferWithCategoryList = false.obs;
  var offerWithCategoryListObj = MainResponse().obs;

  RxBool isLoadingProductByAttributeAndCategory = false.obs;
  var productByAttributeAndCategoryObj = MainResponse().obs;

  RxString customerId = "".obs;

  RxBool isRefresh = false.obs;

  List productIds = [];

  String? chooseType;

  final List<String> img = [
    'https://images.template.net/wp-content/uploads/2016/11/15115545/Free-Marketing-Product-Sale-Banner.jpg',
    'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/facebook-cover-sale-banner-design-template-724adcb8d9a5e63bd0c602643186454d_screen.jpg?ts=1608557087',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTU7RiD0MiS3zu_IjZA6cCNtPpNgm6rk2spsaKCw40OxTLdH72Renkgm21Cd09TxM0vevE&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4A_THdCJyuCOmGkN11OR4gGjyBJuBgEpGmQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHTzusfPqz1-dogbofS9mxWdCAegcO8i7D3w&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJOCHxQGCUwAE1Ybn6vTcIz4JZnjnNJU5s5Q&usqp=CAU'
  ];


  List<String> imageList = [
    'https://cdn.pixabay.com/photo/2019/03/15/09/49/girl-4056684_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/12/15/16/25/clock-5834193__340.jpg',
    'https://cdn.pixabay.com/photo/2020/09/18/19/31/laptop-5582775_960_720.jpg',
    'https://media.istockphoto.com/photos/woman-kayaking-in-fjord-in-norway-picture-id1059380230?b=1&k=6&m=1059380230&s=170667a&w=0&h=kA_A_XrhZJjw2bo5jIJ7089-VktFK0h0I4OWDqaac0c=',
    'https://cdn.pixabay.com/photo/2019/11/05/00/53/cellular-4602489_960_720.jpg',
    'https://cdn.pixabay.com/photo/2017/02/12/10/29/christmas-2059698_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/01/29/17/09/snowboard-4803050_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/02/06/20/01/university-library-4825366_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/11/22/17/28/cat-5767334_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/12/13/16/22/snow-5828736_960_720.jpg',
  ];


  List<Categories> categoryList = [
    Categories(categoryName: "Sarees",categoryImage: "assets/category/category1.png",color: AppColors.categoryBG1),
    Categories(categoryName: "Tops",categoryImage: "assets/category/category2.png",color: AppColors.categoryBG2),
    Categories(categoryName: "Jackets",categoryImage: "assets/category/category3.png",color: AppColors.categoryBG3),
    Categories(categoryName: "Shirts",categoryImage: "assets/category/category4.png",color: AppColors.categoryBG4),
    Categories(categoryName: "Shorts",categoryImage: "assets/category/category5.png",color: AppColors.categoryBG5),
    Categories(categoryName: "Kurta",categoryImage: "assets/category/category6.png",color: AppColors.categoryBG6),
    Categories(categoryName: "Bra",categoryImage: "assets/category/category7.png",color: AppColors.categoryBG7),
    Categories(categoryName: "Jeans",categoryImage: "assets/category/category8.png",color: AppColors.categoryBG8),
    Categories(categoryName: "Leggins",categoryImage: "assets/category/category9.png",color: AppColors.categoryBG9),
    Categories(categoryName: "Jumpsuits",categoryImage: "assets/category/category10.png",color: AppColors.categoryBG10),

  ];

  List<Categories> shopByAgeList = [
    // Categories(categoryName: "Newborn",categoryImage: "assets/img/producr1.png",color: AppColors.categoryBG1),
    // Categories(categoryName: "Infant",categoryImage: "assets/img/producr1.png",color: AppColors.categoryBG2),
    // Categories(categoryName: "Toddler",categoryImage: "assets/img/producr1.png",color: AppColors.categoryBG3),
    // Categories(categoryName: "Newborn",categoryImage: "assets/img/producr1.png",color: AppColors.categoryBG1),
    // Categories(categoryName: "Infant",categoryImage: "assets/img/producr1.png",color: AppColors.categoryBG2),
    // Categories(categoryName: "Toddler",categoryImage: "assets/img/producr1.png",color: AppColors.categoryBG3),
    Categories(categoryName: "ANITA DONGRE",categoryImage: "assets/img/wishlist1.png",color: AppColors.black),
    Categories(categoryName: "SABYSACHI",categoryImage: "assets/shop/shop2.png",color: AppColors.shopBG1),
    Categories(categoryName: "echke",categoryImage: "assets/shop/shop3.png",color: AppColors.categoryBG1),
    Categories(categoryName: "masaba",categoryImage: "assets/shop/shop4.png",color: AppColors.categoryBG1),
    Categories(categoryName: "rohit bal",categoryImage: "assets/shop/shop5.png",color: AppColors.categoryBG1),
    Categories(categoryName: "Payal singhal",categoryImage: "assets/shop/shop6.png",color: AppColors.categoryBG1),

  ];


  List<Categories> categoryList1 = [
    // Categories(categoryName: "Sarees",categoryImage: "assets/category/category1.png",color: AppColors.categoryBG1,fit: BoxFit.contain),
    Categories(categoryName: "Sarees",categoryImage: "assets/img/wishlist1.png",color: AppColors.categoryBG1,fit: BoxFit.contain),
    Categories(categoryName: "Tops",categoryImage: "assets/category/category2.png",color: AppColors.categoryBG2,fit: BoxFit.contain),
    Categories(categoryName: "Jackets",categoryImage: "assets/category/category3.png",color: AppColors.categoryBG3,fit: BoxFit.contain),
    Categories(categoryName: "Shirts",categoryImage: "assets/category/category4.png",color: AppColors.categoryBG4,fit: BoxFit.contain),
    Categories(categoryName: "Shorts",categoryImage: "assets/category/category8.png",color: AppColors.categoryBG5,fit: BoxFit.fill),

  ];

  List<Categories> categoryList2 = [
    Categories(categoryName: "Kurta",categoryImage: "assets/category/category6.png",color: AppColors.categoryBG6),
    Categories(categoryName: "Bra",categoryImage: "assets/category/category2.png",color: AppColors.categoryBG7),
    Categories(categoryName: "Jeans",categoryImage: "assets/category/category8.png",color: AppColors.categoryBG8),
    Categories(categoryName: "Leggins",categoryImage: "assets/category/category9.png",color: AppColors.categoryBG9),
    Categories(categoryName: "Jumpsuits",categoryImage: "assets/category/category10.png",color: AppColors.categoryBG10),

  ];

  // List<Categories> budgetList1 = [
  //   Categories(categoryName: "T-Shirt",categoryImage: "assets/budget/budget1.png"),
  //   Categories(categoryName: "T-Shirt",categoryImage: "assets/budget/budget1.png"),
  //   Categories(categoryName: "Kurti",categoryImage: "assets/budget/budget2.png"),
  //   Categories(categoryName: "Innerwear",categoryImage: "assets/budget/budget3.png"),
  //   Categories(categoryName: "Joggers",categoryImage: "assets/budget/budget4.png"),
  //   Categories(categoryName: "Boxer",categoryImage: "assets/budget/budget5.png"),
  // ];
  //
  // List<Categories> budgetList2 = [
  //   Categories(categoryName: "T-Shirt",categoryImage: "assets/budget/budget1.png"),
  //   Categories(categoryName: "Shirts",categoryImage: "assets/budget/budget6.png"),
  //   Categories(categoryName: "Bow Tie",categoryImage: "assets/budget/budget7.png"),
  //   Categories(categoryName: "Activewear",categoryImage: "assets/budget/budget8.png"),
  //   Categories(categoryName: "Track Pants",categoryImage: "assets/budget/budget9.png"),
  //   Categories(categoryName: "Shorts",categoryImage: "assets/budget/budget10.png"),
  // ];
  // List<Categories> budgetList3 = [
  //   Categories(categoryName: "T-Shirt",categoryImage: "assets/budget/budget1.png"),
  //   Categories(categoryName: "Jeans",categoryImage: "assets/budget/budget11.png"),
  //   Categories(categoryName: "Sweatshirt",categoryImage: "assets/budget/budget12.png"),
  //   Categories(categoryName: "Kurta Sets",categoryImage: "assets/budget/budget13.png"),
  //   Categories(categoryName: "Trousers",categoryImage: "assets/budget/budget14.png"),
  //   Categories(categoryName: "Jacketst",categoryImage: "assets/budget/budget15.png"),
  // ];

  List<Categories> budgetList1 = [
    Categories(categoryName: "T-Shirt",categoryImage: "assets/img/wishlist1.png"),
    Categories(categoryName: "T-Shirt",categoryImage: "assets/budget/bug1.png"),
    Categories(categoryName: "Kurti",categoryImage: "assets/budget/bug2.png"),
    Categories(categoryName: "Innerwear",categoryImage: "assets/budget/bug3.png"),
    Categories(categoryName: "Joggers",categoryImage: "assets/budget/bug1.png"),
    Categories(categoryName: "Boxer",categoryImage: "assets/budget/bug2.png"),
  ];

  List<Categories> budgetList2 = [
    Categories(categoryName: "T-Shirt",categoryImage: "assets/img/wishlist1.png"),
    Categories(categoryName: "Shirts",categoryImage: "assets/budget/bug1.png"),
    Categories(categoryName: "Bow Tie",categoryImage: "assets/budget/bug2.png"),
    Categories(categoryName: "Activewear",categoryImage: "assets/budget/bug3.png"),
    Categories(categoryName: "Track Pants",categoryImage: "assets/budget/bug1.png"),
    Categories(categoryName: "Shorts",categoryImage: "assets/budget/bug2.png"),
  ];
  List<Categories> budgetList3 = [
    Categories(categoryName: "T-Shirt",categoryImage: "assets/img/wishlist1.png"),
    Categories(categoryName: "Jeans",categoryImage: "assets/budget/bug1.png"),
    Categories(categoryName: "Sweatshirt",categoryImage: "assets/budget/bug2.png"),
    Categories(categoryName: "Kurta Sets",categoryImage: "assets/budget/bug3.png"),
    Categories(categoryName: "Trousers",categoryImage: "assets/budget/bug1.png"),
    Categories(categoryName: "Jacketst",categoryImage: "assets/budget/bug2.png"),
  ];

  List<Categories> shopList = [
    Categories(categoryName: "ANITA DONGRE",categoryImage: "assets/img/wishlist1.png",color: AppColors.black),
    Categories(categoryName: "SABYSACHI",categoryImage: "assets/shop/shop2.png",color: AppColors.shopBG1),
    Categories(categoryName: "echke",categoryImage: "assets/shop/shop3.png",color: AppColors.categoryBG1),
    Categories(categoryName: "masaba",categoryImage: "assets/shop/shop4.png",color: AppColors.categoryBG1),
    Categories(categoryName: "rohit bal",categoryImage: "assets/shop/shop5.png",color: AppColors.categoryBG1),
    Categories(categoryName: "Payal singhal",categoryImage: "assets/shop/shop6.png",color: AppColors.categoryBG1),

  ];

  List<Categories> modeList = [
    Categories(categoryName: "Komal Pandey",categoryImage: "assets/img/wishlist1.png"),
    Categories(categoryName: "Thatbohogirl",categoryImage: "assets/mode/mode2.png"),
    Categories(categoryName: "Aashna Shroff",categoryImage: "assets/mode/mode3.png"),
    Categories(categoryName: "shauryasanadhya",categoryImage: "assets/mode/mode4.png"),
    Categories(categoryName: "Aakriti Rana",categoryImage: "assets/mode/mode5.png"),
    Categories(categoryName: "Juhi Godambe",categoryImage: "assets/mode/mode6.png"),
  ];


  List<Categories> discoverList = [
    Categories(categoryName: "STARTING ₹1999 ",categoryImage: "assets/img/wishlist1.png",description: "assets/discover/discover_logo1.png",color: AppColors.discover1,fit: BoxFit.contain),
    Categories(categoryName: "40-60% OFF*",categoryImage: "assets/discover/discover2.png",description: "assets/discover/discover_logo6.png",color: AppColors.discover2,fit: BoxFit.contain),
    Categories(categoryName: "MIN 40% OFF*",categoryImage: "assets/discover/discover3.png",description: "assets/discover/discover_logo1.png",color: AppColors.discover3,fit: BoxFit.contain),
    Categories(categoryName: "up to 70% OFF*",categoryImage: "assets/discover/discover4.png",description: "assets/discover/discover_logo4.png",color: AppColors.discover4,fit: BoxFit.contain),
    Categories(categoryName: "STARTING ₹999 ",categoryImage: "assets/discover/discover5.png",description: "assets/discover/discover_logo5.png",color: AppColors.categoryBG1,fit: BoxFit.cover),
    Categories(categoryName: "MIN 70% OFF*",categoryImage: "assets/discover/discover6.png",description: "assets/discover/discover_logo6.png",color: AppColors.discover6,fit: BoxFit.contain),
  ];


  // List<Categories> discoverList = [
  //   Categories(categoryName: "STARTING ₹1999 ",categoryImage: "assets/discover/dis.png",description: "assets/discover/discover_logo1.png",color: AppColors.discover1,fit: BoxFit.contain),
  //   Categories(categoryName: "40-60% OFF*",categoryImage: "assets/discover/dis2.png",description: "assets/discover/discover_logo2.png",color: AppColors.discover2,fit: BoxFit.contain),
  //   Categories(categoryName: "MIN 40% OFF*",categoryImage: "assets/discover/dis3.png",description: "assets/discover/discover_logo2.png",color: AppColors.discover3,fit: BoxFit.contain),
  //   Categories(categoryName: "up to 70% OFF*",categoryImage: "assets/discover/discover4.png",description: "assets/discover/discover_logo4.png",color: AppColors.discover4,fit: BoxFit.contain),
  //   Categories(categoryName: "STARTING ₹999 ",categoryImage: "assets/discover/discover5.png",description: "assets/discover/discover_logo5.png",color: AppColors.categoryBG1,fit: BoxFit.contain),
  //   Categories(categoryName: "MIN 70% OFF*",categoryImage: "assets/discover/discover6.png",description: "assets/discover/discover_logo6.png",color: AppColors.discover6,fit: BoxFit.contain),
  // ];

  //
  List<Categories> finestList = [
    Categories(categoryName: "JADEBLUE",categoryImage: "assets/finest/finest1.jpg"),
    Categories(categoryName: "MANYAVAR",categoryImage: "assets/finest/finest2.jpg"),
    Categories(categoryName: "fabindia",categoryImage: "assets/finest/finest3.jpg"),
    Categories(categoryName: "RAYMOND",categoryImage: "assets/finest/finest4.jpg"),
    Categories(categoryName: "SAMYAKK",categoryImage: "assets/finest/finest5.jpg"),
    Categories(categoryName: "JAYPORE",categoryImage: "assets/finest/finest6.jpg"),
  ];

  List<Categories> finestList1 = [
    Categories(categoryName: "JADEBLUE",categoryImage: "assets/img/wishlist1.png"),
    Categories(categoryName: "MANYAVAR",categoryImage: "assets/finest/finest2.jpg"),
    Categories(categoryName: "fabindia",categoryImage: "assets/finest/finest3.jpg"),
  ];

  List<Categories> finestList2 = [
    Categories(categoryName: "RAYMOND",categoryImage: "assets/img/wishlist1.png"),
    Categories(categoryName: "SAMYAKK",categoryImage: "assets/finest/finest5.jpg"),
    Categories(categoryName: "JAYPORE",categoryImage: "assets/finest/finest6.jpg"),
  ];

  List<Categories> launchList = [
    Categories(categoryName: "allen solly",categoryImage: "assets/img/wishlist1.png"),
    Categories(categoryName: "Louis philippe",categoryImage: "assets/launch/launch2.jpg"),
    Categories(categoryName: "pepe jeans",categoryImage: "assets/launch/launch3.jpg"),
    Categories(categoryName: "arrow",categoryImage: "assets/launch/launch4.jpg"),
    Categories(categoryName: "bewakoof",categoryImage: "assets/launch/launch5.jpg"),
    Categories(categoryName: "peter england",categoryImage: "assets/launch/launch6.jpg"),
  ];

  List<Color> colorList = [
    Colors.black,
    Colors.green,
    Colors.red,
    Colors.white,
    Colors.purple,
    Colors.yellow,
    Colors.blue,
    Colors.pink,
    Colors.orange,
  ];

  HomeController({required this.apiRepositoryInterface,
    required this.localRepositoryInterface});

  @override
  void onInit() {
    init();
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
    print("getUser customerId ===========================================");
    try {
      await localRepositoryInterface.getUser().then((value) {
        print("getUser customerId ${value!.customerId}");
        if (value.customerId != null ) {
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

        }else{
          cartList([]);
          productIds.clear();
          totalAmount(0.0);
          totalMRP(0.0);
          totalDISCOUNT(0.0);
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

  bestSellerProduct(String chooseType, customerId) async {
    try {
      isLoadingBestSellerProducts(true);
      await apiRepositoryInterface.bestSellerProduct(chooseType,customerId).then((value) {
        bestSellerProductObj(value);
      });
    } finally {

      isLoadingBestSellerProducts(false);
    }
  }

  getNewLaunch(String chooseType) async {
    try {
      isLoadingNewLaunch(true);
      await apiRepositoryInterface.getNewLaunch(chooseType).then((value) {
        newLaunchObj(value);
      });
    } finally {

      isLoadingNewLaunch(false);
    }
  }


  getHomeCategory(String chooseType) async {
    try {
      isLoadingHomeCategory(true);
      await apiRepositoryInterface.getHomeCategory(chooseType).then((value) {
        getHomeCategoryObj(value);
      });
    } finally {

      isLoadingHomeCategory(false);
    }
  }

  getHomeDesigner(String chooseType) async {
    try {
      isLoadingHomeDesigner(true);
      await apiRepositoryInterface.getHomeDesigner(chooseType).then((value) {
        getHomeDesignerObj(value);
      });
    } finally {

      isLoadingHomeDesigner(false);
    }
  }

  getCategoryByAge(String chooseType) async {
    try {
      isLoadingCategoryByAge(true);
      await apiRepositoryInterface.getCategoryByAge(chooseType).then((value) {
        getCategoryByAgeObj(value);
      });
    } finally {

      isLoadingCategoryByAge(false);
    }
  }

  getFestiveFashion(String chooseType) async {
    try {
      isLoadingFestiveFashion(true);
      await apiRepositoryInterface.getFestiveFashion(chooseType).then((value) {
        getFestiveFashionObj(value);
      });
    } finally {

      isLoadingFestiveFashion(false);
    }
  }

  getTrendingBrand(String chooseType) async {
    try {
      isLoadingTrendingBrand(true);
      await apiRepositoryInterface.getTrendingBrand(chooseType).then((value) {
        trendingBrandObj(value);
      });
    } finally {

      isLoadingTrendingBrand(false);
    }
  }


  getOfferWithCategoryList(String chooseType) async {
    try {
      isLoadingOfferWithCategoryList(true);
      await apiRepositoryInterface.getOfferWithCategoryList(chooseType).then((value) {
        offerWithCategoryListObj(value);
      });
    } finally {
      isLoadingOfferWithCategoryList(false);
    }
  }


  chooseColor(String chooseType) async {
    try {
      isLoadingChooseColor(true);
      await apiRepositoryInterface.chooseColor(chooseType).then((value) {
        chooseColorObj(value);
      });
    } finally {

      isLoadingChooseColor(false);
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
   double totalMrp = 0.0;
   double totalDiscount = 0.0;
   // print("cartList total ------------- ${cartList[0].totalAmt!}");
    cartList.forEach((element) {
      double totalQty = double.parse(element.netPrice!) * double.parse(element.quantity!);
      double totalQtyMrp = double.parse(element.mrpPrice!) * double.parse(element.quantity!);
      double totalQtyDiscount = double.parse(element.discountAmt!) * double.parse(element.quantity!);
      if (selectedCarts.contains(element.cartId)) {
        total += totalQty;
        totalMrp += totalQtyMrp;
        totalDiscount += totalQtyDiscount;
        print("total ------------- $total");
        print("totalMrp ------------- $totalMrp");
        print("totalDiscount ------------- $totalDiscount");
      }
    });
    totalAmount(total);
    totalMRP(totalMrp);
    totalDISCOUNT(totalDiscount);
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

   addToCard(String productId,String quantity, String customerId) async {
    // var result = await apiRepositoryInterface.updateProductQty(token, id, quantity);


    MainResponse? mainResponse  = await apiRepositoryInterface.addToCart(customerId, productId,quantity);
    if (mainResponse!.status!) {
      getCartItems(customerId, true);
      SnackBarDialog.showSnackbar('Success',mainResponse.message!);
      // Get.offAllNamed(Routes.landingHome);

    } else {
      SnackBarDialog.showSnackbar('Error',mainResponse.message!);
    }

    // if (result == true) {
    //   AppWidget.snacbar('Added to cart successfully!');
    //   homecontroller.getCartItems(customerId);
    // }
  }

   addToWishList(String productId, String customerId) async {
    // var result = await apiRepositoryInterface.updateProductQty(token, id, quantity);


    MainResponse? mainResponse  = await apiRepositoryInterface.addToWishList(customerId, productId);
    if (mainResponse!.status!) {
      getCartItems(customerId, true);
      SnackBarDialog.showSnackbar('Success',mainResponse.message!);
      // Get.offAllNamed(Routes.landingHome);

    } else {
      SnackBarDialog.showSnackbar('Error',mainResponse.message!);
    }

    // if (result == true) {
    //   AppWidget.snacbar('Added to cart successfully!');
    //   homecontroller.getCartItems(customerId);
    // }
  }

  moveToWishList(String productId, String customerId) async {
    // var result = await apiRepositoryInterface.updateProductQty(token, id, quantity);


    MainResponse? mainResponse  = await apiRepositoryInterface.moveToWishList(customerId, productId);
    if (mainResponse!.status!) {
      getCartItems(customerId, true);
      SnackBarDialog.showSnackbar('Success',mainResponse.message!);
      // Get.offAllNamed(Routes.landingHome);

    } else {
      SnackBarDialog.showSnackbar('Error',mainResponse.message!);
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
      getCartItems(customerId, true);


      // Get.snackbar('Success', mainResponse.message!,duration: const Duration(seconds: 8), snackPosition: SnackPosition.BOTTOM,);
      SnackBarDialog.showSnackbar('Success',mainResponse.message!);
      // Get.offAllNamed(Routes.landingHome);
      return true;

    } else {
      // Get.snackbar('Error', mainResponse.message!,duration: const Duration(seconds: 8), snackPosition: SnackPosition.BOTTOM,);
      SnackBarDialog.showSnackbar('Error',mainResponse.message!);
      return false;
    }

    // if (result == true) {
    //   AppWidget.snacbar('Added to cart successfully!');
    //   homecontroller.getCartItems(customerId);
    // }
  }

   addOrder(String paymentType,productId) async {
    // var result = await apiRepositoryInterface.u
     // pdateProductQty(token, id, quantity);

    MainResponse? mainResponse  = await apiRepositoryInterface.addOrder(customerId.value,productId, paymentType);
    if (mainResponse!.status!) {




      getCartItems(customerId.value, true);
      Get.back();
      Get.back();
      SnackBarDialog.showSnackbar('Success',mainResponse.message!);
    } else {
      SnackBarDialog.showSnackbar('Error',mainResponse.message!);
    }

    // if (result == true) {
    //   AppWidget.snacbar('Added to cart successfully!');
    //   homecontroller.getCartItems(customerId);
    // }
  }

   emptyCart( String customerId) async {
    // var result = await apiRepositoryInterface.updateProductQty(token, id, quantity);

    MainResponse? mainResponse  = await apiRepositoryInterface.emptyCart(customerId);
    if (mainResponse!.status!) {
      getCartItems(customerId, false);
      cartList.clear();
      SnackBarDialog.showSnackbar('Success',mainResponse.message!);
      // Get.offAllNamed(Routes.landingHome);

    } else {
      SnackBarDialog.showSnackbar('Error',mainResponse.message!);
    }

    // if (result == true) {
    //   AppWidget.snacbar('Added to cart successfully!');
    //   homecontroller.getCartItems(customerId);
    // }
  }

   init() async {

     SharedPreferences sharedPreferences = await SharedPreferences.getInstance() ;
     chooseType = sharedPreferences.getString(AppConstants.chooseType!);

     print("chooseType ================= ${chooseType}");

    CheckInternet.checkInternet();
    getSlider();
    // getBrand();
     if(chooseType != null){
       getHomeCategory(chooseType!);
       getHomeDesigner(chooseType!);
       getCategoryByAge(chooseType!);
       getFestiveFashion(chooseType!);
       getNewLaunch(chooseType!);
       getTrendingBrand(chooseType!);
       getOfferWithCategoryList(chooseType!);
       chooseColor(chooseType!);
       bestSellerProduct(chooseType!,customerId.value);
     }
     allProducts();
     newProducts(false);
     await loadUser(true);

  }

  // void clearCart() {
  //   cartList.clear();
  // }


}
