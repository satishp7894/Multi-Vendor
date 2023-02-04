import 'package:eshoperapp/pages/wishlist/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/theme.dart';
import '../../constants/app_costants.dart';
import '../../models/customer.dart';
import '../../models/main_response.dart';
import '../../models/products.dart';
import '../../models/wishlist_model.dart';
import '../../routes/navigation.dart';
import '../../utils/check_internet.dart';
import '../../widgets/login_dialog.dart';
import '../details/prodcut_details_screen.dart';
import '../landing_home/home_controller.dart';
import '../profile/profile_controller.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> with TickerProviderStateMixin{

  final wishListController = Get.put(WishListController(
      apiRepositoryInterface: Get.find(), localRepositoryInterface: Get.find()));

  final homecontroller = Get.put(HomeController(
      localRepositoryInterface: Get.find(),
      apiRepositoryInterface: Get.find()));

  final profileController = Get.put(ProfileController(
      apiRepositoryInterface: Get.find(),
      customer: Customer(),
      localRepositoryInterface: Get.find()));

  late AnimationController controller;
  late TextEditingController? mobile;



  String selectedCriteria = 'All';

  @override
  void initState() {
    controller = BottomSheet.createAnimationController(this);
    // Animation duration for displaying the BottomSheet
    controller.duration = const Duration(milliseconds: 600);
    // Animation duration for retracting the BottomSheet
    controller.reverseDuration = const Duration(milliseconds: 600);
    // Set animation curve duration for the BottomSheet
    controller.drive(CurveTween(curve: Curves.easeIn));
    mobile = TextEditingController();
    wishListController.loadUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   leading: Image.asset(
      //     'assets/img/arrow_left.png',
      //     color: AppColors.appText,
      //   ),
      //   title: Text(
      //     "Wishlist",
      //     style: GoogleFonts.inriaSans(
      //         textStyle: const TextStyle(
      //             fontSize: 20,
      //             color: AppColors.appText,
      //             fontWeight: FontWeight.w700)),
      //   ),
      //   elevation: 1,
      //   actions: [
      //
      //     IconButton(
      //         padding: EdgeInsets.zero,
      //         onPressed: ()  {
      //         },
      //         icon: Image.asset('assets/img/bag.png',fit: BoxFit.fill,height: 22,width: 22,)),
      //
      //   ],
      // ),
      body: SafeArea(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  InkWell(child: Padding(
                    padding: const EdgeInsets.only(left: AppSizes.sidePadding,right: AppSizes.sidePadding,top: 26,bottom: 8),
                    child: Image.asset('assets/img/arrow_left.png',fit: BoxFit.fill,height: 15,width: 18,),
                  ),onTap: (){
                    Get.back();
                  },),
                  // SizedBox(width: 16,),
                  Padding(
                    padding: const EdgeInsets.only(left: 0,right: 0,top: 26,bottom: 8),
                    child: Text('Wishlist',
                        style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: AppColors.appText))),
                  ),
                ],
              ),

              InkWell(child: Padding(
                padding: const EdgeInsets.only(left: AppSizes.sidePadding,right: AppSizes.sidePadding,top: 26,bottom: 8),
                child: Image.asset('assets/img/bag.png',fit: BoxFit.fill,height: 20,width: 20,),
              ),
                onTap: (){

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
                },),
            ],
          ),
          Container(height: 0.5,width: MediaQuery.of(context).size.width,color: AppColors.tileLine,),
          // Container(
          //   // color: AppColors.white,
          //   height: 46,
          //   alignment: Alignment.centerLeft,
          //   width: MediaQuery.of(context).size.width,
          //   child: ListView.builder(
          //       scrollDirection: Axis.horizontal,
          //       itemCount: wishListController.categoryList.length,
          //       itemBuilder: (BuildContext c,int index){
          //
          //         if(selectedCriteria == wishListController.categoryList[index]){
          //           return Padding(
          //             padding: index == 0 ? const EdgeInsets.only(right: 32.0,left: 16.0,top: 16):const EdgeInsets.only(right: 32,top: 16),
          //             child: Text(wishListController.categoryList[index],style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.appRed))),
          //           );
          //         }else{
          //           return InkWell(
          //             onTap: (){
          //               setState(() {
          //                 selectedCriteria = wishListController.categoryList[index];
          //               });
          //             },
          //             child: Padding(
          //               padding: index == 0 ? const EdgeInsets.only(right: 32.0,left: 16.0,top: 16):const EdgeInsets.only(right: 32.0,top: 16),
          //               child: Text(wishListController.categoryList[index],style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.black))),
          //             ),
          //           );
          //         }
          //
          //       }),
          // ),



          Expanded(
            child:  RefreshIndicator(
              onRefresh: () {
                CheckInternet.checkInternet();
                return wishListController.loadUser();
              },
              child: ListView(
                children: [
                  Obx(() {
                    if (wishListController.isLoadingGetWishList.value == true) {
                      MainResponse? mainResponse = wishListController.getWishListObj.value;
                      List<WishListModel>? getWishListData = [];

                      if(mainResponse.data != null){
                        mainResponse.data!.forEach((v) {
                          getWishListData.add(WishListModel.fromJson(v));
                          // cardController.getCartDataBottomView!.add(Carts.fromJson(v));
                        });

                      }


                      // print("getCartData total ------------- ${getCartData[0].totalAmt!}");
                      // cardController.homecontroller.cartList(getCartData);


                      // cardController.homecontroller.refreshTotal();
                      // mainResponse.data!.map((e) => customerProfileData!.add(UpdateCustomerPasswordData.fromJson(e))).toList();


                      String? imageUrl = mainResponse.imageUrl ?? "";
                      String? message = mainResponse.message ?? AppConstants.noInternetConn;



                      if (getWishListData.isEmpty) {
                        return Container(
                          height: MediaQuery.of(context).size.height,
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
                        // cardController.selectAllCartInit(getCartData);
                    return    Padding(
                          padding: const EdgeInsets.only(left: 16.0,right: 16,bottom: 16,top: 16),
                          child: Container(
                            // padding: const EdgeInsets.only(top: 18,left: 18,right: 18,bottom: 16),
                            // height: 400,
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                              getWishListData.length,
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                // crossAxisCount: 2,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                  mainAxisExtent: 250,
                                  // childAspectRatio:   MediaQuery.of(context)
                                  //     .size
                                  //     .width /
                                  //     (MediaQuery.of(context)
                                  //         .size
                                  //         .height /
                                  //         1.3),
                                  crossAxisCount:
                                  (orientation == Orientation.portrait)
                                      ? 2
                                      : 4),
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>  ProductDetailsScreen(
                                              products: Products(productId: getWishListData[index].productId!,productName: getWishListData[index].productName!,variantCode: getWishListData[index].variantCode!),
                                              // article: articles[index],
                                            )));
                                  },
                                  child: Stack(
                                    children: [
                                      Container(

                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: AppColors.white,
                                                // color: AppColors.red,
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
                                                  Container(
                                                    color: AppColors.wishListImageBg,
                                                    child: Image.network(
                                                      imageUrl+getWishListData[index].productId!+"/"+
                                                      getWishListData[index].coverImg!,
                                                      fit: BoxFit.cover,
                                                      height: 170,
                                                      width: double.infinity,

                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Container(
                                                    height: 41,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(
                                                        left: 5.0,
                                                        right: 5.0,

                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        // mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(
                                                              getWishListData[index]
                                                                  .productName!,
                                                              maxLines: 1,
                                                              //  style: GoogleFonts.ptSans(),
                                                              overflow:
                                                              TextOverflow.ellipsis,
                                                              style: GoogleFonts.inriaSans(
                                                                  textStyle:
                                                                  const TextStyle(
                                                                      fontSize: 14,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                      color: AppColors
                                                                          .black))),
                                                          SizedBox(height: 3,),

                                                          getWishListData[index].discount != "0"?  Row(
                                                            children: [
                                                              Text(
                                                                  "\u{20B9}${double.parse(getWishListData[index].netPrice!).toStringAsFixed(0)} ",
                                                                  style: GoogleFonts.inriaSans(
                                                                      textStyle: const TextStyle(
                                                                          fontSize: 12,
                                                                          fontWeight:
                                                                          FontWeight.w400,
                                                                          color:
                                                                          AppColors.black))),
                                                              SizedBox(width: 2,),
                                                              Text(
                                                                  "\u{20B9}${double.parse(getWishListData[index].mrpPrice!).toStringAsFixed(0)} ",
                                                                  style: GoogleFonts.inriaSans(
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
                                                              SizedBox(width: 2,),
                                                              Text(
                                                                  "${getWishListData[index].discount!}",
                                                                  style: GoogleFonts.inriaSans(
                                                                      textStyle: const TextStyle(
                                                                          fontSize: 12,
                                                                          fontWeight:
                                                                          FontWeight.w400,
                                                                          color: AppColors.off)))
                                                            ],
                                                          ): Text(
                                                              "\u{20B9}${double.parse(getWishListData[index].netPrice!).toStringAsFixed(0)} ",
                                                              style: GoogleFonts.inriaSans(
                                                                  textStyle: const TextStyle(
                                                                      fontSize: 12,
                                                                      fontWeight:
                                                                      FontWeight.w400,
                                                                      color:
                                                                      AppColors.black))),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  // const SizedBox(
                                                  //   height: 8,
                                                  // ),
                                                  //Text(categoryProductController!.productGrid[index].productName!,style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 13,fontWeight: FontWeight.w400,color: AppColors.appText)))
                                                ],
                                              ),
                                            ),
                                            Container(

                                              decoration: BoxDecoration(
                                                color: AppColors.white,
                                                // borderRadius: const BorderRadius
                                                //         .all(
                                                //     const Radius.circular(10)),

                                                border: Border(
                                                  right: BorderSide(
                                                    width: 1,
                                                    color: AppColors
                                                        .bestSellingBorder,
                                                  ),
                                                  bottom: BorderSide(
                                                    width: 1,
                                                    color: AppColors
                                                        .bestSellingBorder,
                                                  ),
                                                  left: BorderSide(
                                                    width: 1,
                                                    color: AppColors
                                                        .bestSellingBorder,
                                                  ),

                                                  // style: BorderStyle.solid,
                                                ),
                                              ),
                                              child: InkWell(

                                                child: Center(
                                                  child: Text(
                                                      "MOVE TO BAG",
                                                      // maxLines: 1,
                                                      // //  style: GoogleFonts.ptSans(),
                                                      // overflow:
                                                      // TextOverflow.ellipsis,
                                                      style: GoogleFonts.inriaSans(
                                                          textStyle:
                                                          const TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                              color: AppColors
                                                                  .appRed))),
                                                ),
                                                onTap: () async {
                                                await  homecontroller.addToCard(getWishListData[index].productId!, "1",homecontroller.customerId.value);
                                                await wishListController.removeWishlistItem(getWishListData[index].productId!,homecontroller.customerId.value,false);
                                                wishListController.loadUser();

                                                },
                                              ),
                                              width: MediaQuery.of(context).size.width,
                                              height: 35,
                                            ),
                                          ],
                                        ),

                                      ),
                                      Positioned(
                                          right: 1,
                                          top: 1,child: InkWell(

                                          onTap:() async {
                                          await  wishListController.removeWishlistItem(getWishListData[index].productId!,homecontroller.customerId.value,true);
                                          wishListController.loadUser();

                                },
                                          child: Image.asset('assets/img/close_circle_gray.png',fit: BoxFit.fill,height: 28,width: 28,)))
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      }

                    } else {
                      // return Container();
                      return  Container(
                          height: MediaQuery.of(context).size.height,
                          child: const Center(child: CircularProgressIndicator(color: AppColors.appColor)));

                    }
                  }),
                ],
              ),
            ),
          )
        ],),
      ),
    );
  }
}
