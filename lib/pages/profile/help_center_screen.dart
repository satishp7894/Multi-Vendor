import 'package:eshoperapp/pages/profile/views/list_item_cart.dart';
import 'package:eshoperapp/pages/profile/write_to_us_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/theme.dart';
import '../../widgets/app_bar_title.dart';


class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen>  with TickerProviderStateMixin {

  late AnimationController controller;

  @override
  void initState() {
    controller = BottomSheet.createAnimationController(this);
    // Animation duration for displaying the BottomSheet
    controller.duration = const Duration(milliseconds: 600);
    // Animation duration for retracting the BottomSheet
    controller.reverseDuration = const Duration(milliseconds: 600);
    // Set animation curve duration for the BottomSheet
    controller.drive(CurveTween(curve: Curves.easeIn));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
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
                  Container(height: 2.0,width: MediaQuery.of(context).size.width,color: AppColors.ratingText,),
                  SizedBox(height: 32,),

                  InkWell(
                    child: Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColors.appRed, width: 1),
                        color: AppColors.appRed,
                        borderRadius: const BorderRadius.all(
                            Radius.circular(
                                10.0) //                 <--- border radius here
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "CONTACT US",
                          style: GoogleFonts.salsa(
                            textStyle: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                          // style: const TextStyle(
                          //     fontSize: 23,
                          //     fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    onTap: () {
                      // Get.offNamed(Routes.login);
                      showModalBottomSheet(
                        context: context,
                        isDismissible:false,
                        isScrollControlled: true,
                        transitionAnimationController: controller,
                        builder: (BuildContext context) {

                          // return LoginDialog(mobile: mobile,context: context,);
                          return  Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: Wrap(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 24.0,bottom: 24.0,left: 16.0,right: 16.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Contact Us",
                                                  style: GoogleFonts.inriaSans(
                                                      textStyle: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w700,
                                                          color: AppColors.black))),
                                              Text("How do you wish to contact us",
                                                  style: GoogleFonts.inriaSans(
                                                      textStyle: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w400,
                                                          color: AppColors.black))),
                                            ],
                                          ),
                                          InkWell(
                                              onTap: (){
                                                Get.back();
                                              },
                                              child: Image.asset("assets/img/close.png",fit: BoxFit.fill,height: 18,width: 18,))
                                        ],
                                      ),
                                      SizedBox(height: 30,),
                                      InkWell(
                                        onTap: ()async{
                                          Get.back();
                                         // launch("tel://<phone_number>");
                                          var uri = 'tel:1234567890';
                                          Uri callUrl = Uri.parse(uri);
                                          if (await canLaunchUrl(callUrl)) {
                                          await launchUrl(callUrl);
                                          }
                                          // else {
                                          // throw 'Could not launch $uri';
                                          // }
                                        },
                                        child: Row(children: [
                                          Image.asset("assets/img/telephone.png",fit: BoxFit.fill,height: 20,width: 20,),
                                          SizedBox(width: 16,),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Call Now",
                                                  style: GoogleFonts.inriaSans(
                                                      textStyle: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w700,
                                                          color: AppColors.black))),
                                              Text("For a better experience, call from your registered number.",
                                                  style: GoogleFonts.inriaSans(
                                                      textStyle: TextStyle(
                                                          fontSize: 11,
                                                          fontWeight: FontWeight.w400,
                                                          color: AppColors.black))),
                                            ],
                                          ),

                                        ],),
                                      ),
                                      SizedBox(height: 20,),
                                      InkWell(
                                        onTap: (){
                                          Get.back();
                                          Get.to(WriteToUsScreen());
                                        },
                                        child: Row(children: [
                                          Image.asset("assets/img/write.png",fit: BoxFit.fill,height: 20,width: 20,),
                                          SizedBox(width: 16,),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Write To Us",
                                                  style: GoogleFonts.inriaSans(
                                                      textStyle: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w700,
                                                          color: AppColors.black))),
                                              Text("Average Response Time 24-48 Hrs.",
                                                  style: GoogleFonts.inriaSans(
                                                      textStyle: TextStyle(
                                                          fontSize: 11,
                                                          fontWeight: FontWeight.w400,
                                                          color: AppColors.black))),
                                            ],
                                          ),

                                        ],),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),

                  // Container(
                  //   height: 1,width: MediaQuery.of(context).size.width,
                  //   color: AppColors.tileLine,
                  // ),

                  // Container(
                  //   color: AppColors.white,
                  //   child: Column(children: [
                  //     Padding(
                  //       padding: const EdgeInsets.only(top: 22.0,bottom: 22.0),
                  //       child: Container(
                  //         color: AppColors.white,
                  //         child: Text(
                  //           "MORE QUARIES RELATED TO YOUR EXPERIENCE",
                  //           style: GoogleFonts.inriaSans(
                  //               textStyle: const TextStyle(
                  //                   fontSize: 14,
                  //                   color: AppColors.black,
                  //                   fontWeight: FontWeight.bold)),
                  //         ),
                  //       ),
                  //     ),
                  //     Container(
                  //       height: 1,width: MediaQuery.of(context).size.width,
                  //       color: AppColors.tileLine,
                  //     ),
                  //     listTileWidget("Payment/Refund"),
                  //     listTileWidget("Offers, Discounts, Coupons"),
                  //     listTileWidget("Manage Your Account"),
                  //     listTileWidget("Other",last: false)
                  //   ],),
                  // )

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
