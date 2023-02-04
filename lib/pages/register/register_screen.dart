import 'package:eshoperapp/models/check_login.dart';
import 'package:eshoperapp/models/register_customer.dart';
import 'package:eshoperapp/pages/landing_home/home_controller.dart';
import 'package:eshoperapp/pages/login/views/form.dart';
import 'package:eshoperapp/pages/profile/profile_controller.dart';
import 'package:eshoperapp/pages/register/views/form.dart';
import 'package:eshoperapp/routes/navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/theme.dart';
import '../../constants/app_costants.dart';
import '../../models/customer.dart';
import '../../utils/snackbar_dialog.dart';
import 'register_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final controller =
  Get.put(RegisterController(
  apiRepositoryInterface: Get.find(), localRepositoryInterface: Get.find()));
  final profileController = Get.find<ProfileController>();
  final homeController = Get.find<HomeController>();

  dynamic argumentData = Get.arguments;
  bool editMode = false;
  String phone = "";
  @override
  void initState() {
    editMode = argumentData[0]["editMode"];
    phone = argumentData[1]["phone"];
    print("phone initState===== $phone");
    super.initState();
  }

  void login() async {
    Get.toNamed(Routes.otpScreen,arguments: [
      {"editMode": true},
      {"phone": controller.mobileTextController.text},
    ]);
    // CheckLogin? checkLogin = await controller.checkLogin();
    // if (checkLogin.status!) {
    //   Get.back();
    //   controller.customerNameTexcontroller.clear();
    //   controller.genderTextController.clear();
    //   controller.emailTextController.clear();
    //   controller.mobileTextController.clear();
    //   controller.passwordTextController.clear();
    //   profileController.isUserDataRefresh(true);
    //   // Get.snackbar('Success', checkLogin.message!,duration: const Duration(seconds: 8), snackPosition: SnackPosition.BOTTOM,);
    //   SnackBarDialog.showSnackbar('Success',checkLogin.message!);
    //   await profileController.getUser();
    //   await homeController.loadUser(true);
    //   homeController.getCartItems(profileController.customerId.value, true);
    // } else {
    //   // Get.snackbar('Error', checkLogin.message!,duration: const Duration(seconds: 8), snackPosition: SnackPosition.BOTTOM,);
    //   SnackBarDialog.showSnackbar('Error',checkLogin.message!);
    // }
  }

  void register() async {
    print('register call in screen');
    // Get.toNamed(Routes.otpScreen,arguments: [
    //   {"editMode": false},
    //   {"phone": controller.mobileTextController.text},
    // ]);
    CheckLogin? registerCustomer = await controller.registerCustomer(phone);
    if (registerCustomer.status!) {
      controller.customerNameTexcontroller.clear();
      controller.genderTextController.clear();
      controller.emailTextController.clear();
      controller.mobileTextController.clear();
      controller.passwordTextController.clear();
      // Get.toNamed(Routes.login);
      //Get.offNamed(Routes.login);
      // controller.toggleFormType();
      // Get.snackbar('Success', registerCustomer.message!,duration: const Duration(seconds: 8), snackPosition: SnackPosition.BOTTOM,);
      // Get.offAllNamed(Routes.landingHome);
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance() ;

      print("sharedPreferences.getString(AppConstants.chooseType!) ===============> ${sharedPreferences.getString(AppConstants.chooseType!)}");

      if(sharedPreferences.getString(AppConstants.chooseType!) != null ){
        Get.offAllNamed(Routes.landingHome);
      }else{
        Get.offAndToNamed(Routes.chooseYourStoreScreen);
      }
      SnackBarDialog.showSnackbar('Success',registerCustomer.message!);
    } else {
      // Get.offNamed(Routes.login);
      // controller.toggleFormType();
      // controller.customerNameTexcontroller.clear();
      // controller.genderTextController.clear();
      // controller.emailTextController.clear();
      // controller.mobileTextController.clear();
      // controller.passwordTextController.clear();
      // controller.toggleFormType();
      // Get.snackbar('Error', registerCustomer.message!);
      SnackBarDialog.showSnackbar('Error',registerCustomer.message!);

    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.customerNameTexcontroller.clear();
        controller.genderTextController.clear();
        controller.emailTextController.clear();
        controller.mobileTextController.clear();
        controller.passwordTextController.clear();
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          // leading: Center(
          //   child: IconButton(
          //     icon: Image.asset(
          //       "assets/img/arrow_left.png",
          //       fit: BoxFit.fill,
          //       height: 14,width: 17,
          //     ),
          //     onPressed: () => Get.back(),
          //   ),
          // ),
          actions: [
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: InkWell(
            //     onTap: (){
            //       Get.offNamed(Routes.chooseYourStoreScreen);
            //     },
            //     child: Text("Skip",
            //         style: GoogleFonts.inriaSerif(
            //             textStyle: TextStyle(
            //                 letterSpacing: 1.0,
            //                 fontSize: 18,
            //                 fontWeight: FontWeight.bold,
            //                 color: AppColors.black))),
            //   ),
            // ),
          ],
        ),
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SignUPForm(
                      customerName: controller.customerNameTexcontroller,
                      gender: controller.genderTextController,
                      email: controller.emailTextController,
                      mobile: controller.mobileTextController,
                      password: controller.passwordTextController,
                      regAction:
                      register,


                    )
                  ],
                ),
              ),
              // Container(
              //   alignment: Alignment.topRight,
              //   child: Padding(
              //     padding: const EdgeInsets.only(top: 40.0, right: 15.0),
              //     child: Text("Skip",
              //         style: GoogleFonts.inriaSans(
              //             textStyle: TextStyle(
              //                 fontSize: 20,
              //                 fontWeight: FontWeight.w700,
              //                 color: AppColors.black))),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}


// class ResgisterScreen extends GetWidget<RegisterController> {
//   // final profileController =
//   // Get.put(ProfileController(
//   // apiRepositoryInterface: Get.find(), customer: Customer(), localRepositoryInterface: Get.find()));
//   final profileController = Get.find<ProfileController>();
//   final homeController = Get.find<HomeController>();
//
//
//   void login() async {
//     Get.toNamed(Routes.otpScreen,arguments: [
//           {"editMode": true},
//           {"phone": controller.mobileTextController.text},
//         ]);
//     // CheckLogin? checkLogin = await controller.checkLogin();
//     // if (checkLogin.status!) {
//     //   Get.back();
//     //   controller.customerNameTexcontroller.clear();
//     //   controller.genderTextController.clear();
//     //   controller.emailTextController.clear();
//     //   controller.mobileTextController.clear();
//     //   controller.passwordTextController.clear();
//     //   profileController.isUserDataRefresh(true);
//     //   // Get.snackbar('Success', checkLogin.message!,duration: const Duration(seconds: 8), snackPosition: SnackPosition.BOTTOM,);
//     //   SnackBarDialog.showSnackbar('Success',checkLogin.message!);
//     //   await profileController.getUser();
//     //   await homeController.loadUser(true);
//     //   homeController.getCartItems(profileController.customerId.value, true);
//     // } else {
//     //   // Get.snackbar('Error', checkLogin.message!,duration: const Duration(seconds: 8), snackPosition: SnackPosition.BOTTOM,);
//     //   SnackBarDialog.showSnackbar('Error',checkLogin.message!);
//     // }
//   }
//
//   void register() async {
//     print('register call in screen');
//     Get.toNamed(Routes.otpScreen,arguments: [
//       {"editMode": false},
//       {"phone": controller.mobileTextController.text},
//     ]);
//     // RegisterCustomer? registerCustomer = await controller.registerCustomer();
//     // if (registerCustomer.status!) {
//     //   controller.customerNameTexcontroller.clear();
//     //   controller.genderTextController.clear();
//     //   controller.emailTextController.clear();
//     //   controller.mobileTextController.clear();
//     //   controller.passwordTextController.clear();
//     //   // Get.toNamed(Routes.login);
//     //   //Get.offNamed(Routes.login);
//     //   controller.toggleFormType();
//     //   // Get.snackbar('Success', registerCustomer.message!,duration: const Duration(seconds: 8), snackPosition: SnackPosition.BOTTOM,);
//     //   SnackBarDialog.showSnackbar('Success',registerCustomer.message!);
//     // } else {
//     //   // Get.offNamed(Routes.login);
//     //   // controller.toggleFormType();
//     //   // controller.customerNameTexcontroller.clear();
//     //   // controller.genderTextController.clear();
//     //   // controller.emailTextController.clear();
//     //   // controller.mobileTextController.clear();
//     //   // controller.passwordTextController.clear();
//     //   // controller.toggleFormType();
//     //   // Get.snackbar('Error', registerCustomer.message!);
//     //   SnackBarDialog.showSnackbar('Error',registerCustomer.message!);
//     //
//     // }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         controller.customerNameTexcontroller.clear();
//         controller.genderTextController.clear();
//         controller.emailTextController.clear();
//         controller.mobileTextController.clear();
//         controller.passwordTextController.clear();
//         return true;
//       },
//       child: Scaffold(
//         backgroundColor: AppColors.white,
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Colors.white,
//           // leading: Center(
//           //   child: IconButton(
//           //     icon: Image.asset(
//           //       "assets/img/arrow_left.png",
//           //       fit: BoxFit.fill,
//           //       height: 14,width: 17,
//           //     ),
//           //     onPressed: () => Get.back(),
//           //   ),
//           // ),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: InkWell(
//                 onTap: (){
//                   Get.offNamed(Routes.chooseYourStoreScreen);
//                 },
//                 child: Text("Skip",
//                     style: GoogleFonts.inriaSerif(
//                         textStyle: TextStyle(
//                             letterSpacing: 1.0,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: AppColors.black))),
//               ),
//             ),
//           ],
//         ),
//         body: SafeArea(
//           child: Stack(
//             children: [
//               SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Obx(() {
//                       return SignUPForm(
//                         customerName: controller.customerNameTexcontroller,
//                         gender: controller.genderTextController,
//                         email: controller.emailTextController,
//                         mobile: controller.mobileTextController,
//                         password: controller.passwordTextController,
//                         regAction:
//                             register,
//
//
//                       );
//                     })
//                   ],
//                 ),
//               ),
//               // Container(
//               //   alignment: Alignment.topRight,
//               //   child: Padding(
//               //     padding: const EdgeInsets.only(top: 40.0, right: 15.0),
//               //     child: Text("Skip",
//               //         style: GoogleFonts.inriaSans(
//               //             textStyle: TextStyle(
//               //                 fontSize: 20,
//               //                 fontWeight: FontWeight.w700,
//               //                 color: AppColors.black))),
//               //   ),
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }