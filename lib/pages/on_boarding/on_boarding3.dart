import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/theme.dart';
import '../../constants/app_costants.dart';
import '../../routes/navigation.dart';
import 'onboarding2_controller.dart';
//
// class OnBoarding2 extends StatefulWidget {
//   const OnBoarding2({Key? key}) : super(key: key);
//
//   @override
//   State<OnBoarding2> createState() => _OnBoarding2State();
// }



class OnBoarding3 extends StatefulWidget {
  const OnBoarding3({Key? key}) : super(key: key);

  @override
  State<OnBoarding3> createState() => _OnBoarding3State();
}

class _OnBoarding3State extends State<OnBoarding3> {
  //


  @override


  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  void init() async {
    await Future.delayed(
      const Duration(seconds: 3),
    );


    // Get.offAndToNamed(Routes.login);
    // Get.offNamed(Routes.chooseYourStoreScreen);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final prefCustomerId = sharedPreferences.getString(AppConstants.prefCustomerId!);
    print("prefCustomerId ----------------------- ${prefCustomerId}");

    if(prefCustomerId != null){
      Get.offNamed(Routes.landingHome);
    }else{
      Get.offAndToNamed(Routes.login);
    }

    // final token = await localRepositoryInterface.getUser();
    // if (token != null) {
    //   Get.offNamed(Routes.landingHome);
    //
    // } else{
    //   Get.offNamed(Routes.login);
    // }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Stack(
          children: [
            Image.asset('assets/img/onboarding3.jpg',
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60.0, right: 20),
                    child: InkWell(
                      onTap: (){
                        Get.offAllNamed(Routes.login);
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.white
                            ),
                          ),
                          SizedBox(width: 5,),
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.white
                            ),
                          ),
                          SizedBox(width: 5,),
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.appRed
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}


// class OnBoarding2 extends GetWidget<OnBoarding2Controller> {
//   const OnBoarding2({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SizedBox(
//         child: Stack(
//           children: [
//             Image.asset('assets/img/onboarding2.jpg',
//                 fit: BoxFit.fill,
//                 height: MediaQuery.of(context).size.height,
//                 width: MediaQuery.of(context).size.width),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 80.0, right: 20),
//                     child: Text(
//                       "Skip",
//                       style: GoogleFonts.inriaSans(
//                           textStyle: const TextStyle(
//                               color: AppColors.white,
//                               fontWeight: FontWeight.w700,
//                               fontSize: 18)),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 80.0),
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 8.0),
//                         child: Container(
//                             alignment: Alignment.centerLeft,
//                             child: Text("Be Trendy",
//                                 style: GoogleFonts.bungeeShade(
//                                     textStyle: const TextStyle(
//                                         color: AppColors.white,
//                                         fontWeight: FontWeight.w400,
//                                         fontSize: 34)))),
//                       ),
//                       Container(
//                           alignment: Alignment.center,
//                           child: Text("For every",
//                               style: GoogleFonts.bungeeShade(
//                                   textStyle: const TextStyle(
//                                       color: AppColors.white,
//                                       fontWeight: FontWeight.w400,
//                                       fontSize: 34)))),
//                       Padding(
//                         padding: const EdgeInsets.only(right: 8.0),
//                         child: Container(
//                             alignment: Alignment.centerRight,
//                             child: Text("Mood",
//                                 style: GoogleFonts.bungeeShade(
//                                     textStyle: const TextStyle(
//                                         color: AppColors.white,
//                                         fontWeight: FontWeight.w400,
//                                         fontSize: 34)))),
//                       ),
//                       SizedBox(height: 50,),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             height: 10,
//                             width: 10,
//                             decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: AppColors.white
//                             ),
//                           ),
//                           SizedBox(width: 5,),
//                           Container(
//                             height: 10,
//                             width: 10,
//                             decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: AppColors.appRed
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }


// class _OnBoarding2State extends State<OnBoarding2> {
//
//   final onBoarding2Controller = Get.put(OnBoarding2Controller(
//       apiRepositoryInterface: Get.find(),localRepositoryInterface: Get.find()));
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       SizedBox(
//       child: Stack(
//
//         children: [
//           Image.asset('assets/img/onboarding2.jpg',fit: BoxFit.fill,height: MediaQuery.of(context).size.height
//             ,width: MediaQuery.of(context).size.width),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Text("Be Trendy",),
//               Text("data"),
//               Text("data"),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
