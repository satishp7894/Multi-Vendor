import 'package:eshoperapp/config/theme.dart';
import 'package:eshoperapp/constants/app_costants.dart';
import 'package:eshoperapp/models/brand.dart';
import 'package:eshoperapp/models/products.dart';
import 'package:eshoperapp/models/get_slider.dart';
import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/pages/category/category_products.dart';
import 'package:eshoperapp/pages/home/views/brand.dart';

// import 'package:eshoperapp/pages/home/views/header.dart';
import 'package:eshoperapp/pages/home/views/populor_product.dart';
import 'package:eshoperapp/pages/home/views/sajilo_carousel.dart';
import 'package:eshoperapp/pages/landing_home/home_controller.dart';
import 'package:eshoperapp/routes/navigation.dart';
import 'package:eshoperapp/utils/check_internet.dart';

// import 'package:eshoperapp/pages/landing_home/home_controller.dart';
import 'package:eshoperapp/widgets/block_header.dart';
import 'package:eshoperapp/widgets/product_gridview_tile.dart';
import 'package:eshoperapp/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eshoperapp/style/theme.dart' as Style;

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//
//   }
// }

class Home extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  final int? index;

  Home({this.index});

  @override
  Widget build(BuildContext context) {
    return SajiloDokanScaffold(
      leading: false,
      searchOnTab: () {},
      bottomMenuIndex: index,
      title: null,
      background: Colors.grey.withOpacity(0.1),
      body: RefreshIndicator(
        onRefresh: () {
          CheckInternet.checkInternet();
          homeController.getBrand();
          homeController.bestSellerProduct();
          homeController.allProducts();
          homeController.newProducts();
          return homeController.getSlider();
        },        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                // Header(),
                //  SajiloCarousel(),
                Obx(() {
                  GetSlider getSliderObj = homeController.getSliderObj.value;
                  if (homeController.isLoadingGetSlider.value != true) {

                    List<GetSliderData>? getSliderDataList =
                    getSliderObj.data ?? [];
                    String? message = getSliderObj.message ?? AppConstants.noInternetConn;
                    String? imageUrl = getSliderObj.imageUrl;
                    if (getSliderDataList.isEmpty) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              message!,
                              style: TextStyle(color: Colors.black45),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return SajiloCarousel(
                        sliderList: getSliderDataList,
                        imageUrl: imageUrl,
                      );
                    }
                    // String? message = getTodayNewsObj.message ?? AppConstants.noInternetConn;

                  } else {
                    if (getSliderObj != true) {
                      return Container(
                          height: 90,
                          child: Center(
                              child:
                                  CircularProgressIndicator(color: Colors.red)));
                    } else {
                      return Container(
                        height: 90,
                      );
                    }
                  }
                }),

                BlockHeader(
                  title: 'Brand',
                  // linkText: 'View all',
                  linkText: '',
                  onLinkTap: () {
                    // navigator!.pushNamed(Routes.categoryProduct,
                    //     arguments: CategoryArguments(
                    //         product: homeController.productList,
                    //         categoryName: 'Popular Product'));
                  },
                ),
                // Obx(() {
                //   final list = controller.productList.toList();
                //   return Padding(
                //     padding: const EdgeInsets.all(6.0),
                //     child: PopulorProduct(
                //       products: controller.isLoading.isTrue ? list : null,
                //     ),
                //   );
                // }),
                Obx(() {
                  if (homeController.isLoadingGetBrand.value != true) {
                    MainResponse? mainResponse = homeController.getBrandObj.value;
                    List<Brand>? getBrandData = [];
                    if(mainResponse.data != null){
                      mainResponse.data!.forEach((v) {
                        getBrandData.add( Brand.fromJson(v));
                      });
                    }
                    // mainResponse.data!.map((e) => customerProfileData!.add(UpdateCustomerPasswordData.fromJson(e))).toList();


                    String? imageUrl = mainResponse.imageUrl ?? "";
                    String? message = mainResponse.message ?? AppConstants.noInternetConn;
                    if (getBrandData.isEmpty) {
                      return Container(
                        height: 90.0,
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
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: BrandWidget(
                          brands: getBrandData,
                          imageUrl: imageUrl,
                        ),
                      );
                    }

                  } else {
                    return  Container(
                        height: 90,
                        child: Center(child: CircularProgressIndicator(color: Style.Colors.appColor)));

                  }
                }),
                BlockHeader(
                  title: 'All Product',
                  // linkText: 'View all',
                  linkText: '',
                  onLinkTap: () {
                    // navigator!.pushNamed(Routes.categoryProduct,
                    //     arguments: CategoryArguments(
                    //         product: homeController.productList,
                    //         categoryName: 'Popular Product'));
                  },
                ),
                // Obx(() {
                //   final list = controller.productList.toList();
                //   return Padding(
                //     padding: const EdgeInsets.all(6.0),
                //     child: PopulorProduct(
                //       products: controller.isLoading.isTrue ? list : null,
                //     ),
                //   );
                // }),
                Obx(() {
                  if (homeController.isLoadingAllProducts.value != true) {
                    MainResponse? mainResponse = homeController.allProductsObj.value;
                    List<Products>? allProductsData = [];

                    if(mainResponse.data != null){
                      mainResponse.data!.forEach((v) {
                        allProductsData.add( Products.fromJson(v));
                      });
                    }
                    // mainResponse.data!.map((e) => customerProfileData!.add(UpdateCustomerPasswordData.fromJson(e))).toList();


                    String? imageUrl = mainResponse.imageUrl ?? "";
                    String? message = mainResponse.message ?? AppConstants.noInternetConn;
                    if (allProductsData.isEmpty) {
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
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: PopulorProduct(
                          products: allProductsData,
                          imageUrl: imageUrl,
                        ),
                      );
                    }

                  } else {
                    return const SizedBox(
                        height: 200,
                        child: Center(child: CircularProgressIndicator(color: Style.Colors.appColor)));
                  }
                }),

                BlockHeader(
                  title: 'Best Seller Product',
                  // linkText: 'View all',
                  linkText: '',
                  onLinkTap: () {
                    // navigator!.pushNamed(Routes.categoryProduct,
                    //     arguments: CategoryArguments(
                    //         product: homeController.productList,
                    //         categoryName: 'Popular Product'));
                  },
                ),
                // Obx(() {
                //   final list = controller.productList.toList();
                //   return Padding(
                //     padding: const EdgeInsets.all(6.0),
                //     child: PopulorProduct(
                //       products: controller.isLoading.isTrue ? list : null,
                //     ),
                //   );
                // }),
                Obx(() {
                  if (homeController.isLoadingBestSellerProducts.value != true) {
                    MainResponse? mainResponse = homeController.bestSellerProductObj.value;
                    List<Products>? bestSellerProductsData = [];
                    if(mainResponse.data != null){
                      mainResponse.data!.forEach((v) {
                        bestSellerProductsData.add( Products.fromJson(v));
                      });
                    }
                    // mainResponse.data!.map((e) => customerProfileData!.add(UpdateCustomerPasswordData.fromJson(e))).toList();


                    String? imageUrl = mainResponse.imageUrl ?? "";
                    String? message = mainResponse.message ?? AppConstants.noInternetConn;
                    if (bestSellerProductsData.isEmpty) {
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
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: PopulorProduct(
                          products: bestSellerProductsData,
                          imageUrl: imageUrl,
                        ),
                      );
                    }

                  } else {
                    return  Container(
                        height: 200,
                        child: Center(child: CircularProgressIndicator(color: Style.Colors.appColor)));

                  }
                }),


                BlockHeader(
                  title: 'New Product',
                  // linkText: 'View all'
                  linkText: '',
                  onLinkTap: () {
                    print(homeController.productList);
                    print('ohmygod');
                    // navigator!.pushNamed(Routes.categoryProduct,
                    //     arguments: CategoryArguments(
                    //         product: homeController.productList,
                    //         categoryName: 'New Products'));
                  },
                ),
                // Obx(() {
                //   final list = homeController.productList.toList();
                //   return ProductGridviewTile(
                //     productList: homeController.isLoading.value ? list : null,
                //   );
                // }),

                Obx(() {
                  if (homeController.isLoadingNewProducts.value != true) {
                    MainResponse? mainResponse = homeController.newProductsObj.value;
                    List<Products>? newProductsData = [];
                    if(mainResponse.data != null){
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
            ),
          ),
        ),
      ),
    );
  }
}
