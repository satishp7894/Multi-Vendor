import 'package:eshoperapp/pages/profile/views/list_item_cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/theme.dart';
import '../../widgets/app_bar_title.dart';


class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.ratingText,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   leading: Image.asset(
      //     'assets/img/arrow_left.png',
      //     color: AppColors.appText,
      //   ),
      //   title: Text(
      //     "HELP CENTER",
      //     style: GoogleFonts.inriaSans(
      //         textStyle: const TextStyle(
      //             fontSize: 20,
      //             color: AppColors.appText,
      //             fontWeight: FontWeight.w700)),
      //   ),
      //   elevation: 0,
      // ),

      body: SafeArea(
        child: Column(
          children: [
            // AppbarTitleWidget(title: "HELP CENTER",flag: false,),
            Expanded(
              child: Column(
                children: [
                  Container(

                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            height: 245,
                            child: Row(

                              // crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                  Text(
                                    "HELP CENTER",
                                    style: GoogleFonts.inriaSans(
                                        textStyle: const TextStyle(
                                            fontSize: 22,
                                            color: AppColors.appText,
                                            fontWeight: FontWeight.w700)),
                                  ),
                                  SizedBox(height: 16,),
                                  Text("Please get in touch and we will \nbe happy to help you",
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.inriaSans(

                                        textStyle: const TextStyle(

                                            fontSize: 12,
                                            color: AppColors.appText1,
                                            fontWeight: FontWeight.w700)),
                                  ),

                                ],),

                                Image.asset(
                                  'assets/img/help_center_logo.png',
                                  fit: BoxFit.fill,
                                  width: 177,

                                  height: 245,
                                ),
                              ],
                            ),
                          ),
                        ),
      Container(
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
                    Text('HELP CENTER',
                        style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: AppColors.appText))),
                  ],
                ),

              ],
            ),
          ),
          // Container(height: 0.5,width: MediaQuery.of(context).size.width,color: AppColors.tileLine,),
        ],),
      )
                      ],
                    ),
                    color:AppColors.white,

                  ),
                  SizedBox(height: 16.0,),
                  // Container(
                  //   height: 1,width: MediaQuery.of(context).size.width,
                  //   color: AppColors.tileLine,
                  // ),

                  Container(
                    color: AppColors.white,
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 22.0,bottom: 22.0),
                        child: Container(
                          color: AppColors.white,
                          child: Text(
                            "MORE QUARIES RELATED TO YOUR EXPERIENCE",
                            style: GoogleFonts.inriaSans(
                                textStyle: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                      Container(
                        height: 1,width: MediaQuery.of(context).size.width,
                        color: AppColors.tileLine,
                      ),
                      listTileWidget("Payment/Refund"),
                      listTileWidget("Offers, Discounts, Coupons"),
                      listTileWidget("Manage Your Account"),
                      listTileWidget("Other",last: false)
                    ],),
                  )

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  listTileWidget(String title,{bool? last=true}){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0,right: 16,bottom: 22,top: 22),
          child: Row(
            children: [


              Expanded(
                child: Text(
                    title,
                    style: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 14,color: AppColors.appText))
                  // const TextStyle(color: Color(0xFFFF7643), fontSize: 18),
                ),
              ),
              // Spacer(),
              Image.asset("assets/img/arrow_right.png",fit: BoxFit.fill,height: 12,width: 8,),
              // const Icon(
              //   Icons.arrow_forward_ios,
              //   color: Color(0xFF898989),
              //   size: 20,
              // )
            ],
          ),
        ),
        last == true ?
        Container(height: 1,width: MediaQuery.of(context).size.width,color: AppColors.tileLine,):Container()
      ],
    );
  }
}
