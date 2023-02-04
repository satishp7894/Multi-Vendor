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
import '../../models/similar_product_model.dart';
import '../../models/variant_model.dart';
import '../../utils/alert_dialog.dart';
import '../../widgets/login_dialog.dart';
import '../profile/profile_controller.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Products? products;

  const ProductDetailsScreen({Key? key, required this.products})
      : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> with TickerProviderStateMixin {
  ProductDetailsController? productDetailsController;
  Products? products;
  bool? isSimilerView = true;
  late AnimationController controller;
  late TextEditingController? mobile;

  bool? wishList = false;
  final homecontroller = Get.put(HomeController(
      localRepositoryInterface: Get.find(),
      apiRepositoryInterface: Get.find()));
  final profileController = Get.put(ProfileController(
      apiRepositoryInterface: Get.find(),
      customer: Customer(),
      localRepositoryInterface: Get.find()));
  final _key = GlobalKey();



  @override
  void initState() {
    // TODO: implement initState
    // TODO: implement initState
    // dynamic argumentData = Get.arguments;
    controller = BottomSheet.createAnimationController(this);
    // Animation duration for displaying the BottomSheet
    controller.duration = const Duration(milliseconds: 600);
    // Animation duration for retracting the BottomSheet
    controller.reverseDuration = const Duration(milliseconds: 600);
    // Set animation curve duration for the BottomSheet
    controller.drive(CurveTween(curve: Curves.easeIn));
    mobile = TextEditingController();
    products = widget.products;
    print("productObj productDetailId ${products!.productId}");
    print("homecontroller.customerId ${homecontroller.customerId.value}");
    productDetailsController = Get.put(ProductDetailsController(
        apiRepositoryInterface: Get.find(),
        productDetailId: products!.productId!,
        localRepositoryInterface: Get.find()));
    productDetailsController!.productDetails(products!.productId!,products!.variantCode!, false,homecontroller.customerId.value);
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


    return Obx(() {



      if (productDetailsController!.isLoadingProductDetail.value !=
          true) {
        MainResponse? mainResponse =
            productDetailsController!.productDetailObj.value;
        List<ProductDetail>? productDetailData = [];
        List<ProductElement>? productElementData = [];

        // mainResponse.data!.map((e) => customerProfileData!.add(UpdateCustomerPasswordData.fromJson(e))).toList();

        if (mainResponse.data != null) {
          mainResponse.data!.forEach((v) {
            productDetailData.add(ProductDetail.fromJson(v));


          });
          if(isSimilerView!){
            isSimilerView = false;
            // wishList = productDetailData[0].wishList;
            print("productDetailData[0].childCategory ${productDetailData[0].categoryId}");
            print("productDetailData[0].productId ${productDetailData[0].productId}");
            productDetailsController!.getSimilarProduct(productDetailData[0].productId!,productDetailData[0].childCategory!,homecontroller.customerId.value);
          }

        }

        if (mainResponse.productElement != null) {
          productElementData.addAll(mainResponse.productElement!);

          print(
              "productDetailData[0].value ${productElementData[0].element}");
        }

        String? imageUrl = mainResponse.imageUrl ?? "";
        String? message = mainResponse.message ?? AppConstants.noInternetConn;
        List<ProductReview>? productReviewList = [];
        productReviewList = mainResponse.productReview;
        // ProductReview? productReviewObj = ProductReview.fromJson(mainResponse.productReview!) ;
        //
        // print("productReviewObj ${productReviewObj.totalRatingCount}");

        if (productDetailData.isEmpty) {

          return Scaffold(
            backgroundColor: Colors.grey[200],
            body: SizedBox(
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
          ),
            bottomNavigationBar: AddToCard(
              // product: args.product,
              wishList: wishList,
              onChanged: () {
                print("addToCard ${products!.productId!}");
                if (profileController.customerId.value == "") {
                  showModalBottomSheet(
                    context: context,
                    // isDismissible:false,
                    isScrollControlled: true,
                    transitionAnimationController: controller,
                    builder: (BuildContext context) {

                      return LoginDialog(mobile: mobile,);

                    },
                  );
                } else {
                  homecontroller.addToCard(products!.productId!, "1",profileController.customerId.value);
                }
              },

              addToWishList: (){

                print("addToWishList ${products!.productId!}");
                if (profileController.customerId.value == "") {
                  showModalBottomSheet(
                    context: context,
                    // isDismissible:false,
                    isScrollControlled: true,
                    transitionAnimationController: controller,
                    builder: (BuildContext context) {

                      return LoginDialog(mobile: mobile,);

                    },
                  );
                } else {
                  homecontroller.addToWishList(products!.productId!,profileController.customerId.value);
                }
              },
            ),

            );
        } else {
          // print("products!.productId! ========> ${products!.productId!}");
          // print("products!.categoryId! ========> ${products!.categoryId!}");

          return WillPopScope(
            onWillPop: () async{
              Get.back(result: true);
              return true;
            },
            child: Scaffold(
              backgroundColor: Colors.grey[200],
              body: SafeArea(
                child: RefreshIndicator(
                  onRefresh: () {
                    CheckInternet.checkInternet();
                    return productDetailsController!
                        .productDetails(products!.productId!,products!.variantCode!, true,homecontroller.customerId.value);

                  },
                  child:
                  ListView(
                    // shrinkWrap: true,
                    children: [
                      Container(
                        // color: Colors.grey.withOpacity(0.1),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [


                              Stack(
                                //fit: StackFit.passthrough,
                                children: [
                                  SizedBox(
                                    height: 400,
                                    child: PageView.builder(
                                      controller: productDetailsController!
                                          .pageController,
                                      itemCount:
                                      productDetailData[0].image!.length,
                                      onPageChanged: (index) {
                                        setState(() {
                                          productDetailsController!.currentIndex = index;
                                        });
                                      },
                                      itemBuilder: (_, index) {
                                        return ClipRRect(
                                          // borderRadius: BorderRadius.all(Radius.circular(10)),
                                          child: Image.network(
                                            imageUrl+"/"+productDetailData[0].image![index],
                                            fit: BoxFit.cover,
                                            width: double.infinity,
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
                                                  "assets/img/arrow_left.png","1"),
                                              Row(
                                                children: [
                                                  iconContainer(
                                                      "assets/img/search.png","2"),
                                                  iconContainer(
                                                      "assets/img/heart.png","3"),
                                                  iconContainer(
                                                      "assets/img/Notification.png","4"),
                                                  iconContainer(
                                                      "assets/img/bag.png","5"),
                                                ],
                                              ),
                                            ],
                                          ),
                                          productReviewList!.isNotEmpty ?
                                          InkWell(
                                            onTap: (){
                                              Scrollable.ensureVisible(_key.currentContext!);
                                            },
                                            child: Row(
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
                                                      bottom: 24.0),
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
                                                          top: 5.0,
                                                          bottom: 5.0,
                                                          right: 12.0,
                                                          left: 12.0),
                                                      child: Row(
                                                        children: [
                                                          Text("${productReviewList[0].totalStar} ",
                                                              style: GoogleFonts.inriaSans(
                                                                  textStyle: const TextStyle(
                                                                      fontSize: 12,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold,
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
                                                          Text("${productReviewList[0].totalReviewsCount}",
                                                              style: GoogleFonts.inriaSans(
                                                                  textStyle: const TextStyle(
                                                                      fontSize: 12,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                      color: AppColors
                                                                          .white))),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ):Container(),
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
                                            count:productDetailData[0].image!.length,
                                            effect: const ColorTransitionEffect(
                                              dotHeight: 8,
                                              dotWidth: 8,
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

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    color: AppColors.white,child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.start,
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
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w400,
                                                          color: AppColors.black))),
                                              // const SizedBox(
                                              //   height: 5,
                                              // ),
                                              // Text("Lightweight Leather jacket",
                                              //     style: GoogleFonts.inriaSans(
                                              //         textStyle: const TextStyle(
                                              //             fontSize: 14,
                                              //             fontWeight: FontWeight.w400,
                                              //             color: AppColors.black))),
                                              const SizedBox(
                                                height: 6,
                                              ),

                                              productDetailData[0]
                                                  .discount != "0"?Row(
                                                children: [
                                                  Text(
                                                    '\u{20B9}' +
                                                        double.parse(
                                                            productDetailData[
                                                            0]
                                                                .netPrice!)
                                                            .toStringAsFixed(0),
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                        FontWeight.w700,
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
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w700,
                                                        color: Colors.grey),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    productDetailData[0]
                                                        .discount! +
                                                        "% OFF",
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                        FontWeight.w700,
                                                        color: Colors.redAccent),
                                                  ),
                                                ],
                                              ):Text(
                                                '\u{20B9}' +
                                                    double.parse(
                                                        productDetailData[
                                                        0]
                                                            .netPrice!)
                                                        .toStringAsFixed(0),
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                    FontWeight.w700,
                                                    color: Colors.black),
                                              ),


                                            ],
                                          ),
                                        ),


                                      ],),
                                  ),
                                  ),

                                  // SizedBox(height: 10,),
                                  // Container(
                                  //   color: AppColors.white,
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.all(16.0),
                                  //     child: Column(
                                  //       crossAxisAlignment: CrossAxisAlignment.start,
                                  //     children: [
                                  //       // SizedBox(height: 24,),
                                  //       Text("Available Colors",
                                  //           style: GoogleFonts.inriaSans(
                                  //               textStyle: const TextStyle(
                                  //                   fontSize: 14,
                                  //                   fontWeight: FontWeight.w700,
                                  //                   color: AppColors.black))),
                                  //       SizedBox(
                                  //         height: 10,
                                  //       ),
                                  //       SizedBox(
                                  //         height: 40,
                                  //         width: MediaQuery.of(context).size.width,
                                  //         child: ListView.builder(
                                  //             scrollDirection: Axis.horizontal,
                                  //             itemCount: productDetailsController!
                                  //                 .colorList.length,
                                  //             itemBuilder: (c, index) {
                                  //               return Padding(
                                  //                 padding: index == 0
                                  //                     ? const EdgeInsets.only(
                                  //                     right: 8.0, left: 0.0)
                                  //                     : const EdgeInsets.only(
                                  //                     right: 8.0),
                                  //                 child: Container(
                                  //                   height: 40,
                                  //                   width: 40,
                                  //                   decoration: BoxDecoration(
                                  //                     shape: BoxShape.circle,
                                  //                     color: productDetailsController!
                                  //                         .colorList[index],
                                  //                     // borderRadius: const BorderRadius.all(
                                  //                     //     const Radius.circular(100)
                                  //                     // ),
                                  //                   ),
                                  //                 ),
                                  //               );
                                  //             }),
                                  //       ),
                                  //     ],
                                  // ),
                                  //   ),),

                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  Column(children: productElementData.map((productElementObj) {





                                    if(productElementObj.element == "Color"){
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 10.0),
                                        child: Container(
                                          color: AppColors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                // SizedBox(height: 24,),
                                                Text("${productElementObj.element}",
                                                    style: GoogleFonts.inriaSans(
                                                        textStyle: const TextStyle(
                                                            fontSize: 14,
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
                                                      itemCount: productElementObj.value!.length,
                                                      itemBuilder: (c, index) {



                                                        return Padding(
                                                          padding: index == 0
                                                              ? const EdgeInsets.only(
                                                              right: 8.0, left: 0.0)
                                                              : const EdgeInsets.only(
                                                              right: 8.0),
                                                          child:


                                                          productElementObj.value![index].elementValue!.isSelected! == true?
                                                          Container(
                                                            height: 45,
                                                            width: 45,
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape.circle,

                                                                // borderRadius: const BorderRadius.all(
                                                                //     const Radius.circular(100)
                                                                // ),
                                                                //   color: Colors.red,
                                                                border: Border.all(
                                                                    color:
                                                                    AppColors.black)
                                                            ),

                                                            child: Center(
                                                              child: Container(
                                                                height: 35,
                                                                width: 35,
                                                                // margin: EdgeInsets.all(5.0),
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape.circle,
                                                                    color : Color(int.parse("0xFF"+productElementObj.value![index].elementValue!.attrCode!)),
                                                                    // color: productElementObj.value![index].elementValue.attrCode!,
                                                                    // borderRadius: const BorderRadius.all(
                                                                    //     const Radius.circular(100)
                                                                    // ),
                                                                    border: Border.all(
                                                                        color:
                                                                        AppColors.colorInside)
                                                                ),
                                                              ),
                                                            ),
                                                          ):InkWell(
                                                            onTap: () async {

                                                              List<ElementValue> elementList = [];
                                                              String selectedAttributes = "";
                                                              String currentAttributes = "";

                                                              productElementData.forEach((productElement) {
                                                                productElement.value!.forEach((element) {
                                                                  if(element.elementValue!.isSelected == true){
                                                                    elementList.add(element.elementValue!);
                                                                    // selectedAttributes = selectedAttributes + element.elementValue!.attrId.toString()+",";
                                                                  }
                                                                });
                                                              });

                                                              elementList.forEach((element) {
                                                                if(element.elementId == productElementObj.value![index].elementValue!.elementId! ){
                                                                  currentAttributes = productElementObj.value![index].elementValue!.attrId!;
                                                                }else{
                                                                  selectedAttributes = selectedAttributes + element.attrId.toString()+",";
                                                                }
                                                              });

                                                              // print("elementList ===================> ${elementList.toString()}");
                                                              print("currentAttributes ===================> ${currentAttributes.toString()}");
                                                              print("selectedAttributes ===================> ${selectedAttributes.toString()}");
                                                              print("products!.variantCode! ===================> ${products!.variantCode!}");

                                                              List<VariantModel>? variantModelData =    await productDetailsController!.getProductFromVariant(currentAttributes.toString(),selectedAttributes.toString(),products!.variantCode!,homecontroller.customerId.value);


                                                              setState(() {
                                                                products = Products(productId: variantModelData![0].productId!,productName: "",variantCode: variantModelData[0].variantCode ?? "");
                                                                productDetailsController!.productDetails(variantModelData[0].productId!,variantModelData[0].variantCode!,true,homecontroller.customerId.value);
                                                              });

                                                            },
                                                            child: Container(
                                                              height: 45,
                                                              width: 45,
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape.circle,

                                                                  // borderRadius: const BorderRadius.all(
                                                                  //     const Radius.circular(100)
                                                                  // ),
                                                                  //   color: Colors.red,
                                                                  border: Border.all(
                                                                      color:
                                                                      AppColors.colorOutside)
                                                              ),

                                                              child: Center(
                                                                child: Container(
                                                                  height: 35,
                                                                  width: 35,
                                                                  // margin: EdgeInsets.all(5.0),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color : Color(int.parse("0xFF"+productElementObj.value![index].elementValue!.attrCode!)),
                                                                      // color: productElementObj.value![index].elementValue.attrCode!,
                                                                      // borderRadius: const BorderRadius.all(
                                                                      //     const Radius.circular(100)
                                                                      // ),
                                                                      border: Border.all(
                                                                          color:
                                                                          AppColors.colorInside)
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                ),
                                              ],
                                            ),
                                          ),),
                                      );
                                    }
                                    else if(productElementObj.element == "Size"){
                                      return  Padding(
                                        padding: const EdgeInsets.only(top: 10.0),
                                        child: Container(
                                          color: AppColors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("${productElementObj.element}",
                                                      style: GoogleFonts.inriaSans(
                                                          textStyle: const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w700,
                                                              color: AppColors.black))),
                                                  // Text("Size Chart",
                                                  //     style: GoogleFonts.inriaSans(
                                                  //         textStyle: const TextStyle(
                                                  //             fontSize: 14,
                                                  //             fontWeight: FontWeight.w700,
                                                  //             color: AppColors.appRed))),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 14,
                                              ),
                                              SizedBox(
                                                height: 40,
                                                width: MediaQuery.of(context).size.width,
                                                child: ListView.builder(
                                                    scrollDirection: Axis.horizontal,
                                                    itemCount: productElementObj.value!.length,
                                                    itemBuilder: (c, index) {
                                                      return Padding(
                                                        padding: index == 0
                                                            ? const EdgeInsets.only(
                                                            right: 8.0, left: 0.0)
                                                            : const EdgeInsets.only(
                                                            right: 8.0),
                                                        child:

                                                        productElementObj.value![index].elementValue!.isSelected! == true?
                                                        Container(
                                                          height: 40,
                                                          width: 40,
                                                          child: Center(
                                                              child: Text(
                                                                  productElementObj.value![index].elementName!,
                                                                  style: GoogleFonts.inriaSans(
                                                                      textStyle:
                                                                      const TextStyle(
                                                                          fontSize: 14,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                          color: AppColors
                                                                              .white)))),
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              color: AppColors.appColor,
                                                              // color: productDetailsController!.colorList[index],
                                                              // borderRadius: const BorderRadius.all(
                                                              //     const Radius.circular(100)
                                                              // ),
                                                              border: Border.all(
                                                                  color:
                                                                  AppColors.appColor)),
                                                        ): InkWell(
                                                          onTap: ()async{
                                                            List<ElementValue> elementList = [];
                                                            String selectedAttributes = "";
                                                            String currentAttributes = "";

                                                            productElementData.forEach((productElement) {
                                                              productElement.value!.forEach((element) {
                                                                if(element.elementValue!.isSelected == true){
                                                                  elementList.add(element.elementValue!);
                                                                  // selectedAttributes = selectedAttributes + element.elementValue!.attrId.toString()+",";
                                                                }
                                                              });
                                                            });

                                                            elementList.forEach((element) {
                                                              if(element.elementId == productElementObj.value![index].elementValue!.elementId! ){
                                                                currentAttributes = productElementObj.value![index].elementValue!.attrId!;
                                                              }else{
                                                                selectedAttributes = selectedAttributes + element.attrId.toString()+",";
                                                              }
                                                            });

                                                            // print("elementList ===================> ${elementList.toString()}");
                                                            print("currentAttributes ===================> ${currentAttributes.toString()}");
                                                            print("selectedAttributes ===================> ${selectedAttributes.toString()}");
                                                            print("products!.variantCode! ===================> ${products!.variantCode!}");

                                                            List<VariantModel>? variantModelData =    await    productDetailsController!.getProductFromVariant(currentAttributes.toString(),selectedAttributes.toString(),products!.variantCode!,homecontroller.customerId.value);


                                                            setState(() {
                                                              products = Products(productId: variantModelData![0].productId!,productName: "",variantCode: variantModelData[0].variantCode ?? "");
                                                              productDetailsController!.productDetails(variantModelData[0].productId!,variantModelData[0].variantCode!,true,homecontroller.customerId.value);
                                                            });



                                                          },
                                                          child: Container(
                                                            height: 40,
                                                            width: 40,
                                                            child: Center(
                                                                child: Text(
                                                                    productElementObj.value![index].elementName!,
                                                                    style: GoogleFonts.inriaSans(
                                                                        textStyle:
                                                                        const TextStyle(
                                                                            fontSize: 14,
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .bold,
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
                                                        ),
                                                      );
                                                    }),
                                              ),

                                            ],),
                                          ),),
                                      );
                                    }else{
                                      return  Padding(
                                        padding: const EdgeInsets.only(top: 10.0),
                                        child: Container(
                                          color: AppColors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("${productElementObj.element}",
                                                      style: GoogleFonts.inriaSans(
                                                          textStyle: const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w700,
                                                              color: AppColors.black))),
                                                  // Text("Size Chart",
                                                  //     style: GoogleFonts.inriaSans(
                                                  //         textStyle: const TextStyle(
                                                  //             fontSize: 14,
                                                  //             fontWeight: FontWeight.w700,
                                                  //             color: AppColors.appRed))),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 14,
                                              ),
                                              SizedBox(
                                                height: 40,
                                                width: MediaQuery.of(context).size.width,
                                                child: ListView.builder(
                                                    scrollDirection: Axis.horizontal,
                                                    itemCount: productElementObj.value!.length,
                                                    itemBuilder: (c, index) {
                                                      return Padding(
                                                        padding: index == 0
                                                            ? const EdgeInsets.only(
                                                            right: 8.0, left: 0.0)
                                                            : const EdgeInsets.only(
                                                            right: 8.0),
                                                        child:
                                                        productElementObj.value![index].elementValue!.isSelected! == true?
                                                        Container(
                                                          height: 50,
                                                          // width: 100,
                                                          child: Center(
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                                                child: Text(
                                                                    productElementObj.value![index].elementName!,
                                                                    style: GoogleFonts.inriaSans(
                                                                        textStyle:
                                                                        const TextStyle(
                                                                            fontSize: 14,
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                            color: AppColors
                                                                                .white))),
                                                              )),
                                                          decoration: BoxDecoration(
                                                              color: AppColors.appColor,
                                                              // shape: BoxShape.circle,
                                                              // color: productDetailsController!.colorList[index],
                                                              borderRadius: const BorderRadius.all(
                                                                  const Radius.circular(5)
                                                              ),
                                                              border: Border.all(
                                                                  color:
                                                                  AppColors.appColor)),
                                                        ):InkWell(
                                                          onTap: ()async{
                                                            List<ElementValue> elementList = [];
                                                            String selectedAttributes = "";
                                                            String currentAttributes = "";

                                                            productElementData.forEach((productElement) {
                                                              productElement.value!.forEach((element) {
                                                                if(element.elementValue!.isSelected == true){
                                                                  elementList.add(element.elementValue!);
                                                                  // selectedAttributes = selectedAttributes + element.elementValue!.attrId.toString()+",";
                                                                }
                                                              });
                                                            });

                                                            elementList.forEach((element) {
                                                              if(element.elementId == productElementObj.value![index].elementValue!.elementId! ){
                                                                currentAttributes = productElementObj.value![index].elementValue!.attrId!;
                                                              }else{
                                                                selectedAttributes = selectedAttributes + element.attrId.toString()+",";
                                                              }
                                                            });

                                                            // print("elementList ===================> ${elementList.toString()}");
                                                            print("currentAttributes ===================> ${currentAttributes.toString()}");
                                                            print("selectedAttributes ===================> ${selectedAttributes.toString()}");
                                                            print("products!.variantCode! ===================> ${products!.variantCode!}");

                                                            List<VariantModel>? variantModelData =    await productDetailsController!.getProductFromVariant(currentAttributes.toString(),selectedAttributes.toString(),products!.variantCode!,homecontroller.customerId.value);

                                                                                      setState(() {
                                                                                        products = Products(productId: variantModelData![0].productId!,productName: "",variantCode: variantModelData[0].variantCode ?? "");
                                                                                        productDetailsController!.productDetails(variantModelData[0].productId!,variantModelData[0].variantCode!,true,homecontroller.customerId.value);
                                                                                      });

                                                          },
                                                          child: Container(
                                                            height: 50,
                                                            // width: 100,
                                                            child: Center(
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                                                  child: Text(
                                                                      productElementObj.value![index].elementName!,
                                                                      style: GoogleFonts.inriaSans(
                                                                          textStyle:
                                                                          const TextStyle(
                                                                              fontSize: 14,
                                                                              fontWeight:
                                                                              FontWeight
                                                                                  .bold,
                                                                              color: AppColors
                                                                                  .appColor))),
                                                                )),
                                                            decoration: BoxDecoration(
                                                              // shape: BoxShape.circle,
                                                              // color: productDetailsController!.colorList[index],
                                                                borderRadius: const BorderRadius.all(
                                                                    const Radius.circular(5)
                                                                ),
                                                                border: Border.all(
                                                                    color:
                                                                    AppColors.appColor)),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              ),

                                            ],),
                                          ),),
                                      );
                                    }



                                  }).toList(),),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // Container(
                                  //   color: AppColors.white,
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.all(16.0),
                                  //     child: Column(children: [
                                  //     Row(
                                  //       mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //       children: [
                                  //         Text("Select Size",
                                  //             style: GoogleFonts.inriaSans(
                                  //                 textStyle: const TextStyle(
                                  //                     fontSize: 14,
                                  //                     fontWeight: FontWeight.w700,
                                  //                     color: AppColors.black))),
                                  //         Text("Size Chart",
                                  //             style: GoogleFonts.inriaSans(
                                  //                 textStyle: const TextStyle(
                                  //                     fontSize: 14,
                                  //                     fontWeight: FontWeight.w700,
                                  //                     color: AppColors.appRed))),
                                  //       ],
                                  //     ),
                                  //     SizedBox(
                                  //       height: 14,
                                  //     ),
                                  //     SizedBox(
                                  //       height: 40,
                                  //       width: MediaQuery.of(context).size.width,
                                  //       child: ListView.builder(
                                  //           scrollDirection: Axis.horizontal,
                                  //           itemCount: productDetailsController!
                                  //               .sizeList.length,
                                  //           itemBuilder: (c, index) {
                                  //             return Padding(
                                  //               padding: index == 0
                                  //                   ? const EdgeInsets.only(
                                  //                   right: 8.0, left: 0.0)
                                  //                   : const EdgeInsets.only(
                                  //                   right: 8.0),
                                  //               child: Container(
                                  //                 height: 40,
                                  //                 width: 40,
                                  //                 child: Center(
                                  //                     child: Text(
                                  //                         productDetailsController!
                                  //                             .sizeList[index],
                                  //                         style: GoogleFonts.inriaSans(
                                  //                             textStyle:
                                  //                             const TextStyle(
                                  //                                 fontSize: 14,
                                  //                                 fontWeight:
                                  //                                 FontWeight
                                  //                                     .bold,
                                  //                                 color: AppColors
                                  //                                     .black)))),
                                  //                 decoration: BoxDecoration(
                                  //                     shape: BoxShape.circle,
                                  //                     // color: productDetailsController!.colorList[index],
                                  //                     // borderRadius: const BorderRadius.all(
                                  //                     //     const Radius.circular(100)
                                  //                     // ),
                                  //                     border: Border.all(
                                  //                         color:
                                  //                         AppColors.appText)),
                                  //               ),
                                  //             );
                                  //           }),
                                  //     ),
                                  //
                                  // ],),
                                  //   ),),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  Container(
                                    color: AppColors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("EMI option available",
                                                  style: GoogleFonts.inriaSans(
                                                      textStyle: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold,
                                                          color: AppColors.black))),
                                              Text("View Plan",
                                                  style: GoogleFonts.inriaSans(
                                                      textStyle: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold,
                                                          color: AppColors.appRed))),
                                            ],
                                          ),
                                          SizedBox(height: 2,),
                                          Text("EMI starting from \u{20B9}150/month",
                                              style: GoogleFonts.inriaSans(
                                                  textStyle: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w400,
                                                      color: AppColors
                                                          .productDescription))),

                                        ],),
                                    ),),

                                  // SizedBox(
                                  //   height: 10,
                                  // ),

                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Container(
                                      color: AppColors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Delivery Details",
                                                  style: GoogleFonts.inriaSans(
                                                      textStyle: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w700,
                                                          color: AppColors.black))),
                                              Text("Check Delivery Date",
                                                  style: GoogleFonts.inriaSans(
                                                      textStyle: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w700,
                                                          color: AppColors.appRed))),
                                            ],
                                          ),

                                        ],),
                                      ),),
                                  ),


                                  SizedBox(
                                    height: 10,
                                  ),



                                  Container(
                                    color: AppColors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child:   Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                            10,
                                          ),
                                          child: HtmlWidget(
                                              productDetailData[0].description!),
                                        ),
                                      ),


                                        //   Column(
                                        // crossAxisAlignment:
                                        // CrossAxisAlignment.start,
                                        // children: [
                                        //
                                        //   Container(
                                        //     // padding: const EdgeInsets.only(top: 18,left: 18,right: 18,bottom: 16),
                                        //     // height: 400,
                                        //     child: GridView.builder(
                                        //       physics:
                                        //       const NeverScrollableScrollPhysics(),
                                        //       shrinkWrap: true,
                                        //       itemCount:
                                        //       productDetailsController!.list.length,
                                        //       gridDelegate:
                                        //       SliverGridDelegateWithFixedCrossAxisCount(
                                        //         // crossAxisCount: 2,
                                        //           crossAxisSpacing: 50,
                                        //           mainAxisSpacing: 4,
                                        //           childAspectRatio:
                                        //           MediaQuery.of(context)
                                        //               .size
                                        //               .width /
                                        //               (MediaQuery.of(context)
                                        //                   .size
                                        //                   .height /
                                        //                   5.5),
                                        //           crossAxisCount: (orientation ==
                                        //               Orientation.portrait)
                                        //               ? 2
                                        //               : 2),
                                        //       itemBuilder:
                                        //           (BuildContext context, int index) {
                                        //         return Column(
                                        //           crossAxisAlignment:
                                        //           CrossAxisAlignment.start,
                                        //           children: [
                                        //             Text(
                                        //                 productDetailsController!
                                        //                     .list[index].productName!,
                                        //                 maxLines: 1,
                                        //                 //  style: GoogleFonts.ptSans(),
                                        //                 overflow: TextOverflow.ellipsis,
                                        //                 style: GoogleFonts.inriaSans(
                                        //                     textStyle: const TextStyle(
                                        //                         fontSize: 14,
                                        //                         fontWeight:
                                        //                         FontWeight.bold,
                                        //                         color:
                                        //                         AppColors.black))),
                                        //             Text(
                                        //                 productDetailsController!
                                        //                     .list[index]
                                        //                     .shortDescription!,
                                        //                 maxLines: 1,
                                        //                 //  style: GoogleFonts.ptSans(),
                                        //                 overflow: TextOverflow.ellipsis,
                                        //                 style: GoogleFonts.inriaSans(
                                        //                     textStyle: const TextStyle(
                                        //                         fontSize: 14,
                                        //                         fontWeight:
                                        //                         FontWeight.w400,
                                        //                         color: AppColors
                                        //                             .productDescription))),
                                        //             SizedBox(height: 10,),
                                        //             Container(
                                        //
                                        //               width: MediaQuery.of(context).size.width,
                                        //               height: 1,
                                        //               color: AppColors.ratingText,)
                                        //           ],
                                        //         );
                                        //       },
                                        //     ),
                                        //   ),
                                        //
                                        //   Column(
                                        //     crossAxisAlignment:
                                        //     CrossAxisAlignment.start,
                                        //     children: [
                                        //       Text("Product Details",
                                        //           style: GoogleFonts.inriaSans(
                                        //               textStyle: const TextStyle(
                                        //                   fontSize: 14,
                                        //                   fontWeight: FontWeight.bold,
                                        //                   color: AppColors.black))),
                                        //       Padding(
                                        //         padding: const EdgeInsets.only(right: 25.0),
                                        //         child: Text(
                                        //             "Brown solid jacket, has a stand collar, four pockets, zip closure, long sleeves, straight hem",
                                        //             style: GoogleFonts.inriaSans(
                                        //                 textStyle: const TextStyle(
                                        //                     fontSize: 12,
                                        //                     fontWeight: FontWeight.w400,
                                        //                     color: AppColors
                                        //                         .productDescription))),
                                        //       ),
                                        //     ],
                                        //   ),
                                        //   const SizedBox(
                                        //     height: 16,
                                        //   ),
                                        //   Column(
                                        //     crossAxisAlignment:
                                        //     CrossAxisAlignment.start,
                                        //     children: [
                                        //       Text("Size & Fit",
                                        //           // maxLines: 1,
                                        //           //  style: GoogleFonts.ptSans(),
                                        //           // overflow: TextOverflow.ellipsis,
                                        //           style: GoogleFonts.inriaSans(
                                        //               textStyle: const TextStyle(
                                        //                   fontSize: 14,
                                        //                   fontWeight: FontWeight.bold,
                                        //                   color: AppColors.black))),
                                        //       Text(
                                        //           "The model(height 5’8”) is wearing a size S",
                                        //           style: GoogleFonts.inriaSans(
                                        //               textStyle: const TextStyle(
                                        //                   fontSize: 12,
                                        //                   fontWeight: FontWeight.w400,
                                        //                   color: AppColors
                                        //                       .productDescription))),
                                        //     ],
                                        //   ),
                                        //   const SizedBox(
                                        //     height: 16,
                                        //   ),
                                        //   Column(
                                        //     crossAxisAlignment:
                                        //     CrossAxisAlignment.start,
                                        //     children: [
                                        //       Text("Material & Care",
                                        //           // maxLines: 1,
                                        //           //  style: GoogleFonts.ptSans(),
                                        //           // overflow: TextOverflow.ellipsis,
                                        //           style: GoogleFonts.inriaSans(
                                        //               textStyle: const TextStyle(
                                        //                   fontSize: 14,
                                        //                   fontWeight: FontWeight.bold,
                                        //                   color: AppColors.black))),
                                        //       Text(
                                        //           "Material: Leather \nLining: Polyster \nDry Clean",
                                        //           // maxLines: 1,
                                        //           //  style: GoogleFonts.ptSans(),
                                        //           // overflow: TextOverflow.ellipsis,
                                        //           style: GoogleFonts.inriaSans(
                                        //               textStyle: const TextStyle(
                                        //                   fontSize: 12,
                                        //                   fontWeight: FontWeight.w400,
                                        //                   color: AppColors
                                        //                       .productDescription))),
                                        //     ],
                                        //   ),
                                        //
                                        // ],),
                                    ),),


                                  SizedBox(
                                    height: 10,
                                  ),






                                  Container(

                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                  child: Image.asset('assets/img/Verified Badge.png',fit: BoxFit.fill,height: 58,width: 65,)),

                                              const SizedBox(
                                                height: 1,
                                              ),
                                              Text("Genuine Product",
                                                  // maxLines: 1,
                                                  //  style: GoogleFonts.ptSans(),
                                                  // overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.inriaSans(
                                                      textStyle: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          color: AppColors.black))),
                                            ],
                                          ),
                                          SizedBox(width: 50,),
                                          Column(
                                            children: [
                                              Container(
                                                  child: Image.asset('assets/img/Holding Box.png',fit: BoxFit.fill,height: 58,width: 65,)),

                                              const SizedBox(
                                                height: 1,
                                              ),
                                              Text("Genuine Product",
                                                  // maxLines: 1,
                                                  //  style: GoogleFonts.ptSans(),
                                                  // overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.inriaSans(
                                                      textStyle: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          color: AppColors.black))),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    color: AppColors.white,
                                  ),



                                  const SizedBox(
                                    height: 10,
                                  ),

                                  Container(color: AppColors.white,child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text("Easy 15 days returns and exchanges",
                                            // maxLines: 1,
                                            //  style: GoogleFonts.ptSans(),
                                            // overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.inriaSans(
                                                textStyle: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.black))),
                                        Text(
                                            "Choose to return or exchange for a different size(if available) within 15 days.",
                                            // maxLines: 1,
                                            //  style: GoogleFonts.ptSans(),
                                            // overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.inriaSans(
                                                textStyle: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors
                                                        .productDescription))),
                                      ],
                                    ),
                                  ),),

                                  productReviewList.isNotEmpty?
                                  Container(
                                    key: _key,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Container(
                                        color: AppColors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              // SizedBox(height: 16,),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("Ratings & Reviews",
                                                      style: GoogleFonts.inriaSans(
                                                          textStyle: const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w700,
                                                              color: AppColors.black))),
                                                  Text("View all Reviews",
                                                      style: GoogleFonts.inriaSans(
                                                          textStyle: const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w700,
                                                              color: AppColors.appRed))),
                                                ],
                                              ),
                                              SizedBox(height: 16,),
                                              // Container(
                                              //     color: AppColors.ratingText,
                                              //   height: 1,width: MediaQuery.of(context).size.width,
                                              // ),
                                              // SizedBox(height: 16,),

                                              Row(children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        Text("${productReviewList[0].totalStar}",style: GoogleFonts.inriaSans(
                                                            textStyle: const TextStyle(
                                                                fontSize: 48,
                                                                fontWeight: FontWeight.w400,
                                                                color: AppColors.black))),
                                                        Padding(
                                                          padding: const EdgeInsets.only(bottom: 10.0),
                                                          child: Icon(
                                                            Icons.star,
                                                            color:
                                                            AppColors.startBat,
                                                            size: 16,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 8,
                                                  child: Center(
                                                    child: Text("${productReviewList[0].totalRatingCount} ratings and ${productReviewList[0].totalReviewsCount} reviews",style: GoogleFonts.inriaSans(
                                                        textStyle: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w400,
                                                            color: AppColors.black))),
                                                  ),
                                                )
                                              ],),
                                              SizedBox(height: 16,),
                                              Container(
                                                color: AppColors.ratingText,
                                                height: 1,width: MediaQuery.of(context).size.width,
                                              ),
                                              SizedBox(height: 16,),
                                              Text("Customers Reviews(${productReviewList[0].totalReviewsCount})",
                                                  style: GoogleFonts.inriaSans(
                                                      textStyle: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w700,
                                                          color: AppColors.black))),
                                              SizedBox(height: 16,),
                                              Column(children:
                                              productReviewList[0].reviews!.map((reviewsObj) {
                                                int i = productReviewList![0].reviews!.indexOf(reviewsObj);
                                                return Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(

                                                      children: [
                                                        Container(
                                                          height: 36,
                                                          width: 32,
                                                          child: Center(

                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                                children: [
                                                                  Text(
                                                                      reviewsObj.starRate!,
                                                                      style: GoogleFonts.inriaSans(
                                                                          textStyle:
                                                                          const TextStyle(
                                                                              fontSize: 16,
                                                                              fontWeight:
                                                                              FontWeight
                                                                                  .bold,
                                                                              color: AppColors
                                                                                  .white))),
                                                                  Padding(
                                                                    padding: const EdgeInsets.only(bottom: 3.0),
                                                                    child: Icon(
                                                                      Icons.star,
                                                                      color:
                                                                      AppColors.white,
                                                                      size: 10,
                                                                    ),
                                                                  ),
                                                                ],
                                                              )),
                                                          decoration: BoxDecoration(
                                                            // shape: BoxShape.circle,
                                                              color: AppColors.appColor,
                                                              // color: productDetailsController!.colorList[index],
                                                              borderRadius: const BorderRadius.all(
                                                                  const Radius.circular(3)
                                                              ),
                                                              border: Border.all(
                                                                  color:
                                                                  AppColors.appColor)),
                                                        ),
                                                        SizedBox(width: 12,),
                                                        Text("${reviewsObj.reviewDate}",
                                                            style: GoogleFonts.inriaSans(
                                                                textStyle: const TextStyle(
                                                                    fontSize: 12,
                                                                    fontWeight: FontWeight.normal,
                                                                    color: AppColors.productDescription))),
                                                      ],
                                                    ),
                                                    SizedBox(height: 12,),
                                                    reviewsObj.reviewTitle != ""?
                                                    Text("${reviewsObj.reviewTitle}",
                                                        style: GoogleFonts.inriaSans(
                                                            textStyle: const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w700,
                                                                color: AppColors.black))):Container(),
                                                    // SizedBox(height: 3,),
                                                    reviewsObj.reviewTitle != "" && reviewsObj.reviewContent != ""?
                                                    SizedBox(height: 5,):Container(),
                                                    reviewsObj.reviewContent != ""?Text("${reviewsObj.reviewContent}",
                                                        style: GoogleFonts.inriaSans(
                                                            textStyle: const TextStyle(
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.w400,
                                                                color: AppColors.productDescription))): Container(),
                                                    // SizedBox(height: 12,),
                                                    // Container(
                                                    //   height: 25,
                                                    //   width: 100,
                                                    //   child: Center(
                                                    //
                                                    //       child: Row(
                                                    //         mainAxisAlignment: MainAxisAlignment.center,
                                                    //         crossAxisAlignment: CrossAxisAlignment.center,
                                                    //         children: [
                                                    //           Text(
                                                    //               "Size Bought:",
                                                    //               style: GoogleFonts.inriaSans(
                                                    //                   textStyle:
                                                    //                   const TextStyle(
                                                    //                       fontSize: 12,
                                                    //                       fontWeight:
                                                    //                       FontWeight
                                                    //                           .w700,
                                                    //                       color: AppColors
                                                    //                           .black))),
                                                    //           Text(
                                                    //               "  L",
                                                    //               style: GoogleFonts.inriaSans(
                                                    //                   textStyle:
                                                    //                   const TextStyle(
                                                    //                       fontSize: 12,
                                                    //                       fontWeight:
                                                    //                       FontWeight
                                                    //                           .normal,
                                                    //                       color: AppColors
                                                    //                           .black))),
                                                    //         ],
                                                    //       )),
                                                    //   decoration: BoxDecoration(
                                                    //     // shape: BoxShape.circle,
                                                    //       color: AppColors.toggleBg,
                                                    //       // color: productDetailsController!.colorList[index],
                                                    //       borderRadius: const BorderRadius.all(
                                                    //           const Radius.circular(1)
                                                    //       ),
                                                    //       // border: Border.all(
                                                    //       //     color:
                                                    //       //     AppColors.appColor)
                                                    //   ),
                                                    // ),
                                                    reviewsObj.reviewTitle != "" || reviewsObj.reviewContent != ""?
                                                    SizedBox(height: 12,):Container(),
                                                    Text("${reviewsObj.customerName}",
                                                        style: GoogleFonts.inriaSans(
                                                            textStyle: const TextStyle(
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.w400,
                                                                color: AppColors.productDescription))),
                                                    productReviewList[0].reviews!.length - 1 != i?
                                                    SizedBox(height: 12,):Container(),
                                                    productReviewList[0].reviews!.length - 1 != i?Container(
                                                      color: AppColors.ratingText,
                                                      height: 1,width: MediaQuery.of(context).size.width,
                                                    ):Container(),
                                                    productReviewList[0].reviews!.length - 1 != i?
                                                    SizedBox(height: 16,):Container(),

                                                  ],
                                                );
                                              }).toList()
                                                ,)


                                            ],),
                                        ),
                                      ),
                                    ),
                                  ):Container(),

                                  // InkWell(
                                  //   onTap: (){
                                  //     showModalBottomSheet(
                                  //
                                  //         context: context,
                                  //         builder: (context) {
                                  //
                                  //           bool? isFlag = false;
                                  //           return Wrap(
                                  //             children: [
                                  //               Padding(
                                  //                 padding: const EdgeInsets.only(right: 30.0,left: 30,top: 15,bottom: 10.0),
                                  //                 child: Column(
                                  //                   crossAxisAlignment: CrossAxisAlignment.center,
                                  //                   children: [
                                  //                     Row(
                                  //
                                  //                       children: [
                                  //                         Text("Cancel",
                                  //                             style: GoogleFonts.inriaSans(
                                  //                                 textStyle: const TextStyle(
                                  //                                     fontSize: 14,
                                  //                                     fontWeight: FontWeight.w400,
                                  //                                     color: AppColors.startBat))),
                                  //                         Text("Rate",
                                  //                             style: GoogleFonts.inriaSans(
                                  //                                 textStyle: const TextStyle(
                                  //                                     fontSize: 14,
                                  //                                     fontWeight: FontWeight.w400,
                                  //                                     color: AppColors.startBat))),
                                  //                         Text("Done",
                                  //                             style: GoogleFonts.inriaSans(
                                  //                                 textStyle:  TextStyle(
                                  //                                     fontSize: 14,
                                  //                                     fontWeight: FontWeight.w400,
                                  //                                     color: isFlag == false ? AppColors.black :AppColors.red))),
                                  //                       ],
                                  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //                     ),
                                  //                     const SizedBox(
                                  //                       height: 40,
                                  //                     ),
                                  //                     Text("Have you tried this? Rate it!",
                                  //                         style: GoogleFonts.inriaSans(
                                  //                             textStyle: const TextStyle(
                                  //                                 fontSize: 14,
                                  //                                 fontWeight: FontWeight.w400,
                                  //                                 color: AppColors.black))),
                                  //                     const SizedBox(
                                  //                       height: 10,
                                  //                     ),
                                  //                     RatingBar(
                                  //                       initialRating: 0,
                                  //                       // minRating: 1,
                                  //                       // ignoreGestures: true,
                                  //                       direction: Axis.horizontal,
                                  //                       allowHalfRating: true,
                                  //                       itemCount: 5,
                                  //                       itemSize: 25,
                                  //                       // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                  //                       ratingWidget: RatingWidget(
                                  //                         full: const Icon(
                                  //                           Icons.star,
                                  //                           color: AppColors.startBat,
                                  //                           size: 35,
                                  //                         ),
                                  //                         half: const Icon(
                                  //                           Icons.star_half,
                                  //                           color: AppColors.startBat,
                                  //                           size: 35,
                                  //                         ),
                                  //                         empty: const Icon(
                                  //                           Icons.star_border_rounded,
                                  //                           color: AppColors.startBat,
                                  //                           size: 35,
                                  //                         ),
                                  //                       ),
                                  //                       // itemBuilder: (context, _) =>
                                  //                       //     Icon(
                                  //                       //   Icons.star_border_rounded,
                                  //                       //   color: AppColors.appRed,
                                  //                       //   size: 10,
                                  //                       // ),
                                  //                       onRatingUpdate: (rating) {
                                  //                         print("rating  $rating");
                                  //                         if(rating>0){
                                  //                           isFlag = true;
                                  //                           print("rating if $rating");
                                  //
                                  //                           setState(() {
                                  //
                                  //                           });
                                  //
                                  //                         }
                                  //                       },
                                  //                     ),
                                  //                     const SizedBox(
                                  //                       height: 60,
                                  //                     ),
                                  //                     Text("Thank You!",
                                  //                         style: GoogleFonts.salsa(
                                  //                             textStyle: const TextStyle(
                                  //                                 fontSize: 36,
                                  //                                 fontWeight: FontWeight.w400,
                                  //                                 color: AppColors.appRed))),
                                  //                     const SizedBox(
                                  //                       height: 10,
                                  //                     ),
                                  //                   ],
                                  //                 ),
                                  //               ),
                                  //             ],
                                  //           );
                                  //         });
                                  //   },
                                  //   child: Center(
                                  //     child: Column(
                                  //       children: [
                                  //         Text("Rate",
                                  //             style: GoogleFonts.inriaSans(
                                  //                 textStyle: const TextStyle(
                                  //                     fontSize: 18,
                                  //                     fontWeight: FontWeight.w400,
                                  //                     color: AppColors.black))),
                                  //         const SizedBox(
                                  //           height: 10,
                                  //         ),
                                  //         RatingBar(
                                  //           initialRating: 0,
                                  //           // minRating: 1,
                                  //           ignoreGestures: true,
                                  //           direction: Axis.horizontal,
                                  //           allowHalfRating: true,
                                  //           itemCount: 5,
                                  //           itemSize: 25,
                                  //           // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                  //           ratingWidget: RatingWidget(
                                  //             full: const Icon(
                                  //               Icons.star,
                                  //               color: AppColors.startBat,
                                  //               size: 18,
                                  //             ),
                                  //             half: const Icon(
                                  //               Icons.star_half,
                                  //               color: AppColors.startBat,
                                  //               size: 18,
                                  //             ),
                                  //             empty: const Icon(
                                  //               Icons.star_outline_sharp,
                                  //               color: AppColors.startBat,
                                  //               size: 18,
                                  //             ),
                                  //           ),
                                  //           // itemBuilder: (context, _) =>
                                  //           //     Icon(
                                  //           //   Icons.star_border_rounded,
                                  //           //   color: AppColors.appRed,
                                  //           //   size: 10,
                                  //           // ),
                                  //           onRatingUpdate: (rating) {
                                  //             print(rating);
                                  //           },
                                  //         ),
                                  //         const SizedBox(
                                  //           height: 10,
                                  //         ),
                                  //         Text("Tap to Rate",
                                  //             style: GoogleFonts.salsa(
                                  //                 textStyle: const TextStyle(
                                  //                     fontSize: 12,
                                  //                     color: AppColors.black))),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                  const SizedBox(
                                    height: 10,
                                  ),

                                  // Container(
                                  //   color: AppColors.white,
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.only(left: 16.0, top: 16),
                                  //     child: Column(
                                  //       crossAxisAlignment: CrossAxisAlignment.start,
                                  //       children: [
                                  //     Text("View Similar",
                                  //         style: GoogleFonts.inriaSans(
                                  //             textStyle: const TextStyle(
                                  //                 fontSize: 16,
                                  //                 fontWeight: FontWeight.w700,
                                  //                 color: AppColors.black))),
                                  //     const SizedBox(
                                  //       height: 16,
                                  //     ),
                                  //
                                  //     SizedBox(
                                  //       height: 180,
                                  //       width: MediaQuery.of(context).size.width,
                                  //       child: ListView.builder(
                                  //           scrollDirection: Axis.horizontal,
                                  //           itemCount:
                                  //           productDetailsController!.similarList.length,
                                  //           itemBuilder: (c, index) {
                                  //             return Padding(
                                  //               padding: index == 0
                                  //                   ? const EdgeInsets.only(
                                  //                   right: 0.0, left: 0.0)
                                  //                   : const EdgeInsets.only(
                                  //                   left: 15.0),
                                  //               child: Container(
                                  //                 height: 180,
                                  //                 width: 140,
                                  //                 decoration: BoxDecoration(
                                  //                   color: AppColors.white,
                                  //                   // borderRadius: const BorderRadius
                                  //                   //         .all(
                                  //                   //     const Radius.circular(10)),
                                  //                   border: Border.all(
                                  //                     width: 1,
                                  //                     color: AppColors
                                  //                         .bestSellingBorder,
                                  //                     // style: BorderStyle.solid,
                                  //                   ),
                                  //                 ),
                                  //                 child: Column(
                                  //                   children: [
                                  //                     Image.asset(
                                  //                       productDetailsController!.similarList[index]
                                  //                           .coverImage!,
                                  //                       fit: BoxFit.fill,
                                  //                       width: double.infinity,
                                  //                       height: 98,
                                  //                     ),
                                  //                     Padding(
                                  //                       padding:
                                  //                       const EdgeInsets
                                  //                           .only(
                                  //                           left: 8.0,
                                  //                           right: 6.0,
                                  //                           bottom: 5.0,
                                  //                           top: 6.0),
                                  //                       child: Column(
                                  //                         crossAxisAlignment:
                                  //                         CrossAxisAlignment
                                  //                             .start,
                                  //                         children: [
                                  //                           Text(
                                  //                               productDetailsController!.similarList[index]
                                  //                                   .productName!,
                                  //                               maxLines:
                                  //                               1,
                                  //                               //  style: GoogleFonts.ptSans(),
                                  //                               overflow:
                                  //                               TextOverflow
                                  //                                   .ellipsis,
                                  //                               style: GoogleFonts.inriaSans(
                                  //                                   textStyle: const TextStyle(
                                  //                                       fontSize: 14,
                                  //                                       fontWeight: FontWeight.w400,
                                  //                                       color: AppColors.black))),
                                  //                           // SizedBox(height: 6,),
                                  //                           Text(
                                  //                               productDetailsController!.similarList[
                                  //                               index]
                                  //                                   .shortDescription!,
                                  //                               maxLines: 2,
                                  //                               //  style: GoogleFonts.ptSans(),
                                  //                               overflow:
                                  //                               TextOverflow
                                  //                                   .ellipsis,
                                  //                               style: GoogleFonts.inriaSans(
                                  //                                   textStyle: const TextStyle(
                                  //                                       fontSize:
                                  //                                       14,
                                  //                                       fontWeight:
                                  //                                       FontWeight
                                  //                                           .w400,
                                  //                                       color: AppColors
                                  //                                           .appText1))),
                                  //                           // SizedBox(height: 6,),
                                  //
                                  //                           Row(
                                  //                             children: [
                                  //                               Text(
                                  //                                   "\u{20B9}${double.parse(productDetailsController!.similarList[index].netPrice!).toStringAsFixed(0)} ",
                                  //                                   style: GoogleFonts.inriaSans(
                                  //                                       textStyle: const TextStyle(
                                  //                                           fontSize:
                                  //                                           12,
                                  //                                           fontWeight:
                                  //                                           FontWeight.w400,
                                  //                                           color: AppColors.black))),
                                  //                               Text(
                                  //                                   "\u{20B9}${double.parse(productDetailsController!.similarList[index].mrpPrice!).toStringAsFixed(0)} ",
                                  //                                   style: GoogleFonts.inriaSans(
                                  //                                       textStyle: TextStyle(
                                  //                                           fontSize:
                                  //                                           12,
                                  //                                           decoration:
                                  //                                           TextDecoration.combine([
                                  //                                             TextDecoration.lineThrough
                                  //                                           ]),
                                  //                                           fontWeight:
                                  //                                           FontWeight.w400,
                                  //                                           color: AppColors.appText1))),
                                  //
                                  //                             ],
                                  //                           ),
                                  //                           // SizedBox(height: 6,),
                                  //                           Text(
                                  //                               "${productDetailsController!.similarList[index].discount!}",
                                  //                               style: GoogleFonts.inriaSans(
                                  //                                   textStyle: const TextStyle(
                                  //                                       fontSize:
                                  //                                       12,
                                  //                                       fontWeight:
                                  //                                       FontWeight.w400,
                                  //                                       color: AppColors.off)))
                                  //                         ],
                                  //                       ),
                                  //                     ),
                                  //                   ],
                                  //                 ),
                                  //               ),
                                  //             );
                                  //           }),
                                  //     ),
                                  //       const SizedBox(
                                  //         height: 16,
                                  //       ),
                                  //
                                  // ],),
                                  //   ),),



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
                                  Obx(() {
                                    if (productDetailsController!.isLoadingGetSimilarProduct.value ==
                                        true) {
                                      MainResponse? mainResponse =
                                          productDetailsController!.getSimilarProductObj.value;
                                      List<SimilarProductModel>? similarProductData = [];
                                      print(
                                          "getSimilarProductObj.data! ${mainResponse.data!}");
                                      if (mainResponse.data != null) {
                                        mainResponse.data!.forEach((v) {
                                          print(
                                              "getSimilarProductObj.data! ${mainResponse.data!}");
                                          similarProductData.add(SimilarProductModel.fromJson(v));
                                        });
                                      }
                                      // mainResponse.data!.map((e) => customerProfileData!.add(UpdateCustomerPasswordData.fromJson(e))).toList();

                                      String? imageUrl = mainResponse.imageUrl ?? "";
                                      String? message =
                                          mainResponse.message ?? AppConstants.noInternetConn;
                                      print("message =====> $message");
                                      if (similarProductData.isEmpty) {
                                        // return SizedBox(
                                        //   height: 200.0,
                                        //   width: MediaQuery.of(context).size.width,
                                        //   child: Column(
                                        //     mainAxisAlignment: MainAxisAlignment.center,
                                        //     crossAxisAlignment: CrossAxisAlignment.center,
                                        //     children: <Widget>[
                                        //       Column(
                                        //         children: <Widget>[
                                        //           Text(
                                        //             message!,
                                        //             style: const TextStyle(
                                        //                 color: Colors.black45),
                                        //           )
                                        //         ],
                                        //       )
                                        //     ],
                                        //   ),
                                        // );

                                        return Container();
                                      } else {

                                        return Container(
                                          color: AppColors.white,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 16,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 16.0),
                                                child: Text("View Similar",
                                                    style: GoogleFonts.inriaSans(
                                                        textStyle: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w700,
                                                            color: AppColors.black))),
                                              ),
                                              const SizedBox(
                                                height: 16,
                                              ),
                                              SizedBox(
                                                height: 180,
                                                width: MediaQuery.of(context).size.width,
                                                child: ListView.builder(
                                                    scrollDirection: Axis.horizontal,
                                                    itemCount:
                                                    similarProductData.length,
                                                    itemBuilder: (c, index) {
                                                      return Padding(
                                                        padding: index == 0
                                                            ? const EdgeInsets.only(
                                                            right: 15.0, left: 15.0)
                                                            : const EdgeInsets.only(
                                                            right: 15.0),
                                                        child: InkWell(
                                                          onTap: (){
                                                            products = Products(productId: similarProductData[index].productId!,productName: similarProductData[index].productName!,variantCode: similarProductData[index].variantCode ?? "");
                                                            isSimilerView = true;
                                                            productDetailsController!.productDetails(similarProductData[index].productId!,similarProductData[index].variantCode ?? "", false,homecontroller.customerId.value);
                                                            // Navigator.pushReplacement(
                                                            //     context,
                                                            //     MaterialPageRoute(
                                                            //         builder: (context) =>  ProductDetailsScreen(
                                                            //           products: Products(productId: similarProductData[index].productId!,productName: similarProductData[index].productName!,variantCode: similarProductData[index].variantCode ?? ""),
                                                            //           // article: articles[index],
                                                            //         )));
                                                          },
                                                          child: Container(
                                                            height: 180,
                                                            width: 140,
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
                                                                Image.network(
                                                                  imageUrl+ similarProductData[index]
                                                                      .productId!+"/"+similarProductData[index]
                                                                      .coverImg!,
                                                                  fit: BoxFit.cover,
                                                                  width: double.infinity,
                                                                  height: 98,
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 8.0,
                                                                      right: 6.0,
                                                                      bottom: 5.0,
                                                                      top: 6.0),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                    children: [
                                                                      Text(
                                                                          similarProductData[index]
                                                                              .brandName!,
                                                                          maxLines:
                                                                          1,
                                                                          //  style: GoogleFonts.ptSans(),
                                                                          overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                          style: GoogleFonts.inriaSans(
                                                                              textStyle: const TextStyle(
                                                                                  fontSize: 14,
                                                                                  fontWeight: FontWeight.w400,
                                                                                  color: AppColors.black))),
                                                                      // SizedBox(height: 6,),
                                                                      Text(
                                                                          similarProductData[
                                                                          index]
                                                                              .productName!,
                                                                          maxLines: 1,
                                                                          //  style: GoogleFonts.ptSans(),
                                                                          overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                          style: GoogleFonts.inriaSans(
                                                                              textStyle: const TextStyle(
                                                                                  fontSize:
                                                                                  14,
                                                                                  fontWeight:
                                                                                  FontWeight
                                                                                      .w400,
                                                                                  color: AppColors
                                                                                      .appText1))),
                                                                      // SizedBox(height: 6,),

                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                              "\u{20B9}${double.parse(similarProductData[index].netPrice!).toStringAsFixed(0)} ",
                                                                              style: GoogleFonts.inriaSans(
                                                                                  textStyle: const TextStyle(
                                                                                      fontSize:
                                                                                      12,
                                                                                      fontWeight:
                                                                                      FontWeight.w700,
                                                                                      color: AppColors.black))),
                                                                          similarProductData[index].discount != "0"?Text(
                                                                              "\u{20B9}${double.parse(similarProductData[index].mrpPrice!).toStringAsFixed(0)} ",
                                                                              style: GoogleFonts.inriaSans(
                                                                                  textStyle: TextStyle(
                                                                                      fontSize:
                                                                                      12,
                                                                                      decoration:
                                                                                      TextDecoration.combine([
                                                                                        TextDecoration.lineThrough
                                                                                      ]),
                                                                                      fontWeight:
                                                                                      FontWeight.w700,
                                                                                      color: AppColors.appText1))):Container(),

                                                                        ],
                                                                      ),
                                                                      // SizedBox(height: 6,),
                                                                      similarProductData[index].discount != "0"?Text( similarProductData[index].discount != null ?
                                                                      similarProductData[index].discount! + "% OFF":"",
                                                                          style: GoogleFonts.inriaSans(
                                                                              textStyle: const TextStyle(
                                                                                  fontSize:
                                                                                  12,
                                                                                  fontWeight:
                                                                                  FontWeight.w700,
                                                                                  color: AppColors.off))):Container()
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              ),
                                              const SizedBox(
                                                height: 16,
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    } else {
                                      return Container(
                                        height: 200,
                                        // child: Center(child: CircularProgressIndicator(color: Style.Colors.appColor))
                                      );
                                    }
                                  })

                                  // viewSimilar(),
                                ],
                              )


                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              bottomNavigationBar: AddToCard(
                // product: args.product,
                wishList: productDetailData[0].wishList!,
                onChanged: () {
                  print("addToCard ${products!.productId!}");
                  if (profileController.customerId.value == "") {
                    // AlertDialogs.showLoginRequiredDialog();
                    showModalBottomSheet(
                      context: context,
                      // isDismissible:false,
                      isScrollControlled: true,
                      transitionAnimationController: controller,
                      builder: (BuildContext context) {

                        return LoginDialog(mobile: mobile,);

                      },
                    );
                  } else {
                    homecontroller.addToCard(products!.productId!, "1",profileController.customerId.value);
                  }
                },

                addToWishList: () async {


                  print("addToWishList ${products!.productId!}");
                  if (profileController.customerId.value == "") {
                    // AlertDialogs.showLoginRequiredDialog();
                    showModalBottomSheet(
                      context: context,
                      // isDismissible:false,
                      isScrollControlled: true,
                      transitionAnimationController: controller,
                      builder: (BuildContext context) {

                        return LoginDialog(mobile: mobile,);

                      },
                    );
                  } else {
                    if( productDetailData[0].wishList == true ) {
                      Get.toNamed(Routes.wishList);
                    }else {
                      await homecontroller.addToWishList(products!.productId!,
                          profileController.customerId.value);
                      productDetailsController!.productDetails(
                          products!.productId!, products!.variantCode!, false,
                          homecontroller.customerId.value);
                    }
                  }



                },
              ),
            ),
          );
        }
      } else {
        if (productDetailsController!.isRefresh.value != true) {

          return Scaffold(
            backgroundColor: Colors.grey[200],
            body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: const Center(
                    child: const CircularProgressIndicator(
                        color: AppColors.appColor))),
            bottomNavigationBar: AddToCard(
              // product: args.product,
              wishList: wishList,
              onChanged: () {
                print("addToCard ${products!.productId!}");
                if (profileController.customerId.value == "") {
                  showModalBottomSheet(
                    context: context,
                    // isDismissible:false,
                    isScrollControlled: true,
                    transitionAnimationController: controller,
                    builder: (BuildContext context) {

                      return LoginDialog(mobile: mobile,);

                    },
                  );
                } else {
                  homecontroller.addToCard(products!.productId!, "1",profileController.customerId.value);
                }
              },

              addToWishList: (){

                print("addToWishList ${products!.productId!}");
                if (profileController.customerId.value == "") {
                  showModalBottomSheet(
                    context: context,
                    // isDismissible:false,
                    isScrollControlled: true,
                    transitionAnimationController: controller,
                    builder: (BuildContext context) {

                      return LoginDialog(mobile: mobile,);

                    },
                  );
                } else {
                  homecontroller.addToWishList(products!.productId!,profileController.customerId.value);
                }
              },
            ),

          );
        } else {

          return Scaffold(
            backgroundColor: Colors.grey[200],
            body: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,

            ),
            bottomNavigationBar: AddToCard(
              // product: args.product,
              wishList: wishList,
              onChanged: () {
                print("addToCard ${products!.productId!}");
                if (profileController.customerId.value == "") {
                  showModalBottomSheet(
                    context: context,
                    // isDismissible:false,
                    isScrollControlled: true,
                    transitionAnimationController: controller,
                    builder: (BuildContext context) {

                      return LoginDialog(mobile: mobile,);

                    },
                  );
                } else {
                  homecontroller.addToCard(products!.productId!, "1",profileController.customerId.value);
                }
              },

              addToWishList: (){

                print("addToWishList ${products!.productId!}");
                if (profileController.customerId.value == "") {
                  showModalBottomSheet(
                    context: context,
                    // isDismissible:false,
                    isScrollControlled: true,
                    transitionAnimationController: controller,
                    builder: (BuildContext context) {

                      return LoginDialog(mobile: mobile,);

                    },
                  );
                } else {
                  homecontroller.addToWishList(products!.productId!,profileController.customerId.value);
                }
              },
            ),

          );
        }
      }

    });



  }

  iconContainer(String iconPath,index) {
    return InkWell(
      onTap: (){
        if(index == "1"){
          Get.back(result: true);
        }else if(index == "2") {
          Get.toNamed(Routes.searchScreen);
        }else if(index == "3") {
          Get.toNamed(Routes.wishList);
        }else if(index == "4") {
          Get.toNamed(Routes.notification);
        } else{

          if (profileController.customerId.value == "") {
            showModalBottomSheet(
              context: context,
              // isDismissible:false,
              isScrollControlled: true,
              transitionAnimationController: controller,
              builder: (BuildContext context) {
                return LoginDialog(mobile: mobile,);
              },
            );
          } else {
            Get.toNamed(Routes.cart);
          }
        }
      },
      child: Padding(
        padding: index == "1"
            ? const EdgeInsets.only(left: 0.0)
            : const EdgeInsets.only(left: 6.0),
        child: Container(
          child: Padding(
            padding: index == "1" ?const EdgeInsets.all(10.0):const EdgeInsets.all(9.0),
            child: Image.asset(
              iconPath,
              fit: BoxFit.fill,height: index == "1" ?14:16,width: 16,
            ),
          ),
          // height: 32,
          // width: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.toggleBg,
            // borderRadius: const BorderRadius.all(Radius.circular(100)),
          ),
        ),
      ),
    );
  }

  viewSimilar() {


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
