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

class SearchController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;


  SearchController(
      {required this.apiRepositoryInterface,
      required this.localRepositoryInterface});

  List<Products> productGrid = [
    Products(productName: "ROADSTER",coverImage: "assets/img/producr1.png",shortDescription:"Lightweight Leather Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
    Products(productName: "ROADSTER",coverImage: "assets/img/producr2.png",shortDescription:"Lightweight Leather Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
    Products(productName: "ROADSTER",coverImage: "assets/img/producr3.png",shortDescription:"Lightweight Leather Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
    Products(productName: "ROADSTER",coverImage: "assets/img/producr3.png",shortDescription:"Lightweight Leather Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
    Products(productName: "ROADSTER",coverImage: "assets/img/producr3.png",shortDescription:"Lightweight Leather Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
    Products(productName: "ROADSTER",coverImage: "assets/img/producr3.png",shortDescription:"Lightweight Leather Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
    Products(productName: "ROADSTER",coverImage: "assets/img/producr3.png",shortDescription:"Lightweight Leather Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
    Products(productName: "ROADSTER",coverImage: "assets/img/producr3.png",shortDescription:"Lightweight Leather Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
    Products(productName: "ROADSTER",coverImage: "assets/img/producr3.png",shortDescription:"Lightweight Leather Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
    Products(productName: "ROADSTER",coverImage: "assets/img/producr3.png",shortDescription:"Lightweight Leather Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
    Products(productName: "ROADSTER",coverImage: "assets/img/producr3.png",shortDescription:"Lightweight Leather Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
    Products(productName: "ROADSTER",coverImage: "assets/img/producr3.png",shortDescription:"Lightweight Leather Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF")
  ];

  List<Categories> categoryList = [
    Categories(categoryName: "All",categoryImage: "assets/img/all.png"),
    Categories(categoryName: "Women",categoryImage: "assets/img/women.png"),
    Categories(categoryName: "Men",categoryImage: "assets/img/men.png"),
    Categories(categoryName: "Kids",categoryImage: "assets/img/kids2.png"),
    Categories(categoryName: "All",categoryImage: "assets/img/all.png"),
    Categories(categoryName: "Women",categoryImage: "assets/img/women.png"),
    Categories(categoryName: "Men",categoryImage: "assets/img/men.png"),
    Categories(categoryName: "Kids",categoryImage: "assets/img/kids2.png"),
    Categories(categoryName: "All",categoryImage: "assets/img/all.png"),
    Categories(categoryName: "Women",categoryImage: "assets/img/women.png"),
    Categories(categoryName: "Men",categoryImage: "assets/img/men.png"),
    Categories(categoryName: "Kids",categoryImage: "assets/img/kids2.png")
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

}
