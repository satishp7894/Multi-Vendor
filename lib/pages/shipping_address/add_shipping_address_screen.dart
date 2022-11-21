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
import 'package:google_fonts/google_fonts.dart';

import '../../config/theme.dart';
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
  String? selectedSalutation;

  // void socialLogin(String? idToken, String provider) async {


  String? selectedCountry;
  String? selectedState;

  bool? checkedValue = false;
  int? groupValue;

  final _formKey = GlobalKey<FormState>();
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
        backgroundColor: AppColors.appBg,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.white,
          leading: InkWell(
            onTap: (){
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: Image.asset(
              'assets/img/arrow_left.png',
              color: AppColors.appText,
            ),
          ),
          // leading: IconButton(
          //   icon: Icon(
          //     Icons.arrow_back,
          //     color: Style.Colors.appColor,
          //     size: 30,
          //   ),
          //   onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          // ),
          title: InkWell(
              onTap: (){
                print("shippingAddressController!.firstNameTextController ${shippingAddressController!.firstNameTextController}");
                print("shippingAddressController!.checkBoxValue ${shippingAddressController!.checkBoxValue}");
              },
              child: Text("${editMode==true?AppConstants.editAddress:AppConstants.addAddress}",  style: CustomTextStyle.appBarTitle,)),
        ),
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            child: buildSignType()

            // ShippingAddressForm(
            //   firstNameTextController: shippingAddressController!.firstNameTextController,
            //   lastNameTextController: shippingAddressController!.lastNameTextController,
            //   emailTextController: shippingAddressController!.emailTextController,
            //   mobileTextController: shippingAddressController!.mobileTextController,
            //   addressTextController: shippingAddressController!.addressTextController,
            //   // localityTextController: shippingAddressController!.localityTextController,
            //   // landmarkTextController: shippingAddressController!.landmarkTextController,
            //   cityTextController: shippingAddressController!.cityTextController,
            //   stateTextController: shippingAddressController!.stateTextController,
            //   pincodeTextController: shippingAddressController!.pincodeTextController,
            //   countryTextController: shippingAddressController!.countryTextController,
            //   addressTypeTextController: shippingAddressController!.addressTypeTextController,
            //   editMode: shippingAddressController!.editMode,
            //   checkBox: shippingAddressController!.checkBoxValue,
            //   checkBoxValue: (){
            //     if(shippingAddressController!.checkBoxValue==0){
            //       shippingAddressController!.checkBoxValue = 1;
            //     }else{
            //       shippingAddressController!.checkBoxValue = 0;
            //     }
            //   },
            //   saveAddress:editMode! == true ? editAddress:saveAddress,
            // ),
          ),
        ),
        bottomNavigationBar:  Container(
          // color: AppColors.appText1,
          color: AppColors.appText1,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    // onChanged!();
                  },
                  child:  Padding(
                    padding: const EdgeInsets.only(top: 1.0),
                    child: Container(
                        color: Colors.white,

                        child: Center(
                          child: Text('CANCEL',
                              style: GoogleFonts.inriaSans(
                                  textStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight:
                                      FontWeight
                                          .w700,
                                      color: AppColors
                                          .appText1))),
                        )),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    // onChanged!();
                  },
                  child: Container(
                      color: AppColors.appText1,

                      child: Center(
                        child: Text('SAVE',
                            style: GoogleFonts.inriaSans(
                                textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight:
                                    FontWeight
                                        .w700,
                                    color: AppColors
                                        .white))),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSignType() {

    // print("addressTypeTextController ${widget.addressTypeTextController!.text}");
    // print("controller.checkedValue.value ${controller.checkedValue.value}");
    // bool b =bool.hasEnvironment(controller.checkedValue.value.toString());
    // print("bbbbbbbbbbbbbbb ${b}");
    // final title = controller.isSignIn.value ? 'Welcome,' : 'Create Account';
    // final primary = controller.isSignIn.value
    //     ? 'Sign In To  Continue!'
    //     : 'Sign Up To Get Started!';
    //
    // final btnText = controller.isSignIn.value ? 'Login' : 'Create';
    // final secondary =
    //     controller.isSignIn.value ? 'Need an profile?' : 'Have you profile?';
    //
    // final signInOrRegister = controller.isSignIn.value ? 'Register' : 'SignIn';

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment:MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
              color: AppColors.white,
              child: Padding(
                padding: const EdgeInsets.only(top:10.5,left: AppSizes.labelPadding,right: AppSizes.labelPadding,bottom: 10.5),
                child: Text("ADD NEW ADDRESS",style: CustomTextStyle.label,),
              )),
            Container(
              height: 2,
              width: MediaQuery.of(context).size.width,
              color: AppColors.tileLine,
            ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // DefaultLogo(),
                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(title,
                  //         style: const TextStyle(
                  //             fontSize: 24, fontWeight: FontWeight.bold)),
                  //     const SizedBox(
                  //       height: 5,
                  //     ),
                  //     Text(primary, style: TextStyle(fontSize: 18)),
                  //   ],
                  // ),
                  const SizedBox(
                    height: 20,
                  ),

                  Container(
                    color: AppColors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(AppSizes.sidePadding),
                      child: Column(
                        children: [
                        FormField<String>(
                          validator: (value) {
                            if (shippingAddressController!.firstNameTextController!.text.isEmpty) {
                              return 'This field is required';
                            } else {
                              return null;
                            }
                          },

                          builder: (state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.appText1,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: 60,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    height: 60,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: TextFormField(
                                        onChanged: (text){
                                          setState(() {
                                            shippingAddressController!.firstNameTextController!.text = text;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Name *',
                                          labelText: 'Name *',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  state.errorText ?? '',
                                  style: TextStyle(
                                    color: Theme.of(context).errorColor,
                                  ),
                                ),
                              )
                            ],
                          );
                          },
                        ), FormField<String>(
                            validator: (value) {
                              if (shippingAddressController!.mobileTextController!.text.isEmpty) {
                                return 'This field is required';
                              } else {
                                return null;
                              }
                            },

                            builder: (state) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.appText1,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          height: 60,
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        height: 60,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: TextFormField(
                                            onChanged: (text){
                                              setState(() {
                                                shippingAddressController!.mobileTextController!.text = text;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Mobile *',
                                              labelText: 'Mobile *',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      state.errorText ?? '',
                                      style: TextStyle(
                                        color: Theme.of(context).errorColor,
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                      ],),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: AppColors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(AppSizes.sidePadding),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Container(
                              width: 150,
                              child: FormField<String>(
                                validator: (value) {
                                  if (shippingAddressController!.pincodeTextController!.text.isEmpty) {
                                    return 'This field is required';
                                  } else {
                                    return null;
                                  }
                                },

                                builder: (state) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: AppColors.appText1,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              height: 60,
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            height: 60,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 8.0),
                                              child: TextFormField(
                                                onChanged: (text){
                                                  setState(() {
                                                    shippingAddressController!.pincodeTextController!.text = text;
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Pincode *',
                                                  labelText: 'Pincode *',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          state.errorText ?? '',
                                          style: TextStyle(
                                            color: Theme.of(context).errorColor,
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                            Container(
                              width: 150,
                              child: FormField<String>(
                                validator: (value) {
                                  if (shippingAddressController!.stateTextController!.text.isEmpty) {
                                    return 'This field is required';
                                  } else {
                                    return null;
                                  }
                                },

                                builder: (state) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: AppColors.appText1,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              height: 60,
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            height: 60,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 8.0),
                                              child: TextFormField(
                                                onChanged: (text){
                                                  setState(() {
                                                    shippingAddressController!.stateTextController!.text = text;
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'State *',
                                                  labelText: 'State *',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          state.errorText ?? '',
                                          style: TextStyle(
                                            color: Theme.of(context).errorColor,
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],),
                          FormField<String>(
                            validator: (value) {
                              if (shippingAddressController!.addressTextController!.text.isEmpty) {
                                return 'This field is required';
                              } else {
                                return null;
                              }
                            },

                            builder: (state) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.appText1,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          height: 60,
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        height: 60,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: TextFormField(
                                            onChanged: (text){
                                              setState(() {
                                                shippingAddressController!.addressTextController!.text = text;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Address(House No, Building, Street, Area) *',
                                              labelText: 'Address(House No, Building, Street, Area) *',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      state.errorText ?? '',
                                      style: TextStyle(
                                        color: Theme.of(context).errorColor,
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                          FormField<String>(
                            validator: (value) {
                              if (shippingAddressController!.localityTextController!.text.isEmpty) {
                                return 'This field is required';
                              } else {
                                return null;
                              }
                            },

                            builder: (state) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.appText1,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          height: 60,
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        height: 60,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: TextFormField(
                                            onChanged: (text){
                                              setState(() {
                                                shippingAddressController!.localityTextController!.text = text;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Locality/ Town *',
                                              labelText: 'Locality/ Town *',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      state.errorText ?? '',
                                      style: TextStyle(
                                        color: Theme.of(context).errorColor,
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                          FormField<String>(
                            validator: (value) {
                              if (shippingAddressController!.cityTextController!.text.isEmpty) {
                                return 'This field is required';
                              } else {
                                return null;
                              }
                            },

                            builder: (state) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.appText1,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          height: 60,
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        height: 60,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: TextFormField(
                                            onChanged: (text){
                                              setState(() {
                                                shippingAddressController!.cityTextController!.text = text;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Locality/ Town *',
                                              labelText: 'Locality/ Town *',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      state.errorText ?? '',
                                      style: TextStyle(
                                        color: Theme.of(context).errorColor,
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        ],),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: AppColors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(AppSizes.sidePadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text("Type of Address *",style: CustomTextStyle.label14,),
                        ),
                          SizedBox(height: 10,),
                          Row(children: [
                            Row(
                              children: [
                                Radio(
                                  value: 1,

                                  groupValue: groupValue,
                                  onChanged: (value) async {
                                    setState(() {
                                      shippingAddressController!.addressTypeTextController!.text = value.toString();
                                      groupValue = int.parse(value!.toString());
                                    });
                                    print("value value value $value");
                                    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                    // sharedPreferences.setInt(AppConstants.prefAddressId!, int.parse(value.toString()));
                                    // print("value value value $value");
                                    // Get.back(result: value);


                                  },
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                Text("Home",style: CustomTextStyle.label14,),
                              ],
                            ),
                            SizedBox(width: 10,),
                            Row(
                              children: [
                                Radio(
                                  value: 2,
                                  groupValue:  groupValue,
                                  onChanged: (value) async {
                                    setState(() {
                                      shippingAddressController!.addressTypeTextController!.text = value.toString();
                                      groupValue = int.parse(value!.toString());
                                    });
                                    print("value value value $value");
                                    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                    // sharedPreferences.setInt(AppConstants.prefAddressId!, int.parse(value.toString()));
                                    // print("value value value $value");
                                    // Get.back(result: value);


                                  },
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                Text("Office",style: CustomTextStyle.label14,),
                              ],
                            )

                          ],),
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                            child: Container(
                              height: 1,
                              width: MediaQuery.of(context).size.width,
                              color: AppColors.tileLine,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Row(children: [
                            Transform.scale(
                              scale: 1.1,
                              child: Checkbox(

                                value:checkedValue,
                                activeColor: Colors.redAccent,
                                onChanged: (bool? value) {
                                  setState(() {
                                    // widget.checkBoxValue!();
                                    checkedValue=value;
                                    print("checkedValue ${value}");
                                    // if(value == true){
                                    //   widget.checkBoxValue = 1;
                                    //   // controller.checkBoxValue(1);
                                    // }else{
                                    //   widget.checkBoxValue = 0;
                                    //   // controller.checkBoxValue(0);
                                    // }
                                    // print("widget.checkBoxValue ${widget.checkBoxValue}");
                                    // print("controller.checkBoxValue ${controller.checkBoxValue.value}");

                                  });

                                },
                              ),
                            ),
                             Text('Make this my default address',style: CustomTextStyle.label14,)
                          ],),

                      ],),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),


                ],
              ),
            ),
          ),
        ],
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