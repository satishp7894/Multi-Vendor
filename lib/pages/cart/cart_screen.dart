import 'package:eshoperapp/constants/app_costants.dart';
import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/models/products.dart';
import 'package:eshoperapp/pages/cart/views/cart_item.dart';
import 'package:eshoperapp/pages/cart/views/checkout_cart.dart';
import 'package:eshoperapp/pages/cart/views/items_number.dart';
import 'package:eshoperapp/pages/landing_home/home_controller.dart';
import 'package:eshoperapp/utils/check_internet.dart';
import 'package:eshoperapp/widgets/product_gridview_tile.dart';
import 'package:eshoperapp/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:eshoperapp/style/theme.dart' as Style;
import 'cart_controller.dart';

class CartScreen extends StatelessWidget {
  final controller = Get.find<HomeController>();
  final cardController = Get.put(CartController(
      apiRepositoryInterface: Get.find(),
      localRepositoryInterface: Get.find()));
  final int index;
  final bool leading;
  CartScreen(this.index, this.leading);
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return SajiloDokanScaffold(
        title: "Shopping Cart",
        searchOnTab: (){

        },
        leading: leading,
        body: RefreshIndicator(
          onRefresh: () {
            CheckInternet.checkInternet();
            return controller.newProducts();
          },
          child: Scaffold(
              // appBar: AppBar(
              //   centerTitle: true,
              //   elevation: 0,
              //   title: Text(
              //     'Shopping Cart',
              //     style: TextStyle(color: Colors.black),
              //   ),
              // ),
              backgroundColor: Colors.grey.withOpacity(0.1),
              body:  Stack(
                children: [
                  Obx(() {
                    return ListView(
                      //controller: _scrollController,
                      children: [
                        Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: ItemNuber(
                                      itemNumber: controller.cartList.length,
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        controller.clearCart();
                                      },
                                      child: Text(
                                        'Clear all',
                                        style: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 16),
                                      ))
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        cardController.selectAllCart();
                                      },
                                      icon: controller.isAllCartSelected
                                          ? Icon(Icons.check_box)
                                          : Icon(
                                          Icons.check_box_outline_blank)),
                                  Text(
                                    'Select All',
                                    style: TextStyle(
                                        color: Colors.redAccent, fontSize: 16),
                                  ),
                                  Spacer()
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            ...List.generate(
                                controller.cartList.length,
                                    (index) => CartItem(
                                  cartIndex: index,
                                  cart: controller.cartList[index],
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          color: Colors.white.withOpacity(0.4),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Continue Shopping',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Obx(() {
                          if (controller.isLoadingNewProducts.value != true) {
                            MainResponse? mainResponse = controller.newProductsObj.value;
                            List<Products>? newProductsData = [];
                            if(mainResponse.data !=null){
                              mainResponse.data!.forEach((v) {
                                newProductsData.add( Products.fromJson(v));
                              });
                            }
                            // mainResponse.data!.map((e) => customerProfileData!.add(UpdateCustomerPasswordData.fromJson(e))).toList();


                            String? imageUrl = mainResponse.imageUrl ?? "";
                            String? message = mainResponse.message ?? AppConstants.noInternetConn;
                            if (newProductsData.isEmpty) {
                              return Container(
                                height: 200.0,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          message!,
                                          style: TextStyle(color: Colors.black45),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }else{
                              return ProductGridviewTile(
                                products: newProductsData,
                                imageUrl: imageUrl,
                              );
                            }

                          } else {
                            return  Container(
                                height: 200,
                                child: Center(child: CircularProgressIndicator(color: Style.Colors.appColor)));

                          }
                        }),
                      ],
                    );
                  }),
                  Obx(() {
                    return controller.isCartLoad.value
                        ? Container(
                      color: Colors.grey.withOpacity(0.4),
                      height: double.infinity,
                      width: double.infinity,
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                    )
                        : SizedBox.shrink();
                  })
                ],
              ),

              // NotificationListener<ScrollNotification>(
              //   onNotification: (scrollNotification) {
              //     if (_scrollController.position.userScrollDirection ==
              //         ScrollDirection.reverse) {
              //       cardController.isVisible(false);
              //
              //       //the setState function
              //     } else if (_scrollController.position.userScrollDirection ==
              //         ScrollDirection.forward) {
              //       cardController.isVisible(true);
              //
              //       //setState function
              //     }
              //     return true;
              //   },
              //   child:
              //
              // ),
              bottomNavigationBar: Obx(() {
                return CheckoutCart(
                  totalAmount: controller.totalAmount.value,
                );
              })),
        ));
  }
}
