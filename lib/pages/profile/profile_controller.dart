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

  TextEditingController? currentPasswordTexcontroller;
  TextEditingController? newPasswordTexcontroller;
  TextEditingController? confirmPasswordTexcontroller;

  @override
  void onInit() {
    passwordTextController = TextEditingController();
    currentPasswordTexcontroller = TextEditingController();
    newPasswordTexcontroller = TextEditingController();
    confirmPasswordTexcontroller = TextEditingController();
    if (customer != null) {
      emailTextController = TextEditingController(text: customer!.email);
      genderTexcontroller = TextEditingController(text: customer!.gender);
      nameTexcontroller = TextEditingController(text: customer!.customerName);
      mobileTextController = TextEditingController(text: customer!.mobile);
      // passwordTextController = TextEditingController(text: customer!.customerName);
      // passwordTextController = TextEditingController(text: customer!.customerName);
      // passwordTextController = TextEditingController(text: customer!.customerName);
    } else {
      emailTextController = TextEditingController();
      genderTexcontroller = TextEditingController();
      nameTexcontroller = TextEditingController();
      mobileTextController = TextEditingController();
    }

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

  Future<MainResponse> updateCustomerProfile() async {
    final customerName = nameTexcontroller!.text;
    final gender = genderTexcontroller!.text;
    final email = emailTextController!.text;
    final mobile = mobileTextController!.text;
    final password = passwordTextController!.text;

    try {
      isLoading(true);
      final mainResponse = await apiRepositoryInterface.updateCustomerProfile(
          RegisterRequest(customerName, gender, email, mobile, password), customerId.value);

      // if (loginResponse != null) {
      // await localRepositoryInterface.saveToken(loginResponse.token);
      print("loginResponse ${mainResponse!.message}");
      if (mainResponse.status == true) {
        print("loginResponse ${mainResponse.message}");

        // await localRepositoryInterface.saveUser(loginResponse.data![0]);
        return mainResponse;
      } else {
        isLoading(false);
        return mainResponse;
      }

      // } else{
      //   isLoading(false);
      //
      //   return false;
      // }

    } on Exception {
      isLoading(false);

      return MainResponse();
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
