import 'package:eshoperapp/models/address_request.dart';
import 'package:eshoperapp/models/check_login.dart';
import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/models/shipping_address.dart';
import 'package:eshoperapp/repository/api_repository.dart';
import 'package:eshoperapp/repository/local_repository.dart';
import 'package:eshoperapp/utils/check_internet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/app_costants.dart';
import '../../models/categories.dart';
import '../../models/country_and_state.dart';
import '../../models/products.dart';
import '../../utils/snackbar_dialog.dart';

class WishListController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;


  WishListController(
      {required this.apiRepositoryInterface,
      required this.localRepositoryInterface});

  List<Products> productGrid = [
    Products(productName: "ZARA",coverImage: "assets/img/wishlist1.png",shortDescription:"Lightweight Leather Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
    Products(productName: "ZARA",coverImage: "assets/img/wishlist1.png",shortDescription:"Lightweight Leather Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
    Products(productName: "ZARA",coverImage: "assets/img/wishlist1.png",shortDescription:"Lightweight Leather Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
    Products(productName: "ZARA",coverImage: "assets/img/wishlist1.png",shortDescription:"Lightweight Leather Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
    Products(productName: "ZARA",coverImage: "assets/img/wishlist1.png",shortDescription:"Lightweight Leather Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
    Products(productName: "ZARA",coverImage: "assets/img/wishlist1.png",shortDescription:"Lightweight Leather Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
    Products(productName: "ZARA",coverImage: "assets/img/wishlist1.png",shortDescription:"Lightweight Leather Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
    Products(productName: "ZARA",coverImage: "assets/img/wishlist1.png",shortDescription:"Lightweight Leather Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
    Products(productName: "ZARA",coverImage: "assets/img/wishlist1.png",shortDescription:"Lightweight Leather Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
    Products(productName: "ZARA",coverImage: "assets/img/wishlist1.png",shortDescription:"Lightweight Leather Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
    Products(productName: "ZARA",coverImage: "assets/img/wishlist1.png",shortDescription:"Lightweight Leather Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
    Products(productName: "ZARA",coverImage: "assets/img/wishlist1.png",shortDescription:"Lightweight Leather Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF")
  ];

  List<String> categoryList = [
     "All",
    "Women",
    "Men",
    "Kids",
   

  ];
  List<Categories> recentList = [
    Categories(categoryName: "Men Black Suit",categoryImage: "assets/recent/recent1.png"),
    Categories(categoryName: "Girl’s T-Shirt",categoryImage: "assets/recent/recent2.png"),
    Categories(categoryName: "Baby Sweatshirt",categoryImage: "assets/recent/recent3.png"),
    Categories(categoryName: "Womens Sweatshirt",categoryImage: "assets/recent/recent4.png"),
    Categories(categoryName: "Womens Kurta",categoryImage: "assets/recent/recent5.png"),
    Categories(categoryName: "Men’s Kurta ",categoryImage: "assets/recent/recent6.png"),
    Categories(categoryName: "Men Black Suit",categoryImage: "assets/recent/recent1.png"),
    Categories(categoryName: "Girl’s T-Shirt",categoryImage: "assets/recent/recent2.png"),
    Categories(categoryName: "Baby Sweatshirt",categoryImage: "assets/recent/recent3.png"),
    Categories(categoryName: "Womens Sweatshirt",categoryImage: "assets/recent/recent4.png"),
    Categories(categoryName: "Womens Kurta",categoryImage: "assets/recent/recent5.png"),
    Categories(categoryName: "Men’s Kurta ",categoryImage: "assets/recent/recent6.png"),
  ];

  List<Products> wishList = [
    Products(productName: "NIKE",coverImage: "assets/wish/wish1.png",shortDescription:"T-Shirt" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
    Products(productName: "PUMA",coverImage: "assets/wish/wish2.png",shortDescription:"Tights" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
    Products(productName: "KOTTY",coverImage: "assets/wish/wish3.png",shortDescription:"Jeans" ,netPrice: "649",mrpPrice: "999",discount: "68% OFF"),
    Products(productName: "CHEMISTRY",coverImage: "assets/wish/wish4.png",shortDescription:"Tops" ,netPrice: "599",mrpPrice: "999",discount: "55% OFF"),
    Products(productName: "CHEMISTRY",coverImage: "assets/wish/wish5.png",shortDescription:"Shorts" ,netPrice: "584",mrpPrice: "999",discount: "52% OFF"),
  ];
  List<Products> trendingList = [
    Products(productName: "NIKE",coverImage: "assets/wish/wish1.png",shortDescription:"T-Shirt" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
    Products(productName: "PUMA",coverImage: "assets/wish/wish2.png",shortDescription:"Tights" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
    Products(productName: "KOTTY",coverImage: "assets/wish/wish3.png",shortDescription:"Jeans" ,netPrice: "649",mrpPrice: "999",discount: "68% OFF"),
    Products(productName: "CHEMISTRY",coverImage: "assets/wish/wish4.png",shortDescription:"Tops" ,netPrice: "599",mrpPrice: "999",discount: "55% OFF"),
    Products(productName: "CHEMISTRY",coverImage: "assets/wish/wish5.png",shortDescription:"Shorts" ,netPrice: "584",mrpPrice: "999",discount: "52% OFF"),
  ];



  RxBool isLoadingGetWishList = false.obs;
  var getWishListObj = MainResponse().obs;

  loadUser() async {
    print("getUser customerId ===========================================");
    try {
      await localRepositoryInterface.getUser().then((value) {
        print("getUser customerId ${value!.customerId}");
        if (value.customerId != null) {
          getWishList(value.customerId);
        }else{
          getWishList("");
        }
      });
    } on Exception {

      return MainResponse();
    }
    // localRepositoryInterface.getUser().then((value) => user(value!));
  }

  getWishList(String? customerId) async {
    try {
      isLoadingGetWishList(false);
      await apiRepositoryInterface.getWishList("",customerId!).then((value) {
        getWishListObj(value);
      });
    } finally {
      isLoadingGetWishList(true);
    }
  }

  removeWishlistItem(String productId, String customerId, bool bool) async {
    // var result = await apiRepositoryInterface.updateProductQty(token, id, quantity);


    MainResponse? mainResponse  = await apiRepositoryInterface.removeToWishList(customerId, productId);
    if (mainResponse!.status!) {
      if(bool){
        SnackBarDialog.showSnackbar('Success',mainResponse.message!);
      }

      // Get.offAllNamed(Routes.landingHome);

    } else {
      if(bool){
        SnackBarDialog.showSnackbar('Error',mainResponse.message!);
      }

    }

    // if (result == true) {
    //   AppWidget.snacbar('Added to cart successfully!');
    //   homecontroller.getCartItems(customerId);
    // }
  }



}
