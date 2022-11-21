// import 'package:eshoperapp/models/cart.dart';
// import 'package:eshoperapp/models/product.dart';
// import 'package:eshoperapp/models/user.dart';
// import 'package:eshoperapp/repository/api_repository.dart';
// import 'package:eshoperapp/repository/local_repository.dart';
// import 'package:eshoperapp/routes/navigation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class HomeController extends GetxController {
//   final ApiRepositoryInterface apiRepositoryInterface;
//   final LocalRepositoryInterface localRepositoryInterface;
//   HomeController(
//       {required this.apiRepositoryInterface,
//       required this.localRepositoryInterface});
//
//   Rx<User> user = User.empty().obs;
//   RxInt selectedIndex = 0.obs;
//   var productList = <Product>[].obs;
//   RxBool isLoading = true.obs;
//
//   RxBool isFavorite = false.obs;
//   var cartList = <Cart>[].obs;
//   RxBool isCartLoad = false.obs;
//   RxDouble totalAmount = 0.0.obs;
//   var total;
//
//   RxList selectedCarts = [].obs;
//
//   void refreshTotal() async {
//     total = 0.0;
//     cartList.forEach((element) {
//       if (selectedCarts.contains(element.id)) {
//         total += element.amount;
//       }
//     });
//     totalAmount(total);
//   }
//
//   bool get isAllCartSelected =>
//       selectedCarts.length == cartList.length ? true : false;
//
//   @override
//   void onReady() {
//     loadUser();
//     super.onReady();
//     fetchProduct();
//     fetchCartList();
//   }
//
//   loadUser() {
//     localRepositoryInterface.getUser().then((value) => user(value));
//   }
//
//   void updateIndexSelected(int index) {
//     selectedIndex(index);
//   }
//
//   void logout() async {
//     final token = await localRepositoryInterface.getToken();
//     await apiRepositoryInterface.logout(token);
//     await localRepositoryInterface.clearAllData();
//   }
//
//   void fetchProduct() async {
//     final token = await localRepositoryInterface.getToken();
//     isLoading(false);
//     try {
//       var products = await apiRepositoryInterface.fetchingProdcut(token);
//       if (products != null) {
//         productList(products);
//       }
//     } finally {
//       isLoading(true);
//     }
//   }
//
//   // void favoritebtn() {
//   //   isFavorite.value = !isFavorite.value;
//   // }
//
//   void fetchCartList() async {
//     final token = await localRepositoryInterface.getToken();
//     try {
//       isCartLoad(true);
//       var carts = await apiRepositoryInterface.getCartList(token);
//       print('Cartlist called');
//       if (carts != null) {
//         cartList(carts);
//       }
//     } finally {
//       isCartLoad(false);
//       refreshTotal();
//     }
//   }
//
//   void addToCard(int? id) async {
//     final token = await localRepositoryInterface.getToken();
//     if (token != null) {
//       if (!isCartLoad.value) {
//         var result = await apiRepositoryInterface.addToCart(token, id);
//
//         fetchCartList();
//         if (result == true) {
//           Get.snackbar('Added to cart successfully!', '',
//               snackPosition: SnackPosition.BOTTOM,
//               colorText: Colors.white,
//               borderRadius: 0,
//               backgroundColor: Colors.black.withOpacity(0.8),
//               isDismissible: true,
//               margin: EdgeInsets.all(0),
//               padding: EdgeInsets.all(5)
//               // animationDuration: Duration(seconds: 1),
//               // duration: Duration(seconds: 2),
//               );
//         }
//       }
//     } else {
//       Get.offNamed(Routes.login);
//     }
//   }
//
//   void removeProductFromCart(int? id) async {
//     final token = await localRepositoryInterface.getToken();
//
//     await apiRepositoryInterface.deleteCart(token, id);
//     fetchCartList();
//   }
//
//   void clearCart() {
//     cartList.clear();
//   }
// }



// import 'package:eshopapp/constants/asset_constants.dart';
// import 'package:eshopapp/constants/string_constants.dart';
// import 'package:eshopapp/models/product.dart';
// import 'package:eshopapp/views/login_view.dart';
// import 'package:eshopapp/models/category.dart';
// import 'package:flutter/foundation.dart';
import 'package:eshoperapp/models/cart.dart';
import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/models/product.dart';
import 'package:eshoperapp/models/product_comment.dart';
import 'package:eshoperapp/models/user.dart';
import 'package:eshoperapp/repository/api_repository.dart';
import 'package:eshoperapp/repository/local_repository.dart';
import 'package:eshoperapp/routes/navigation.dart';
import 'package:eshoperapp/utils/check_internet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/products.dart';

class ProductDetailsController extends GetxController {
  final ApiRepositoryInterface apiRepositoryInterface;
  final LocalRepositoryInterface localRepositoryInterface;
  final String productDetailId;

  ProductDetailsController({required this.apiRepositoryInterface,
    required this.localRepositoryInterface,required this.productDetailId});

  RxInt? selectedImage = 0.obs;
  int get index => selectedImage!.value;

  PageController pageController = PageController(
    initialPage: 0,
  );

  RxBool initbool = true.obs;
  RxInt productid = 0.obs;

  var comments = <ProductComment>[].obs;
  RxBool isCommentsLoad = false.obs;

  PhotoViewScaleStateController? controllerState;

  RxBool isLoadingProductDetail= false.obs;
  var productDetailObj = MainResponse().obs;

  RxBool isRefresh = false.obs;

  List<Color> colorList = [
    Colors.red,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.pink,
    Colors.orange,
  ];

  int? currentIndex = 0;
  final List<String> img = [
    'https://images.template.net/wp-content/uploads/2016/11/15115545/Free-Marketing-Product-Sale-Banner.jpg',
    'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/facebook-cover-sale-banner-design-template-724adcb8d9a5e63bd0c602643186454d_screen.jpg?ts=1608557087',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTU7RiD0MiS3zu_IjZA6cCNtPpNgm6rk2spsaKCw40OxTLdH72Renkgm21Cd09TxM0vevE&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4A_THdCJyuCOmGkN11OR4gGjyBJuBgEpGmQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHTzusfPqz1-dogbofS9mxWdCAegcO8i7D3w&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJOCHxQGCUwAE1Ybn6vTcIz4JZnjnNJU5s5Q&usqp=CAU'
  ];

  final List<String> sizeList = [
    "XS",
    "S",
    "M",
    "L",
    "XL",
    "XXL",
    "3XL",
  ];


  List<Products> list = [
    Products(productName: "Fabric",shortDescription:"Leather"),
    Products(productName: "Number of Pockets",shortDescription:"4"),
    Products(productName: "Lining Fabric",shortDescription:"Polyster"),
    Products(productName: "Sustainable",shortDescription:"Regular"),
    Products(productName: "Features",shortDescription:"Lightweight"),
  ];

  List<Products> similarList = [
    Products(productName: "ROADSTER",coverImage: "assets/img/similar.png",shortDescription:"Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
    Products(productName: "ROADSTER",coverImage: "assets/img/similar.png",shortDescription:"Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
    Products(productName: "ROADSTER",coverImage: "assets/img/similar.png",shortDescription:"Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
    Products(productName: "ROADSTER",coverImage: "assets/img/similar.png",shortDescription:"Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
    Products(productName: "ROADSTER",coverImage: "assets/img/similar.png",shortDescription:"Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
    Products(productName: "ROADSTER",coverImage: "assets/img/similar.png",shortDescription:"Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
    Products(productName: "ROADSTER",coverImage: "assets/img/similar.png",shortDescription:"Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
    Products(productName: "ROADSTER",coverImage: "assets/img/similar.png",shortDescription:"Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
    Products(productName: "ROADSTER",coverImage: "assets/img/similar.png",shortDescription:"Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
    Products(productName: "ROADSTER",coverImage: "assets/img/similar.png",shortDescription:"Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
    Products(productName: "ROADSTER",coverImage: "assets/img/similar.png",shortDescription:"Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF"),
    Products(productName: "ROADSTER",coverImage: "assets/img/similar.png",shortDescription:"Jacket" ,netPrice: "549",mrpPrice: "999",discount: "45% OFF")

  ];

  //Animation Controller for Controll animation
  //Declare

  //Animation Onject

  @override
  void onInit() async {
    super.onInit();
    CheckInternet.checkInternet();
    controllerState = PhotoViewScaleStateController();
    // final token = await localRepositoryInterface.getToken();
    // getComments(productid.value, token);
    // productDetails(productDetailId, false);

    //Initialize Animation Controller
  }

  @override
  void onClose() {
    // TODO: implement onClose
    print("selectedImage");
    // selectedImage!(0);
    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void goBack() {
    controllerState!.scaleState = PhotoViewScaleState.initial;
  }

  void setInit(bool? fab) {
    initbool(fab!);
  }

  void clickFavorite() {
    initbool(!initbool.value);
  }

  productDetails(String productId, bool refresh) async {
    try {
      isLoadingProductDetail(true);
      isRefresh(refresh);
      await apiRepositoryInterface.productDetails(productId).then((value) {
        productDetailObj(value);
      });
    } finally {
      isLoadingProductDetail(false);
    }
  }

  Future<void> makeFavorite(int? id) async {
    final token = await localRepositoryInterface.getToken();
    clickFavorite();
    if (token != null) {
      var result = await apiRepositoryInterface.makeFavorite(token, id);
      print('fab btn called');

      if (result == true) {
        Get.snackbar(
            initbool.value
                ? 'Add item to favorit list successfully!'
                : 'Remove from favorite',
            '',
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
    } else {
      Get.offNamed(Routes.login);
    }
  }

  Future<void> getComments(int? id, String? token) async {
    String? token = await localRepositoryInterface.getToken();
    isCommentsLoad(true);
    var data = await apiRepositoryInterface.getComments(token, id);
    print(id);
    print('GetComment call');

    if (data != null) {
      comments(data);
    } else {
      comments(null);
    }
    isCommentsLoad(false);
  }

  void likeBtn(int? commentId, int? productId) async {
    var token = await localRepositoryInterface.getToken();
    if (token != null) {
      var result = await apiRepositoryInterface.likeComment(token, commentId);

      if (result == true) {
        await getComments(productId, token);
      }
    } else {
      Get.offNamed(Routes.login);
    }
  }

  void dislikeBtn(int? commentId, int? productId) async {
    var token = await localRepositoryInterface.getToken();

    if (token != null) {
      var result =
      await apiRepositoryInterface.dislikeComment(token, commentId);

      if (result == true) {
        await getComments(productId, token);
      }
    } else {
      Get.offNamed(Routes.login);
    }
  }
}
