import 'package:eshoperapp/models/category_product.dart';
import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/models/products.dart';
import 'package:eshoperapp/repository/api_repository.dart';
import 'package:eshoperapp/repository/local_repository.dart';
import 'package:eshoperapp/utils/check_internet.dart';
import 'package:get/get.dart';

import '../../models/product_filter_oprion_model.dart';

class CommonProductListController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;

  CommonProductListController(
      {required this.apiRepositoryInterface,
      required this.localRepositoryInterface});

  RxString genderValue= "".obs;
  RxString sortValue= "".obs;
  RxString filterValue= "".obs;

  double lowerValue = 0;
  double upperValue = 0;
  double minValue = 0;
  double maxValue = 0;

  // double lowerValue = 0.0;
  // double upperValue = 100.0;
  List<ProductFilterOption>? getFilterLoaded = [];
  List<Map<String, String>> finalData = [];

  RxBool isLoadingCommonProduct= false.obs;
  var commonProductObj = MainResponse().obs;

  RxBool isLoadingGetProductFilterOption= false.obs;
  var getProductFilterOptionObj = MainResponse().obs;


  // List<Products> productGrid = [
  //   Products(productName: "ROADSTER",coverImage: "assets/img/producr1.png",shortDescription:"Lightweight Leather Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
  //   Products(productName: "ROADSTER",coverImage: "assets/img/producr2.png",shortDescription:"Lightweight Leather Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
  //   Products(productName: "ROADSTER",coverImage: "assets/img/producr3.png",shortDescription:"Lightweight Leather Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
  //   Products(productName: "ROADSTER",coverImage: "assets/img/producr3.png",shortDescription:"Lightweight Leather Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
  //   Products(productName: "ROADSTER",coverImage: "assets/img/producr3.png",shortDescription:"Lightweight Leather Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
  //   Products(productName: "ROADSTER",coverImage: "assets/img/producr3.png",shortDescription:"Lightweight Leather Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
  //   Products(productName: "ROADSTER",coverImage: "assets/img/producr3.png",shortDescription:"Lightweight Leather Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
  //   Products(productName: "ROADSTER",coverImage: "assets/img/producr3.png",shortDescription:"Lightweight Leather Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
  //   Products(productName: "ROADSTER",coverImage: "assets/img/producr3.png",shortDescription:"Lightweight Leather Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
  //   Products(productName: "ROADSTER",coverImage: "assets/img/producr3.png",shortDescription:"Lightweight Leather Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
  //   Products(productName: "ROADSTER",coverImage: "assets/img/producr3.png",shortDescription:"Lightweight Leather Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
  //   Products(productName: "ROADSTER",coverImage: "assets/img/producr3.png",shortDescription:"Lightweight Leather Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF")
  // ];
  //
  //
  List<String> sortList = ["What’s new","Price - high to low","Popularity","Discount","Price - low to high"];

  @override
  void onInit() {
    // print("apiType ======== $apiType");
    // print("id ======== $id");
    // print("chooseType ======== $chooseType");
    // CheckInternet.checkInternet();
    // if(apiType == "ProductByAttributeAndCategory"){
    //   getProductByAttributeAndCategory();
    // }
    super.onInit();
  }


  getProductByAttributeAndCategory(attributeId,chooseType,customerId) async {
    try {
      isLoadingCommonProduct(true);
      await apiRepositoryInterface.getProductByAttributeAndCategory(attributeId,chooseType,customerId).then((value) {
        commonProductObj(value);
      });
    } finally {
      isLoadingCommonProduct(false);
    }
  }

  brandProduct(brandId,customerId,chooseType) async {
    try {
      isLoadingCommonProduct(true);
      await apiRepositoryInterface.brandProduct(brandId,customerId,chooseType).then((value) {
        commonProductObj(value);
      });
    } finally {
      isLoadingCommonProduct(false);
    }
  }

  categoryProduct(categoryId,customerId) async {
    try {
      isLoadingCommonProduct(true);
      await apiRepositoryInterface.categoryProduct(categoryId,customerId).then((value) {
        commonProductObj(value);
      });
    } finally {
      isLoadingCommonProduct(false);
    }
  }

  getCategoryProductWithOffers(offerId,categoryId,customerId) async {
    try {
      isLoadingCommonProduct(true);
      await apiRepositoryInterface.getCategoryProductWithOffers(offerId,categoryId,customerId).then((value) {
        commonProductObj(value);
      });
    } finally {
      isLoadingCommonProduct(false);
    }
  }

  searchBykeywords(keyword,customerId,chooseType) async {
    try {
      isLoadingCommonProduct(true);
      await apiRepositoryInterface.searchBykeywords(keyword,customerId,chooseType).then((value) {
        commonProductObj(value);
      });
    } finally {
      isLoadingCommonProduct(false);
    }
  }

  productSortByWithFilter(categoryId,shorBy,flutterOption,customerId,gender,chooseCode,tag,mimPrice,maxPrice) async {
    try {
      isLoadingCommonProduct(true);
      await apiRepositoryInterface.productSortByWithFilter(
          categoryId,
          shorBy,
          flutterOption,
          customerId,
          gender,
          chooseCode,
          tag,
          mimPrice,
          maxPrice
      ).then((value) {
        commonProductObj(value);
      });
    } finally {
      isLoadingCommonProduct(false);
    }
  }

  getProductFilterOption(categoryId,brandId,chooseType) async {
    try {
      isLoadingGetProductFilterOption(false);
      await apiRepositoryInterface.getProductFilterOption(categoryId,brandId,chooseType).then((value) {
        getProductFilterOptionObj(value);
      });
    } finally {
      isLoadingGetProductFilterOption(true);
    }
  }

  // brandProduct(String brandId,bool refresh) async {
  //   try {
  //     isLoadingBrandProduct(true);
  //     isRefresh(refresh);
  //     await apiRepositoryInterface.brandProduct(brandId).then((value) {
  //       brandProductObj(value);
  //     });
  //   } finally {
  //     isLoadingBrandProduct(false);
  //   }
  // }
}
