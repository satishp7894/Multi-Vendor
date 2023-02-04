import 'package:eshoperapp/models/change_password_request.dart';
import 'package:eshoperapp/models/customer.dart';
import 'package:eshoperapp/models/forget_password.dart';
import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/models/register_request.dart';
import 'package:eshoperapp/models/update_customer_password.dart';
import 'package:eshoperapp/pages/landing_home/home_controller.dart';
import 'package:eshoperapp/repository/api_repository.dart';
import 'package:eshoperapp/repository/local_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/check_login.dart';

class ProfileController extends GetxController {
  final ApiRepositoryInterface apiRepositoryInterface;
  final LocalRepositoryInterface localRepositoryInterface;
  final Customer? customer;
  final homecontroller = Get.put(HomeController(
      localRepositoryInterface: Get.find(),
      apiRepositoryInterface: Get.find()));

  ProfileController(
      {required this.apiRepositoryInterface,
      required this.localRepositoryInterface,
      required this.customer});

  RxBool isLoadingCustomerProfile = false.obs;
  RxString customerId = "".obs;
  var customerProfileObj = MainResponse().obs;

  RxBool isUserDataRefresh = false.obs;

  var isLoading = false.obs;
  RxBool showCurrentPassword = true.obs;
  RxBool showNewPassword = true.obs;
  RxBool showConfirmPassword = true.obs;
  TextEditingController? passwordTextController;

  TextEditingController? nameTexcontroller;
  TextEditingController? emailTextController;
  TextEditingController? genderTexcontroller;
  TextEditingController? mobileTextController;


  TextEditingController? birthdateTexcontroller;
  TextEditingController? locationTextController;
  TextEditingController? numberTexcontroller;
  TextEditingController? hintTextController;

  TextEditingController? currentPasswordTexcontroller;
  TextEditingController? newPasswordTexcontroller;
  TextEditingController? confirmPasswordTexcontroller;

  @override
  void onInit() {
    passwordTextController = TextEditingController();
    currentPasswordTexcontroller = TextEditingController();
    newPasswordTexcontroller = TextEditingController();
    confirmPasswordTexcontroller = TextEditingController();


    // customerProfile();
    getUser();
    super.onInit();
  }

  toggleShowCurrentPassword() {
    showCurrentPassword(!showCurrentPassword.value);
  }

  toggleShowNewPassword() {
    showNewPassword(!showNewPassword.value);
  }

  toggleShowConfirmPassword() {
    showConfirmPassword(!showConfirmPassword.value);
  }

  Future<UpdateCustomerPassword> updateCustomerPassword() async {
    final currentPass = currentPasswordTexcontroller!.text;
    final newPass = newPasswordTexcontroller!.text;
    final confirmPass = confirmPasswordTexcontroller!.text;

    try {
      isLoading(true);
      final updateCustomerPasswordResponse =
          await apiRepositoryInterface.updateCustomerPassword(
              ChangePasswordRequest(currentPass, newPass, confirmPass),customerId.value);

      // if (loginResponse != null) {
      // await localRepositoryInterface.saveToken(loginResponse.token);
      print("loginResponse ${updateCustomerPasswordResponse!.message}");
      if (updateCustomerPasswordResponse.data != null) {
        print("loginResponse ${updateCustomerPasswordResponse.data![0]}");
        isLoading(false);
        // await localRepositoryInterface.saveUser(updateCustomerPasswordResponse.data![0]);
        return updateCustomerPasswordResponse;
      } else {
        isLoading(false);
        return updateCustomerPasswordResponse;
      }

      // } else{
      //   isLoading(false);
      //
      //   return false;
      // }

    } on Exception {
      isLoading(false);

      return UpdateCustomerPassword();
    }
  }

  Future<ForgetPassword> forgetPassword() async {
    final email = emailTextController!.text;

    try {
      isLoading(true);
      final forgetPasswordResponse =
          await apiRepositoryInterface.forgetPassword(email);

      // if (loginResponse != null) {
      // await localRepositoryInterface.saveToken(loginResponse.token);
      print("loginResponse ${forgetPasswordResponse!.message}");
      if (forgetPasswordResponse.status == true) {
        // print("loginResponse ${updateCustomerPasswordResponse.data![0]}");

        // await localRepositoryInterface.saveUser(updateCustomerPasswordResponse.data![0]);
        isLoading(false);
        return forgetPasswordResponse;
      } else {
        isLoading(false);
        return forgetPasswordResponse;
      }

      // } else{
      //   isLoading(false);
      //
      //   return false;
      // }

    } on Exception {
      isLoading(false);

      return ForgetPassword();
    }
  }

  customerProfile(String? customerId) async {
    try {
      isLoadingCustomerProfile(true);
      if (customerId != null) {
        customerId = customerId;
      } else {
        customerId = "";
      }
      await apiRepositoryInterface.customerProfile(customerId).then((value) {
        customerProfileObj(value);
        isLoadingCustomerProfile(false);
      });
    } on Exception {
      isLoadingCustomerProfile(false);

      return MainResponse();
    }
  }

  getUser() async {
    try {
      // isLoadingCustomerProfile(true);
      await localRepositoryInterface.getUser().then((value) {
        print("getUser customerId ${value!.customerId}");
        if (value.customerId != null) {
          customerId(value.customerId);
          customerProfile(value.customerId);
        }else{
          customerId("");
          // customerProfile(value.customerId);
        }
      });
    } on Exception {
      //isLoadingCustomerProfile(false);

      return MainResponse();
    }
  }

  Future<bool> logout() async {
    try {
      // isLoadingCustomerProfile(true);
      await localRepositoryInterface.clearAllData();
      homecontroller.cartList([]);
      homecontroller.getCartItems("", false);
      print("clearAllData");
      return true;

      //     .then((value) {
      //   print("clearAllData");
      //   return true;
      //   // if (value.customerId != null) {
      //   //   customerId(value.customerId);
      //   //   customerProfile(value.customerId);
      //   // }
      // });
    } on Exception {
      //isLoadingCustomerProfile(false);

      return false;
    }
  }

  Future<CheckLogin> updateCustomerProfile() async {
    final customerName = nameTexcontroller!.text;
    final gender = genderTexcontroller!.text;
    final email = emailTextController!.text;
    final mobile = mobileTextController!.text;
    final password = passwordTextController!.text;
    final alterNateNumber = numberTexcontroller!.text;
    final birthDate = birthdateTexcontroller!.text;

    try {
      isLoading(true);
      final checkLogin = await apiRepositoryInterface.updateCustomerProfile(
          RegisterRequest(customerName, gender, email, mobile, password), customerId.value,alterNateNumber,birthDate);

      // if (loginResponse != null) {
      // await localRepositoryInterface.saveToken(loginResponse.token);
      print("loginResponse ${checkLogin!.message}");
      if (checkLogin.status == true) {
        print("loginResponse ${checkLogin.message}");

        if(checkLogin.data != null){
          await localRepositoryInterface.saveUser(checkLogin.data![0]);
        }

        // await localRepositoryInterface.saveUser(loginResponse.data![0]);
        return checkLogin;
      } else {
        isLoading(false);
        return checkLogin;
      }

      // } else{
      //   isLoading(false);
      //
      //   return false;
      // }

    } on Exception {
      isLoading(false);

      return CheckLogin();
    }
  }

  Future<bool> submit() async {
    // final email = emailTextController.text;
    // final password = passwordTextController.text;

    return true;
    // try {
    //   isLoading(true);
    //   final loginResponse =
    //   await apiRepositoryInterface.login(LoginRequest(email, password));
    //
    //   if (loginResponse != null) {
    //     await localRepositoryInterface.saveToken(loginResponse.token);
    //     await localRepositoryInterface.saveUser(loginResponse.user);
    //     return true;
    //   } else
    //     isLoading(false);
    //
    //   return false;
    // } on Exception {
    //   isLoading(false);
    //   return false;
    // }
  }
}
