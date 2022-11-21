import 'package:eshoperapp/models/address_request.dart';
import 'package:eshoperapp/models/check_login.dart';
import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/models/shipping_address.dart';
import 'package:eshoperapp/repository/api_repository.dart';
import 'package:eshoperapp/repository/local_repository.dart';
import 'package:eshoperapp/utils/check_internet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/app_costants.dart';
import '../../models/country_and_state.dart';

class ShippingAddressController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;
  final ShippingAddress shippingAddress;
  final bool editMode;

  ShippingAddressController(
      {required this.apiRepositoryInterface,required this.editMode,required this.shippingAddress,
      required this.localRepositoryInterface});

  RxBool isLoadingGetAddress= false.obs;
  var getAddressObj = MainResponse().obs;

  RxBool isLoadingAddAddress= false.obs;
  var addAddressObj = MainResponse().obs;

  RxString customerId = "".obs;
  var checkLoginData = CheckLoginData().obs;

  RxBool isLoadingCountry = false.obs;
  var countryList = <CountryAndState>[].obs;

  RxBool isLoadingState = true.obs;
  var stateList = <CountryAndState>[].obs;

  RxInt index = 0.obs;

  TextEditingController? firstNameTextController;
  TextEditingController? lastNameTextController;
  TextEditingController? emailTextController;
  TextEditingController? mobileTextController;
  TextEditingController? addressTextController;
  TextEditingController? localityTextController;
  TextEditingController? landmarkTextController;
  TextEditingController? cityTextController;
  TextEditingController? stateTextController;
  TextEditingController? pincodeTextController;
  TextEditingController? countryTextController;
  TextEditingController? addressTypeTextController;
  int? checkBoxValue;
  // RxInt checkBoxValue = 0.obs;
  // bool? checkedValue  = false;






  @override
  void onInit() {
    stateList([]);
    print("stateList init");
    CheckInternet.checkInternet();
    getAddressId();
    getUser();
    getCountry();
    if(editMode){
      print("shippingAddress.firstName ${shippingAddress.firstName}");
      firstNameTextController = TextEditingController(text: shippingAddress.firstName);
      lastNameTextController = TextEditingController(text: shippingAddress.lastName);
      emailTextController = TextEditingController(text: shippingAddress.email);
      mobileTextController = TextEditingController(text: shippingAddress.mobile);
      addressTextController = TextEditingController(text: shippingAddress.address);
      localityTextController = TextEditingController();
      landmarkTextController = TextEditingController();
      cityTextController = TextEditingController(text: shippingAddress.city);
      stateTextController = TextEditingController(text: shippingAddress.state);
      pincodeTextController = TextEditingController(text: shippingAddress.pincode);
      countryTextController = TextEditingController(text: shippingAddress.country);
      addressTypeTextController = TextEditingController(text: shippingAddress.addressType);
      checkBoxValue=int.parse(shippingAddress.setDefault!);
      print("controller.checkBoxValue init  ${checkBoxValue}");
    }else{

      firstNameTextController = TextEditingController();
      lastNameTextController = TextEditingController();
      emailTextController = TextEditingController();
      mobileTextController = TextEditingController();
      addressTextController = TextEditingController();
      localityTextController = TextEditingController();
      landmarkTextController = TextEditingController();
      cityTextController = TextEditingController();
      stateTextController = TextEditingController();
      pincodeTextController = TextEditingController();
      countryTextController = TextEditingController();
      addressTypeTextController = TextEditingController();
      checkBoxValue=0;

    }

    // getAddress("4");
    super.onInit();
  }

  getAddressId() async {
    await SharedPreferences.getInstance().then((value) {
      final addressId = value.getInt(AppConstants.prefAddressId!);
      print("addressId ShippingAddressController ${addressId}");
      if(addressId != null){
        index(addressId);
      }else{
        index(0);
      }
    });

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();



    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // sharedPreferences.setString(AppConstants.prefCustomerId!, checkLoginData!.customerId!);
  }

  getUser() async {
    try {
      // isLoadingCustomerProfile(true);
      await localRepositoryInterface.getUser().then((value) {
        print("getUser customerId ${value!.customerId}");
        if (value.customerId != null) {
          checkLoginData(value);
          customerId(value.customerId!);
          getAddress(value.customerId!);
        }else{
          customerId("");
          checkLoginData();
          getAddress("3");
        }
      });
    } on Exception {
      //isLoadingCustomerProfile(false);

      return MainResponse();
    }
  }



  getAddress(String customerId) async {
    try {
      isLoadingGetAddress(false);
      await apiRepositoryInterface.getAddress(customerId).then((value) {
        getAddressObj(value);
      });
    } finally {
      isLoadingGetAddress(true);
    }
  }

  getCountry() async {
    try {
      isLoadingCountry(false);
      await apiRepositoryInterface.countries().then((value) {
        print("value ${value[0].name}");
        countryList(value);
        isLoadingCountry(true);
      });
    } finally {
      // isLoadingCountry(true);
    }
  }


  getState(String countryCode) async {
    try {
      isLoadingState(false);
      await apiRepositoryInterface.states(countryCode).then((value) {
        stateList(value);
      });
    } finally {
      isLoadingState(true);
    }
  }


  Future<MainResponse> addAddress() async {
    print("customerId ${customerId}");
    final firstName = firstNameTextController!.text;
    final lastName = lastNameTextController!.text;
    final email = emailTextController!.text;
    final mobile = mobileTextController!.text;
    final address = addressTextController!.text;
    final locality = localityTextController!.text;
    final landmark = landmarkTextController!.text;
    final city = cityTextController!.text;
    final state = stateTextController!.text;
    final pincode = pincodeTextController!.text;
    final country = countryTextController!.text;
    final addressType = addressTypeTextController!.text;
    String setDefault = checkBoxValue.toString();
    print("setDefault ${setDefault}");
    try {
      isLoadingAddAddress(true);
      final addAddressResponse = await apiRepositoryInterface.addAddress(AddressRequest(firstName,
          lastName,
          email,
          mobile,
          address,
          locality,
          landmark,
          city,
          state,
          pincode,
          country,
          setDefault,
          addressType),customerId.value);

      //     .then((value) {
      // return  addAddressObj(value);
      //   print("value ${value!.status}");
      // });

      print("addAddressResponse ${addAddressResponse!.message}");
      print("addAddressResponse ${addAddressResponse.status}");
      if (addAddressResponse.data != null){
       // print("loginResponse ${addAddressResponse.data![0]}");

      //  await localRepositoryInterface.saveUser(addAddressResponse.data![0]);
        return addAddressResponse;
      }else{
        isLoadingAddAddress(false);
        return addAddressResponse;
      }
    } finally {
      isLoadingAddAddress(false);
    }
  }

  Future<MainResponse> editAddress(String addressId) async {
    final firstName = firstNameTextController!.text;
    final lastName = lastNameTextController!.text;
    final email = emailTextController!.text;
    final mobile = mobileTextController!.text;
    final address = addressTextController!.text;
    final locality = localityTextController!.text;
    final landmark = landmarkTextController!.text;
    final city = cityTextController!.text;
    final state = stateTextController!.text;
    final pincode = pincodeTextController!.text;
    final country = countryTextController!.text;
    final addressType = addressTypeTextController!.text;
    String setDefault = checkBoxValue.toString();
    try {
      isLoadingAddAddress(true);
      final editAddressResponse = await apiRepositoryInterface.editAddress(AddressRequest(firstName,
          lastName,
          email,
          mobile,
          address,
          locality,
          landmark,
          city,
          state,
          pincode,
          country,
          setDefault,
          addressType),addressId,customerId.value);

      //     .then((value) {
      // return  addAddressObj(value);
      //   print("value ${value!.status}");
      // });

      print("editAddressResponse ${editAddressResponse!.message}");
      print("editAddressResponse ${editAddressResponse.status}");
      if (editAddressResponse.data != null){
        // print("loginResponse ${addAddressResponse.data![0]}");

        //  await localRepositoryInterface.saveUser(addAddressResponse.data![0]);
        return editAddressResponse;
      }else{
        isLoadingAddAddress(false);
        return editAddressResponse;
      }
    } finally {
      isLoadingAddAddress(false);
    }
  }

  Future<MainResponse> deleteAddress(String addressId) async {

    try {
      isLoadingAddAddress(true);
      final deleteAddressResponse = await apiRepositoryInterface.deleteAddress(customerId.value,addressId);



      print("deleteAddressResponse ${deleteAddressResponse!.message}");
      print("deleteAddressResponse ${deleteAddressResponse.status}");
      if (deleteAddressResponse.data != null){
        // print("loginResponse ${addAddressResponse.data![0]}");

        //  await localRepositoryInterface.saveUser(addAddressResponse.data![0]);
        return deleteAddressResponse;
      }else{
        isLoadingAddAddress(false);
        return deleteAddressResponse;
      }
    } finally {
      isLoadingAddAddress(false);
    }
  }

  Future<MainResponse> changeDeliveryAddress(String addressId) async {

    try {
      isLoadingAddAddress(true);
      final changeDeliveryAddress = await apiRepositoryInterface.changeDeliveryAddress(customerId.value,addressId);



      print("changeDeliveryAddress ${changeDeliveryAddress!.message}");
      print("changeDeliveryAddress ${changeDeliveryAddress.status}");
      if (changeDeliveryAddress.data != null){
        // print("loginResponse ${addAddressResponse.data![0]}");

        //  await localRepositoryInterface.saveUser(addAddressResponse.data![0]);
        return changeDeliveryAddress;
      }else{
        isLoadingAddAddress(false);
        return changeDeliveryAddress;
      }
    } finally {
      isLoadingAddAddress(false);
    }
  }
}
