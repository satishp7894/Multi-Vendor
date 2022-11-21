import 'package:eshoperapp/config/theme.dart';
import 'package:eshoperapp/models/categories.dart';
import 'package:eshoperapp/models/category.dart';
import 'package:eshoperapp/models/product.dart';
import 'package:eshoperapp/style/theme.dart' as Style;
import 'package:eshoperapp/utils/check_internet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import '../../models/products.dart';
import '../../widgets/app_bar_title.dart';


class BrandProductListScreen extends StatefulWidget {
  final Categories? category;

  const BrandProductListScreen({Key? key, required this.category})
      : super(key: key);

  @override
  State<BrandProductListScreen> createState() => _BrandProductListScreenState();
}

class _BrandProductListScreenState extends State<BrandProductListScreen> {
  Categories? categories;

  List<Products> itemsString = [
    Products(productName: "A",image: ["Aarika","AD By Arvind","AD By Arvind","American Eagle","Aarika","AD By Arvind","AD By Arvind","American Eagle"]),
    Products(productName: "B",image: ["Bewakoof","Biba","Bown Bee","Bewakoof","Biba","Bown Bee"]),
    Products(productName: "C",image: ["Calvin Klein","Chemistry","AD By Arvind","American Eagle","Calvin Klein","Chemistry","AD By Arvind","American Eagle"]),
    Products(productName: "D",image: ["Diesel","AD By Arvind","AD By Arvind","American Eagle","Diesel","AD By Arvind","AD By Arvind","American Eagle"]),
  ];




  @override
  void initState() {
    // TODO: implement initState
    // dynamic argumentData = Get.arguments;
    // categories = argumentData[0]['categoryObj'];

    // dynamic argumentData = Get.arguments;
    categories = widget.category;


    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    // final CategoryArguments args =
    //     ModalRoute.of(context)!.settings.arguments as CategoryArguments;

    return Scaffold(
      // backgroundColor: Colors.green.withOpacity(0.1),
      // appBar: AppBar(
      //   actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      //   elevation: 0,
      // ),

      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.white,
      //   leading: IconButton(
      //     icon: Image.asset("assets/img/arrow_left.png",fit: BoxFit.fill,height: 20,width: 22,),
      //
      //     // Icon(
      //     //   Icons.arrow_back,
      //     //   color: Style.Colors.appColor,
      //     //   size: 30,
      //     // ),
      //     onPressed: () =>  Get.back(),
      //   ),
      //   // title: Text("${categories!.categoryName!}", style: TextStyle(fontSize: 20,color: Style.Colors.appColor)),
      //   title: Text("ALL BRANDS",
      //       style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: AppColors.appText))),
      //   actions: [
      //     // IconButton(
      //     //   onPressed: () {},
      //     //   icon: Icon(Icons.notifications_none),
      //     //   color: Colors.red,
      //     // ),
      //     // IconButton(
      //     //     onPressed: () {},
      //     //     icon: Icon(Icons.favorite_border),
      //     //
      //     //
      //     //
      //     //     color: Colors.red),
      //
      //
      //     // Obx((){
      //     //   if (profileController.isUserDataRefresh.value == true) {
      //     //     print(
      //     //         "profileController.isUserDataRefresh.value if ${profileController.isUserDataRefresh.value}");
      //     //     profileController.getUser();
      //     //     profileController.isUserDataRefresh(false);
      //     //   } else {
      //     //     print(
      //     //         "profileController.isUserDataRefresh.value  else ${profileController.isUserDataRefresh.value}");
      //     //   }
      //     //
      //     //   return IconButton(
      //     //     onPressed: () async {
      //     //       profileController.customerId == "" ?Get.toNamed(Routes.login):
      //     //       Get.defaultDialog(
      //     //         title: "Logout?",
      //     //         barrierDismissible : false,
      //     //         middleText: "Are you sure you want to logout from this App?",
      //     //         titleStyle: TextStyle(color: Colors.black),
      //     //         middleTextStyle: TextStyle(color: Colors.black),
      //     //         confirm: Row(
      //     //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     //           children: [
      //     //             TextButton(
      //     //               // style: flatButtonStyle,
      //     //               onPressed: () {
      //     //                 Get.back();
      //     //               },
      //     //               child: Text(
      //     //                 "Cancel",
      //     //                 style: TextStyle(color: Colors.red),
      //     //               ),
      //     //             ),
      //     //             TextButton(
      //     //               // style: flatButtonStyle,
      //     //               onPressed: () async {
      //     //                 bool? logout = await profileController.logout();
      //     //                 print("logout  $logout");
      //     //                 if (logout == true) {
      //     //                   print("logout if $logout");
      //     //                   profileController.getUser();
      //     //                   Get.back();
      //     //                 } else {
      //     //                   print("logout else $logout");
      //     //                 }
      //     //               },
      //     //               child: Text(
      //     //                 "OK",
      //     //                 style: TextStyle(color: Colors.red),
      //     //               ),
      //     //             )
      //     //           ],
      //     //         ),
      //     //         // cancel: Text("Cancel"),
      //     //         // custom: Text("djdn",style: TextStyle(color: Colors.red),)
      //     //       );
      //     //       // homeController.logout();
      //     //       // ShowAlertDialog.showAlertLogoutConfirm(context,"Logout?","Are you sure you want to logout from this App?",homeController);
      //     //     },
      //     //     icon: Icon(profileController.customerId == "" ?
      //     //     Icons.login:Icons.logout,
      //     //       size: 30,
      //     //     ),
      //     //     color: Color(0xFFFC7663));}),
      //     IconButton(
      //         padding: EdgeInsets.zero,
      //         onPressed: ()  {
      //         },
      //         icon: Image.asset('assets/img/search.png',fit: BoxFit.fill,height: 22,width: 22,)),
      //     IconButton(
      //         padding: EdgeInsets.zero,
      //         onPressed: ()  {
      //         },
      //         icon: Image.asset('assets/img/heart.png',fit: BoxFit.fill,height: 22,width: 22,)),
      //     IconButton(
      //         padding: EdgeInsets.zero,
      //         onPressed: ()  {
      //         },
      //         icon: Image.asset('assets/img/notification.png',fit: BoxFit.fill,height: 22,width: 22,)),
      //
      //   ],
      // ),
      body: SafeArea(
        child: Column(
          children: [
            AppbarTitleWidget(title: "ALL BRANDS",),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () {
                  return CheckInternet.checkInternet();
                  // return categoryProductController!.categoryProduct(categories!.categoryId!);
                },
                child:
                ListView.builder(
                    itemCount: itemsString.length,
                    itemBuilder: (context, index) {
                  return StickyHeader(
                    overlapHeaders : false,
                    header: Stack(
                      children: [
                        Container(
                          height: 25.0,
                          color:AppColors.white,

                        ),
                        Container(
                          height: 25.0,
                          color:AppColors.brandTopTitle,
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          alignment: Alignment.centerLeft,
                          child: Text('${itemsString[index].productName}',
                              style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.w700,color: AppColors.black))
                          ),
                        ),
                      ],
                    ),
                    content: Padding(
                      padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                      child: Column(children: itemsString[index].image!.map((e) => Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              //                   <--- left side
                              width: 1,
                              color: AppColors.toggleBg,
                            ),

                            // style: BorderStyle.solid,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16.0,bottom: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("$e", style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.black))),
                              Image.asset("assets/img/arrow_right.png",fit: BoxFit.fill,height: 12,width: 8,),
                            ],
                          ),
                        ),
                      )).toList()


                     ,),
                    )
                  );
                })

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
                //
                //
                //
                //
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
    );
  }
}

