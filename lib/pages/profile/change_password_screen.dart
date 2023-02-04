import 'package:eshoperapp/constants/app_costants.dart';
import 'package:eshoperapp/models/check_login.dart';
import 'package:eshoperapp/models/register_customer.dart';
import 'package:eshoperapp/models/update_customer_password.dart';
import 'package:eshoperapp/pages/login/views/form.dart';
import 'package:eshoperapp/pages/profile/profile_controller.dart';
import 'package:eshoperapp/pages/profile/views/change_pass_form.dart';
import 'package:eshoperapp/routes/navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eshoperapp/style/theme.dart' as Style;
import 'package:google_fonts/google_fonts.dart';

import '../../config/theme.dart';
import '../../utils/snackbar_dialog.dart';
import '../../widgets/app_bar_title.dart';


class ChangePasswordScreen extends GetWidget<ProfileController> {
  void submit() async {
    UpdateCustomerPassword? updateCustomerPassword = await controller.updateCustomerPassword();
    if (updateCustomerPassword.status!) {
      controller.currentPasswordTexcontroller!.clear();
      controller.newPasswordTexcontroller!.clear();
      controller.confirmPasswordTexcontroller!.clear();
      controller.isUserDataRefresh(true);
      controller.logout();
      // Get.snackbar('Success', updateCustomerPassword.message!,duration: const Duration(seconds: 8), snackPosition: SnackPosition.BOTTOM,);
      SnackBarDialog.showSnackbar('Success',updateCustomerPassword.message!);
      Get.offNamed(Routes.login);
    } else {
      // controller.currentPasswordTexcontroller!.clear();
      // controller.newPasswordTexcontroller!.clear();
      // controller.confirmPasswordTexcontroller!.clear();
      // Get.offNamed(Routes.login);
      // Get.snackbar('Error', updateCustomerPassword.message!,duration: const Duration(seconds: 8), snackPosition: SnackPosition.BOTTOM,);
      SnackBarDialog.showSnackbar('Error',updateCustomerPassword.message!);
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
        controller.currentPasswordTexcontroller!.clear();
        controller.newPasswordTexcontroller!.clear();
        controller.confirmPasswordTexcontroller!.clear();
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.appBg,
        // appBar: AppBar(
        //   elevation: 1,
        //   backgroundColor: Colors.white,
        //   leading: IconButton(
        //     icon: Image.asset("assets/img/arrow_left.png",fit: BoxFit.fill,height: 20,width: 22,),
        //
        //     // Icon(
        //     //   Icons.arrow_back,
        //     //   color: Style.Colors.appColor,
        //     //   size: 30,
        //     // ),
        //     onPressed: () =>  Get.back(),
        //   ),
        //   title: Text("${AppConstants.changePassword}", style: GoogleFonts.inriaSans(textStyle: TextStyle(color:AppColors.appText,fontSize: 20,fontWeight: FontWeight.w700 ))),
        // ),
        // appBar: AppBar(
        //   elevation: 5,
        //   backgroundColor: Colors.white,
        //   leading: IconButton(
        //     icon: Icon(
        //       Icons.arrow_back,
        //       color: Style.Colors.appColor,
        //       size: 30,
        //     ),
        //     onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        //   ),
        //   title: const Text("${AppConstants.changePassword}", style: TextStyle(fontSize: 20,color: Style.Colors.appColor)),
        // ),
        body: SafeArea(
          child: Column(
            children: [
              AppbarTitleWidget(title: "${AppConstants.changePassword}",flag: false,),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 16,),
                      ChangePassForm(
                        currentPassword: controller.currentPasswordTexcontroller,
                        newPassword: controller.newPasswordTexcontroller,
                        confirmPassword: controller.confirmPasswordTexcontroller,
                        submitAction:submit,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}