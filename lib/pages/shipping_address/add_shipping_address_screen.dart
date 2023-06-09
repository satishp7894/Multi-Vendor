import 'package:eshoperapp/constants/app_costants.dart';
import 'package:eshoperapp/models/check_login.dart';
import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/models/register_customer.dart';
import 'package:eshoperapp/models/shipping_address.dart';
import 'package:eshoperapp/models/update_customer_password.dart';
import 'package:eshoperapp/pages/login/views/form.dart';
import 'package:eshoperapp/pages/profile/profile_controller.dart';
import 'package:eshoperapp/pages/profile/views/change_pass_form.dart';
import 'package:eshoperapp/pages/shipping_address/shippig_address_controller.dart';
import 'package:eshoperapp/pages/shipping_address/views/shipping_address_form.dart';
import 'package:eshoperapp/routes/navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eshoperapp/style/theme.dart' as Style;

import '../../utils/snackbar_dialog.dart';

class AddShippingAddressScreen extends StatefulWidget {
  const AddShippingAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddShippingAddressScreen> createState() => _AddShippingAddressScreenState();
}

class _AddShippingAddressScreenState extends State<AddShippingAddressScreen> {

  ShippingAddressController? shippingAddressController;
  bool? editMode;
  ShippingAddress? shippingAddress;

  @override
  void initState() {
    dynamic argumentData = Get.arguments;
    editMode = argumentData[0]['editMode'];
    print("editMode  ${editMode!}");
    if(editMode!){
      shippingAddress = argumentData[1]['addressObj'];
      print("shippingAddress email ${shippingAddress!.email}");
      print("country  ${shippingAddress!.country}");
    }else{
      shippingAddress = ShippingAddress();
    }


    // print("editMode  ${editMode!}");
    shippingAddressController = Get.put(ShippingAddressController(
        apiRepositoryInterface: Get.find(), editMode: editMode!, shippingAddress: shippingAddress!,localRepositoryInterface: Get.find()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          shippingAddressController!.firstNameTextController!.clear();
          shippingAddressController!.lastNameTextController!.clear();
          shippingAddressController!.emailTextController!.clear();
          shippingAddressController!.mobileTextController!.clear();
          shippingAddressController!.localityTextController!.clear();
          shippingAddressController!.landmarkTextController!.clear();
          shippingAddressController!.cityTextController!.clear();
          shippingAddressController!.stateTextController!.clear();
          shippingAddressController!.pincodeTextController!.clear();
          shippingAddressController!.countryTextController!.clear();
          shippingAddressController!.addressTypeTextController!.clear();
          shippingAddressController!.checkBoxValue=0;
          shippingAddressController!.countryList([]);
          shippingAddressController!.stateList([]);

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
          title: InkWell(
              onTap: (){
                print("shippingAddressController!.firstNameTextController ${shippingAddressController!.firstNameTextController}");
                print("shippingAddressController!.checkBoxValue ${shippingAddressController!.checkBoxValue}");
              },
              child: Text("${editMode==true?AppConstants.editAddress:AppConstants.addAddress}", style: TextStyle(fontSize: 20,color: Style.Colors.appColor))),
        ),
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            child: ShippingAddressForm(
              firstNameTextController: shippingAddressController!.firstNameTextController,
              lastNameTextController: shippingAddressController!.lastNameTextController,
              emailTextController: shippingAddressController!.emailTextController,
              mobileTextController: shippingAddressController!.mobileTextController,
              addressTextController: shippingAddressController!.addressTextController,
              // localityTextController: shippingAddressController!.localityTextController,
              // landmarkTextController: shippingAddressController!.landmarkTextController,
              cityTextController: shippingAddressController!.cityTextController,
              stateTextController: shippingAddressController!.stateTextController,
              pincodeTextController: shippingAddressController!.pincodeTextController,
              countryTextController: shippingAddressController!.countryTextController,
              addressTypeTextController: shippingAddressController!.addressTypeTextController,
              editMode: shippingAddressController!.editMode,
              checkBox: shippingAddressController!.checkBoxValue,
              checkBoxValue: (){
                if(shippingAddressController!.checkBoxValue==0){
                  shippingAddressController!.checkBoxValue = 1;
                }else{
                  shippingAddressController!.checkBoxValue = 0;
                }
              },
              saveAddress:editMode! == true ? editAddress:saveAddress,
            ),
          ),
        ),
      ),
    );
  }

 void saveAddress() async {
    // MainResponse? mainResponse = await controller.addAddress("4");
    // if (mainResponse.status! == true) {
    //   // Get.offAllNamed(Routes.login);
    //   Get.back(result: "back");
    //   SnackBarDialog.showSnackbar('Success',mainResponse.message!);
    // } else {
    //   SnackBarDialog.showSnackbar('Error',mainResponse.message!);
    // }

    MainResponse? mainResponse  = await shippingAddressController!.addAddress();
    if(mainResponse != null){
      if (mainResponse.status!) {
        shippingAddressController!.firstNameTextController!.clear();
        shippingAddressController!.lastNameTextController!.clear();
        shippingAddressController!.emailTextController!.clear();
        shippingAddressController!.mobileTextController!.clear();
        shippingAddressController!.localityTextController!.clear();
        shippingAddressController!.landmarkTextController!.clear();
        shippingAddressController!.cityTextController!.clear();
        shippingAddressController!.stateTextController!.clear();
        shippingAddressController!.pincodeTextController!.clear();
        shippingAddressController!.countryTextController!.clear();
        shippingAddressController!.addressTypeTextController!.clear();
        shippingAddressController!.checkBoxValue=0;
        Get.back(result: "back");
        SnackBarDialog.showSnackbar('Success',mainResponse.message!);
        // Get.offAllNamed(Routes.landingHome);

      } else {
        SnackBarDialog.showSnackbar('Error',mainResponse.message!);
      }
    }else{
      print("elseeeeee");
    }

  }

  void editAddress() async {
    // MainResponse? mainResponse = await controller.addAddress("4");
    // if (mainResponse.status! == true) {
    //   // Get.offAllNamed(Routes.login);
    //   Get.back(result: "back");
    //   SnackBarDialog.showSnackbar('Success',mainResponse.message!);
    // } else {
    //   SnackBarDialog.showSnackbar('Error',mainResponse.message!);
    // }

    MainResponse? mainResponse  = await shippingAddressController!.editAddress(shippingAddress!.addressId!);
    if(mainResponse != null){
      if (mainResponse.status!) {
        shippingAddressController!.firstNameTextController!.clear();
        shippingAddressController!.lastNameTextController!.clear();
        shippingAddressController!.emailTextController!.clear();
        shippingAddressController!.mobileTextController!.clear();
        shippingAddressController!.localityTextController!.clear();
        shippingAddressController!.landmarkTextController!.clear();
        shippingAddressController!.cityTextController!.clear();
        shippingAddressController!.stateTextController!.clear();
        shippingAddressController!.pincodeTextController!.clear();
        shippingAddressController!.countryTextController!.clear();
        shippingAddressController!.addressTypeTextController!.clear();
        shippingAddressController!.checkBoxValue=0;
        Get.back(result: "back");
        SnackBarDialog.showSnackbar('Success',mainResponse.message!);
        // Get.offAllNamed(Routes.landingHome);

      } else {
        SnackBarDialog.showSnackbar('Error',mainResponse.message!);
      }
    }else{
      print("elseeeeee");
    }

  }
}