import 'package:eshoperapp/config/theme.dart';
import 'package:eshoperapp/models/products.dart';
import 'package:eshoperapp/models/product.dart';
import 'package:eshoperapp/package/product_rating.dart';
import 'package:eshoperapp/pages/details/prodcut_details_screen.dart';
import 'package:eshoperapp/routes/navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class AppbarWidget extends StatelessWidget {
  final bool? flag;
   AppbarWidget({ this.flag}) ;

  @override
  Widget build(BuildContext context) {
   return Column(children: [
     Padding(
       padding: const EdgeInsets.only(left: AppSizes.sidePadding,right: AppSizes.sidePadding),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Row(
             children: [
               flag! ? InkWell(child: Image.asset('assets/img/arrow_left.png',fit: BoxFit.fill,height: 17,width: 20,),
               onTap: (){
                 Get.back();
               },):Container(),
               SizedBox(width:  flag! ?8:0,),
               Image.asset('assets/logos/app_logo.png',fit: BoxFit.fill,height: 55,width: 100,),
             ],
           ),
           Row(
             crossAxisAlignment: CrossAxisAlignment.end,
             children: [
               InkWell(child: Image.asset('assets/img/search.png',fit: BoxFit.fill,height: 18,width: 18,),
               onTap: (){
                 Get.toNamed(Routes.searchScreen);
               },),
               SizedBox(width: 18.0,),
               InkWell(child: Image.asset('assets/img/heart.png',fit: BoxFit.fill,height: 18,width: 18,),
               onTap: (){
                 Get.toNamed(Routes.wishList);
               },),
               SizedBox(width: 18.0,),
               InkWell(child: Image.asset('assets/img/Notification.png',fit: BoxFit.fill,height: 18,width: 16,),
                 onTap: (){
                   Get.toNamed(Routes.notification);
                 },
               )
             ],)
         ],
       ),
     ),
     Container(height: 0.5,width: MediaQuery.of(context).size.width,color: AppColors.tileLine,),
   ],);
  }
}



