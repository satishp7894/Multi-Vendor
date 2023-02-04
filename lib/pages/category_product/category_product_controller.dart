import 'package:eshoperapp/models/category_product.dart';
import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/models/products.dart';
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


  RxBool isLoadingChildCategory= false.obs;
  var childCategoryObj = MainResponse().obs;


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


  List<String> sortList = ["What’s new","Price- high to low","Popularity","Discount","Price- low to high","Customer rating"];

  @override
  void onInit() {
    CheckInternet.checkInternet();

    super.onInit();
  }


  // categoryProduct(String categoryId) async {
  //   try {
  //     isLoadingCategoryProduct(true);
  //     await apiRepositoryInterface.categoryProduct(categoryId).then((value) {
  //       categoryProductObj(value);
  //     });
  //   } finally {
  //     isLoadingCategoryProduct(false);
  //   }
  // }

  getChildCategory(String chooseType) async {
    try {
      isLoadingChildCategory(true);
      await apiRepositoryInterface.getChildCategory(chooseType).then((value) {
        childCategoryObj(value);
      });
    } finally {
      isLoadingChildCategory(false);
    }
  }
}
