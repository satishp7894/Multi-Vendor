import 'package:eshoperapp/models/check_login.dart';
import 'package:eshoperapp/models/register_customer.dart';
import 'package:eshoperapp/pages/landing_home/home_controller.dart';
import 'package:eshoperapp/pages/login/views/form.dart';
import 'package:eshoperapp/pages/profile/profile_controller.dart';
import 'package:eshoperapp/routes/navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/snackbar_dialog.dart';
import 'login_controller.dart';

class LoginScreen extends GetWidget<LoginController> {
  final profileController = Get.find<ProfileController>();
  final homeController = Get.find<HomeController>();
  void login() async {
    CheckLogin? checkLogin = await controller.checkLogin();
    if (checkLogin.status!) {
      Get.back();
      controller.customerNameTexcontroller.clear();
      controller.genderTextController.clear();
      controller.emailTextController.clear();
      controller.mobileTextController.clear();
      controller.passwordTextController.clear();
      profileController.isUserDataRefresh(true);
      // Get.snackbar('Success', checkLogin.message!,duration: const Duration(seconds: 8), snackPosition: SnackPosition.BOTTOM,);
      SnackBarDialog.showSnackbar('Success',checkLogin.message!);
      await profileController.getUser();
      await homeController.loadUser(true);
      homeController.getCartItems(profileController.customerId.value, true);
    } else {
      // Get.snackbar('Error', checkLogin.message!,duration: const Duration(seconds: 8), snackPosition: SnackPosition.BOTTOM,);
      SnackBarDialog.showSnackbar('Error',checkLogin.message!);
    }
  }

  void register() async {
    print('register call in screen');
    RegisterCustomer? registerCustomer = await controller.registerCustomer();
    if (registerCustomer.status!) {
      controller.customerNameTexcontroller.clear();
      controller.genderTextController.clear();
      controller.emailTextController.clear();
      controller.mobileTextController.clear();
      controller.passwordTextController.clear();
      // Get.toNamed(Routes.login);
      //Get.offNamed(Routes.login);
      controller.toggleFormType();
      // Get.snackbar('Success', registerCustomer.message!,duration: const Duration(seconds: 8), snackPosition: SnackPosition.BOTTOM,);
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
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(() {
                      return SignForm(
                        customerName: controller.customerNameTexcontroller,
                        gender: controller.genderTextController,
                        email: controller.emailTextController,
                        mobile: controller.mobileTextController,
                        password: controller.passwordTextController,
                        logOrRegAction:
                        controller.isSignIn.value ? login : register,
                      );
                    })
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}