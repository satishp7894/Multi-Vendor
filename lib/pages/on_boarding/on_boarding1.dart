import 'package:eshoperapp/config/theme.dart';
import 'package:eshoperapp/pages/on_boarding/onboarding1_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

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

    Get.offNamed(Routes.onBoarding2);
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
            Image.asset('assets/img/onboarding1.jpg',
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60.0, right: 20),
                    child: Text(
                      "Skip",
                      style: GoogleFonts.inriaSans(
                          textStyle: const TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
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
                              color: AppColors.appRed
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
                                color: AppColors.white
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
