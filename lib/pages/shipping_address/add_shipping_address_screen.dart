import 'package:eshoperapp/constants/app_costants.dart';
import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/models/shipping_address.dart';
import 'package:eshoperapp/pages/shipping_address/shippig_address_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/theme.dart';
import '../../models/country_and_state.dart';
import '../../utils/check_internet.dart';
import '../../utils/snackbar_dialog.dart';

class AddShippingAddressScreen extends StatefulWidget {
  const AddShippingAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddShippingAddressScreen> createState() =>
      _AddShippingAddressScreenState();
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

  FocusNode _focusName = FocusNode();
  bool? _nameBool = false;

  FocusNode _focusLast = FocusNode();
  bool? _lastBool = false;

  FocusNode _focusMobile = FocusNode();
  bool? _mobileBool = false;

  FocusNode _focusPincode = FocusNode();
  bool? _pincodeBool = false;

  FocusNode _focusCountry = FocusNode();
  bool? _countryBool = false;

  FocusNode _focusState = FocusNode();
  bool? _stateBool = false;

  FocusNode _focusAddress = FocusNode();
  bool? _addressBool = false;

  FocusNode _focusLocality = FocusNode();
  bool? _localityBool = false;

  FocusNode _focusCity = FocusNode();
  bool? _cityBool = false;

  bool? _homeBool = false;

  bool? _officeBool = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    dynamic argumentData = Get.arguments;
    editMode = argumentData[0]['editMode'];

    _focusName.addListener(_onFocusChange);
    _focusLast.addListener(_onFocusChange);
    _focusMobile.addListener(_onFocusChange);
    _focusPincode.addListener(_onFocusChange);
    _focusCountry.addListener(_onFocusChange);
    _focusState.addListener(_onFocusChange);
    _focusAddress.addListener(_onFocusChange);
    _focusLocality.addListener(_onFocusChange);
    _focusCity.addListener(_onFocusChange);

    print("editMode  ${editMode!}");

    print("stateList init");
    CheckInternet.checkInternet();

    if (editMode!) {
      shippingAddress = argumentData[1]['addressObj'];
      shippingAddressController = Get.put(ShippingAddressController(
          apiRepositoryInterface: Get.find(),
          editMode: editMode!,
          shippingAddress: shippingAddress!,
          localRepositoryInterface: Get.find()));
      print("shippingAddress email ${shippingAddress!.email}");
      print("country  ${shippingAddress!.country}");
      print("shippingAddress.firstName ${shippingAddress!.firstName}");
      shippingAddressController!.getAddressId();
      shippingAddressController!.getUser();

      getCountry();

      shippingAddressController!.firstNameTextController = TextEditingController(text: shippingAddress!.firstName);
      shippingAddressController!.lastNameTextController = TextEditingController(text: shippingAddress!.lastName);
      shippingAddressController!.emailTextController = TextEditingController(text: shippingAddress!.email);
      shippingAddressController!.mobileTextController = TextEditingController(text: shippingAddress!.mobile);
      shippingAddressController!.addressTextController = TextEditingController(text: shippingAddress!.address);
      shippingAddressController!.localityTextController = TextEditingController();
      shippingAddressController!.landmarkTextController = TextEditingController();
      shippingAddressController!.cityTextController = TextEditingController(text: shippingAddress!.city);
      shippingAddressController!.stateTextController = TextEditingController(text: shippingAddress!.state);
      shippingAddressController!.pincodeTextController = TextEditingController(text: shippingAddress!.pincode);
      shippingAddressController!.countryTextController = TextEditingController(text: shippingAddress!.country);
      shippingAddressController!.addressTypeTextController = TextEditingController(text: shippingAddress!.addressType);
      shippingAddressController!.checkBoxValue=int.parse(shippingAddress!.setDefault!);
      if(shippingAddress!.setDefault == "1"){
        checkedValue = true;
      }else{
        checkedValue = false;
      }
      if( shippingAddress!.addressType == "Home"){
        _homeBool = true;
        _officeBool = false;
      }else{
        _homeBool = false;
        _officeBool = true;
      }
      print("controller.checkBoxValue init  ${shippingAddressController!.checkBoxValue}");
    } else {
      shippingAddress = ShippingAddress();
      shippingAddressController = Get.put(ShippingAddressController(
          apiRepositoryInterface: Get.find(),
          editMode: editMode!,
          shippingAddress: shippingAddress!,
          localRepositoryInterface: Get.find()));
      shippingAddressController!.getAddressId();
      shippingAddressController!.getUser();
      shippingAddressController!.getCountry();
      shippingAddressController!.stateList([]);
      shippingAddressController!.firstNameTextController = TextEditingController();
      shippingAddressController!.lastNameTextController = TextEditingController();
      shippingAddressController!.emailTextController = TextEditingController();
      shippingAddressController!.mobileTextController = TextEditingController();
      shippingAddressController!.addressTextController = TextEditingController();
      shippingAddressController!.localityTextController = TextEditingController();
      shippingAddressController!.landmarkTextController = TextEditingController();
      shippingAddressController!.cityTextController = TextEditingController();
      shippingAddressController!.stateTextController = TextEditingController();
      shippingAddressController!.pincodeTextController = TextEditingController();
      shippingAddressController!.countryTextController = TextEditingController();
      shippingAddressController!.addressTypeTextController = TextEditingController();
      shippingAddressController!.checkBoxValue=0;

    }



    // print("editMode  ${editMode!}");


    super.initState();
  }

  void _onFocusChange() {
    _nameBool = _focusName.hasFocus;
    _lastBool = _focusLast.hasFocus;
    _mobileBool = _focusMobile.hasFocus;
    _pincodeBool = _focusPincode.hasFocus;
    _countryBool = _focusCountry.hasFocus;
    _stateBool = _focusState.hasFocus;
    _addressBool = _focusAddress.hasFocus;
    _localityBool = _focusLocality.hasFocus;
    _cityBool = _focusCity.hasFocus;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _focusName.removeListener(_onFocusChange);
    _focusName.dispose();
    _focusLast.removeListener(_onFocusChange);
    _focusLast.dispose();
    _focusMobile.removeListener(_onFocusChange);
    _focusMobile.dispose();
    _focusPincode.removeListener(_onFocusChange);
    _focusPincode.dispose();
    _focusCountry.removeListener(_onFocusChange);
    _focusCountry.dispose();
    _focusState.removeListener(_onFocusChange);
    _focusState.dispose();
    _focusAddress.removeListener(_onFocusChange);
    _focusAddress.dispose();
    _focusLocality.removeListener(_onFocusChange);
    _focusLocality.dispose();
    _focusCity.removeListener(_onFocusChange);
    _focusCity.dispose();
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
        shippingAddressController!.checkBoxValue = 0;
        shippingAddressController!.countryList([]);
        shippingAddressController!.stateList([]);

        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.ratingText,
        // appBar: AppBar(
        //   elevation: 0,
        //   backgroundColor: AppColors.white,
        //   leading: InkWell(
        //     onTap: (){
        //       Navigator.of(context, rootNavigator: true).pop();
        //     },
        //     child: Image.asset(
        //       'assets/img/arrow_left.png',
        //       color: AppColors.appText,
        //     ),
        //   ),
        //   // leading: IconButton(
        //   //   icon: Icon(
        //   //     Icons.arrow_back,
        //   //     color: Style.Colors.appColor,
        //   //     size: 30,
        //   //   ),
        //   //   onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        //   // ),
        //   title: InkWell(
        //       onTap: (){
        //         print("shippingAddressController!.firstNameTextController ${shippingAddressController!.firstNameTextController}");
        //         print("shippingAddressController!.checkBoxValue ${shippingAddressController!.checkBoxValue}");
        //       },
        //       child: Text("${editMode==true?AppConstants.editAddress:AppConstants.addAddress}",  style: CustomTextStyle.appBarTitle,)),
        // ),
        body: SafeArea(
          child: Container(alignment: Alignment.center, child: buildSignType()

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
        bottomNavigationBar: Container(
          // color: AppColors.appText1,
          color: AppColors.appText1,
          height: 42,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    // onChanged!();
                    Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 1.0),
                    child: Container(
                        color: Colors.white,
                        child: Center(
                          child: Text('CANCEL',
                              style: GoogleFonts.inriaSans(
                                  textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.appText1))),
                        )),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    print(
                        "${shippingAddressController!.firstNameTextController!.text}");
                    print(
                        "${shippingAddressController!.lastNameTextController!.text}");
                    print(
                        "${shippingAddressController!.mobileTextController!.text}");
                    print(
                        "${selectedCountry}");
                    print(
                        "${selectedState}");
                    print(
                        "${shippingAddressController!.addressTextController!.text}");
                    print(
                        "${shippingAddressController!.cityTextController!.text}");
                    print(
                        "${shippingAddressController!.pincodeTextController!.text}");
                    print(
                        "${shippingAddressController!.addressTypeTextController!.text}");
                    print(
                        "${shippingAddressController!.checkBoxValue}");

                    FocusManager.instance.primaryFocus?.unfocus();
                    if (_formKey.currentState!.validate()) {
                      if(shippingAddressController!.addressTypeTextController!.text == ""){
                        SnackBarDialog.showSnackbar('Error',"Please select type of address");
                      }else{
                        if(editMode!){
                          editAddress();
                        }else{
                          saveAddress();
                        }

                      }

                    }
                  },
                  child: Container(
                      color: AppColors.appText1,
                      child: Center(
                        child: Text('SAVE',
                            style: GoogleFonts.inriaSans(
                                textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.white))),
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: AppColors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16),
              child: Row(
                children: [
                  InkWell(
                    child: Image.asset(
                      'assets/img/arrow_left.png',
                      fit: BoxFit.fill,
                      height: 15,
                      width: 18,
                    ),
                    onTap: () {
                      Get.back();
                    },
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                      "${editMode == true ? AppConstants.editAddress : AppConstants.addAddress}",
                      style: GoogleFonts.inriaSans(
                          textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.appText))),
                ],
              ),
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              color: AppColors.white,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10.5,
                    left: AppSizes.labelPadding,
                    right: AppSizes.labelPadding,
                    bottom: 10.5),
                child: Text(
                  "ADD NEW ADDRESS",
                  style: CustomTextStyle.label,
                ),
              )),
          Container(
            height: 1,
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
                          Row(
                            children: [
                              Expanded(
                                child: FormField<String>(
                                  validator: (value) {
                                    if (shippingAddressController!
                                        .firstNameTextController!.text.isEmpty) {
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
                                                  color: _nameBool == true
                                                      ? AppColors.appRed
                                                      : AppColors.appText1,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                height: 53,
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              height: 53,
                                              child: Padding(
                                                padding: EdgeInsets.only(left: 8.0),
                                                child: TextFormField(
                                                  controller: shippingAddressController!
                                                      .firstNameTextController,
                                                  focusNode: _focusName,
                                                  // onTab:

                                                  onChanged: (text) {
                                                    setState(() {
                                                      shippingAddressController!
                                                          .firstNameTextController!
                                                          .text = text;
                                                      _onFocusChange();
                                                    });

                                                      shippingAddressController!.firstNameTextController!.selection = TextSelection.collapsed(offset: shippingAddressController!.firstNameTextController!.text.length);
                                                    // });
                                                  },

                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.only(top: 0),
                                                    border: InputBorder.none,
                                                    hintText: 'First Name *',
                                                    labelText: 'First Name *',
                                                    hintStyle: GoogleFonts.inriaSans(
                                                        textStyle: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color:
                                                                AppColors.appText1)),
                                                    labelStyle: GoogleFonts.inriaSans(
                                                        textStyle: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: _nameBool == true
                                                                ? AppColors.appRed
                                                                : AppColors
                                                                    .appText1)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        state.errorText != null
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0, top: 2),
                                                child: Text(
                                                  state.errorText ?? '',
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .errorColor,
                                                      fontSize: 10),
                                                ),
                                              )
                                            : Container()
                                      ],
                                    );
                                  },
                                ),
                              ),
                              SizedBox(width: 20,),
                              Expanded(
                                child: FormField<String>(
                                  validator: (value) {
                                    if (shippingAddressController!
                                        .lastNameTextController!.text.isEmpty) {
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
                                                  color: _lastBool == true
                                                      ? AppColors.appRed
                                                      : AppColors.appText1,
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                ),
                                                height: 53,
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                BorderRadius.circular(10),
                                              ),
                                              height: 53,
                                              child: Padding(
                                                padding: EdgeInsets.only(left: 8.0),
                                                child: TextFormField(
                                                  controller: shippingAddressController!
                                                      .lastNameTextController,
                                                  focusNode: _focusLast,
                                                  // onTab:

                                                  onChanged: (text) {
                                                    setState(() {
                                                      shippingAddressController!
                                                          .lastNameTextController!
                                                          .text = text;
                                                      _onFocusChange();
                                                    });
                                                    shippingAddressController!.lastNameTextController!.selection = TextSelection.collapsed(offset: shippingAddressController!.lastNameTextController!.text.length);
                                                  },

                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                    EdgeInsets.only(top: 0),
                                                    border: InputBorder.none,
                                                    hintText: 'Last Name *',
                                                    labelText: 'Last Name *',
                                                    hintStyle: GoogleFonts.inriaSans(
                                                        textStyle: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                            FontWeight.w700,
                                                            color:
                                                            AppColors.appText1)),
                                                    labelStyle: GoogleFonts.inriaSans(
                                                        textStyle: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                            FontWeight.w700,
                                                            color: _lastBool == true
                                                                ? AppColors.appRed
                                                                : AppColors
                                                                .appText1)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        state.errorText != null
                                            ? Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, top: 2),
                                          child: Text(
                                            state.errorText ?? '',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .errorColor,
                                                fontSize: 10),
                                          ),
                                        )
                                            : Container()
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          // _nameBool1 == false && _mobileBool == false?
                          // const Text("ddd"):const SizedBox(
                          //   height: 10,
                          // ),

                          FormField<String>(
                            validator: (value) {
                              if (shippingAddressController!
                                  .mobileTextController!.text.isEmpty) {
                                return 'This field is required';
                              }

                              if (shippingAddressController!
                                  .mobileTextController!.text.length < 10) {
                                return 'Enter a minimum 10 number';
                              }else if (shippingAddressController!
                                  .mobileTextController!.text.length > 10) {
                                return 'Enter a maximum 10 number';
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
                                            color: _mobileBool == true
                                                ? AppColors.appRed
                                                : AppColors.appText1,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          height: 53,
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        height: 53,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: TextFormField(
                                            controller: shippingAddressController!
                                                .mobileTextController,
                                            keyboardType: TextInputType.phone,
                                            focusNode: _focusMobile,
                                            onChanged: (text) {
                                              setState(() {
                                                shippingAddressController!
                                                    .mobileTextController!
                                                    .text = text;
                                                _onFocusChange();
                                              });
                                              shippingAddressController!.mobileTextController!.selection = TextSelection.collapsed(offset: shippingAddressController!.mobileTextController!.text.length);
                                            },
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.only(top: 0),
                                              border: InputBorder.none,
                                              hintText: 'Mobile *',
                                              labelText: 'Mobile *',
                                              hintStyle: GoogleFonts.inriaSans(
                                                  textStyle: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color:
                                                          AppColors.appText1)),
                                              labelStyle: GoogleFonts.inriaSans(
                                                  textStyle: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: _mobileBool == true
                                                          ? AppColors.appRed
                                                          : AppColors
                                                              .appText1)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  state.errorText != null
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, top: 2),
                                          child: Text(
                                            state.errorText ?? '',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .errorColor,
                                                fontSize: 10),
                                          ),
                                        )
                                      : Container()
                                ],
                              );
                            },
                          ),
                        ],
                      ),
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
                          Obx(() {
                            if (shippingAddressController!
                                .isLoadingCountry.value ==
                                true) {
                              print(
                                  "controller.countryList if ${shippingAddressController!.countryList.value.length}");
                              return FormField<String>(
                                validator: (value) {
                                  if (shippingAddressController!
                                      .countryTextController!
                                      .text
                                      .isEmpty) {
                                    return 'Please select country';
                                  } else {
                                    return null;
                                  }
                                },
                                builder: (state) {
                                  return Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          Padding(
                                            padding:
                                            EdgeInsets.all(2.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: _countryBool ==
                                                    true
                                                    ? AppColors.appRed
                                                    : AppColors.appText1,
                                                borderRadius:
                                                BorderRadius.circular(
                                                    10),
                                              ),
                                              height: 53,
                                            ),
                                          ),
                                          Container(
                                            // width:150,
                                            decoration: BoxDecoration(
                                              color: Colors.white,

                                              borderRadius:
                                              BorderRadius.circular(
                                                  10),
                                            ),
                                            height: 53,

                                            child: Padding(
                                              padding:
                                              EdgeInsets.only(
                                                  left: 8.0),
                                              child:
                                              DropdownButtonFormField<
                                                  String>(
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                  EdgeInsets.only(top: 0),
                                                  border: InputBorder.none,
                                                  hintText: 'Country *',
                                                  labelText: 'Country *',
                                                  hintStyle:
                                                  GoogleFonts.inriaSans(
                                                      textStyle: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight
                                                              .w700,
                                                          color: AppColors
                                                              .appText1)),
                                                  labelStyle: GoogleFonts.inriaSans(
                                                      textStyle: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight.w700,
                                                          color: _countryBool ==
                                                              true
                                                              ? AppColors
                                                              .appRed
                                                              : AppColors
                                                              .appText1)),
                                                ),
                                                // value: widget.countryTextController!.text == "" ? selectedCountry:CountryAndState(name: widget.countryTextController!.text),
                                                value: selectedCountry,
                                                // hint: Text(
                                                //   'Salutation',
                                                // ),
                                                onChanged: (salutation) {
                                                  selectedCountry =
                                                  salutation!;
                                                  shippingAddressController!
                                                      .countryTextController!
                                                      .text = salutation;
                                                  print(
                                                      "salutation $salutation");
                                                  // print("selectedCountry!.iso2! ${salutation.iso2!}");
                                                  // print("selectedCountry ${selectedCountry!.name!}");
                                                  selectedState = null;
                                                  shippingAddressController!
                                                      .stateList([]);
                                                  shippingAddressController!.stateTextController!.clear();
                                                  shippingAddressController!
                                                      .countryList.value
                                                      .forEach((element) {
                                                    if (selectedCountry ==
                                                        element.name) {
                                                      print(
                                                          "selectedCountry!.iso2! ${element.iso2!}");
                                                      // print("selectedCountry ${selectedCountry!.name!}");
                                                      shippingAddressController!
                                                          .getState(
                                                          element
                                                              .iso2!);
                                                    }
                                                  });
                                                },
                                                // onChanged: (salutation) =>
                                                //     setState(() => selectedSalutation = salutation),
                                                // validator: (value) =>
                                                // value == null
                                                //     ? 'This field is required'
                                                //     : null,
                                                items: shippingAddressController!
                                                    .countryList.value
                                                    .map<
                                                    DropdownMenuItem<
                                                        String>>(
                                                        (CountryAndState
                                                    value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value.name,
                                                        child:
                                                        Text(value.name!),
                                                      );
                                                    }).toList(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      state.errorText != null
                                          ? Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            left: 8.0, top: 2),
                                        child: Text(
                                          state.errorText ?? '',
                                          style: TextStyle(
                                              color:
                                              Theme.of(context)
                                                  .errorColor,
                                              fontSize: 10),
                                        ),
                                      )
                                          : Container()
                                    ],
                                  );
                                },
                              );
                            } else {
                              print(
                                  "controller.countryList  else ${shippingAddressController!.countryList.value.length}");
                              // print("controller.countryList ${controller.countryList[0].name}");
                              return  Container(

                              );
                            }
                          }),
                          SizedBox(
                            height: 5,
                          ),
                          Obx(() {
                            if (shippingAddressController!
                                .isLoadingState.value ==
                                true) {
                              print(
                                  "controller.countryList if ${shippingAddressController!.stateList.value.length}");
                              return FormField<String>(
                                validator: (value) {
                                  if (shippingAddressController!
                                      .stateTextController!
                                      .text
                                      .isEmpty) {
                                    return 'Please select State';
                                  } else {
                                    return null;
                                  }
                                },
                                builder: (state) {
                                  return Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          Padding(
                                            padding:
                                            EdgeInsets.all(2.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: _stateBool ==
                                                    true
                                                    ? AppColors.appRed
                                                    : AppColors.appText1,
                                                borderRadius:
                                                BorderRadius.circular(
                                                    10),
                                              ),
                                              height: 53,
                                            ),
                                          ),
                                          Container(
                                            // width:150,
                                            decoration: BoxDecoration(
                                              color: Colors.white,

                                              borderRadius:
                                              BorderRadius.circular(
                                                  10),
                                            ),
                                            height: 53,

                                            child: Padding(
                                              padding:
                                              EdgeInsets.only(
                                                  left: 8.0),
                                              child:
                                              DropdownButtonFormField<
                                                  String>(
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                  EdgeInsets.only(top: 0),
                                                  border: InputBorder.none,
                                                  hintText: 'State *',
                                                  labelText: 'State *',
                                                  hintStyle:
                                                  GoogleFonts.inriaSans(
                                                      textStyle: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight
                                                              .w700,
                                                          color: AppColors
                                                              .appText1)),
                                                  labelStyle: GoogleFonts.inriaSans(
                                                      textStyle: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight.w700,
                                                          color: _stateBool ==
                                                              true
                                                              ? AppColors
                                                              .appRed
                                                              : AppColors
                                                              .appText1)),
                                                ),
                                                // value: widget.countryTextController!.text == "" ? selectedCountry:CountryAndState(name: widget.countryTextController!.text),
                                                value: selectedState,
                                                // hint: Text(
                                                //   'Salutation',
                                                // ),
                                                onChanged: (salutation) {
                                                  shippingAddressController!.stateTextController!.text = salutation!;
                                                  selectedState = salutation;
                                                  print("salutation $salutation");
                                                },
                                                // onChanged: (salutation) =>
                                                //     setState(() => selectedSalutation = salutation),
                                                // validator: (value) =>
                                                // value == null
                                                //     ? 'This field is required'
                                                //     : null,
                                                items: shippingAddressController!
                                                    .stateList.value
                                                    .map<
                                                    DropdownMenuItem<
                                                        String>>(
                                                        (CountryAndState
                                                    value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value.name,
                                                        child:
                                                        Text(value.name!),
                                                      );
                                                    }).toList(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      state.errorText != null
                                          ? Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            left: 8.0, top: 2),
                                        child: Text(
                                          state.errorText ?? '',
                                          style: TextStyle(
                                              color:
                                              Theme.of(context)
                                                  .errorColor,
                                              fontSize: 10),
                                        ),
                                      )
                                          : Container()
                                    ],
                                  );
                                },
                              );
                            } else {
                              print(
                                  "controller.countryList  else ${shippingAddressController!.stateList.value.length}");
                              // print("controller.countryList ${controller.countryList[0].name}");
                              return  Container(

                              );
                            }
                          }),
                          SizedBox(
                            height: 5,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Obx(() {
                          //       if (shippingAddressController!
                          //               .isLoadingCountry.value ==
                          //           true) {
                          //         print(
                          //             "controller.countryList if ${shippingAddressController!.countryList.value.length}");
                          //         return Expanded(
                          //           child: FormField<String>(
                          //             validator: (value) {
                          //               if (shippingAddressController!
                          //                   .countryTextController!
                          //                   .text
                          //                   .isEmpty) {
                          //                 return 'This field is required';
                          //               } else {
                          //                 return null;
                          //               }
                          //             },
                          //             builder: (state) {
                          //               return Column(
                          //                 crossAxisAlignment:
                          //                     CrossAxisAlignment.start,
                          //                 children: [
                          //                   Stack(
                          //                     children: [
                          //                       Padding(
                          //                         padding:
                          //                              EdgeInsets.all(2.0),
                          //                         child: Container(
                          //                           decoration: BoxDecoration(
                          //                             color: _countryBool ==
                          //                                     true
                          //                                 ? AppColors.appRed
                          //                                 : AppColors.appText1,
                          //                             borderRadius:
                          //                                 BorderRadius.circular(
                          //                                     10),
                          //                           ),
                          //                           height: 53,
                          //                         ),
                          //                       ),
                          //                       Container(
                          //                         // width:150,
                          //                         decoration: BoxDecoration(
                          //                           color: Colors.white,
                          //                           borderRadius:
                          //                               BorderRadius.circular(
                          //                                   10),
                          //                         ),
                          //                         height: 53,
                          //
                          //                         child: Padding(
                          //                           padding:
                          //                                EdgeInsets.only(
                          //                                   left: 8.0),
                          //                           child:
                          //                               DropdownButtonFormField<
                          //                                   String>(
                          //                                 decoration: InputDecoration(
                          //                                   contentPadding:
                          //                                   EdgeInsets.only(top: 0),
                          //                                   border: InputBorder.none,
                          //                                   hintText: 'Country *',
                          //                                   labelText: 'Country *',
                          //                                   hintStyle:
                          //                                   GoogleFonts.inriaSans(
                          //                                       textStyle: TextStyle(
                          //                                           fontSize: 14,
                          //                                           fontWeight:
                          //                                           FontWeight
                          //                                               .w700,
                          //                                           color: AppColors
                          //                                               .appText1)),
                          //                                   labelStyle: GoogleFonts.inriaSans(
                          //                                       textStyle: TextStyle(
                          //                                           fontSize: 14,
                          //                                           fontWeight:
                          //                                           FontWeight.w700,
                          //                                           color: _countryBool ==
                          //                                               true
                          //                                               ? AppColors
                          //                                               .appRed
                          //                                               : AppColors
                          //                                               .appText1)),
                          //                                 ),
                          //                             // value: widget.countryTextController!.text == "" ? selectedCountry:CountryAndState(name: widget.countryTextController!.text),
                          //                             value: selectedCountry,
                          //                             // hint: Text(
                          //                             //   'Salutation',
                          //                             // ),
                          //                             onChanged: (salutation) {
                          //                               selectedCountry =
                          //                                   salutation!;
                          //                               shippingAddressController!
                          //                                   .countryTextController!
                          //                                   .text = salutation;
                          //                               print(
                          //                                   "salutation $salutation");
                          //                               // print("selectedCountry!.iso2! ${salutation.iso2!}");
                          //                               // print("selectedCountry ${selectedCountry!.name!}");
                          //                               selectedState = null;
                          //                               shippingAddressController!
                          //                                   .stateList([]);
                          //                               shippingAddressController!
                          //                                   .countryList.value
                          //                                   .forEach((element) {
                          //                                 if (selectedCountry ==
                          //                                     element.name) {
                          //                                   print(
                          //                                       "selectedCountry!.iso2! ${element.iso2!}");
                          //                                   // print("selectedCountry ${selectedCountry!.name!}");
                          //                                   shippingAddressController!
                          //                                       .getState(
                          //                                           element
                          //                                               .iso2!);
                          //                                 }
                          //                               });
                          //                             },
                          //                             // onChanged: (salutation) =>
                          //                             //     setState(() => selectedSalutation = salutation),
                          //                             validator: (value) =>
                          //                                 value == null
                          //                                     ? 'This field is required'
                          //                                     : null,
                          //                             items: shippingAddressController!
                          //                                 .countryList.value
                          //                                 .map<
                          //                                         DropdownMenuItem<
                          //                                             String>>(
                          //                                     (CountryAndState
                          //                                         value) {
                          //                               return DropdownMenuItem<
                          //                                   String>(
                          //                                 value: value.name,
                          //                                 child:
                          //                                     Text(value.name!),
                          //                               );
                          //                             }).toList(),
                          //                           ),
                          //                         ),
                          //                       ),
                          //                     ],
                          //                   ),
                          //                   state.errorText != null
                          //                       ? Padding(
                          //                           padding:
                          //                               const EdgeInsets.only(
                          //                                   left: 8.0, top: 2),
                          //                           child: Text(
                          //                             state.errorText ?? '',
                          //                             style: TextStyle(
                          //                                 color:
                          //                                     Theme.of(context)
                          //                                         .errorColor,
                          //                                 fontSize: 10),
                          //                           ),
                          //                         )
                          //                       : Container()
                          //                 ],
                          //               );
                          //             },
                          //           ),
                          //         );
                          //       } else {
                          //         print(
                          //             "controller.countryList  else ${shippingAddressController!.countryList.value.length}");
                          //         // print("controller.countryList ${controller.countryList[0].name}");
                          //         return const Center(
                          //           child: CircularProgressIndicator(),
                          //         );
                          //       }
                          //     }),
                          //     SizedBox(
                          //       width: 10,
                          //     ),
                          //     Expanded(
                          //       // width: 150,
                          //       child: FormField<String>(
                          //         validator: (value) {
                          //           if (shippingAddressController!
                          //               .stateTextController!.text.isEmpty) {
                          //             return 'This field is required';
                          //           } else {
                          //             return null;
                          //           }
                          //         },
                          //         builder: (state) {
                          //           return Column(
                          //             crossAxisAlignment:
                          //                 CrossAxisAlignment.start,
                          //             children: [
                          //               Stack(
                          //                 children: [
                          //                   Padding(
                          //                     padding:
                          //                         const EdgeInsets.all(2.0),
                          //                     child: Container(
                          //                       decoration: BoxDecoration(
                          //                         color: _stateBool == true
                          //                             ? AppColors.appRed
                          //                             : AppColors.appText1,
                          //                         borderRadius:
                          //                             BorderRadius.circular(10),
                          //                       ),
                          //                       height: 53,
                          //                     ),
                          //                   ),
                          //                   Container(
                          //                     decoration: BoxDecoration(
                          //                       color: Colors.white,
                          //                       borderRadius:
                          //                           BorderRadius.circular(10),
                          //                     ),
                          //                     height: 53,
                          //                     child: Padding(
                          //                       padding: const EdgeInsets.only(
                          //                           left: 8.0),
                          //                       child: TextFormField(
                          //                         focusNode: _focusState,
                          //                         onChanged: (text) {
                          //                           setState(() {
                          //                             shippingAddressController!
                          //                                 .stateTextController!
                          //                                 .text = text;
                          //                             _onFocusChange();
                          //                           });
                          //                         },
                          //                         decoration: InputDecoration(
                          //                           contentPadding:
                          //                               EdgeInsets.only(top: 0),
                          //                           border: InputBorder.none,
                          //                           hintText: 'State *',
                          //                           labelText: 'State *',
                          //                           hintStyle:
                          //                               GoogleFonts.inriaSans(
                          //                                   textStyle: TextStyle(
                          //                                       fontSize: 14,
                          //                                       fontWeight:
                          //                                           FontWeight
                          //                                               .w700,
                          //                                       color: AppColors
                          //                                           .appText1)),
                          //                           labelStyle: GoogleFonts.inriaSans(
                          //                               textStyle: TextStyle(
                          //                                   fontSize: 14,
                          //                                   fontWeight:
                          //                                       FontWeight.w700,
                          //                                   color: _stateBool ==
                          //                                           true
                          //                                       ? AppColors
                          //                                           .appRed
                          //                                       : AppColors
                          //                                           .appText1)),
                          //                         ),
                          //                       ),
                          //                     ),
                          //                   ),
                          //                 ],
                          //               ),
                          //               state.errorText != null
                          //                   ? Padding(
                          //                       padding: const EdgeInsets.only(
                          //                           left: 8.0, top: 2),
                          //                       child: Text(
                          //                         state.errorText ?? '',
                          //                         style: TextStyle(
                          //                             color: Theme.of(context)
                          //                                 .errorColor,
                          //                             fontSize: 10),
                          //                       ),
                          //                     )
                          //                   : Container()
                          //             ],
                          //           );
                          //         },
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: 5,
                          // ),
                          FormField<String>(
                            validator: (value) {
                              if (shippingAddressController!
                                  .addressTextController!.text.isEmpty) {
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
                                            color: _addressBool == true
                                                ? AppColors.appRed
                                                : AppColors.appText1,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          height: 53,
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        height: 53,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: TextFormField(

                                            onChanged: (text) {
                                              setState(() {
                                                shippingAddressController!
                                                    .addressTextController!
                                                    .text = text;
                                                _onFocusChange();
                                              });
                                              shippingAddressController!.addressTextController!.selection = TextSelection.collapsed(offset: shippingAddressController!.addressTextController!.text.length);
                                            },

                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.only(top: 0),
                                              border: InputBorder.none,
                                              hintText:
                                                  'Address(House No, Building, Street, Area) *',
                                              labelText:
                                                  'Address(House No, Building, Street, Area) *',
                                              hintStyle: GoogleFonts.inriaSans(
                                                  textStyle: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color:
                                                          AppColors.appText1)),
                                              labelStyle: GoogleFonts.inriaSans(
                                                  textStyle: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color:
                                                          _addressBool == true
                                                              ? AppColors.appRed
                                                              : AppColors
                                                                  .appText1)),
                                            ),
                                            focusNode: _focusAddress,
                                            controller: shippingAddressController!
                                                .addressTextController,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  state.errorText != null
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, top: 2),
                                          child: Text(
                                            state.errorText ?? '',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .errorColor,
                                                fontSize: 10),
                                          ),
                                        )
                                      : Container()
                                ],
                              );
                            },
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          // FormField<String>(
                          //   validator: (value) {
                          //     if (shippingAddressController!
                          //         .localityTextController!.text.isEmpty) {
                          //       return 'This field is required';
                          //     } else {
                          //       return null;
                          //     }
                          //   },
                          //   builder: (state) {
                          //     return Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         Stack(
                          //           children: [
                          //             Padding(
                          //               padding: const EdgeInsets.all(2.0),
                          //               child: Container(
                          //                 decoration: BoxDecoration(
                          //                   color: _localityBool == true
                          //                       ? AppColors.appRed
                          //                       : AppColors.appText1,
                          //                   borderRadius:
                          //                       BorderRadius.circular(10),
                          //                 ),
                          //                 height: 53,
                          //               ),
                          //             ),
                          //             Container(
                          //               decoration: BoxDecoration(
                          //                 color: Colors.white,
                          //                 borderRadius:
                          //                     BorderRadius.circular(10),
                          //               ),
                          //               height: 53,
                          //               child: Padding(
                          //                 padding:
                          //                     const EdgeInsets.only(left: 8.0),
                          //                 child: TextFormField(
                          //                   onChanged: (text) {
                          //                     setState(() {
                          //                       shippingAddressController!
                          //                           .localityTextController!
                          //                           .text = text;
                          //                       _onFocusChange();
                          //                     });
                          //                   },
                          //                   decoration: InputDecoration(
                          //                     contentPadding:
                          //                         EdgeInsets.only(top: 0),
                          //                     border: InputBorder.none,
                          //                     hintText: 'Locality/ Town *',
                          //                     labelText: 'Locality/ Town *',
                          //                     hintStyle: GoogleFonts.inriaSans(
                          //                         textStyle: TextStyle(
                          //                             fontSize: 14,
                          //                             fontWeight:
                          //                                 FontWeight.w700,
                          //                             color:
                          //                                 AppColors.appText1)),
                          //                     labelStyle: GoogleFonts.inriaSans(
                          //                         textStyle: TextStyle(
                          //                             fontSize: 14,
                          //                             fontWeight:
                          //                                 FontWeight.w700,
                          //                             color:
                          //                                 _localityBool == true
                          //                                     ? AppColors.appRed
                          //                                     : AppColors
                          //                                         .appText1)),
                          //                   ),
                          //                   focusNode: _focusLocality,
                          //                 ),
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //         state.errorText != null
                          //             ? Padding(
                          //                 padding: const EdgeInsets.only(
                          //                     left: 8.0, top: 2),
                          //                 child: Text(
                          //                   state.errorText ?? '',
                          //                   style: TextStyle(
                          //                       color: Theme.of(context)
                          //                           .errorColor,
                          //                       fontSize: 10),
                          //                 ),
                          //               )
                          //             : Container()
                          //       ],
                          //     );
                          //   },
                          // ),
                          // SizedBox(
                          //   height: 5,
                          // ),
                          FormField<String>(
                            validator: (value) {
                              if (shippingAddressController!
                                  .cityTextController!.text.isEmpty) {
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
                                            color: _cityBool == true
                                                ? AppColors.appRed
                                                : AppColors.appText1,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          height: 53,
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        height: 53,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: TextFormField(
                                            onChanged: (text) {
                                              setState(() {
                                                shippingAddressController!
                                                    .cityTextController!
                                                    .text = text;
                                                _onFocusChange();
                                              });
                                              shippingAddressController!.cityTextController!.selection = TextSelection.collapsed(offset: shippingAddressController!.cityTextController!.text.length);
                                            },
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.only(top: 0),
                                              border: InputBorder.none,
                                              hintText: 'City/ District *',
                                              labelText: 'City/ District *',
                                              hintStyle: GoogleFonts.inriaSans(
                                                  textStyle: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color:
                                                          AppColors.appText1)),
                                              labelStyle: GoogleFonts.inriaSans(
                                                  textStyle: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: _cityBool == true
                                                          ? AppColors.appRed
                                                          : AppColors
                                                              .appText1)),
                                            ),
                                            focusNode: _focusCity,
                                            controller: shippingAddressController!
                                                .cityTextController,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  state.errorText != null
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, top: 2),
                                          child: Text(
                                            state.errorText ?? '',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .errorColor,
                                                fontSize: 10),
                                          ),
                                        )
                                      : Container()
                                ],
                              );
                            },
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          FormField<String>(
                            validator: (value) {
                              if (shippingAddressController!
                                  .pincodeTextController!.text.isEmpty) {
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
                                            color: _pincodeBool == true
                                                ? AppColors.appRed
                                                : AppColors.appText1,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          height: 53,
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        height: 53,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: TextFormField(
                                            onChanged: (text) {
                                              setState(() {
                                                shippingAddressController!
                                                    .pincodeTextController!
                                                    .text = text;
                                                _onFocusChange();
                                              });
                                              shippingAddressController!.pincodeTextController!.selection = TextSelection.collapsed(offset: shippingAddressController!.pincodeTextController!.text.length);
                                            },
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.only(top: 0),
                                              border: InputBorder.none,
                                              hintText: 'Pincode *',
                                              labelText: 'Pincode *',
                                              hintStyle: GoogleFonts.inriaSans(
                                                  textStyle: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color:
                                                          AppColors.appText1)),
                                              labelStyle: GoogleFonts.inriaSans(
                                                  textStyle: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color:
                                                          _pincodeBool == true
                                                              ? AppColors.appRed
                                                              : AppColors
                                                                  .appText1)),
                                            ),
                                            focusNode: _focusPincode,
                                            keyboardType: TextInputType.phone,
                                            controller: shippingAddressController!
                                                .pincodeTextController,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  state.errorText != null
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, top: 2),
                                          child: Text(
                                            state.errorText ?? '',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .errorColor,
                                                fontSize: 10),
                                          ),
                                        )
                                      : Container()
                                ],
                              );
                            },
                          ),
                        ],
                      ),
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
                            child: Text(
                              "Type of Address *",
                              style: CustomTextStyle.label14,
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              _homeBool == true
                                  ? InkWell(
                                      child: Row(
                                        children: [
                                          // Radio(
                                          //   value: 1,
                                          //
                                          //   groupValue: groupValue,
                                          //   onChanged: (value) async {
                                          //     setState(() {
                                          //       shippingAddressController!.addressTypeTextController!.text = value.toString();
                                          //       groupValue = int.parse(value!.toString());
                                          //     });
                                          //     print("value value value $value");
                                          //     // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                          //     // sharedPreferences.setInt(AppConstants.prefAddressId!, int.parse(value.toString()));
                                          //     // print("value value value $value");
                                          //     // Get.back(result: value);
                                          //
                                          //
                                          //   },
                                          //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          // ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 7.0, right: 8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: AppColors.appRed,
                                                    width: 1),
                                                color: AppColors.white,
                                                borderRadius: const BorderRadius
                                                        .all(
                                                    Radius.circular(
                                                        100.0) //                 <--- border radius here
                                                    ),
                                                // boxShadow: const [
                                                //   BoxShadow(
                                                //     color: Colors.black26,
                                                //     blurRadius: 10,
                                                //     offset:
                                                //     Offset(4, 8), // Shadow position
                                                //   ),
                                                // ],
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(1.5),
                                                child: Container(
                                                  height: 13,
                                                  width: 13,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: AppColors.appRed,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "Home",
                                            style: CustomTextStyle.label14,
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        setState(() {
                                          _homeBool = true;
                                          _officeBool = false;
                                          shippingAddressController!.addressTypeTextController!.text = "Home";
                                        });
                                      },
                                    )
                                  : InkWell(
                                      child: Row(
                                        children: [
                                          // Radio(
                                          //   value: 1,
                                          //
                                          //   groupValue: groupValue,
                                          //   onChanged: (value) async {
                                          //     setState(() {
                                          //       shippingAddressController!.addressTypeTextController!.text = value.toString();
                                          //       groupValue = int.parse(value!.toString());
                                          //     });
                                          //     print("value value value $value");
                                          //     // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                          //     // sharedPreferences.setInt(AppConstants.prefAddressId!, int.parse(value.toString()));
                                          //     // print("value value value $value");
                                          //     // Get.back(result: value);
                                          //
                                          //
                                          //   },
                                          //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          // ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 7.0, right: 8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: AppColors
                                                        .bestSellingBorder,
                                                    width: 1),
                                                color: AppColors.white,
                                                borderRadius: const BorderRadius
                                                        .all(
                                                    Radius.circular(
                                                        100.0) //                 <--- border radius here
                                                    ),
                                                // boxShadow: const [
                                                //   BoxShadow(
                                                //     color: Colors.black26,
                                                //     blurRadius: 10,
                                                //     offset:
                                                //     Offset(4, 8), // Shadow position
                                                //   ),
                                                // ],
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(1.5),
                                                child: Container(
                                                  height: 13,
                                                  width: 13,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: AppColors
                                                        .bestSellingBorder,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "Home",
                                            style: CustomTextStyle.label14,
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        setState(() {
                                          _homeBool = true;
                                          _officeBool = false;
                                          shippingAddressController!.addressTypeTextController!.text = "Home";
                                        });
                                      },
                                    ),
                              SizedBox(
                                width: 10,
                              ),
                              _officeBool == true
                                  ? InkWell(
                                      onTap: () {
                                        setState(() {
                                          _officeBool = true;
                                          _homeBool = false;
                                          shippingAddressController!.addressTypeTextController!.text = "Office";
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          // Radio(
                                          //   value: 2,
                                          //   groupValue:  groupValue,
                                          //   onChanged: (value) async {
                                          //     setState(() {
                                          //       shippingAddressController!.addressTypeTextController!.text = value.toString();
                                          //       groupValue = int.parse(value!.toString());
                                          //     });
                                          //     print("value value value $value");
                                          //     // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                          //     // sharedPreferences.setInt(AppConstants.prefAddressId!, int.parse(value.toString()));
                                          //     // print("value value value $value");
                                          //     // Get.back(result: value);
                                          //
                                          //
                                          //   },
                                          //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          // ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, right: 8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: AppColors.appRed,
                                                    width: 1),
                                                color: AppColors.white,
                                                borderRadius: const BorderRadius
                                                        .all(
                                                    Radius.circular(
                                                        100.0) //                 <--- border radius here
                                                    ),
                                                // boxShadow: const [
                                                //   BoxShadow(
                                                //     color: Colors.black26,
                                                //     blurRadius: 10,
                                                //     offset:
                                                //     Offset(4, 8), // Shadow position
                                                //   ),
                                                // ],
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(1.5),
                                                child: Container(
                                                  height: 13,
                                                  width: 13,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: AppColors.appRed,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "Office",
                                            style: CustomTextStyle.label14,
                                          ),
                                        ],
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        setState(() {
                                          _officeBool = true;
                                          _homeBool = false;
                                          shippingAddressController!.addressTypeTextController!.text = "Office";
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          // Radio(
                                          //   value: 2,
                                          //   groupValue:  groupValue,
                                          //   onChanged: (value) async {
                                          //     setState(() {
                                          //       shippingAddressController!.addressTypeTextController!.text = value.toString();
                                          //       groupValue = int.parse(value!.toString());
                                          //     });
                                          //     print("value value value $value");
                                          //     // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                          //     // sharedPreferences.setInt(AppConstants.prefAddressId!, int.parse(value.toString()));
                                          //     // print("value value value $value");
                                          //     // Get.back(result: value);
                                          //
                                          //
                                          //   },
                                          //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          // ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, right: 8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: AppColors
                                                        .bestSellingBorder,
                                                    width: 1),
                                                color: AppColors.white,
                                                borderRadius: const BorderRadius
                                                        .all(
                                                    Radius.circular(
                                                        100.0) //                 <--- border radius here
                                                    ),
                                                // boxShadow: const [
                                                //   BoxShadow(
                                                //     color: Colors.black26,
                                                //     blurRadius: 10,
                                                //     offset:
                                                //     Offset(4, 8), // Shadow position
                                                //   ),
                                                // ],
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(1.5),
                                                child: Container(
                                                  height: 13,
                                                  width: 13,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: AppColors
                                                        .bestSellingBorder,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "Office",
                                            style: CustomTextStyle.label14,
                                          ),
                                        ],
                                      ),
                                    )
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Container(
                              height: 1,
                              width: MediaQuery.of(context).size.width,
                              color: AppColors.tileLine,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  checkedValue = !checkedValue!;
                                  if(checkedValue!){
                                    shippingAddressController!.checkBoxValue = 1;
                                  }else{
                                    shippingAddressController!.checkBoxValue = 0;
                                  }

                                  print("checkedValue ${checkedValue}");
                                });
                              },
                              child: Row(
                                children: [
                                  checkedValue == true
                                      ? Container(
                                          decoration: BoxDecoration(
                                            // border:
                                            // Border.all(color: AppColors.black, width: 1),
                                            color: AppColors.appRed,
                                            borderRadius: const BorderRadius
                                                    .all(
                                                Radius.circular(
                                                    2.0) //                 <--- border radius here
                                                ),
                                            // boxShadow: const [
                                            //   BoxShadow(
                                            //     color: Colors.black26,
                                            //     blurRadius: 10,
                                            //     offset:
                                            //     Offset(4, 8), // Shadow position
                                            //   ),
                                            // ],
                                          ),
                                          height: 17,
                                          width: 17,
                                        )
                                      : Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.black,
                                                width: 1),
                                            color: AppColors.white,
                                            borderRadius: const BorderRadius
                                                    .all(
                                                Radius.circular(
                                                    2.0) //                 <--- border radius here
                                                ),
                                            // boxShadow: const [
                                            //   BoxShadow(
                                            //     color: Colors.black26,
                                            //     blurRadius: 10,
                                            //     offset:
                                            //     Offset(4, 8), // Shadow position
                                            //   ),
                                            // ],
                                          ),
                                          height: 17,
                                          width: 17,
                                        ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  // Transform.scale(
                                  //   scale: 1.1,
                                  //   child: Checkbox(
                                  //
                                  //     value:checkedValue,
                                  //     activeColor: Colors.redAccent,
                                  //     onChanged: (bool? value) {
                                  //       setState(() {
                                  //         // widget.checkBoxValue!();
                                  //         checkedValue=value;
                                  //         print("checkedValue ${value}");
                                  //         // if(value == true){
                                  //         //   widget.checkBoxValue = 1;
                                  //         //   // controller.checkBoxValue(1);
                                  //         // }else{
                                  //         //   widget.checkBoxValue = 0;
                                  //         //   // controller.checkBoxValue(0);
                                  //         // }
                                  //         // print("widget.checkBoxValue ${widget.checkBoxValue}");
                                  //         // print("controller.checkBoxValue ${controller.checkBoxValue.value}");
                                  //
                                  //       });
                                  //
                                  //     },
                                  //   ),
                                  // ),
                                  Text(
                                    'Make this my default address',
                                    style: CustomTextStyle.label14,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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

    MainResponse? mainResponse = await shippingAddressController!.addAddress();
    if (mainResponse != null) {
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
        shippingAddressController!.checkBoxValue = 0;
        Get.back(result: "back");
        SnackBarDialog.showSnackbar('Success', mainResponse.message!);
        // Get.offAllNamed(Routes.landingHome);

      } else {
        SnackBarDialog.showSnackbar('Error', mainResponse.message!);
      }
    } else {
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

    MainResponse? mainResponse = await shippingAddressController!
        .editAddress(shippingAddress!.addressId!);
    if (mainResponse != null) {
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
        shippingAddressController!.checkBoxValue = 0;
        Get.back(result: "back");
        SnackBarDialog.showSnackbar('Success', mainResponse.message!);
        // Get.offAllNamed(Routes.landingHome);

      } else {
        SnackBarDialog.showSnackbar('Error', mainResponse.message!);
      }
    } else {
      print("elseeeeee");
    }
  }

  Future<void> getCountry() async {
   await shippingAddressController!.getCountry();
    shippingAddressController!.stateList([]);

    selectedCountry = shippingAddress!.country;
    selectedState = null;
    // shippingAddressController!.stateList([]);
    shippingAddressController!.countryList.value.forEach((element) {
      if(selectedCountry == element.name){
        print("selectedCountry!.iso2! ${element.iso2!}");
        // print("selectedCountry ${selectedCountry!.name!}");
        shippingAddressController!.getState(element.iso2!);
        selectedState = shippingAddress!.state;
      }

    });
  }
}
