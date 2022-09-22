import 'package:eshoperapp/constants/app_costants.dart';
import 'package:eshoperapp/models/check_login.dart';
import 'package:eshoperapp/models/forget_password.dart';
import 'package:eshoperapp/models/register_customer.dart';
import 'package:eshoperapp/models/update_customer_password.dart';
import 'package:eshoperapp/pages/login/views/form.dart';
import 'package:eshoperapp/pages/profile/profile_controller.dart';
import 'package:eshoperapp/pages/profile/views/change_pass_form.dart';
import 'package:eshoperapp/pages/profile/views/forget_pass_form.dart';
import 'package:eshoperapp/routes/navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eshoperapp/style/theme.dart' as Style;

import '../../utils/snackbar_dialog.dart';

class ForgetPasswordScreen extends GetWidget<ProfileController> {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  void submit() async {
    ForgetPassword? forgetPassword = await controller.forgetPassword();
    if (forgetPassword.status!) {
      controller.emailTextController!.clear();
      controller.isUserDataRefresh(true);
      controller.logout();
      // Get.snackbar('Success', forgetPassword.message!,duration: const Duration(seconds: 8), snackPosition: SnackPosition.BOTTOM,);
      SnackBarDialog.showSnackbar('Success',forgetPassword.message!);
      Get.offNamed(Routes.login);
    } else {
      // controller.emailTextController!.clear();
      // Get.offNamed(Routes.login);
      // Get.snackbar('Error', forgetPassword.message!,duration: const Duration(seconds: 8), snackPosition: SnackPosition.BOTTOM,);
      SnackBarDialog.showSnackbar('Error',forgetPassword.message!);
    }
  }

  // void register() async {
  //   print('register call in screen');
  //   RegisterCustomer? registerCustomer = await controller.registerCustomer();
  //   if (registerCustomer.status!) {
  //     Get.offAllNamed(Routes.login);
  //   } else {
  //     Get.snackbar('Error', registerCustomer.message!);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.emailTextController!.clear();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Style.Colors.appColor,
              size: 30,
            ),
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          ),
          title:  const Text("${AppConstants.forgetPassword}", style: TextStyle(fontSize: 20,color: Style.Colors.appColor)),
        ),
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

                    ForgetPassForm(
                      email: controller.emailTextController,
                      submitAction:submit,
                    )
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