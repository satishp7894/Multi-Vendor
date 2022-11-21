import 'package:eshoperapp/constants/app_costants.dart';
import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/models/product.dart';
import 'package:eshoperapp/models/product_detail.dart';
import 'package:eshoperapp/models/products.dart';
import 'package:eshoperapp/package/product_rating.dart';
import 'package:eshoperapp/pages/details/product_details_controller.dart';
import 'package:eshoperapp/pages/details/view/add_cart.dart';
import 'package:eshoperapp/pages/landing_home/home_controller.dart';
import 'package:eshoperapp/routes/navigation.dart';
import 'package:eshoperapp/utils/check_internet.dart';
import 'package:eshoperapp/widgets/product_gridview_tile.dart';
import 'package:eshoperapp/widgets/product_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

// import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:share/share.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../config/theme.dart';
import '../../models/customer.dart';
import '../../utils/alert_dialog.dart';
import '../profile/profile_controller.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Products? products;

  const ProductDetailsScreen({Key? key, required this.products})
      : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ProductDetailsController? productDetailsController;
  Products? products;
  final homecontroller = Get.put(HomeController(
      localRepositoryInterface: Get.find(),
      apiRepositoryInterface: Get.find()));
  final profileController = Get.put(ProfileController(
      apiRepositoryInterface: Get.find(),
      customer: Customer(),
      localRepositoryInterface: Get.find()));

  @override
  void initState() {
    // TODO: implement initState
    // TODO: implement initState
    // dynamic argumentData = Get.arguments;
    products = widget.products;
    print("productObj productDetailId ${products!.productId}");
    productDetailsController = Get.put(ProductDetailsController(
        apiRepositoryInterface: Get.find(),
        productDetailId: products!.productId!,
        localRepositoryInterface: Get.find()));
    productDetailsController!.productDetails(products!.productId!, false);
    super.initState();
  }

  @override
  void dispose() {
    productDetailsController!.selectedImage!(0);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      backgroundColor: AppColors.white,
      // appBar: AppBar(
      //   elevation: 5,
      //   backgroundColor: AppColors.white,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back, color: AppColors.appColor,size: 30,),
      //     onPressed: () =>
      //         Navigator.of(context, rootNavigator: true).pop(),
      //   ),
      //   title: Text(products!.productName.toString(),style: const TextStyle(fontSize: 20,color: AppColors.appColor)),
      //   // actions: [
      //   //   Center(
      //   //     child: Padding(
      //   //       padding: const EdgeInsets.only(right: 20.0),
      //   //       child: InkWell(
      //   //         onTap: (){
      //   //           Navigator.of(context).pushNamed(Routes.cart);
      //   //         },
      //   //         child: Stack(
      //   //           children: <Widget>[
      //   //             Icon(CupertinoIcons.cart,color: Colors.black,size: 30,),
      //   //         Positioned(
      //   //           right: 0,
      //   //           child: Container(
      //   //             padding: const EdgeInsets.all(1),
      //   //             decoration: BoxDecoration(
      //   //               color: Colors.red,
      //   //               borderRadius: BorderRadius.circular(6),
      //   //             ),
      //   //             constraints: const BoxConstraints(
      //   //               minWidth: 12,
      //   //               minHeight: 12,
      //   //             ),
      //   //             child: Text(
      //   //               // "homecontroller.cartList.length.toString()",
      //   //               "5",
      //   //               style: const TextStyle(
      //   //                 color: Colors.white,
      //   //                 fontSize: 8,
      //   //               ),
      //   //               textAlign: TextAlign.center,
      //   //             ),
      //   //           ),
      //   //         )
      //   //
      //   //           ],
      //   //         ),
      //   //       ),
      //   //     ),
      //   //   ),
      //   // ],
      // ),
      //body: Center(child: Text(controller.totalAmount.toString())),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () {
            CheckInternet.checkInternet();
            return productDetailsController!
                .productDetails(products!.productId!, true);
            ;
          },
          child: Obx(() {
            if (productDetailsController!.isLoadingProductDetail.value !=
                true) {
              MainResponse? mainResponse =
                  productDetailsController!.productDetailObj.value;
              List<ProductDetail>? productDetailData = [];
              List<ProductElement>? productElementDate = [];

              // mainResponse.data!.map((e) => customerProfileData!.add(UpdateCustomerPasswordData.fromJson(e))).toList();

              if (mainResponse.data != null) {
                mainResponse.data!.forEach((v) {
                  productDetailData.add(ProductDetail.fromJson(v));
                });
                print(
                    "productDetailData[0].description ${productDetailData[0].description}");
              }

              if (mainResponse.productElement != null) {
                mainResponse.productElement!.forEach((v) {
                  productElementDate.add(ProductElement.fromJson(v));
                });
                print(
                    "productDetailData[0].value ${productElementDate[0].value}");
              }

              String? imageUrl = mainResponse.imageUrl ?? "";
              String? message =
                  mainResponse.message ?? AppConstants.noInternetConn;

              if (productDetailData.isEmpty) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: ListView(
                    // physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height - 100,
                        //height: MediaQuery.of(context).size.height,
                        alignment: Alignment.center,
                        child: Center(
                          child: Text(
                            message!,
                            style: const TextStyle(color: Colors.black45),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return ListView(
                  // shrinkWrap: true,
                  children: [
                    Container(
                      // color: Colors.grey.withOpacity(0.1),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Obx((){
                            //   return SizedBox(
                            //     height: 300,
                            //     child: Stack(
                            //       alignment: Alignment.bottomCenter,
                            //       children: [
                            //         IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back_ios)),
                            //         PhotoViewGallery.builder(
                            //           scrollPhysics:
                            //           const BouncingScrollPhysics(),
                            //           builder:
                            //               (BuildContext context, int index) {
                            //             return PhotoViewGalleryPageOptions(
                            //               disableGestures: true,
                            //               imageProvider: NetworkImage( imageUrl + "/"+
                            //                   productDetailData[0]
                            //                       .image![productDetailsController!
                            //                       .selectedImage!.value]),
                            //               initialScale:
                            //               PhotoViewComputedScale.contained *
                            //                  1.0,
                            //
                            //             );
                            //           },
                            //           itemCount: productDetailData[0]
                            //               .image!.length,
                            //           loadingBuilder: (context, progress) =>
                            //               Center(
                            //                 child: SizedBox(
                            //                   width: 20.0,
                            //                   height: 20.0,
                            //                   child: CircularProgressIndicator(
                            //                     value: progress == null
                            //                         ? null
                            //                         : progress
                            //                         .cumulativeBytesLoaded /
                            //                         progress
                            //                             .expectedTotalBytes!,
                            //                   ),
                            //                 ),
                            //               ),
                            //           pageController: null,
                            //           backgroundDecoration:
                            //           const BoxDecoration(color: Colors.white),
                            //           onPageChanged: (int index) {
                            //             productDetailsController!.selectedImage!(index);
                            //           },
                            //         ),
                            //
                            //         Positioned(
                            //           child: Container(
                            //             decoration: BoxDecoration(
                            //                 borderRadius: BorderRadius.circular(30),
                            //                 color: Colors.black.withOpacity(0.4)),
                            //             height: 25,
                            //             width: 40,
                            //             child: Center(
                            //               child:
                            //
                            //               //Text("5")
                            //               Text(
                            //                 productDetailData[0]
                            //                     .image!.length == 0
                            //                     ? '${productDetailsController!.index + 1} '
                            //                     '/' +
                            //                     '${productDetailData[0]
                            //                         .image!.length + 1}'
                            //                     : '${productDetailsController!.index + 1} '
                            //                     '/' +
                            //                     productDetailData[0]
                            //                         .image!.length.toString(),
                            //                 style: const TextStyle(
                            //                     fontSize: 18, color: Colors.white),
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   );
                            // }),

                            Stack(
                              //fit: StackFit.passthrough,
                              children: [
                                SizedBox(
                                  height: 400,
                                  child: PageView.builder(
                                    controller: productDetailsController!
                                        .pageController,
                                    itemCount:
                                        productDetailsController!.img.length,
                                    onPageChanged: (index) {
                                      setState(() {
                                        productDetailsController!.currentIndex =
                                            index;
                                      });
                                    },
                                    itemBuilder: (_, index) {
                                      return ClipRRect(
                                        // borderRadius: BorderRadius.all(Radius.circular(10)),
                                        child: Image.asset(
                                          "assets/img/producr3.png",
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 400,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.0,
                                        bottom: 10.0,
                                        left: 15.0,
                                        right: 15.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            iconContainer(
                                                "assets/img/arrow_left.png"),
                                            Row(
                                              children: [
                                                iconContainer(
                                                    "assets/img/search.png"),
                                                iconContainer(
                                                    "assets/img/heart.png"),
                                                iconContainer(
                                                    "assets/img/notification.png"),
                                                iconContainer(
                                                    "assets/img/bag.png"),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              height: 10,
                                              width: 10,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 18.0),
                                              child: Container(
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: AppColors
                                                      .ratingValueContainer,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(100)),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 3.0,
                                                          bottom: 3.0,
                                                          right: 12.0,
                                                          left: 12.0),
                                                  child: Row(
                                                    children: [
                                                      Text("4.4",
                                                          style: GoogleFonts.inriaSans(
                                                              textStyle: const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: AppColors
                                                                      .white))),
                                                      Icon(
                                                        Icons.star,
                                                        color:
                                                            AppColors.startBat,
                                                        size: 16,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Container(
                                                        width: 1.0,
                                                        color: AppColors
                                                            .ratingText,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text("270",
                                                          style: GoogleFonts.inriaSans(
                                                              textStyle: const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: AppColors
                                                                      .white))),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 400,
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.0,
                                        bottom: 10.0,
                                        left: 15.0,
                                        right: 15.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SmoothPageIndicator(
                                          controller: productDetailsController!
                                              .pageController,
                                          count: productDetailsController!
                                              .img.length,
                                          effect: const ColorTransitionEffect(
                                            dotHeight: 10,
                                            dotWidth: 10,
                                            spacing: 8,
                                            dotColor: AppColors.toggleBg,
                                            activeDotColor: AppColors.appRed,
                                            // type: SwapType.yRotation,
                                            // strokeWidth: 5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(productDetailData[0].productName!,
                                            style: GoogleFonts.inriaSans(
                                                textStyle: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors.black))),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  '\u{20B9}' +
                                                      double.parse(
                                                              productDetailData[
                                                                      0]
                                                                  .netPrice!)
                                                          .toStringAsFixed(0),
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  '\u{20B9}' +
                                                      double.parse(
                                                              productDetailData[
                                                                      0]
                                                                  .mrpPrice!)
                                                          .toStringAsFixed(0),
                                                  style: TextStyle(
                                                      decoration: TextDecoration
                                                          .combine([
                                                        TextDecoration
                                                            .lineThrough
                                                      ]),
                                                      fontSize: 20,
                                                      color: Colors.grey),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  productDetailData[0]
                                                          .discount! +
                                                      "% off",
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.redAccent),
                                                ),
                                              ],
                                            ),

                                            // Row(
                                            //   children: [
                                            //     // Obx(() {
                                            //     //   return AnimatedContainer(
                                            //     //     // height:
                                            //     //     //     controller.initbool.value ? 50 : 30,
                                            //     //     duration: Duration(microseconds: 500),
                                            //     //     child: IconButton(
                                            //     //         onPressed: () {
                                            //     //           // controller.makeFavorite(
                                            //     //           //     args.product!.id);
                                            //     //           //
                                            //     //           // homecontroller.fetchProduct();
                                            //     //         },
                                            //     //         icon: productDetailsController!.initbool.value
                                            //     //             ? Icon(
                                            //     //           Icons.favorite,
                                            //     //           color: Colors.red,
                                            //     //           size: 30,
                                            //     //         )
                                            //     //             : Icon(
                                            //     //           Icons.favorite_border,
                                            //     //         )),
                                            //     //   );
                                            //     // }),
                                            //     // FavoriteBTN(
                                            //     //   controller:
                                            //     //       controller.animationController,
                                            //     //   colorTween: controller.colorAnimation,
                                            //     // ),
                                            //     // IconButton(
                                            //     //     onPressed: () {
                                            //     //       Share.share('App link not available');
                                            //     //     },
                                            //     //     icon: Icon(Icons.share)),
                                            //   ],
                                            // )
                                          ],
                                        ),

                                        // SizedBox(
                                        //   height: 5,
                                        // ),
                                        // Row(
                                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        //   children: [
                                        //     InkWell(
                                        //       // onTap: () => Scrollable.ensureVisible(
                                        //       //     dataKey.currentContext!),
                                        //       child: Row(
                                        //         children: [
                                        //           // ProductRating(
                                        //           //   rating: args.product!.avaragereview,
                                        //           //   isReadOnly: true,
                                        //           //   size: 15,
                                        //           //   filledIconData: Icons.star,
                                        //           //   borderColor:
                                        //           //   Colors.red.withOpacity(0.8),
                                        //           //   color: Colors.red,
                                        //           //   halfFilledIconData: Icons.star_half,
                                        //           //   defaultIconData: Icons.star_border,
                                        //           //   starCount: 5,
                                        //           //   allowHalfRating: true,
                                        //           // ),
                                        //           SizedBox(
                                        //             width: 5,
                                        //           ),
                                        //           // Text(
                                        //           //   args.product!.avaragereview.toString(),
                                        //           //   style: TextStyle(color: Colors.red),
                                        //           // ),
                                        //           // Text(
                                        //           //   ' / ' +
                                        //           //       '(${args.product!.noOfReviews}) reviews',
                                        //           //   style: TextStyle(color: Colors.red),
                                        //           // )
                                        //         ],
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                  ),
                                  Text("Available Colors",
                                      style: GoogleFonts.inriaSans(
                                          textStyle: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.black))),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 45,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: productDetailsController!
                                            .colorList.length,
                                        itemBuilder: (c, index) {
                                          return Padding(
                                            padding: index == 0
                                                ? const EdgeInsets.only(
                                                    right: 10.0, left: 0.0)
                                                : const EdgeInsets.only(
                                                    right: 10.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: productDetailsController!
                                                    .colorList[index],
                                                // borderRadius: const BorderRadius.all(
                                                //     const Radius.circular(100)
                                                // ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Select Size",
                                          style: GoogleFonts.inriaSans(
                                              textStyle: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.black))),
                                      Text("Size Chart",
                                          style: GoogleFonts.inriaSans(
                                              textStyle: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.appRed))),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 45,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: productDetailsController!
                                            .sizeList.length,
                                        itemBuilder: (c, index) {
                                          return Padding(
                                            padding: index == 0
                                                ? const EdgeInsets.only(
                                                    right: 10.0, left: 0.0)
                                                : const EdgeInsets.only(
                                                    right: 10.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              child: Center(
                                                  child: Text(
                                                      productDetailsController!
                                                          .sizeList[index],
                                                      style: GoogleFonts.inriaSans(
                                                          textStyle:
                                                              const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: AppColors
                                                                      .black)))),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  // color: productDetailsController!.colorList[index],
                                                  // borderRadius: const BorderRadius.all(
                                                  //     const Radius.circular(100)
                                                  // ),
                                                  border: Border.all(
                                                      color:
                                                          AppColors.appText)),
                                            ),
                                          );
                                        }),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("EMI option available",
                                          style: GoogleFonts.inriaSans(
                                              textStyle: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.black))),
                                      Text("View Plan",
                                          style: GoogleFonts.inriaSans(
                                              textStyle: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.appRed))),
                                    ],
                                  ),
                                  Text("EMI starting from \u{20B9}150/month",
                                      style: GoogleFonts.inriaSans(
                                          textStyle: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors
                                                  .productDescription))),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Delivery Details",
                                          style: GoogleFonts.inriaSans(
                                              textStyle: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.black))),
                                      Text("Check Delivery Date",
                                          style: GoogleFonts.inriaSans(
                                              textStyle: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.appRed))),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Container(
                                    // padding: const EdgeInsets.only(top: 18,left: 18,right: 18,bottom: 16),
                                    // height: 400,
                                    child: GridView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount:
                                          productDetailsController!.list.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              // crossAxisCount: 2,
                                              crossAxisSpacing: 2,
                                              mainAxisSpacing: 4,
                                              childAspectRatio:
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      (MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          5.5),
                                              crossAxisCount: (orientation ==
                                                      Orientation.portrait)
                                                  ? 2
                                                  : 2),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                productDetailsController!
                                                    .list[index].productName!,
                                                maxLines: 1,
                                                //  style: GoogleFonts.ptSans(),
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.inriaSans(
                                                    textStyle: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color:
                                                            AppColors.black))),
                                            Text(
                                                productDetailsController!
                                                    .list[index]
                                                    .shortDescription!,
                                                maxLines: 1,
                                                //  style: GoogleFonts.ptSans(),
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.inriaSans(
                                                    textStyle: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: AppColors
                                                            .productDescription))),
                                          ],
                                        );
                                      },
                                    ),
                                  ),

                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Product Details",
                                          style: GoogleFonts.inriaSans(
                                              textStyle: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.black))),
                                      Text(
                                          "Brown solid jacket, has a stand collar, four pockets, zip closure, long sleeves, straight hem",
                                          style: GoogleFonts.inriaSans(
                                              textStyle: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors
                                                      .productDescription))),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Size & Fit",
                                          // maxLines: 1,
                                          //  style: GoogleFonts.ptSans(),
                                          // overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.inriaSans(
                                              textStyle: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.black))),
                                      Text(
                                          "The model(height 5’8”) is wearing a size S",
                                          style: GoogleFonts.inriaSans(
                                              textStyle: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors
                                                      .productDescription))),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Material & Care",
                                          // maxLines: 1,
                                          //  style: GoogleFonts.ptSans(),
                                          // overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.inriaSans(
                                              textStyle: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.black))),
                                      Text(
                                          "Material: Leather \nLining: Polyster \nDry Clean",
                                          // maxLines: 1,
                                          //  style: GoogleFonts.ptSans(),
                                          // overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.inriaSans(
                                              textStyle: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors
                                                      .productDescription))),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                "assets/img/Verified Badge.png"),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text("Genuine Product",
                                              // maxLines: 1,
                                              //  style: GoogleFonts.ptSans(),
                                              // overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.hanuman(
                                                  textStyle: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: AppColors.black))),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                "assets/img/Holding Box.png"),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text("Genuine Product",
                                              // maxLines: 1,
                                              //  style: GoogleFonts.ptSans(),
                                              // overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.hanuman(
                                                  textStyle: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: AppColors.black))),
                                        ],
                                      )
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Easy 15 days returns and exchanges",
                                          // maxLines: 1,
                                          //  style: GoogleFonts.ptSans(),
                                          // overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.inriaSans(
                                              textStyle: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.black))),
                                      Text(
                                          "Choose to return or exchange for a different size(if available) within 15 days.",
                                          // maxLines: 1,
                                          //  style: GoogleFonts.ptSans(),
                                          // overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.inriaSans(
                                              textStyle: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors
                                                      .productDescription))),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),

                                  InkWell(
                                    onTap: (){
                                      showModalBottomSheet(

                                          context: context,
                                          builder: (context) {
                                            return Wrap(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 30.0,left: 30,top: 15,bottom: 10.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Row(

                                                        children: [
                                                          Text("Cancel",
                                                              style: GoogleFonts.inriaSans(
                                                                  textStyle: const TextStyle(
                                                                      fontSize: 16,
                                                                      fontWeight: FontWeight.w400,
                                                                      color: AppColors.startBat))),
                                                          Text("Rate",
                                                              style: GoogleFonts.inriaSans(
                                                                  textStyle: const TextStyle(
                                                                      fontSize: 16,
                                                                      fontWeight: FontWeight.w400,
                                                                      color: AppColors.startBat))),
                                                          Text("Done",
                                                              style: GoogleFonts.inriaSans(
                                                                  textStyle: const TextStyle(
                                                                      fontSize: 16,
                                                                      fontWeight: FontWeight.w400,
                                                                      color: AppColors.startBat))),
                                                        ],
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      ),
                                                      const SizedBox(
                                                        height: 40,
                                                      ),
                                                      Text("Have you tried this? Rate it!",
                                                          style: GoogleFonts.inriaSans(
                                                              textStyle: const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight: FontWeight.w400,
                                                                  color: AppColors.black))),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      RatingBar(
                                                        initialRating: 0,
                                                        // minRating: 1,
                                                        // ignoreGestures: true,
                                                        direction: Axis.horizontal,
                                                        allowHalfRating: true,
                                                        itemCount: 5,
                                                        itemSize: 35,
                                                        // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                                        ratingWidget: RatingWidget(
                                                          full: const Icon(
                                                            Icons.star,
                                                            color: AppColors.startBat,
                                                            size: 35,
                                                          ),
                                                          half: const Icon(
                                                            Icons.star_half,
                                                            color: AppColors.startBat,
                                                            size: 35,
                                                          ),
                                                          empty: const Icon(
                                                            Icons.star_border_rounded,
                                                            color: AppColors.startBat,
                                                            size: 35,
                                                          ),
                                                        ),
                                                        // itemBuilder: (context, _) =>
                                                        //     Icon(
                                                        //   Icons.star_border_rounded,
                                                        //   color: AppColors.appRed,
                                                        //   size: 10,
                                                        // ),
                                                        onRatingUpdate: (rating) {
                                                          print(rating);
                                                        },
                                                      ),
                                                      const SizedBox(
                                                        height: 60,
                                                      ),
                                                      Text("Thank You!",
                                                          style: GoogleFonts.salsa(
                                                              textStyle: const TextStyle(
                                                                  fontSize: 38,
                                                                  fontWeight: FontWeight.w400,
                                                                  color: AppColors.appRed))),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Text("Rate",
                                              style: GoogleFonts.inriaSans(
                                                  textStyle: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.w400,
                                                      color: AppColors.black))),
                                          const SizedBox(
                                            height: 05,
                                          ),
                                          RatingBar(
                                            initialRating: 0,
                                            // minRating: 1,
                                            ignoreGestures: true,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemSize: 40,
                                            // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                            ratingWidget: RatingWidget(
                                              full: const Icon(
                                                Icons.star,
                                                color: AppColors.startBat,
                                                size: 30,
                                              ),
                                              half: const Icon(
                                                Icons.star_half,
                                                color: AppColors.startBat,
                                                size: 30,
                                              ),
                                              empty: const Icon(
                                                Icons.star_border_rounded,
                                                color: AppColors.startBat,
                                                size: 30,
                                              ),
                                            ),
                                            // itemBuilder: (context, _) =>
                                            //     Icon(
                                            //   Icons.star_border_rounded,
                                            //   color: AppColors.appRed,
                                            //   size: 10,
                                            // ),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          ),
                                          const SizedBox(
                                            height: 05,
                                          ),
                                          Text("Tap to Rate",
                                              style: GoogleFonts.salsa(
                                                  textStyle: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400,
                                                      color: AppColors.black))),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),

                                  Text("View Similar",
                                      style: GoogleFonts.inriaSans(
                                          textStyle: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.black))),
                                  const SizedBox(
                                    height: 25,
                                  ),

                                  SizedBox(
                                    height: 200,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            productDetailsController!.similarList.length,
                                        itemBuilder: (c, index) {
                                          return Padding(
                                            padding: index == 0
                                                ? const EdgeInsets.only(
                                                    right: 0.0, left: 0.0)
                                                : const EdgeInsets.only(
                                                    left: 15.0),
                                            child: Container(
                                              height: 225,
                                              width: 175,
                                              decoration: BoxDecoration(
                                                color: AppColors.white,
                                                // borderRadius: const BorderRadius
                                                //         .all(
                                                //     const Radius.circular(10)),
                                                border: Border.all(
                                                  width: 1,
                                                  color: AppColors
                                                      .bestSellingBorder,
                                                  // style: BorderStyle.solid,
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    productDetailsController!.similarList[index]
                                                        .coverImage!,
                                                    fit: BoxFit.fill,
                                                    width: double.infinity,
                                                    height: 110,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets
                                                                .only(
                                                            left: 5.0,
                                                            right: 5.0,
                                                            bottom: 0.0,
                                                            top: 5.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            productDetailsController!.similarList[index]
                                                                .productName!,
                                                            maxLines:
                                                                1,
                                                            //  style: GoogleFonts.ptSans(),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts.inriaSans(
                                                                textStyle: const TextStyle(
                                                                    fontSize: 16,
                                                                    fontWeight: FontWeight.w400,
                                                                    color: AppColors.black))),
                                                        Text(
                                                            productDetailsController!.similarList[
                                                                    index]
                                                                .shortDescription!,
                                                            maxLines: 2,
                                                            //  style: GoogleFonts.ptSans(),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts.inriaSans(
                                                                textStyle: const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: AppColors
                                                                        .appText1))),

                                                        Row(
                                                          children: [
                                                            Text(
                                                                "\u{20B9}${double.parse(productDetailsController!.similarList[index].netPrice!).toStringAsFixed(0)} ",
                                                                style: GoogleFonts.inriaSans(
                                                                    textStyle: const TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        color: AppColors.black))),
                                                            Text(
                                                                "\u{20B9}${double.parse(productDetailsController!.similarList[index].mrpPrice!).toStringAsFixed(0)} ",
                                                                style: GoogleFonts.inriaSans(
                                                                    textStyle: TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        decoration:
                                                                            TextDecoration.combine([
                                                                          TextDecoration.lineThrough
                                                                        ]),
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        color: AppColors.appText1))),

                                                          ],
                                                        ),
                                                        Text(
                                                            "${productDetailsController!.similarList[index].discount!}% OFF",
                                                            style: GoogleFonts.inriaSans(
                                                                textStyle: const TextStyle(
                                                                    fontSize:
                                                                    14,
                                                                    fontWeight:
                                                                    FontWeight.w400,
                                                                    color: AppColors.off)))
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ),

                                  // Container(
                                  //   decoration: const BoxDecoration(
                                  //     color: Colors.white,
                                  //   ),
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.all(
                                  //       10,
                                  //     ),
                                  //     child: HtmlWidget(
                                  //         productDetailData[0].description!),
                                  //   ),
                                  // ),
                                  // const SizedBox(height: 10),
                                  // Container(
                                  //     decoration: const BoxDecoration(
                                  //       color: Colors.white,
                                  //     ),
                                  //     child: ExpansionTile(
                                  //       expandedAlignment: Alignment.topLeft,
                                  //       title: const Text(
                                  //         'Product Details',
                                  //         style: TextStyle(
                                  //           fontSize: 16,
                                  //         ),
                                  //       ),
                                  //       children: [
                                  //         Padding(
                                  //           padding: const EdgeInsets.only(
                                  //               left: 15,
                                  //               bottom: 15,
                                  //               right: 15),
                                  //           child:
                                  //               // Html(
                                  //               //   data: productDetailData[0].description,
                                  //               //   // renderNewlines: true,
                                  //               //   // defaultTextStyle: TextStyle(
                                  //               //   //     fontSize: 14.0,
                                  //               //   //     color: Colors.black87),
                                  //               // ),
                                  //               Text(
                                  //             productDetailData[0]
                                  //                 .shortDescription
                                  //                 .toString(),
                                  //             style: TextStyle(
                                  //                 fontSize: 15,
                                  //                 color: Colors.black
                                  //                     .withOpacity(0.6)),
                                  //           ),
                                  //         )
                                  //       ],
                                  //     )),
                                  // const SizedBox(height: 10),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            } else {
              if (productDetailsController!.isRefresh.value != true) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: const Center(
                        child: const CircularProgressIndicator(
                            color: AppColors.appColor)));
              } else {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                );
              }
            }
          }),
        ),
      ),

      bottomNavigationBar: AddToCard(
        // product: args.product,
        //  customerId: profileController,
        onChanged: () {
          print("addToCard ${products!.productId!}");
          if (profileController.customerId.value == "") {
            AlertDialogs.showLoginRequiredDialog();
          } else {
            homecontroller.addToCard(products!.productId!, "1");
          }
        },
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Stack(
              //fit: StackFit.passthrough,
              children: [
                SizedBox(
                  height: 400,
                  child: PageView.builder(
                    controller: productDetailsController!.pageController,
                    itemCount: productDetailsController!.img.length,
                    onPageChanged: (index) {
                      setState(() {
                        productDetailsController!.currentIndex = index;
                      });
                    },
                    itemBuilder: (_, index) {
                      return ClipRRect(
                        // borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Image.asset(
                          "assets/img/producr3.png",
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 400,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 5.0, bottom: 10.0, left: 15.0, right: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            iconContainer("assets/img/arrow_left.png"),
                            Row(
                              children: [
                                iconContainer("assets/img/search.png"),
                                iconContainer("assets/img/heart.png"),
                                iconContainer("assets/img/notification.png"),
                                iconContainer("assets/img/bag.png"),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              height: 10,
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 18.0),
                              child: Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  color: AppColors.ratingValueContainer,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(100)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 3.0,
                                      bottom: 3.0,
                                      right: 12.0,
                                      left: 12.0),
                                  child: Row(
                                    children: [
                                      Text("4.4",
                                          style: GoogleFonts.inriaSans(
                                              textStyle: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.white))),
                                      Icon(
                                        Icons.star,
                                        color: AppColors.startBat,
                                        size: 16,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        width: 1.0,
                                        color: AppColors.ratingText,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("270",
                                          style: GoogleFonts.inriaSans(
                                              textStyle: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.white))),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 5.0, bottom: 10.0, left: 15.0, right: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SmoothPageIndicator(
                          controller: productDetailsController!.pageController,
                          count: productDetailsController!.img.length,
                          effect: const ColorTransitionEffect(
                            dotHeight: 10,
                            dotWidth: 10,
                            spacing: 8,
                            dotColor: AppColors.toggleBg,
                            activeDotColor: AppColors.appRed,
                            // type: SwapType.yRotation,
                            // strokeWidth: 5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  iconContainer(String iconPath) {
    return Padding(
      padding: iconPath == "assets/img/arrow_left.png"
          ? const EdgeInsets.only(left: 0.0)
          : const EdgeInsets.only(left: 8.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            iconPath,
            fit: BoxFit.fill,
          ),
        ),
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          color: AppColors.toggleBg,
          borderRadius: const BorderRadius.all(Radius.circular(100)),
        ),
      ),
    );
  }
}

// import 'package:eshoperapp/constants/app_costants.dart';
// import 'package:eshoperapp/models/main_response.dart';
// import 'package:eshoperapp/models/product.dart';
// import 'package:eshoperapp/models/product_detail.dart';
// import 'package:eshoperapp/models/products.dart';
// import 'package:eshoperapp/package/product_rating.dart';
// import 'package:eshoperapp/pages/details/product_details_controller.dart';
// import 'package:eshoperapp/pages/details/view/add_cart.dart';
// import 'package:eshoperapp/pages/landing_home/home_controller.dart';
// import 'package:eshoperapp/routes/navigation.dart';
// import 'package:eshoperapp/widgets/product_gridview_tile.dart';
// import 'package:eshoperapp/widgets/product_tile.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';
// import 'package:share/share.dart';
// import 'package:eshoperapp/style/theme.dart' as Style;
//
// class ProductDetailsScreen extends StatefulWidget {
//   final Products? products;
//   const ProductDetailsScreen({Key? key, required this.products}) : super(key: key);
//
//   @override
//   State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
// }
//
// class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
//
//   ProductDetailsController? productDetailsController;
//   ProductDetail? productDetail;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     // TODO: implement initState
//     dynamic argumentData = Get.arguments;
//     productDetail = argumentData[0]['productObj'];
//     print("productObj productDetailId ${productDetail!.productId}");
//     productDetailsController = Get.put(ProductDetailsController(
//         apiRepositoryInterface: Get.find(), productDetailId: productDetail!.productId!, localRepositoryInterface: Get.find()));
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//         appBar: AppBar(
//           elevation: 5,
//           backgroundColor: Colors.white,
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back, color: Colors.black,size: 30,),
//             onPressed: () =>
//                 Navigator.of(context, rootNavigator: true).pop(),
//           ),
//           title: Text("${ productDetail!.productName.toString()}",style: TextStyle(fontSize: 20)),
//           actions: [
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.only(right: 20.0),
//                 child: InkWell(
//                   onTap: (){
//                     Navigator.of(context).pushNamed(Routes.cart);
//                   },
//                   child: Stack(
//                     children: <Widget>[
//                       Icon(CupertinoIcons.cart,color: Colors.black,size: 30,),
//                       Obx((){
//                         return  Positioned(
//                           right: 0,
//                           child: Container(
//                             padding: const EdgeInsets.all(1),
//                             decoration: BoxDecoration(
//                               color: Colors.red,
//                               borderRadius: BorderRadius.circular(6),
//                             ),
//                             constraints: const BoxConstraints(
//                               minWidth: 12,
//                               minHeight: 12,
//                             ),
//                             child: Text(
//                               "homecontroller.cartList.length.toString()",
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 8,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         );
//                       }),
//
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         //body: Center(child: Text(controller.totalAmount.toString())),
//         body:
//
//         Obx((){
//
//           if(productDetailsController!.isLoadingProductDetail.value != true){
//
//             MainResponse? mainResponse = productDetailsController!.productDetailObj.value;
//             List<ProductDetail>? productDetailData = [];
//
//             // mainResponse.data!.map((e) => customerProfileData!.add(UpdateCustomerPasswordData.fromJson(e))).toList();
//             mainResponse.data!.forEach((v) {
//               productDetailData.add( ProductDetail.fromJson(v));
//             });
//
//             String? imageUrl = mainResponse.imageUrl ?? "";
//             String? message = mainResponse.message ?? AppConstants.noInternetConn;
//             if (productDetailData.isEmpty) {
//               return Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: 200,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     Text(
//                       message!,
//                       style: TextStyle(color: Colors.black45),
//                     ),
//                   ],
//                 ),
//               );
//             }else{
//               return  Container(color: Colors.grey.withOpacity(0.1),
//                 child: SafeArea(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         Obx(() {
//                           return Container(
//                             height: 300,
//                             child: Stack(
//                               alignment: Alignment.bottomCenter,
//                               children: [
//                                 // IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
//                                 Padding(
//                                     padding: const EdgeInsets.only(left: 10, right: 10),
//                                     child: Hero(
//                                       tag: productDetailData[0].productId!,
//                                       child: Container(
//                                         child: InkWell(
//                                             onDoubleTap: () {
//                                               // navigator!.pushNamed(
//                                               //    Routes.imageScreen,
//                                               //     arguments: ImageScreenArguments(
//                                               //         product: args.product));
//                                             },
//                                             child: PhotoViewGallery.builder(
//                                               scrollPhysics:
//                                               const BouncingScrollPhysics(),
//                                               builder:
//                                                   (BuildContext context, int index) {
//                                                 return PhotoViewGalleryPageOptions(
//                                                   disableGestures: true,
//                                                   imageProvider: NetworkImage(args
//                                                       .product!
//                                                       .images!
//                                                       .length ==
//                                                       0
//                                                       ? 'https://onlinehatiya.herokuapp.com' +
//                                                       args.product!.image!
//                                                       : 'https://onlinehatiya.herokuapp.com' +
//                                                       args
//                                                           .product!
//                                                           .images![controller
//                                                           .selectedImage!.value]
//                                                           .image!),
//                                                   initialScale:
//                                                   PhotoViewComputedScale.contained *
//                                                       0.8,
//                                                 );
//                                               },
//                                               itemCount: args.product!.images!.length,
//                                               loadingBuilder: (context, progress) =>
//                                                   Center(
//                                                     child: Container(
//                                                       width: 20.0,
//                                                       height: 20.0,
//                                                       child: CircularProgressIndicator(
//                                                         value: progress == null
//                                                             ? null
//                                                             : progress
//                                                             .cumulativeBytesLoaded /
//                                                             progress
//                                                                 .expectedTotalBytes!,
//                                                       ),
//                                                     ),
//                                                   ),
//                                               pageController: null,
//                                               backgroundDecoration:
//                                               BoxDecoration(color: Colors.white),
//                                               onPageChanged: (int index) {
//                                                 controller.selectedImage!(index);
//                                               },
//                                             )),
//                                       ),
//                                     )),
//
//                                 Positioned(
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(30),
//                                         color: Colors.black.withOpacity(0.4)),
//                                     height: 25,
//                                     width: 40,
//                                     child: Center(
//                                       child: Text(
//                                         args.product!.images!.length == 0
//                                             ? '${controller.index + 1} '
//                                             '/' +
//                                             '${args.product!.images!.length + 1}'
//                                             : '${controller.index + 1} '
//                                             '/' +
//                                             args.product!.images!.length.toString(),
//                                         style: TextStyle(
//                                             fontSize: 18, color: Colors.white),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         }),
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(10.0),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       'Rs.' + args.product!.price.toString(),
//                                       style: TextStyle(
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.redAccent),
//                                     ),
//                                     Row(
//                                       children: [
//                                         Obx(() {
//                                           return AnimatedContainer(
//                                             // height:
//                                             //     controller.initbool.value ? 50 : 30,
//                                             duration: Duration(microseconds: 500),
//                                             child: IconButton(
//                                                 onPressed: () {
//                                                   controller.makeFavorite(
//                                                       args.product!.id);
//
//                                                   homecontroller.fetchProduct();
//                                                 },
//                                                 icon: controller.initbool.value
//                                                     ? Icon(
//                                                   Icons.favorite,
//                                                   color: Colors.red,
//                                                   size: 30,
//                                                 )
//                                                     : Icon(
//                                                   Icons.favorite_border,
//                                                 )),
//                                           );
//                                         }),
//                                         // FavoriteBTN(
//                                         //   controller:
//                                         //       controller.animationController,
//                                         //   colorTween: controller.colorAnimation,
//                                         // ),
//                                         IconButton(
//                                             onPressed: () {
//                                               Share.share('App link not available');
//                                             },
//                                             icon: Icon(Icons.share)),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                                 Text(
//                                   args.product!.title!,
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 5,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     InkWell(
//                                       // onTap: () => Scrollable.ensureVisible(
//                                       //     dataKey.currentContext!),
//                                       child: Row(
//                                         children: [
//                                           ProductRating(
//                                             rating: args.product!.avaragereview,
//                                             isReadOnly: true,
//                                             size: 15,
//                                             filledIconData: Icons.star,
//                                             borderColor:
//                                             Colors.red.withOpacity(0.8),
//                                             color: Colors.red,
//                                             halfFilledIconData: Icons.star_half,
//                                             defaultIconData: Icons.star_border,
//                                             starCount: 5,
//                                             allowHalfRating: true,
//                                           ),
//                                           SizedBox(
//                                             width: 5,
//                                           ),
//                                           Text(
//                                             args.product!.avaragereview.toString(),
//                                             style: TextStyle(color: Colors.red),
//                                           ),
//                                           Text(
//                                             ' / ' +
//                                                 '(${args.product!.noOfReviews}) reviews',
//                                             style: TextStyle(color: Colors.red),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Container(
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(10),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     RichText(
//                                         text: TextSpan(
//                                             text: 'Seller:',
//                                             style: TextStyle(color: Colors.black),
//                                             children: [
//                                               TextSpan(
//                                                   text: ' DmkMart',
//                                                   style: TextStyle(color: Colors.black))
//                                             ])),
//                                     Container(
//                                       decoration: BoxDecoration(
//                                         border: Border.all(color: Colors.grey),
//                                       ),
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(5.0),
//                                         child: Text('View Shop',
//                                             style: TextStyle(color: Colors.green)),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Container(
//                           height: 90,
//                           width: double.infinity,
//                           decoration: BoxDecoration(color: Colors.white),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Easy 7 days return and Exchange',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 5,
//                                 ),
//                                 Text(
//                                   'You can return the product within 7 days if the product is damaged, expired , different from order',
//                                   overflow: TextOverflow.clip,
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       color: Colors.black.withOpacity(0.6)),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(10),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Specification',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 5,
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     ...List.generate(
//                                       args.product!.productSpecification!.length,
//                                           (index) => Padding(
//                                         padding: const EdgeInsets.only(bottom: 5),
//                                         child: Row(
//                                           crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               '•',
//                                               style: TextStyle(fontSize: 18),
//                                             ),
//                                             SizedBox(
//                                               width: 10,
//                                             ),
//                                             Expanded(
//                                               child: Text(
//                                                 args
//                                                     .product!
//                                                     .productSpecification![index]
//                                                     .point!,
//                                                 overflow: TextOverflow.clip,
//                                                 style: TextStyle(
//                                                     fontSize: 15,
//                                                     color: Colors.black
//                                                         .withOpacity(0.6)),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                             ),
//                             child: ExpansionTile(
//                               expandedAlignment: Alignment.topLeft,
//                               title: Text(
//                                 'Product Details',
//                                 style:  TextStyle(
//                                   fontSize: 16,
//                                 ),
//                               ),
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(left: 20),
//                                   child: Text(
//                                     args.product!.description!,
//                                     style: TextStyle(
//                                         fontSize: 15,
//                                         color: Colors.black.withOpacity(0.6)),
//                                   ),
//                                 )
//                               ],
//                             )),
//                         SizedBox(height: 10),
//                         Obx(() {
//                           if (!controller.isCommentsLoad.value)
//                             return Container(
//                               color: Colors.white,
//                               // key: dataKey,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           'Rating & Reviews (${controller.comments.length})',
//                                           style: TextStyle(fontSize: 16),
//                                         ),
//                                         InkWell(
//                                           onTap: () {},
//                                           child: Container(
//                                             decoration: BoxDecoration(
//                                                 border: Border.all(
//                                                     color: Colors.grey
//                                                         .withOpacity(0.4))),
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(8.0),
//                                               child: Text(
//                                                 'Rate Product',
//                                                 style:
//                                                 TextStyle(color: Colors.blue),
//                                               ),
//                                             ),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                   ...List.generate(
//                                       controller.comments.length > 3
//                                           ? 3
//                                           : controller.comments.length,
//                                           (index) => !controller.isCommentsLoad.value
//                                           ? Card(
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Column(
//                                             mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                             crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                             children: [
//                                               Row(
//                                                 crossAxisAlignment:
//                                                 CrossAxisAlignment.end,
//                                                 mainAxisAlignment:
//                                                 MainAxisAlignment
//                                                     .spaceBetween,
//                                                 children: [
//                                                   Text(controller
//                                                       .comments[index]
//                                                       .comment!),
//                                                   Spacer(),
//                                                   ProductRating(
//                                                     rating: controller
//                                                         .comments[index].rate!
//                                                         .toDouble(),
//                                                     isReadOnly: true,
//                                                     size: 12,
//                                                     filledIconData:
//                                                     Icons.star,
//                                                     borderColor: Colors.red
//                                                         .withOpacity(0.8),
//                                                     color: Colors.red,
//                                                     halfFilledIconData:
//                                                     Icons.star_half,
//                                                     defaultIconData:
//                                                     Icons.star_border,
//                                                     starCount: 5,
//                                                     allowHalfRating: true,
//                                                   ),
//                                                   SizedBox(
//                                                     width: 15,
//                                                   )
//                                                 ],
//                                               ),
//                                               SizedBox(
//                                                 height: 20,
//                                               ),
//                                               Row(
//                                                 mainAxisAlignment:
//                                                 MainAxisAlignment
//                                                     .spaceBetween,
//                                                 children: [
//                                                   Text(
//                                                     controller.comments[index]
//                                                         .user!.username!
//                                                         .replaceAll(
//                                                         '@gmail.com',
//                                                         '*****'),
//                                                     style: TextStyle(
//                                                         color: Colors.black
//                                                             .withOpacity(
//                                                             0.6)),
//                                                   ),
//                                                   Text(
//                                                     ' | ' +
//                                                         controller
//                                                             .comments[index]
//                                                             .whenpublished!,
//                                                     style: TextStyle(
//                                                         fontSize: 14,
//                                                         color: Colors.black
//                                                             .withOpacity(
//                                                             0.6)),
//                                                   ),
//                                                   Spacer(),
//                                                   IconButton(
//                                                       icon: Icon(
//                                                         Icons
//                                                             .thumb_up_alt_outlined,
//                                                         size: 12,
//                                                         color: controller
//                                                             .comments[
//                                                         index]
//                                                             .like ==
//                                                             true
//                                                             ? Colors.blue
//                                                             : Colors.black,
//                                                       ),
//                                                       onPressed: () {
//                                                         controller.likeBtn(
//                                                             controller
//                                                                 .comments[
//                                                             index]
//                                                                 .id,
//                                                             args.product!.id);
//                                                       }),
//                                                   Text(
//                                                     controller.comments[index]
//                                                         .getTotalLikes ==
//                                                         null
//                                                         ? '0'
//                                                         : controller
//                                                         .comments[index]
//                                                         .getTotalLikes
//                                                         .toString(),
//                                                     style: TextStyle(
//                                                         fontSize: 12),
//                                                   ),
//                                                   IconButton(
//                                                       icon: Icon(
//                                                         Icons
//                                                             .thumb_down_outlined,
//                                                         size: 12,
//                                                         color: controller
//                                                             .comments[
//                                                         index]
//                                                             .dislike ==
//                                                             true
//                                                             ? Colors.blue
//                                                             : Colors.black,
//                                                       ),
//                                                       onPressed: () {
//                                                         controller.dislikeBtn(
//                                                             controller
//                                                                 .comments[
//                                                             index]
//                                                                 .id,
//                                                             args.product!.id);
//                                                       }),
//                                                   Text(
//                                                     controller.comments[index]
//                                                         .getTotalDislikes ==
//                                                         null
//                                                         ? '0'
//                                                         : controller
//                                                         .comments[index]
//                                                         .getTotalDislikes
//                                                         .toString(),
//                                                     style: TextStyle(
//                                                         fontSize: 12),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       )
//                                           : CircularProgressIndicator())
//                                 ],
//                               ),
//                             );
//                           else {
//                             return SizedBox.shrink();
//                           }
//                         }),
//                         SizedBox(height: 10),
//                         // Container(
//                         //   color: Colors.white.withOpacity(0.4),
//                         //   child: Center(
//                         //     child: Padding(
//                         //       padding: const EdgeInsets.all(8.0),
//                         //       child: Text(
//                         //         'You may also like',
//                         //         style: TextStyle(
//                         //             fontSize: 18, fontWeight: FontWeight.bold),
//                         //       ),
//                         //     ),
//                         //   ),
//                         // ),
//                         // Container(child: Obx(() {
//                         //   if (homecontroller.isLoading.value) {
//                         //     final list = homecontroller.productList
//                         //         .where((i) => i.category == args.product!.category)
//                         //         .toList();
//                         //
//                         //     return ProductGridviewTile(
//                         //       productList: list,
//                         //     );
//                         //   } else {
//                         //     return Center(child: CircularProgressIndicator());
//                         //   }
//                         // })),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//           }
//
//
//
//           }else{
//           return Container(
//           height: 200,
//           child: Center(
//           child: CircularProgressIndicator(
//           color: Style.Colors.appColor)));
//           }
//
//         })
//
//
//
//
//       // bottomNavigationBar: AddToCard(
//       //   product: args.product,
//       //   onChanged: () {
//       //     homecontroller.addToCard(args.product!.id);
//       //   },
//       // ),
//     );
//     // return GetBuilder<ProductDetailsController>(
//     //     init: ProductDetailsController(apiRepositoryInterface: Get.find(), localRepositoryInterface: Get.find()),
//     //     builder: (controller){
//     //       final ProductDetailsArguments args =
//     //       ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
//     //
//     //       final homecontroller = Get.find<HomeController>();
//     //       controller.productid(args.product!.id!);
//     //       controller.setInit(args.product!.favorite);
//     //
//     // });
//
//   }
// }
//
