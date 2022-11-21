import 'package:eshoperapp/config/theme.dart';
import 'package:eshoperapp/models/cart.dart';
import 'package:eshoperapp/models/carts.dart';
import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/pages/landing_home/home_controller.dart';
import 'package:eshoperapp/repository/api_repository.dart';
import 'package:eshoperapp/repository/local_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/snackbar_dialog.dart';

class CartController extends GetxController {
  final ApiRepositoryInterface apiRepositoryInterface;
  final LocalRepositoryInterface localRepositoryInterface;
  final homecontroller = Get.put(HomeController(
      localRepositoryInterface: Get.find(),
      apiRepositoryInterface: Get.find()));
  CartController(
      {required this.apiRepositoryInterface,
      required this.localRepositoryInterface});

  RxInt quantity = 0.obs;
  RxBool loading = false.obs;

  ScrollController scrollController = ScrollController();
  RxBool isVisible = true.obs;

  List<Carts> cartList = [
    Carts(productId: "1",productName: "Gap",coverImg: "assets/img/gap.png",description: "Red Women’s T-Shirt With Logo",netPrice: "549",mrpPrice: "999",discount: "45% OFF",quantity: "1"),
    Carts(productId: "2",productName: "Roadster",coverImg: "assets/img/roadster.png",description: "Black Casual Cotton Shirt",netPrice: "549",mrpPrice: "999",discount: "45% OFF",quantity: "1"),

    // Carts(productId: "3",productName: "Gap",coverImg: "assets/img/gap.png",description: "Red Women’s T-Shirt With Logo",netPrice: "549",mrpPrice: "999",discount: "45% OFF",quantity: "1"),
    // Carts(productId: "4",productName: "Roadster",coverImg: "assets/img/roadster.png",description: "Black Casual Cotton Shirt",netPrice: "549",mrpPrice: "999",discount: "45% OFF",quantity: "1"),
    // Carts(productId: "5",productName: "Gap",coverImg: "assets/img/gap.png",description: "Red Women’s T-Shirt With Logo",netPrice: "549",mrpPrice: "999",discount: "45% OFF",quantity: "1"),
    // Carts(productId: "6",productName: "Roadster",coverImg: "assets/img/roadster.png",description: "Black Casual Cotton Shirt",netPrice: "549",mrpPrice: "999",discount: "45% OFF",quantity: "1"),
    // Carts(productId: "7",productName: "Gap",coverImg: "assets/img/gap.png",description: "Red Women’s T-Shirt With Logo",netPrice: "549",mrpPrice: "999",discount: "45% OFF",quantity: "1"),
    // Carts(productId: "8",productName: "Roadster",coverImg: "assets/img/roadster.png",description: "Black Casual Cotton Shirt",netPrice: "549",mrpPrice: "999",discount: "45% OFF",quantity: "1"),
    // Carts(productId: "9",productName: "Gap",coverImg: "assets/img/gap.png",description: "Red Women’s T-Shirt With Logo",netPrice: "549",mrpPrice: "999",discount: "45% OFF",quantity: "1"),
    // Carts(productId: "10",productName: "Roadster",coverImg: "assets/img/roadster.png",description: "Black Casual Cotton Shirt",netPrice: "549",mrpPrice: "999",discount: "45% OFF",quantity: "1"),
    // Carts(productId: "11",productName: "Gap",coverImg: "assets/img/gap.png",description: "Red Women’s T-Shirt With Logo",netPrice: "549",mrpPrice: "999",discount: "45% OFF",quantity: "1"),
    // Carts(productId: "12",productName: "Roadster",coverImg: "assets/img/roadster.png",description: "Black Casual Cotton Shirt",netPrice: "549",mrpPrice: "999",discount: "45% OFF",quantity: "1"),
    // Carts(productId: "13",productName: "Gap",coverImg: "assets/img/gap.png",description: "Red Women’s T-Shirt With Logo",netPrice: "549",mrpPrice: "999",discount: "45% OFF",quantity: "1"),
    // Carts(productId: "14",productName: "Roadster",coverImg: "assets/img/roadster.png",description: "Black Casual Cotton Shirt",netPrice: "549",mrpPrice: "999",discount: "45% OFF",quantity: "1"),
    //


  ];

  @override
  void onInit() {
    super.onInit();
    // scontroller = ScrollController();
    // scontroller.addListener(() {
    //   if (scontroller.position.userScrollDirection == ScrollDirection.reverse) {
    //     if (isVisible.value) {
    //       isVisible(false);
    //       print(isVisible);
    //     }
    //   }
    //   if (scontroller.position.userScrollDirection == ScrollDirection.forward) {
    //     if (!isVisible.value) {
    //       isVisible(true);
    //       print(isVisible);
    //     }
    //   }
    // });
  }


  void selectAllCart(List<Carts> getCartData) {
    if (homecontroller.selectedCarts.length == getCartData.length) {
      homecontroller.selectedCarts([]);
    } else {
      homecontroller.selectedCarts([]);
      getCartData.forEach((element) {
        homecontroller.selectedCarts.add(element.cartId);
      });
    }
    homecontroller.refreshTotal();
  }

  // void selectAllCartInit(List<Carts> getCartData) {
  //
  //   if (homecontroller.selectedCarts.length == getCartData.length) {
  //     homecontroller.selectedCarts([]);
  //   } else {
  //     homecontroller.selectedCarts([]);
  //     getCartData.forEach((element) {
  //       homecontroller.selectedCarts.add(element.cartId);
  //     });
  //   }
  //   homecontroller.refreshTotal();
  // }

  void selectCart(Carts cart) {
    if (!homecontroller.selectedCarts.contains(cart.cartId)) {
      homecontroller.selectedCarts.add(cart.cartId);
    } else {
      homecontroller.selectedCarts.remove(cart.cartId);
    }
    homecontroller.refreshTotal();
  }

  void addQuantity(int? id, int quantity, String customerId) async {
    // var result = await apiRepositoryInterface.updateProductQty(token, id, quantity);

    MainResponse? mainResponse  = await apiRepositoryInterface.updateProductQty(customerId, id.toString(), quantity.toString());
    if (mainResponse!.status!) {
      homecontroller.getCartItems(customerId, false);
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

  void showButtomSheed(
      BuildContext context, VoidCallback onTap, int? id, String customerId) async {
    showModalBottomSheet(
        context: context,
        builder: (context) => SizedBox(
            height: 200,
            child: Obx(() {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        const Text('Selete Quantity'),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.cancel)),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...List.generate(
                            10,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      quantity(index + 1);
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          border: Border.all(
                                              color:
                                                  quantity.value == (index + 1)
                                                      ? Colors.redAccent
                                                      : Colors.black)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text((1 + index).toString()),
                                        ),
                                      ),
                                    ),
                                  ),
                                ))
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      addQuantity(id, quantity.value,customerId);
                      Navigator.pop(context);
                    },
                    child: Container(
                        height: 50,
                        color: Colors.redAccent,
                        width: double.infinity,
                        child: const Center(child: Text('Done'))),
                  )
                ],
              );
            })));
  }
}
