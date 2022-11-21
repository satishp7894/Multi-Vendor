import 'package:eshoperapp/config/theme.dart';
import 'package:eshoperapp/models/products.dart';
import 'package:eshoperapp/models/product.dart';
import 'package:eshoperapp/package/product_rating.dart';
import 'package:eshoperapp/pages/details/prodcut_details_screen.dart';
import 'package:eshoperapp/routes/navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:get/get.dart';

class AppbarTitleWidget extends StatelessWidget {
  final String? title;
  final bool? flag;
  AppbarTitleWidget({ this.title,this.flag= true}) ;

  @override
  Widget build(BuildContext context) {
   return Container(
     color: AppColors.white,
     child: Column(children: [
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
                 Text('$title',
                     style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: AppColors.appText))),
               ],
             ),
             flag! ?
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
               ],):Container()
           ],
         ),
       ),
       Container(height: 0.5,width: MediaQuery.of(context).size.width,color: AppColors.tileLine,),
     ],),
   );
  }
}



