import 'package:eshoperapp/config/theme.dart';
import 'package:eshoperapp/models/categories.dart';
import 'package:eshoperapp/models/category.dart';
import 'package:eshoperapp/models/product.dart';
import 'package:eshoperapp/utils/check_internet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/products.dart';
import '../../routes/navigation.dart';
import '../../widgets/app_bar.dart';
import '../details/prodcut_details_screen.dart';
import 'category_product_controller.dart';

class CategoryProductScreen extends StatefulWidget {
  final Categories? category;

  final String? title;
  const CategoryProductScreen({Key? key, required this.category, required this.title})
      : super(key: key);

  @override
  State<CategoryProductScreen> createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen> {
  CategoryProductController? categoryProductController;
  Categories? categories;

  @override
  void initState() {
    // TODO: implement initState
    // dynamic argumentData = Get.arguments;
    // categories = argumentData[0]['categoryObj'];

    // dynamic argumentData = Get.arguments;
    categories = widget.category;
    // print("categoryObj categoryId ${categories!.categoryId}");
    categoryProductController = Get.put(CategoryProductController(
        apiRepositoryInterface: Get.find(),
        categoryId: "5",
        localRepositoryInterface: Get.find()));
    // initData(categoryProductController!,categories!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    // final CategoryArguments args =
    //     ModalRoute.of(context)!.settings.arguments as CategoryArguments;

    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   title: Image.asset(
        //     'assets/logos/app_logo.png',
        //     fit: BoxFit.fill,
        //     height: 70,
        //     width: 100,
        //   ),
        //   elevation: 1,
        //   actions: [
        //     IconButton(
        //         padding: EdgeInsets.zero,
        //         onPressed: () {},
        //         icon: Image.asset(
        //           'assets/img/search.png',
        //           fit: BoxFit.fill,
        //           height: 22,
        //           width: 22,
        //         )),
        //     IconButton(
        //         padding: EdgeInsets.zero,
        //         onPressed: () {},
        //         icon: Image.asset(
        //           'assets/img/heart.png',
        //           fit: BoxFit.fill,
        //           height: 22,
        //           width: 22,
        //         )),
        //     IconButton(
        //         padding: EdgeInsets.zero,
        //         onPressed: () {},
        //         icon: Image.asset(
        //           'assets/img/notification.png',
        //           fit: BoxFit.fill,
        //           height: 22,
        //           width: 22,
        //         )),
        //   ],
        // ),
        body: //CustonScrollView

            SafeArea(
              child: Column(

                children: [
              Column(children: [
              Padding(
              padding: widget.title == "ALL BRANDS"?const EdgeInsets.only(left: AppSizes.sidePadding,right: AppSizes.sidePadding,bottom: 5,top: 20):const EdgeInsets.only(left: AppSizes.sidePadding,right: AppSizes.sidePadding,bottom: 5,top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                       InkWell(child: Image.asset('assets/img/arrow_left.png',fit: BoxFit.fill,height: 15,width: 18,),
                        onTap: (){
                          Get.back();
                        },),
                      // SizedBox(width:  8,),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text("SHIRTS",
                                style: GoogleFonts.inriaSans(
                                    textStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.black))),
                          ),
                          widget.title != "ALL BRANDS"?
                          Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text("10 products",
                                  style: GoogleFonts.inriaSans(
                                      textStyle: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.appText)))):Container(),
                        ],
                      ),
                    ],
                  ),
                  Row(
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
                    ],)
                ],
              ),
            ),
      Container(height: 0.5,width: MediaQuery.of(context).size.width,color: AppColors.tileLine,),
      ],),
                  Expanded(
                    child: RefreshIndicator(
                        onRefresh: () {
                          return CheckInternet.checkInternet();
                          // return categoryProductController!.categoryProduct(categories!.categoryId!);
                        },
                        child: SingleChildScrollView(
                          child:
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, left: 10.0, right: 10.0, bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                // Padding(
                                //   padding: const EdgeInsets.only(left: 5.0),
                                //   child: Text("SHIRTS",
                                //       style: GoogleFonts.inriaSans(
                                //           textStyle: const TextStyle(
                                //               fontSize: 20,
                                //               fontWeight: FontWeight.w700,
                                //               color: AppColors.black))),
                                // ),
                                // Padding(
                                //     padding: const EdgeInsets.only(left: 5.0),
                                //     child: Text("10 products",
                                //         style: GoogleFonts.inriaSans(
                                //             textStyle: const TextStyle(
                                //                 fontSize: 12,
                                //                 fontWeight: FontWeight.w400,
                                //                 color: AppColors.appText)))),
                                // SizedBox(
                                //   height: 15.0,
                                // ),
                                Container(
                                  // padding: const EdgeInsets.only(top: 18,left: 18,right: 18,bottom: 16),
                                  // height: 400,
                                  child: GridView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        categoryProductController!.productGrid.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            // crossAxisCount: 2,
                                            crossAxisSpacing: 2,
                                            mainAxisSpacing: 0,
                                            childAspectRatio: 0.7,
                                            crossAxisCount:
                                                (orientation == Orientation.portrait)
                                                    ? 2
                                                    : 2),
                                    itemBuilder: (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>  ProductDetailsScreen(
                                                    products: Products(productId: categoryProductController!.productGrid[index].productId,productName: categoryProductController!.productGrid[index].productId,variantCode: categoryProductController!.productGrid[index].variantCode),
                                                    // article: articles[index],
                                                  )));
                                        },
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              categoryProductController!
                                                  .productGrid[index].coverImage!,
                                              fit: BoxFit.fill,
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
                                                            categoryProductController!
                                                                .productGrid[index]
                                                                .productName!,
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
                                                      Image.asset(
                                                        "assets/img/heart.png",
                                                        fit: BoxFit.fill,
                                                        height: 16,
                                                        width: 16,
                                                      )
                                                    ],
                                                  ),
                                                  Text(
                                                      categoryProductController!
                                                          .productGrid[index]
                                                          .shortDescription!,
                                                      maxLines: 1,
                                                      //  style: GoogleFonts.ptSans(),
                                                      overflow: TextOverflow.ellipsis,
                                                      style: GoogleFonts.hanuman(
                                                          textStyle: const TextStyle(
                                                              fontSize: 10,
                                                              fontWeight: FontWeight.w400,
                                                              color:
                                                                  AppColors.appText1))),
                                                  Row(
                                                    children: [
                                                      Text(
                                                          "\u{20B9}${double.parse(categoryProductController!.productGrid[index].netPrice!).toStringAsFixed(0)} ",
                                                          style: GoogleFonts.hanuman(
                                                              textStyle: const TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight.w400,
                                                                  color:
                                                                      AppColors.black))),
                                                      Text(
                                                          "\u{20B9}${double.parse(categoryProductController!.productGrid[index].mrpPrice!).toStringAsFixed(0)} ",
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
                                                                      FontWeight.w400,
                                                                  color: AppColors
                                                                      .appText1))),
                                                      Text(
                                                          "${categoryProductController!.productGrid[index].discount!}",
                                                          style: GoogleFonts.hanuman(
                                                              textStyle: const TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight.w400,
                                                                  color: AppColors.off)))
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            //Text(categoryProductController!.productGrid[index].productName!,style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 13,fontWeight: FontWeight.w400,color: AppColors.appText)))
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

                        // Obx(() {
                        //   if (categoryProductController!.isLoadingCategoryProduct.value != true) {
                        //     CategoryProduct? categoryProduct = categoryProductController!.categoryProductObj.value;
                        //     List<Products>? categoryProductData = [];
                        //     if(categoryProduct.productData != null){
                        //       categoryProduct.productData!.forEach((v) {
                        //         categoryProductData.add( Products.fromJson(v));
                        //       });
                        //     }
                        //
                        //     List<Categories>? categoryData = [];
                        //     if(categoryProduct.categoryData != null){
                        //       categoryProduct.categoryData!.forEach((v) {
                        //         categoryData.add( Categories.fromJson(v));
                        //       });
                        //     }
                        //     // mainResponse.data!.map((e) => customerProfileData!.add(UpdateCustomerPasswordData.fromJson(e))).toList();
                        //
                        //
                        //     String? imageUrl = categoryProduct.imageUrl ?? "";
                        //     String? message = categoryProduct.message ?? AppConstants.noInternetConn;
                        //     if (categoryProductData.isEmpty && categoryData.isEmpty) {
                        //       return Container(
                        //         width: MediaQuery.of(context).size.width,
                        //         height: MediaQuery.of(context).size.height,
                        //         child: ListView(
                        //           // physics: NeverScrollableScrollPhysics(),
                        //           shrinkWrap: true,
                        //           children: [
                        //             Container(
                        //               width: MediaQuery.of(context).size.width,
                        //               height: MediaQuery.of(context).size.height-100,
                        //               //height: MediaQuery.of(context).size.height,
                        //               alignment: Alignment.center,
                        //               child: Center(
                        //                 child: Text(
                        //                   message!,
                        //                   style: TextStyle(color: Colors.black45),
                        //                 ),
                        //               ),
                        //             ),
                        //
                        //           ],
                        //         ),
                        //       );
                        //     }else{
                        //
                        //       if(categoryProductData.isNotEmpty){
                        //         return ListView(
                        //           children: [
                        //             Padding(
                        //               padding: const EdgeInsets.all(5.0),
                        //               child: ProductGridviewTile(
                        //                 products: categoryProductData,
                        //                 imageUrl: imageUrl,
                        //                 brandProductPage: true,
                        //               ),
                        //             ),
                        //           ],
                        //         );
                        //       }else  if(categoryData.isNotEmpty){
                        //
                        //         return  Padding(
                        //           padding: const EdgeInsets.all(8.0),
                        //           child: GridView.builder(
                        //               gridDelegate:
                        //               const SliverGridDelegateWithFixedCrossAxisCount(
                        //                 // maxCrossAxisExtent: 200,
                        //                 // childAspectRatio: 3 / 2,
                        //                   crossAxisCount: 3,
                        //                   crossAxisSpacing: 0,
                        //                   mainAxisSpacing: 0),
                        //               itemCount: categoryData.length,
                        //               itemBuilder: (BuildContext ctx, index) {
                        //                 return Card(
                        //                   elevation: 5,
                        //                   child: InkWell(
                        //                     onTap: () {
                        //                       print("onTap");
                        //                       // Get.toNamed(Routes.categoryProduct, arguments: [
                        //                       //   {"categoryObj": categoryData[index]}
                        //                       // ], preventDuplicates: false);
                        //                       Navigator.pushReplacement(
                        //                         context,
                        //                         MaterialPageRoute(
                        //                           builder: (context) => CategoryProductScreen(
                        //                             category: categoryData[index],
                        //                           ),
                        //                         ),
                        //
                        //                       );
                        //                       // controller.loadCategoryProducts(
                        //                       //     getCategoryData[index].title);
                        //                       // navigator!.pushNamed(Routes.categoryProduct,
                        //                       //     arguments: CategoryArguments(
                        //                       //         categoryName: getCategoryData[index].categoryName,
                        //                       //         product: controller.categoryProducts,
                        //                       //         category: getCategoryData[index].children));
                        //                     },
                        //                     child: Padding(
                        //                       padding: const EdgeInsets.all(10.0),
                        //                       child: Stack(
                        //                         children: [
                        //                           categoryData[index].categoryImage == ""
                        //                               ? Padding(
                        //                             padding: const EdgeInsets.only(
                        //                                 bottom: 10.0),
                        //                             child: Container(
                        //                                 height: 200,
                        //                                 width: 200,
                        //                                 decoration: BoxDecoration(
                        //                                   //  border: Border.all(color: Colors.white,width: 2)
                        //                                   borderRadius:
                        //                                   BorderRadius.circular(15),
                        //                                   // color: Colors.grey,
                        //                                 ),
                        //                                 child: Image.asset(
                        //                                   "assets/img/placeholder.jpg",
                        //                                   fit: BoxFit.fill,
                        //                                 )),
                        //                           )
                        //                               : Padding(
                        //                             padding: const EdgeInsets.only(
                        //                                 bottom: 10.0),
                        //                             child: Container(
                        //                                 height: 200,
                        //                                 width: 200,
                        //                                 decoration: BoxDecoration(
                        //                                   //  border: Border.all(color: Colors.white,width: 2)
                        //                                   borderRadius:
                        //                                   BorderRadius.circular(15),
                        //                                   // color: Colors.grey,
                        //                                 ),
                        //                                 child: Image.network(
                        //                                   imageUrl +
                        //                                       categoryData[index]
                        //                                           .categoryImage
                        //                                           .toString(),
                        //                                   fit: BoxFit.contain,
                        //                                 )),
                        //                           ),
                        //                           Padding(
                        //                             padding:
                        //                             const EdgeInsets.only(bottom: 10.0),
                        //                             child: Container(
                        //                               height: 200,
                        //                               width: 200,
                        //                               decoration: BoxDecoration(
                        //                                 // color: Colors.black26,
                        //                                 //  border: Border.all(color: Colors.white,width: 2)
                        //                                 borderRadius: BorderRadius.circular(15),
                        //                               ),
                        //                             ),
                        //                           ),
                        //                           Container(
                        //                             alignment: Alignment.bottomCenter,
                        //                             child: Container(
                        //                                 decoration: BoxDecoration(
                        //                                   color: Colors.red,
                        //                                   // border: Border.all(color: Colors.white,width: 2)
                        //                                   // borderRadius: BorderRadius.circular(15)
                        //                                 ),
                        //                                 child: Padding(
                        //                                   padding: const EdgeInsets.all(3.0),
                        //                                   child: Text(
                        //                                     categoryData[index]
                        //                                         .categoryName
                        //                                         .toString(),
                        //                                     maxLines: 1,
                        //                                     textAlign: TextAlign.center,
                        //                                     overflow: TextOverflow.ellipsis,
                        //                                     style: TextStyle(
                        //                                         color: Colors.white,
                        //                                         fontWeight: FontWeight.w500,
                        //                                         fontSize: 14),
                        //                                   ),
                        //                                 )),
                        //                           ),
                        //                         ],
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 );
                        //               }),
                        //         );
                        //
                        //         return Text("kfjdsklfdsf");
                        //         // return Padding(
                        //         //   padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                        //         //   child: ProductGridviewTile(
                        //         //     products: categoryData,
                        //         //     imageUrl: imageUrl,
                        //         //     brandProductPage: true,
                        //         //   ),
                        //         // );
                        //       }else{
                        //         return Container();
                        //   }
                        //
                        //
                        //
                        //     }
                        //
                        //   } else {
                        //     return  Container(
                        //         // height: 200,
                        //         child: Center(child: CircularProgressIndicator(color: Style.Colors.appColor)));
                        //
                        //   }
                        // }),

                        ),
                  ),
                ],
              ),
            ),
        bottomNavigationBar:
        widget.title == "Kids" || widget.title == "ALL BRANDS"?
        Container(
          height: 55,
          width: MediaQuery.of(context).size.width,
          color: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
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
                                      Padding(
                                        padding: const EdgeInsets.only(top: 16.0,),
                                        child: Text("Boys",
                                            style: GoogleFonts.inriaSans(
                                                textStyle: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors.black))),
                                      ),
                                      SizedBox(height: 24,),
                                      Text("Girls",
                                          style: GoogleFonts.inriaSans(
                                              textStyle: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.black))),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          });
                    },
                    child: Text("GENDER",
                        style: GoogleFonts.inriaSans(
                            textStyle: const TextStyle(
                                fontSize: 16,

                                color: AppColors.black)))),
                Container(
                  height: 55,
                  width: 1,
                  color: AppColors.appText1,
                ),
                InkWell(
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
                                        itemCount: categoryProductController!.sortList.length,
                                        itemBuilder: (BuildContext context, int index){
                                   return   Padding(
                                        padding: const EdgeInsets.only(bottom: 24.0),
                                        child: Text(categoryProductController!.sortList[index],
                                            style: GoogleFonts.inriaSans(
                                                textStyle: const TextStyle(
                                                    fontSize: 14,

                                                    color: AppColors.black))),
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
                    ],
                  ),
                ),
                Container(
                  height: 55,
                  width: 1,
                  color: AppColors.appText1,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.filterScreen);
                  },
                  child: Row(
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ): Container(
          height: 55,
          width: MediaQuery.of(context).size.width,
          color: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
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
                                        itemCount: categoryProductController!.sortList.length,
                                        itemBuilder: (BuildContext context, int index){
                                          return   Padding(
                                            padding: const EdgeInsets.only(bottom: 24.0),
                                            child: Text(categoryProductController!.sortList[index],
                                                style: GoogleFonts.inriaSans(
                                                    textStyle: const TextStyle(
                                                        fontSize: 14,

                                                        color: AppColors.black))),
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
                    ],
                  ),
                ),
                Container(
                  height: 55,
                  width: 1,
                  color: AppColors.appText1,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.filterScreen);
                  },
                  child: Row(
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

  // Future<void> initData(CategoryProductController categoryProductController,
  //     Categories categories) async {
  //   print("categories.categoryId! ${categories.categoryId!}");
  //   await Future.delayed(const Duration(microseconds: 0), () {
  //     categoryProductController.categoryProduct(categories.categoryId!);
  //   });
  // }
}

class CategoryArguments {
  final String? categoryName;
  final List<Product>? product;
  List<Category>? category;

  CategoryArguments({this.categoryName, this.product, this.category});
}
