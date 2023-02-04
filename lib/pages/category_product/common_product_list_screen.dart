import 'package:eshoperapp/config/theme.dart';
import 'package:eshoperapp/models/categories.dart';
import 'package:eshoperapp/models/category.dart';
import 'package:eshoperapp/models/product.dart';
import 'package:eshoperapp/utils/check_internet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/app_costants.dart';
import '../../models/common_product.dart';
import '../../models/main_response.dart';
import '../../models/products.dart';
import '../../routes/navigation.dart';
import '../../widgets/app_bar.dart';
import '../details/prodcut_details_screen.dart';
import '../landing_home/home_controller.dart';
import 'category_product_controller.dart';
import 'common_product_list_controller.dart';
import 'filter_screen.dart';

class CommonProductListScreen extends StatefulWidget {
  final String? id;
  final String? offerId;
  final String? apiType;
  final String? title;
  final String? chooseType;
  const CommonProductListScreen({Key? key, required this.id,required this.offerId, required this.apiType, required this.title, required this.chooseType})
      : super(key: key);

  @override
  State<CommonProductListScreen> createState() => _CommonProductListScreenState();
}

class _CommonProductListScreenState extends State<CommonProductListScreen> {
  CommonProductListController? commonProductListController;
  final homecontroller = Get.put(HomeController(
      localRepositoryInterface: Get.find(),
      apiRepositoryInterface: Get.find()));

  @override
  void initState() {
    // TODO: implement initState
    // dynamic argumentData = Get.arguments;
    // categories = argumentData[0]['categoryObj'];

    // dynamic argumentData = Get.arguments;
    // print("categoryObj categoryId ${categories!.categoryId}");
    print("widget.id!   ====> ${widget.id!}");
    print("widget.chooseType!)   ====> ${widget.chooseType!}");
    print("widget.apiType!   ====> ${widget.apiType!}");
    commonProductListController = Get.put(CommonProductListController(
        apiRepositoryInterface: Get.find(),
        localRepositoryInterface: Get.find()));
    // initData(categoryProductController!,categories!);
    // print("apiType ======== $apiType");
    // print("id ======== $id");
    // print("chooseType ======== $chooseType");
    CheckInternet.checkInternet();
    commonProductListController!.genderValue("");
    commonProductListController!.sortValue("");
    commonProductListController!.filterValue("");
    commonProductListController!.getFilterLoaded = [];
    commonProductListController!.finalData = [];
    if(widget.apiType! == "ProductByAttributeAndCategory"){
      commonProductListController!.getProductByAttributeAndCategory(widget.id!,widget.chooseType!,homecontroller.customerId.value);
    }else if(widget.apiType! == "brandProduct"){
      if(widget.chooseType! == "All Brands"){
        commonProductListController!.brandProduct(widget.id!,homecontroller.customerId.value,"");
      }else{
        commonProductListController!.brandProduct(widget.id!,homecontroller.customerId.value,widget.chooseType!);
      }

    } else if(widget.apiType! == "categoryProduct"){
      commonProductListController!.categoryProduct(widget.id!,homecontroller.customerId.value);
    } else if(widget.apiType! == "getCategoryProductWithOffers"){
      print("widget.offerId!   ====> ${widget.offerId!}");
      commonProductListController!.getCategoryProductWithOffers(widget.offerId,widget.id!,homecontroller.customerId.value);
    }else if(widget.apiType! == "searchBykeywords"){
      commonProductListController!.searchBykeywords(widget.title,homecontroller.customerId.value,widget.chooseType!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    // final CategoryArguments args =
    //     ModalRoute.of(context)!.settings.arguments as CategoryArguments;

    return WillPopScope(
      onWillPop: () async{
        Get.back(result: true);
        return true;
      },
      child: Scaffold(
          body: SafeArea(
                child: Column(

                  children: [
                Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: (){
                            Get.back(result: true);
                          },
                           child: Padding(
                             padding: const EdgeInsets.only(right: 8.0,left: 16,top: 20,bottom: 5),
                             child: Image.asset('assets/img/arrow_left.png',fit: BoxFit.fill,height: 15,width: 18,),
                           ),
                         ),
                        // SizedBox(width:  8,),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0,bottom: 5),
                          child: Text(widget.title!,
                              style: GoogleFonts.inriaSans(
                                  textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.black))),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0,bottom: 5,right: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          InkWell(child: Image.asset('assets/img/search.png',fit: BoxFit.fill,height: 20,width: 20,),
                            onTap: (){
                              Get.toNamed(Routes.searchScreen);
                            },),
                          SizedBox(width: 18.0,),
                          InkWell(child: Image.asset('assets/img/heart.png',fit: BoxFit.fill,height: 20,width: 20,),
                            onTap: (){
                              Get.toNamed(Routes.wishList);
                            },),
                          SizedBox(width: 18.0,),
                          InkWell(child: Image.asset('assets/img/Notification.png',fit: BoxFit.fill,height: 20,width: 18,),
                            onTap: (){
                              Get.toNamed(Routes.notification);
                            },
                          )
                        ],),
                    )
                  ],
                ),
        Container(height: 0.5,width: MediaQuery.of(context).size.width,color: AppColors.tileLine,),
        ],),
                    Expanded(
                      child: RefreshIndicator(
                          onRefresh: () {
                            return CheckInternet.checkInternet();
                            // return categoryProductController!.categoryProduct(categories!.categoryId!);
                          },
                          child:

                          // SingleChildScrollView(
                          //   child:
                          //   Padding(
                          //     padding: const EdgeInsets.only(
                          //         top: 16.0, left: 10.0, right: 10.0, bottom: 10),
                          //     child: Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         Container(
                          //           // padding: const EdgeInsets.only(top: 18,left: 18,right: 18,bottom: 16),
                          //           // height: 400,
                          //           child: GridView.builder(
                          //             physics: const NeverScrollableScrollPhysics(),
                          //             shrinkWrap: true,
                          //             itemCount:
                          //             commonProductListController!.productGrid.length,
                          //             gridDelegate:
                          //                 SliverGridDelegateWithFixedCrossAxisCount(
                          //                     // crossAxisCount: 2,
                          //                     crossAxisSpacing: 2,
                          //                     mainAxisSpacing: 0,
                          //                     childAspectRatio: 0.7,
                          //                     crossAxisCount:
                          //                         (orientation == Orientation.portrait)
                          //                             ? 2
                          //                             : 2),
                          //             itemBuilder: (BuildContext context, int index) {
                          //               return InkWell(
                          //                 onTap: (){
                          //                   Navigator.push(
                          //                       context,
                          //                       MaterialPageRoute(
                          //                           builder: (context) =>  ProductDetailsScreen(
                          //                             products: Products(productId: "10",productName: "productName!"),
                          //                             // article: articles[index],
                          //                           )));
                          //                 },
                          //                 child: Column(
                          //                   children: [
                          //                     Image.asset(
                          //                       categoryProductController!
                          //                           .productGrid[index].coverImage!,
                          //                       fit: BoxFit.fill,
                          //                       width: double.infinity,
                          //                     ),
                          //                     // const SizedBox(
                          //                     //   height: 2,
                          //                     // ),
                          //                     Padding(
                          //                       padding: const EdgeInsets.only(top: 3.0,left: 4,right: 4),
                          //                       child: Column(
                          //                         crossAxisAlignment:
                          //                             CrossAxisAlignment.start,
                          //                         children: [
                          //                           Row(
                          //                             mainAxisAlignment:
                          //                                 MainAxisAlignment.spaceBetween,
                          //                             children: [
                          //                               Expanded(
                          //                                 child: Text(
                          //                                     categoryProductController!
                          //                                         .productGrid[index]
                          //                                         .productName!,
                          //                                     maxLines: 1,
                          //                                     //  style: GoogleFonts.ptSans(),
                          //                                     overflow:
                          //                                         TextOverflow.ellipsis,
                          //                                     style: GoogleFonts.hanuman(
                          //                                         textStyle:
                          //                                             const TextStyle(
                          //                                                 fontSize: 14,
                          //                                                 fontWeight:
                          //                                                     FontWeight
                          //                                                         .w400,
                          //                                                 color: AppColors
                          //                                                     .black))),
                          //                               ),
                          //                               Image.asset(
                          //                                 "assets/img/heart.png",
                          //                                 fit: BoxFit.fill,
                          //                                 height: 16,
                          //                                 width: 16,
                          //                               )
                          //                             ],
                          //                           ),
                          //                           Text(
                          //                               categoryProductController!
                          //                                   .productGrid[index]
                          //                                   .shortDescription!,
                          //                               maxLines: 1,
                          //                               //  style: GoogleFonts.ptSans(),
                          //                               overflow: TextOverflow.ellipsis,
                          //                               style: GoogleFonts.hanuman(
                          //                                   textStyle: const TextStyle(
                          //                                       fontSize: 10,
                          //                                       fontWeight: FontWeight.w400,
                          //                                       color:
                          //                                           AppColors.appText1))),
                          //                           Row(
                          //                             children: [
                          //                               Text(
                          //                                   "\u{20B9}${double.parse(categoryProductController!.productGrid[index].netPrice!).toStringAsFixed(0)} ",
                          //                                   style: GoogleFonts.hanuman(
                          //                                       textStyle: const TextStyle(
                          //                                           fontSize: 12,
                          //                                           fontWeight:
                          //                                               FontWeight.w400,
                          //                                           color:
                          //                                               AppColors.black))),
                          //                               Text(
                          //                                   "\u{20B9}${double.parse(categoryProductController!.productGrid[index].mrpPrice!).toStringAsFixed(0)} ",
                          //                                   style: GoogleFonts.hanuman(
                          //                                       textStyle: TextStyle(
                          //                                           fontSize: 12,
                          //                                           decoration:
                          //                                               TextDecoration
                          //                                                   .combine([
                          //                                             TextDecoration
                          //                                                 .lineThrough
                          //                                           ]),
                          //                                           fontWeight:
                          //                                               FontWeight.w400,
                          //                                           color: AppColors
                          //                                               .appText1))),
                          //                               Text(
                          //                                   "${categoryProductController!.productGrid[index].discount!}",
                          //                                   style: GoogleFonts.hanuman(
                          //                                       textStyle: const TextStyle(
                          //                                           fontSize: 12,
                          //                                           fontWeight:
                          //                                               FontWeight.w400,
                          //                                           color: AppColors.off)))
                          //                             ],
                          //                           )
                          //                         ],
                          //                       ),
                          //                     ),
                          //                 ],
                          //                 ),
                          //               );
                          //             },
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // )





                          Obx(() {
                            if (commonProductListController!.isLoadingCommonProduct.value !=
                                true) {
                              MainResponse? mainResponse =
                                  commonProductListController!.commonProductObj.value;
                              List<CommonProduct>? commonProductData = [];
                              // print(
                              //     "bestSellerProductObj.data! ${mainResponse.data!}");
                              if (mainResponse.data != null) {
                                mainResponse.data!.forEach((v) {
                                  commonProductData.add(CommonProduct.fromJson(v));
                                });
                              }
                              // mainResponse.data!.map((e) => customerProfileData!.add(UpdateCustomerPasswordData.fromJson(e))).toList();

                              String? imageUrl = mainResponse.imageUrl ?? "";
                              String? message = mainResponse.message ?? "";
                              if (commonProductData.isEmpty) {
                                return SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            message,
                                            style: const TextStyle(
                                                color: Colors.black45),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              } else {

                                return   SingleChildScrollView(
                                  child:
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16.0, left: 10.0, right: 10.0, bottom: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // padding: const EdgeInsets.only(top: 18,left: 18,right: 18,bottom: 16),
                                          // height: 400,
                                          child:
                                          GridView.builder(
                                            physics: const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount:
                                            commonProductData.length,
                                            gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                              // crossAxisCount: 2,
                                                crossAxisSpacing: 2,
                                                mainAxisSpacing: 0,
                                                // childAspectRatio: 0.7,
                                                mainAxisExtent: 250,
                                                crossAxisCount:
                                                (orientation == Orientation.portrait)
                                                    ? 2
                                                    : 2),
                                            itemBuilder: (BuildContext context, int index) {
                                              return InkWell(
                                                onTap: () async {


                                               final result = await   Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>


                                                              ProductDetailsScreen(
                                                            products: Products(productId:commonProductData[index]
                                                                .productId!,productName: commonProductData[index]
                                                                .productName!,variantCode: commonProductData[index]
                                                                .variantCode ?? ""),
                                                            // article: articles[index],
                                                          )

                                                      )

                                                  );


                                               if(result != null){
                                                 if(widget.apiType! == "ProductByAttributeAndCategory"){

                                                   if(commonProductListController!.filterValue.value == "" && commonProductListController!.sortValue.value == "" && commonProductListController!.genderValue.value == ""){
                                                     commonProductListController!.getProductByAttributeAndCategory(widget.id!,widget.chooseType!,homecontroller.customerId.value);
                                                   }else{
                                                          commonProductListController!.productSortByWithFilter(
                                                         "",
                                                         commonProductListController!.sortValue.value,
                                                         commonProductListController!.finalData,
                                                         homecontroller.customerId.value,
                                                         commonProductListController!.genderValue.value,
                                                         widget.chooseType,
                                                         "",
                                                         commonProductListController!.lowerValue.toStringAsFixed(0),
                                                         commonProductListController!.upperValue.toStringAsFixed(0)
                                                     );
                                                   }
                                                 }else if(widget.apiType! == "brandProduct"){

                                                   if(commonProductListController!.filterValue.value == "" && commonProductListController!.sortValue.value == "" && commonProductListController!.genderValue.value == ""){
                                                     // commonProductListController!.brandProduct(widget.id!,homecontroller.customerId.value, widget.chooseType);

                                                     if(widget.chooseType! == "All Brands"){
                                                       commonProductListController!.brandProduct(widget.id!,homecontroller.customerId.value,"");
                                                     }else{
                                                       commonProductListController!.brandProduct(widget.id!,homecontroller.customerId.value,widget.chooseType!);
                                                     }
                                                   }else{

                                                     if(widget.chooseType! == "All Brands"){
                                                       commonProductListController!.productSortByWithFilter(
                                                           "",
                                                           commonProductListController!.sortValue.value,
                                                           commonProductListController!.finalData,
                                                           homecontroller.customerId.value,
                                                           commonProductListController!.genderValue.value,
                                                           "",
                                                           "",
                                                           commonProductListController!.lowerValue.toStringAsFixed(0),
                                                           commonProductListController!.upperValue.toStringAsFixed(0)
                                                       );
                                                     }else{
                                                       commonProductListController!.productSortByWithFilter(
                                                           "",
                                                           commonProductListController!.sortValue.value,
                                                           commonProductListController!.finalData,
                                                           homecontroller.customerId.value,
                                                           commonProductListController!.genderValue.value,
                                                           widget.chooseType,
                                                           "",
                                                           commonProductListController!.lowerValue.toStringAsFixed(0),
                                                           commonProductListController!.upperValue.toStringAsFixed(0)
                                                       );
                                                     }

                                                   }
                                                 } else if(widget.apiType! == "categoryProduct"){
                                                   if(commonProductListController!.filterValue.value == "" && commonProductListController!.sortValue.value == "" && commonProductListController!.genderValue.value == ""){
                                                     print("widget.offerId!   ====> ${widget.offerId!}");
                                                     commonProductListController!.categoryProduct(widget.id!,homecontroller.customerId.value);
                                                   }else{
                                                     commonProductListController!.productSortByWithFilter(
                                                         widget.id,
                                                         commonProductListController!.sortValue.value,
                                                         commonProductListController!.finalData,
                                                         homecontroller.customerId.value,
                                                         commonProductListController!.genderValue.value,
                                                         widget.chooseType,
                                                         "",
                                                         commonProductListController!.lowerValue.toStringAsFixed(0),
                                                         commonProductListController!.upperValue.toStringAsFixed(0)
                                                     );
                                                   }
                                                 } else if(widget.apiType! == "getCategoryProductWithOffers"){


                                                   if(commonProductListController!.filterValue.value == "" && commonProductListController!.sortValue.value == "" && commonProductListController!.genderValue.value == ""){
                                                     commonProductListController!.getCategoryProductWithOffers(widget.offerId,widget.id!,homecontroller.customerId.value);
                                                   }else{
                                                     commonProductListController!.productSortByWithFilter(
                                                         widget.id,
                                                         commonProductListController!.sortValue.value,
                                                         commonProductListController!.finalData,
                                                         homecontroller.customerId.value,
                                                         commonProductListController!.genderValue.value,
                                                         widget.chooseType,
                                                         "",
                                                         commonProductListController!.lowerValue.toStringAsFixed(0),
                                                         commonProductListController!.upperValue.toStringAsFixed(0)
                                                     );
                                                   }

                                                 }else if(widget.apiType! == "searchBykeywords"){

                                                   if(commonProductListController!.filterValue.value == "" && commonProductListController!.sortValue.value == "" && commonProductListController!.genderValue.value == ""){
                                                     commonProductListController!.searchBykeywords(widget.title,homecontroller.customerId.value,widget.chooseType!);
                                                   }else{
                                                     commonProductListController!.productSortByWithFilter(
                                                         widget.id,
                                                         commonProductListController!.sortValue.value,
                                                         commonProductListController!.finalData,
                                                         homecontroller.customerId.value,
                                                         commonProductListController!.genderValue.value,
                                                         widget.chooseType,
                                                         widget.title,
                                                         commonProductListController!.lowerValue.toStringAsFixed(0),
                                                         commonProductListController!.upperValue.toStringAsFixed(0)
                                                     );
                                                   }
                                                 }
                                               }
                                                },
                                                child: Column(
                                                  children: [
                                                    Image.network(
                                                      imageUrl+"${commonProductData[index]
                                                          .productId!}/"+commonProductData[index].coverImg!,
                                                      fit: BoxFit.cover,
                                                      height: 170,
                                                      width: double.infinity,
                                                    ),
                                                    // const SizedBox(
                                                    //   height: 2,
                                                    // ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 3.0,left: 4,right: 4),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                    commonProductData[index]
                                                                        .brandName ?? "",
                                                                    maxLines: 1,
                                                                    //  style: GoogleFonts.ptSans(),
                                                                    overflow:
                                                                    TextOverflow.ellipsis,
                                                                    style: GoogleFonts.hanuman(
                                                                        textStyle:
                                                                        const TextStyle(
                                                                            fontSize: 14,
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                            color: AppColors
                                                                                .black))),
                                                              ),

                                                              commonProductData[index]
                                                                  .wishList == false?
                                                              Image.asset(
                                                                "assets/img/heart.png",
                                                                fit: BoxFit.fill,
                                                                height: 16,
                                                                width: 16,
                                                              ):Image.asset(
                                                                "assets/img/Heart_WishList.png",
                                                                fit: BoxFit.fill,
                                                                height: 16,
                                                                width: 16,
                                                              )
                                                            ],
                                                          ),
                                                          Text(
                                                              commonProductData[index]
                                                                  .productName!,
                                                              maxLines: 1,
                                                              //  style: GoogleFonts.ptSans(),
                                                              overflow: TextOverflow.ellipsis,
                                                              style: GoogleFonts.hanuman(
                                                                  textStyle: const TextStyle(
                                                                      fontSize: 10,
                                                                      fontWeight: FontWeight.w400,
                                                                      color:
                                                                      AppColors.appText1))),
                                                          commonProductData[index].discount != "0"?Row(
                                                            children: [
                                                              Text(
                                                                  "\u{20B9}${double.parse(commonProductData[index].netPrice!).toStringAsFixed(0)} ",
                                                                  style: GoogleFonts.hanuman(
                                                                      textStyle: const TextStyle(
                                                                          fontSize: 12,
                                                                          fontWeight:
                                                                          FontWeight.w700,
                                                                          color:
                                                                          AppColors.black))),
                                                              Text(
                                                                  "\u{20B9}${double.parse(commonProductData[index].mrpPrice!).toStringAsFixed(0)} ",
                                                                  style: GoogleFonts.hanuman(
                                                                      textStyle: TextStyle(
                                                                          fontSize: 12,
                                                                          decoration:
                                                                          TextDecoration
                                                                              .combine([
                                                                            TextDecoration
                                                                                .lineThrough
                                                                          ]),
                                                                          fontWeight:
                                                                          FontWeight.w700,
                                                                          color: AppColors
                                                                              .appText1))),
                                                              Text(
                                                                  commonProductData[index].discount!+"% OFF",
                                                                  style: GoogleFonts.hanuman(
                                                                      textStyle: const TextStyle(
                                                                          fontSize: 12,
                                                                          fontWeight:
                                                                          FontWeight.w700,
                                                                          color: AppColors.off)))
                                                            ],
                                                          ): Text(
                                                              "\u{20B9}${double.parse(commonProductData[index].netPrice!).toStringAsFixed(0)} ",
                                                              style: GoogleFonts.hanuman(
                                                                  textStyle: const TextStyle(
                                                                      fontSize: 12,
                                                                      fontWeight:
                                                                      FontWeight.w700,
                                                                      color:
                                                                      AppColors.black))),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                ;
                                // return Padding(
                                //   padding: const EdgeInsets.only(
                                //       left: 5.0, bottom: 3, right: 5.0),
                                //   child: PopulorProduct(
                                //     products: bestSellerProductsData,
                                //     imageUrl: imageUrl,
                                //   ),
                                // );
                              }
                            } else {
                              return Container(
                                height: 65,
                                // child: Center(child: CircularProgressIndicator(color: Style.Colors.appColor))
                              );
                            }
                          }),





                          ),
                    ),
                  ],
                ),
              ),
          bottomNavigationBar:
          widget.chooseType! == "Kids"?
          Obx(() {

            return Container(
              height: 55,
              width: MediaQuery.of(context).size.width,
              color: AppColors.white,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: InkWell(
                          onTap: () {
                            showModalBottomSheet(

                                context: context,
                                builder: (context) {
                                  return Wrap(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 16.0),
                                              child: Text("GENDER",
                                                  style: GoogleFonts.inriaSans(
                                                      textStyle: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w700,
                                                          color: AppColors.black))),
                                            ),
                                            Container(height: 1,width: MediaQuery.of(context).size.width,color: AppColors.line,),

                                           commonProductListController!.genderValue.value == "Boys"?
                                            Padding(
                                             padding: const EdgeInsets.only(top: 16.0,),
                                             child: Text("Boys",
                                                 style: GoogleFonts.inriaSans(
                                                     textStyle: const TextStyle(
                                                         fontSize: 14,
                                                         fontWeight: FontWeight.bold,
                                                         color: AppColors.black))),
                                           ):InkWell(

                                             child: Container(

                                               child: Padding(
                                                 padding: const EdgeInsets.only(top: 16.0,),
                                                 child: Text("Boys",
                                                     style: GoogleFonts.inriaSans(
                                                         textStyle: const TextStyle(
                                                             fontSize: 14,
                                                             fontWeight: FontWeight.w400,
                                                             color: AppColors.black))),
                                               ),
                                               width: MediaQuery.of(context).size.width,
                                             ),
                                             onTap: (){
                                               print("categoryId ${widget.id}");
                                               print("filter_option length ${commonProductListController!.finalData.length}");
                                               commonProductListController!.genderValue("Boys");
                                               if(widget.apiType! == "ProductByAttributeAndCategory"){
                                                 commonProductListController!.productSortByWithFilter(
                                                     "",
                                                     commonProductListController!.sortValue.value,
                                                     commonProductListController!.finalData,
                                                     homecontroller.customerId.value,
                                                     "Boys",
                                                     widget.chooseType,
                                                     "",
                                                     commonProductListController!.lowerValue.toStringAsFixed(0),
                                                     commonProductListController!.upperValue.toStringAsFixed(0));
                                               }else if(widget.apiType! == "brandProduct"){
                                                 commonProductListController!.productSortByWithFilter(
                                                    "",
                                                     commonProductListController!.sortValue.value,
                                                     commonProductListController!.finalData,
                                                     homecontroller.customerId.value,
                                                     "Boys",
                                                     widget.chooseType,
                                                     "",
                                                     commonProductListController!.lowerValue.toStringAsFixed(0),
                                                     commonProductListController!.upperValue.toStringAsFixed(0));
                                               } else if(widget.apiType! == "categoryProduct"){
                                                 commonProductListController!.productSortByWithFilter(
                                                     widget.id,
                                                     commonProductListController!.sortValue.value,
                                                     commonProductListController!.finalData,
                                                     homecontroller.customerId.value,
                                                     "Boys",
                                                     widget.chooseType,
                                                     "",
                                                     commonProductListController!.lowerValue.toStringAsFixed(0),
                                                     commonProductListController!.upperValue.toStringAsFixed(0));
                                               } else if(widget.apiType! == "getCategoryProductWithOffers"){
                                                 commonProductListController!.productSortByWithFilter(
                                                     widget.id,
                                                     commonProductListController!.sortValue.value,
                                                     commonProductListController!.finalData,
                                                     homecontroller.customerId.value,
                                                     "Boys",
                                                     widget.chooseType,
                                                     "",
                                                     commonProductListController!.lowerValue.toStringAsFixed(0),
                                                     commonProductListController!.upperValue.toStringAsFixed(0));
                                               }else if(widget.apiType! == "searchBykeywords"){
                                                 commonProductListController!.productSortByWithFilter(
                                                     "",
                                                     commonProductListController!.sortValue.value,
                                                     commonProductListController!.finalData,
                                                     homecontroller.customerId.value,
                                                     "Boys",
                                                     widget.chooseType,
                                                     widget.title,
                                                     commonProductListController!.lowerValue.toStringAsFixed(0),
                                                     commonProductListController!.upperValue.toStringAsFixed(0));
                                               }
                                               Get.back();
                                             },
                                           ),
                                            SizedBox(height: 24,),
                                            commonProductListController!.genderValue.value == "Girls"?
                                            Text("Girls",
                                                style: GoogleFonts.inriaSans(
                                                    textStyle: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.bold,
                                                        color: AppColors.black))):
                                            InkWell(
                                              onTap: (){
                                                print("categoryId ${widget.id}");
                                                print("filter_option length ${commonProductListController!.finalData.length}");
                                                commonProductListController!.genderValue("Girls");
                                                if(widget.apiType! == "ProductByAttributeAndCategory"){
                                                  commonProductListController!.productSortByWithFilter(
                                                      "",
                                                      commonProductListController!.sortValue.value,
                                                      commonProductListController!.finalData,
                                                      homecontroller.customerId.value,
                                                      "Girls",
                                                      widget.chooseType,
                                                      "",
                                                      commonProductListController!.lowerValue.toStringAsFixed(0),
                                                      commonProductListController!.upperValue.toStringAsFixed(0));
                                                }else if(widget.apiType! == "brandProduct"){
                                                  commonProductListController!.productSortByWithFilter(
                                                      "",
                                                      commonProductListController!.sortValue.value,
                                                      commonProductListController!.finalData,
                                                      homecontroller.customerId.value,
                                                      "Girls",
                                                      widget.chooseType,
                                                      "",
                                                      commonProductListController!.lowerValue.toStringAsFixed(0),
                                                      commonProductListController!.upperValue.toStringAsFixed(0));
                                                } else if(widget.apiType! == "categoryProduct"){
                                                  commonProductListController!.productSortByWithFilter(
                                                      widget.id,
                                                      commonProductListController!.sortValue.value,
                                                      commonProductListController!.finalData,
                                                      homecontroller.customerId.value,
                                                      "Girls",
                                                      widget.chooseType,
                                                      "",
                                                      commonProductListController!.lowerValue.toStringAsFixed(0),
                                                      commonProductListController!.upperValue.toStringAsFixed(0));
                                                } else if(widget.apiType! == "getCategoryProductWithOffers"){
                                                  commonProductListController!.productSortByWithFilter(
                                                      widget.id,
                                                      commonProductListController!.sortValue.value,
                                                      commonProductListController!.finalData,
                                                      homecontroller.customerId.value,
                                                      "Girls",
                                                      widget.chooseType,
                                                      "",
                                                      commonProductListController!.lowerValue.toStringAsFixed(0),
                                                      commonProductListController!.upperValue.toStringAsFixed(0));
                                                }else if(widget.apiType! == "searchBykeywords"){
                                                  commonProductListController!.productSortByWithFilter(
                                                      "",
                                                      commonProductListController!.sortValue.value,
                                                      commonProductListController!.finalData,
                                                      homecontroller.customerId.value,
                                                      "Girls",
                                                      widget.chooseType,
                                                      widget.title,
                                                      commonProductListController!.lowerValue.toStringAsFixed(0),
                                                      commonProductListController!.upperValue.toStringAsFixed(0));
                                                }
                                                Get.back();
                                              },
                                              child: Container(
                                                width: MediaQuery.of(context).size.width,
                                                child: Text("Girls",
                                                    style: GoogleFonts.inriaSans(
                                                        textStyle: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w400,
                                                            color: AppColors.black))),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("GENDER",
                                  style: GoogleFonts.inriaSans(
                                      textStyle: const TextStyle(
                                          fontSize: 16,

                                          color: AppColors.black))),
                              SizedBox(width: 5,),
                              commonProductListController!.genderValue.value == "" ?Container()
                                  :Container(
                                height: 10,width: 10,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.appColor
                                ),)
                            ],
                          )),
                    ),
                    Container(
                      height: 55,
                      width: 1,
                      color: AppColors.appText1,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Wrap(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 16.0),
                                            child: Text("SORT BY",
                                                style: GoogleFonts.inriaSans(
                                                    textStyle: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold,
                                                        color: AppColors.black))),
                                          ),
                                          Container(height: 1,width: MediaQuery.of(context).size.width,color: AppColors.line,),
                                          SizedBox(height: 16,),
                                          ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: commonProductListController!.sortList.length,
                                              itemBuilder: (BuildContext context, int index){
                                                return   commonProductListController!.sortValue.value == commonProductListController!.sortList[index]?
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 24.0),
                                                  child: Text(commonProductListController!.sortList[index],
                                                      style: GoogleFonts.inriaSans(
                                                          textStyle: const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.bold,
                                                              color: AppColors.black))),
                                                ):InkWell(
                                                  onTap: (){
                                                    print("categoryId ${widget.id}");
                                                    print("filter_option length ${commonProductListController!.finalData.length}");
                                                    commonProductListController!.sortValue(commonProductListController!.sortList[index]);
                                                   if(widget.apiType! == "ProductByAttributeAndCategory"){
                                                     commonProductListController!.productSortByWithFilter(
                                                         "",
                                                         commonProductListController!.sortList[index],
                                                         commonProductListController!.finalData,
                                                         homecontroller.customerId.value,
                                                         commonProductListController!.genderValue.value,
                                                         widget.chooseType,
                                                         "",
                                                         commonProductListController!.lowerValue.toStringAsFixed(0),
                                                         commonProductListController!.upperValue.toStringAsFixed(0));
                                                    }else if(widget.apiType! == "brandProduct"){
                                                     commonProductListController!.productSortByWithFilter(
                                                          "",
                                                         commonProductListController!.sortList[index],
                                                         commonProductListController!.finalData,
                                                         homecontroller.customerId.value,
                                                         commonProductListController!.genderValue.value,
                                                         widget.chooseType,
                                                         "",
                                                         commonProductListController!.lowerValue.toStringAsFixed(0),
                                                         commonProductListController!.upperValue.toStringAsFixed(0));
                                                    } else if(widget.apiType! == "categoryProduct"){
                                                      commonProductListController!.productSortByWithFilter(
                                                          widget.id,
                                                          commonProductListController!.sortList[index],
                                                          commonProductListController!.finalData,
                                                          homecontroller.customerId.value,
                                                          commonProductListController!.genderValue.value,
                                                          widget.chooseType,
                                                          "",
                                                          commonProductListController!.lowerValue.toStringAsFixed(0),
                                                          commonProductListController!.upperValue.toStringAsFixed(0));
                                                    } else if(widget.apiType! == "getCategoryProductWithOffers"){
                                                     commonProductListController!.productSortByWithFilter(
                                                         widget.id,
                                                         commonProductListController!.sortList[index],
                                                         commonProductListController!.finalData,
                                                         homecontroller.customerId.value,
                                                         commonProductListController!.genderValue.value,
                                                         widget.chooseType,
                                                         "",
                                                         commonProductListController!.lowerValue.toStringAsFixed(0),
                                                         commonProductListController!.upperValue.toStringAsFixed(0));
                                                    }else if(widget.apiType! == "searchBykeywords"){
                                                     commonProductListController!.productSortByWithFilter(
                                                         "",
                                                         commonProductListController!.sortList[index],
                                                         commonProductListController!.finalData,
                                                         homecontroller.customerId.value,
                                                         commonProductListController!.genderValue.value,
                                                         widget.chooseType,
                                                         widget.title,
                                                         commonProductListController!.lowerValue.toStringAsFixed(0),
                                                         commonProductListController!.upperValue.toStringAsFixed(0));
                                                    }
                                                    Get.back();
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(bottom: 24.0),
                                                    child: Text(commonProductListController!.sortList[index],
                                                        style: GoogleFonts.inriaSans(
                                                            textStyle: const TextStyle(
                                                                fontSize: 14,

                                                                color: AppColors.black))),
                                                  ),
                                                );
                                              })
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/img/sort.png',
                              fit: BoxFit.fill,
                              height: 20,
                              width: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("SORT",  style: GoogleFonts.inriaSans(
                                textStyle: const TextStyle(
                                    fontSize: 16,

                                    color: AppColors.black))),
                            SizedBox(width: 5,),
                            commonProductListController!.sortValue.value == "" ?Container()
                                :Container(
                              height: 10,width: 10,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.appColor
                              ),)
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 55,
                      width: 1,
                      color: AppColors.appText1,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {

                          print("widget.chooseType! ============> ${
                              widget.chooseType!
                          }");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FilterScreen(id: widget.id!,apiType: widget.apiType!,chooseType: widget.chooseType!,tag: widget.title!,

                              ),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/img/filter.png',
                              fit: BoxFit.fill,
                              height: 20,
                              width: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("FILTER",  style: GoogleFonts.inriaSans(
                                textStyle: const TextStyle(
                                    fontSize: 16,

                                    color: AppColors.black))),
                            SizedBox(
                              width: 5,
                            ),
                            commonProductListController!.filterValue.value == "" ?Container()
                                :Container(
                              height: 10,width: 10,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.appColor
                              ),)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          })
          : Obx(() {
            return  Container(
              height: 55,
              width: MediaQuery.of(context).size.width,
              color: AppColors.white,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {

                                return Wrap(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 16.0),
                                            child: Text("SORT BY",
                                                style: GoogleFonts.inriaSans(
                                                    textStyle: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold,
                                                        color: AppColors.black))),
                                          ),
                                          Container(height: 1,width: MediaQuery.of(context).size.width,color: AppColors.line,),
                                          SizedBox(height: 16,),
                                          ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: commonProductListController!.sortList.length,
                                              itemBuilder: (BuildContext context, int index){
                                                return   commonProductListController!.sortValue.value == commonProductListController!.sortList[index]?
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 24.0),
                                                  child: Text(commonProductListController!.sortList[index],
                                                      style: GoogleFonts.inriaSans(
                                                          textStyle: const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.bold,
                                                              color: AppColors.black))),
                                                ):InkWell(
                                                  onTap: (){
                                                    print("categoryId ${widget.id}");
                                                    print("filter_option length ${commonProductListController!.finalData.length}");
                                                    commonProductListController!.sortValue(commonProductListController!.sortList[index]);
                                                    if(widget.apiType! == "ProductByAttributeAndCategory"){
                                                      commonProductListController!.productSortByWithFilter(
                                                          "",
                                                          commonProductListController!.sortList[index],
                                                          commonProductListController!.finalData,
                                                          homecontroller.customerId.value,
                                                          commonProductListController!.genderValue.value,
                                                          widget.chooseType,
                                                          "",
                                                          commonProductListController!.lowerValue.toStringAsFixed(0),
                                                          commonProductListController!.upperValue.toStringAsFixed(0)
                                                      );
                                                    }else if(widget.apiType! == "brandProduct"){
                                                      commonProductListController!.productSortByWithFilter(
                                                          "",
                                                          commonProductListController!.sortList[index],
                                                          commonProductListController!.finalData,
                                                          homecontroller.customerId.value,
                                                          commonProductListController!.genderValue.value,
                                                          widget.chooseType,
                                                          "",
                                                          commonProductListController!.lowerValue.toStringAsFixed(0),
                                                          commonProductListController!.upperValue.toStringAsFixed(0)
                                                      );
                                                    } else if(widget.apiType! == "categoryProduct"){
                                                      commonProductListController!.productSortByWithFilter(
                                                          widget.id,
                                                          commonProductListController!.sortList[index],
                                                          commonProductListController!.finalData,
                                                          homecontroller.customerId.value,
                                                          commonProductListController!.genderValue.value,
                                                          widget.chooseType,
                                                          "",
                                                          commonProductListController!.lowerValue.toStringAsFixed(0),
                                                          commonProductListController!.upperValue.toStringAsFixed(0)
                                                      );
                                                    } else if(widget.apiType! == "getCategoryProductWithOffers"){
                                                      commonProductListController!.productSortByWithFilter(
                                                          widget.id,
                                                          commonProductListController!.sortList[index],
                                                          commonProductListController!.finalData,
                                                          homecontroller.customerId.value,
                                                          commonProductListController!.genderValue.value,
                                                          widget.chooseType,
                                                          "",
                                                          commonProductListController!.lowerValue.toStringAsFixed(0),
                                                          commonProductListController!.upperValue.toStringAsFixed(0)
                                                      );
                                                    }else if(widget.apiType! == "searchBykeywords"){
                                                      commonProductListController!.productSortByWithFilter(
                                                          "",
                                                          commonProductListController!.sortList[index],
                                                          commonProductListController!.finalData,
                                                          homecontroller.customerId.value,
                                                          commonProductListController!.genderValue.value,
                                                          widget.chooseType,
                                                          widget.title,
                                                          commonProductListController!.lowerValue.toStringAsFixed(0),
                                                          commonProductListController!.upperValue.toStringAsFixed(0)
                                                      );
                                                    }
                                                    Get.back();
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(bottom: 24.0),
                                                    child: Text(commonProductListController!.sortList[index],
                                                        style: GoogleFonts.inriaSans(
                                                            textStyle: const TextStyle(
                                                                fontSize: 14,

                                                                color: AppColors.black))),
                                                  ),
                                                );
                                              })
                                        ],
                                      ),
                                    ),
                                  ],
                                );

                              });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/img/sort.png',
                              fit: BoxFit.fill,
                              height: 20,
                              width: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("SORT",  style: GoogleFonts.inriaSans(
                                textStyle: const TextStyle(
                                    fontSize: 16,

                                    color: AppColors.black))
                            ),
                            SizedBox(width: 5,),
                            commonProductListController!.sortValue.value == "" ?Container()
                                :Container(
                              height: 10,width: 10,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.appColor
                              ),)
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 55,
                      width: 1,
                      color: AppColors.appText1,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          // Get.toNamed(Routes.filterScreen,arguments: [
                          //
                          // ]);
                          print("widget.chooseType! ============> ${
                              widget.chooseType!
                          }");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FilterScreen(id: widget.id!,apiType: widget.apiType!,chooseType: widget.chooseType!,tag: widget.title!

                              ),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/img/filter.png',
                              fit: BoxFit.fill,
                              height: 20,
                              width: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("FILTER",  style: GoogleFonts.inriaSans(
                                textStyle: const TextStyle(
                                    fontSize: 16,

                                    color: AppColors.black))),
                            SizedBox(width: 5,),
                            commonProductListController!.filterValue.value == "" ?Container()
                                :Container(
                              height: 10,width: 10,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.appColor
                              ),)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          })




      ),
    );
  }



}

class CategoryArguments {
  final String? categoryName;
  final List<Product>? product;
  List<Category>? category;

  CategoryArguments({this.categoryName, this.product, this.category});
}
