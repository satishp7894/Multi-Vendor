import 'package:eshoperapp/pages/wishlist/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/theme.dart';
import '../../routes/navigation.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {

  final wishListController = Get.put(WishListController(
      apiRepositoryInterface: Get.find(), localRepositoryInterface: Get.find()));
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
        child: Column(
          children: [
            Column(children: [
              Padding(
                padding: const EdgeInsets.only(left: AppSizes.sidePadding,right: AppSizes.sidePadding,top: 26,bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(child: Image.asset('assets/img/arrow_left.png',fit: BoxFit.fill,height: 15,width: 18,),onTap: (){
                          Get.back();
                        },),
                        SizedBox(width: 16,),
                        Text('Wishlist',
                            style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: AppColors.appText))),
                      ],
                    ),

                    InkWell(child: Image.asset('assets/img/bag.png',fit: BoxFit.fill,height: 20,width: 20,),
                      onTap: (){
                        Get.toNamed(Routes.cart);
                      },),
                  ],
                ),
              ),
              Container(height: 0.5,width: MediaQuery.of(context).size.width,color: AppColors.tileLine,),
            ],),
            Expanded(
              child: SingleChildScrollView(
                child: Column(children: [
                  // SizedBox(height: 15.0,),
                  Container(
                    // color: AppColors.white,
                    height: 46,
                    alignment: Alignment.centerLeft,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: wishListController.categoryList.length,
                        itemBuilder: (BuildContext c,int index){

                          if(index == 0){
                            return Padding(
                              padding: index == 0 ? const EdgeInsets.only(right: 32.0,left: 16.0,top: 16):const EdgeInsets.only(right: 32,top: 16),
                              child: Text(wishListController.categoryList[index],style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.appRed))),
                            );
                          }else{
                            return Padding(
                              padding: index == 0 ? const EdgeInsets.only(right: 32.0,left: 16.0,top: 16):const EdgeInsets.only(right: 32.0,top: 16),
                              child: Text(wishListController.categoryList[index],style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.black))),
                            );
                          }

                        }),
                  ),
                  // SizedBox(height: 15.0,),

                  Padding(
                    padding: const EdgeInsets.only(left: 16.0,right: 16,bottom: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Container(
                          // padding: const EdgeInsets.only(top: 18,left: 18,right: 18,bottom: 16),
                          // height: 400,
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                            wishListController.productGrid.length,
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              // crossAxisCount: 2,
                                crossAxisSpacing: 18,
                                mainAxisSpacing: 0,
                                childAspectRatio:   MediaQuery.of(context)
                                    .size
                                    .width /
                                    (MediaQuery.of(context)
                                        .size
                                        .height /
                                        1.3),
                                crossAxisCount:
                                (orientation == Orientation.portrait)
                                    ? 2
                                    : 2),
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: (){
                                },
                                child: Column(
                                  children: [
                                    Container(
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
                                            wishListController
                                                .productGrid[index].coverImage!,
                                            fit: BoxFit.fill,
                                            width: double.infinity,
                                          ),
                                          const SizedBox(
                                            height: 1,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0,
                                                right: 5.0,

                                                ),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    wishListController
                                                        .productGrid[index]
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

                                                Row(
                                                  children: [
                                                    Text(
                                                        "\u{20B9}${double.parse(wishListController.productGrid[index].netPrice!).toStringAsFixed(0)} ",
                                                        style: GoogleFonts.inriaSans(
                                                            textStyle: const TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                FontWeight.w400,
                                                                color:
                                                                AppColors.black))),
                                                    SizedBox(width: 2,),
                                                    Text(
                                                        "\u{20B9}${double.parse(wishListController.productGrid[index].mrpPrice!).toStringAsFixed(0)} ",
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
                                                        "${wishListController.productGrid[index].discount!}",
                                                        style: GoogleFonts.inriaSans(
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
                                          const SizedBox(
                                            height: 8,
                                          ),
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
                                      width: MediaQuery.of(context).size.width,
                                      height: 35,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
