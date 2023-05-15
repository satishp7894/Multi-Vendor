import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/theme.dart';
import '../../constants/app_costants.dart';
import '../../routes/navigation.dart';

class OnBoarding1 extends StatefulWidget {
  const OnBoarding1({Key? key}) : super(key: key);

  @override
  State<OnBoarding1> createState() => _OnBoarding1State();
}

class _OnBoarding1State extends State<OnBoarding1> {
  // final onBoarding1Controller = Get.put(OnBoarding1Controller(
  //     apiRepositoryInterface: Get.find(),
  //     localRepositoryInterface: Get.find()));

  int? currentIndex = 0;
  final List<String> imgList = [
    'assets/img/onboarding1.jpg',
    'assets/img/onboarding2.jpg',
    'assets/img/onboarding3.jpg'
  ];

  @override
  void initState() {
    // TODO: implement initState
    // init();
    super.initState();
  }

  // void init() async {
  //   await Future.delayed(
  //     const Duration(seconds: 3),
  //   );
  //
  //   Get.offAndToNamed(Routes.onBoarding2);
  //   // final token = await localRepositoryInterface.getUser();
  //   // if (token != null) {
  //   //   Get.offNamed(Routes.landingHome);
  //   //
  //   // } else{
  //   //   Get.offNamed(Routes.login);
  //   // }
  // }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: height,
              viewportFraction: 1.0,
              autoPlayInterval: Duration(seconds: 3),
              pauseAutoPlayInFiniteScroll : true,
              enableInfiniteScroll: false,
              autoPlayAnimationDuration :const Duration(milliseconds: 300),
              autoPlay: true,
                        onPageChanged: (i, re) async {
                          setState(() {
                            currentIndex = i;
                          });
                          if(currentIndex == 2){
                            SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                            final prefCustomerId = sharedPreferences.getString(AppConstants.prefCustomerId!);
                            print("prefCustomerId ----------------------- ${prefCustomerId}");

                            await Future.delayed(
                              const Duration(seconds: 2),
                            );

                            if(prefCustomerId != null){
                              Get.offNamed(Routes.landingHome);
                            }else{
                              Get.offNamed(Routes.login);
                            }
                          }
                        },
              // autoPlay: false,
            ),
            items: imgList
                .map((item) => Stack(
                  children: [
                    Container(
                          child: Center(
                              child: Image.asset(
                            item,
                            fit: BoxFit.cover,
                            height: height,
                          )),
                        ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 60.0, right: 20),
                            child: InkWell(
                              onTap: () async {
                                SharedPreferences sharedPreferences = await SharedPreferences.getInstance() ;

                                print("sharedPreferences.getString(AppConstants.chooseType!) ===============> ${sharedPreferences.getString(AppConstants.chooseType!)}");


                                  final prefCustomerId = sharedPreferences.getString(AppConstants.prefCustomerId!);
                                  if(prefCustomerId != null){
                                    if(sharedPreferences.getString(AppConstants.chooseType!) != null ){
                                    Get.offNamed(Routes.landingHome);
                                    }else{
                                      Get.offAndToNamed(Routes.chooseYourStoreScreen);
                                    }
                                  }else{
                                    Get.offNamed(Routes.login);
                                  }

                              },
                              child: Text(
                                "Skip",
                                style: GoogleFonts.inriaSerif(
                                    textStyle: const TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 80.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Be Trendy",
                                        style: GoogleFonts.bungeeShade(
                                            textStyle: const TextStyle(
                                                color: AppColors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 32)))),
                              ),
                              Container(
                                  alignment: Alignment.center,
                                  child: Text("For every",
                                      style: GoogleFonts.bungeeShade(
                                          textStyle: const TextStyle(
                                              color: AppColors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 32)))),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Container(
                                    alignment: Alignment.centerRight,
                                    child: Text("Mood",
                                        style: GoogleFonts.bungeeShade(
                                            textStyle: const TextStyle(
                                                color: AppColors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 32)))),
                              ),
                              SizedBox(height: 50,),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //
                              //     Container(
                              //       height: 10,
                              //       width: 10,
                              //       decoration: BoxDecoration(
                              //           shape: BoxShape.circle,
                              //           color: AppColors.white
                              //       ),
                              //     ),
                              //     SizedBox(width: 5,),
                              //     Container(
                              //       height: 10,
                              //       width: 10,
                              //       decoration: BoxDecoration(
                              //           shape: BoxShape.circle,
                              //           color: AppColors.white
                              //       ),
                              //     ),
                              //     SizedBox(width: 5,),
                              //     Container(
                              //       height: 10,
                              //       width: 10,
                              //       decoration: BoxDecoration(
                              //           shape: BoxShape.circle,
                              //           color: AppColors.appRed
                              //       ),
                              //     ),
                              //   ],
                              // )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ))
                .toList(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100,
              // width: 300,
              child: ListView.builder(
                shrinkWrap: true,
                  itemCount: imgList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext c, int i) {
                    if (currentIndex == i) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 21.0,bottom: 69.0,right: 5),
                        child: Container(
                          width: 10.0,

                          // margin: EdgeInsets.symmetric(
                          //     vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            color: AppColors.appRed,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(100),
                              topLeft: Radius.circular(100),
                              bottomLeft: Radius.circular(100),
                              bottomRight: Radius.circular(100),
                            ),
                          ),
                          // decoration: BoxDecoration(
                          //     shape: BoxShape.circle, color: Colors.black),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(top: 21.0,bottom: 69.0,right: 5),
                        child: Container(
                          width: 10.0,
                          height: 10,
                          // margin: EdgeInsets.symmetric(
                          //     vertical: 21.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(100),
                              topLeft: Radius.circular(100),
                              bottomLeft: Radius.circular(100),
                              bottomRight: Radius.circular(100),
                            ),),
                        ),
                      );
                    }
                  }),
            ),
          )
        ],
      ),

      // body: SizedBox(
      //   child: Stack(
      //     children: [
      //       Image.asset('assets/img/onboarding1.jpg',
      //           fit: BoxFit.cover,
      //           height: MediaQuery.of(context).size.height,
      //           width: MediaQuery.of(context).size.width
      //       ),
      //       Column(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           Container(
      //             alignment: Alignment.centerRight,
      //             child: Padding(
      //               padding: const EdgeInsets.only(top: 60.0, right: 20),
      //               child: InkWell(
      //                 onTap: (){
      //                   Get.offAllNamed(Routes.login);
      //                 },
      //                 child: Text(
      //                   "Skip",
      //                   style: GoogleFonts.inriaSerif(
      //                       textStyle: const TextStyle(
      //                           color: AppColors.white,
      //                           fontWeight: FontWeight.bold,
      //                           fontSize: 18)),
      //                 ),
      //               ),
      //             ),
      //           ),
      //           Padding(
      //             padding: const EdgeInsets.only(bottom: 80.0),
      //             child: Column(
      //               children: [
      //                 Padding(
      //                   padding: const EdgeInsets.only(left: 8.0),
      //                   child: Container(
      //                       alignment: Alignment.centerLeft,
      //                       child: Text("Be Trendy",
      //                           style: GoogleFonts.bungeeShade(
      //                               textStyle: const TextStyle(
      //                                   color: AppColors.white,
      //                                   fontWeight: FontWeight.w400,
      //                                   fontSize: 32)))),
      //                 ),
      //                 Container(
      //                     alignment: Alignment.center,
      //                     child: Text("For every",
      //                         style: GoogleFonts.bungeeShade(
      //                             textStyle: const TextStyle(
      //                                 color: AppColors.white,
      //                                 fontWeight: FontWeight.w400,
      //                                 fontSize: 32)))),
      //                 Padding(
      //                   padding: const EdgeInsets.only(right: 8.0),
      //                   child: Container(
      //                       alignment: Alignment.centerRight,
      //                       child: Text("Mood",
      //                           style: GoogleFonts.bungeeShade(
      //                               textStyle: const TextStyle(
      //                                   color: AppColors.white,
      //                                   fontWeight: FontWeight.w400,
      //                                   fontSize: 32)))),
      //                 ),
      //                 SizedBox(height: 50,),
      //                 Row(
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   children: [
      //                     Container(
      //                       height: 10,
      //                       width: 10,
      //                       decoration: BoxDecoration(
      //                         shape: BoxShape.circle,
      //                         color: AppColors.appRed
      //                       ),
      //                     ),
      //                     SizedBox(width: 5,),
      //                     Container(
      //                       height: 10,
      //                       width: 10,
      //                       decoration: BoxDecoration(
      //                           shape: BoxShape.circle,
      //                           color: AppColors.white
      //                       ),
      //                     ),
      //                     SizedBox(width: 5,),
      //                     Container(
      //                       height: 10,
      //                       width: 10,
      //                       decoration: BoxDecoration(
      //                           shape: BoxShape.circle,
      //                           color: AppColors.white
      //                       ),
      //                     ),
      //                   ],
      //                 )
      //               ],
      //             ),
      //           ),
      //         ],
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
