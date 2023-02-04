import 'package:eshoperapp/models/check_login.dart';
import 'package:eshoperapp/models/login_request.dart';
import 'package:eshoperapp/models/register_customer.dart';
import 'package:eshoperapp/models/register_request.dart';
import 'package:eshoperapp/models/user.dart';
import 'package:eshoperapp/repository/api_repository.dart';
import 'package:eshoperapp/repository/local_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';

enum SignType { sigIn, signUp }

class RegisterController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;
  RegisterController({
    required this.localRepositoryInterface,required this.apiRepositoryInterface
  });


  final customerNameTexcontroller = TextEditingController();
  final genderTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final mobileTextController = TextEditingController();
  final passwordTextController = TextEditingController();


  var isLoading = false.obs;

  var isvalidEmail = false.obs;
  var isValidPassword = false.obs;

  RxBool showPassword = true.obs;



  toggleShowPassword() {
    showPassword(!showPassword.value);
  }

  Future<CheckLogin> checkLogin() async {
    final email = emailTextController.text;
    final password = passwordTextController.text;

    try {
      isLoading(true);
      final loginResponse =
      await apiRepositoryInterface.checkLogin(LoginRequest(email, password));

      // if (loginResponse != null) {
        // await localRepositoryInterface.saveToken(loginResponse.token);
      print("loginResponse ${loginResponse!.message}");
      if (loginResponse.data != null){
        print("loginResponse ${loginResponse.data![0]}");

        await localRepositoryInterface.saveUser(loginResponse.data![0]);
        isLoading(false);
        return loginResponse;
      }else{
        isLoading(false);
        return loginResponse;
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

  Future<CheckLogin> registerCustomer(String phone) async {
    final customerName = customerNameTexcontroller.text;
    final gender = genderTextController.text;
    final email = emailTextController.text;
    // final mobile = mobileTextController.text = ;
    final password = passwordTextController.text;

    try {
      isLoading(true);
      final registerResponse =
      await apiRepositoryInterface.registerCustomer(RegisterRequest(customerName,gender,email,phone, password));

      // if (loginResponse != null) {
      // await localRepositoryInterface.saveToken(loginResponse.token);
      print("registerResponse ${registerResponse!.message}");
      if (registerResponse.status == true){
        print("registerResponse ${registerResponse.message}");
        isLoading(false);
        print("registerResponse ${registerResponse.data![0]}");

        await localRepositoryInterface.saveUser(registerResponse.data![0]);
        // await localRepositoryInterface.saveUser(loginResponse.data![0]);
        return registerResponse;
      }else{
        isLoading(false);
        return registerResponse;
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

  // Future<bool> login() async {
  //   final email = emailTextController.text;
  //   final password = passwordTextController.text;
  //
  //   try {
  //     isLoading(true);
  //     final loginResponse =
  //     await apiRepositoryInterface.login(LoginRequest(email, password));
  //
  //     if (loginResponse != null) {
  //       await localRepositoryInterface.saveToken(loginResponse.token);
  //       await localRepositoryInterface.saveUser(loginResponse.user);
  //       return true;
  //     } else
  //       isLoading(false);
  //
  //     return false;
  //   } on Exception {
  //     isLoading(false);
  //     return false;
  //   }
  // }
  //
  // Future<bool> register() async {
  //   final name = nameTexcontroller.text;
  //   final email = emailTextController.text;
  //   final password = passwordTextController.text;
  //
  //   try {
  //     isLoading(true);
  //     final loginResponse = await apiRepositoryInterface.register(
  //         RegisterRequest(name: name, email: email, password: password));
  //     if (loginResponse != null) {
  //       await localRepositoryInterface.saveToken(loginResponse.token);
  //       await localRepositoryInterface.saveUser(loginResponse.user);
  //       return true;
  //     } else
  //       isLoading(false);
  //
  //     return false;
  //   } catch (_) {
  //     isLoading(false);
  //     return false;
  //   }
  // }

  // Future<bool> googleAuth(String? idToken, String provider) async {
  //   try {
  //     // isLoading(true);
  //     // final loginResponse =
  //     //     await apiRepositoryInterface.googleSignIn(idToken, provider);
  //     // if (loginResponse != null) {
  //       await localRepositoryInterface.saveToken(loginResponse.token);
  //       await localRepositoryInterface.saveUser(loginResponse.user);
  //       return true;
  //     // } else
  //     //   isLoading(false);
  //
  //     return false;
  //   }  catch (_) {
  //   //  isLoading(false);
  //     return false;
  //   }
  // }
}
