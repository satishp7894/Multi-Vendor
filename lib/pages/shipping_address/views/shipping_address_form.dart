import 'package:eshoperapp/config/theme.dart';
import 'package:eshoperapp/models/country_and_state.dart';
import 'package:eshoperapp/pages/profile/profile_controller.dart';
import 'package:eshoperapp/widgets/default_btn.dart';
import 'package:eshoperapp/widgets/default_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../shippig_address_controller.dart';

class ShippingAddressForm extends StatefulWidget {
  final TextEditingController? firstNameTextController;
  final TextEditingController? lastNameTextController;
  final TextEditingController? emailTextController;
  final TextEditingController? mobileTextController;
  final TextEditingController? addressTextController;
  final TextEditingController? localityTextController;
  final TextEditingController? landmarkTextController;
  final TextEditingController? cityTextController;
  final TextEditingController? stateTextController;
  final TextEditingController? pincodeTextController;
  final TextEditingController? countryTextController;
  final TextEditingController? addressTypeTextController;
  final bool? editMode;
  int? checkBox;
  final VoidCallback? checkBoxValue;
  final VoidCallback? saveAddress;

  ShippingAddressForm(
      {this.firstNameTextController,
      this.lastNameTextController,
      this.emailTextController,
      this.mobileTextController,
      this.addressTextController,
      this.localityTextController,
      this.landmarkTextController,
      this.cityTextController,
      this.stateTextController,
      this.pincodeTextController,
      this.countryTextController,
      this.addressTypeTextController,
        this.editMode,
        this.checkBoxValue,
        this.checkBox,
      this.saveAddress});

  @override
  State<ShippingAddressForm> createState() => _ShippingAddressFormState();
}

class _ShippingAddressFormState extends State<ShippingAddressForm> {
  void create() async {
    Get.snackbar('Error', 'Correct your email!');
  }

  final _formKey = GlobalKey<FormState>();

  final bool remember = false;

  final controller = Get.find<ShippingAddressController>();

  String? selectedSalutation;

  // void socialLogin(String? idToken, String provider) async {


  String? selectedCountry;
  String? selectedState;

  bool? checkedValue = false;

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
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.sidePadding),
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
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFormField(
                    controller: widget.firstNameTextController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This field is required';
                      }
                      if (value.length > 10) {
                        return 'Invalid input';
                      }
                      // if (!value.contains('@')) {
                      //   return 'A valid email is required';
                      // } else {
                      //   return null;
                      // }
                    },
                    // autofillHints: [AutofillHints.name],
                    decoration: const InputDecoration(
                        labelText: 'First Name',
                        hintText: 'First Name ',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: widget.lastNameTextController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This field is required';
                      }
                      if (value.length > 10) {
                        return 'Invalid input';
                      }
                      // if (!value.contains('@')) {
                      //   return 'A valid email is required';
                      // } else {
                      //   return null;
                      // }
                    },
                    // autofillHints: [AutofillHints.name],
                    decoration: const InputDecoration(
                        labelText: 'Last Name',
                        hintText: 'Last Name ',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: widget.emailTextController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regExp = RegExp(pattern);
                      if (value!.isEmpty) {
                        return 'This field is required';
                      }
                      if(!regExp.hasMatch(value)) {
                        return "A valid email is required";
                      }
                      else {
                        return null;
                      }
                      // if (!value.contains('@')) {
                      //   return 'A valid email is required';
                      // } else {
                      //   return null;
                      // }
                    },
                    decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Email',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: widget.mobileTextController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This field is required';
                      }
                      if (value.length < 10) {
                        return 'Enter a minimum 10 number';
                      } else if (value.length > 10) {
                        return 'Enter a maximum 10 number';
                      }
                      {
                        return null;
                      }
                    },
                    // autofillHints: [AutofillHints.name],
                    decoration: const InputDecoration(
                        labelText: 'Mobile',
                        hintText: 'Mobile',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: widget.addressTextController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This field is required';
                      }

                    },
                    // autofillHints: [AutofillHints.name],
                    decoration: const InputDecoration(
                        labelText: 'Address',
                        hintText: 'Address',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // TextFormField(
                  //   controller: widget.localityTextController,
                  //   textInputAction: TextInputAction.next,
                  //   keyboardType: TextInputType.text,
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return 'This field is required';
                  //     }
                  //     // if (!value.contains('@')) {
                  //     //   return 'A valid email is required';
                  //     // } else {
                  //     //   return null;
                  //     // }
                  //   },
                  //   // autofillHints: [AutofillHints.name],
                  //   decoration: const InputDecoration(
                  //       labelText: 'Locality',
                  //       hintText: 'Locality',
                  //       border: OutlineInputBorder()),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // TextFormField(
                  //   controller: widget.landmarkTextController,
                  //   textInputAction: TextInputAction.next,
                  //   keyboardType: TextInputType.text,
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return 'This field is required';
                  //     }
                  //     // if (!value.contains('@')) {
                  //     //   return 'A valid email is required';
                  //     // } else {
                  //     //   return null;
                  //     // }
                  //   },
                  //   // autofillHints: [AutofillHints.name],
                  //   decoration: const InputDecoration(
                  //       labelText: 'Landmark',
                  //       hintText: 'Landmark',
                  //       border: OutlineInputBorder()),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  Obx(() {
                    print("controller.isLoadingCountry ${controller.isLoadingCountry.value}");
                    print("widget.countryTextController!.text ${widget.countryTextController!.text}");


                    if (controller.isLoadingCountry.value == true) {
                      print("controller.countryList if ${controller.countryList.value.length}");
                      return DropdownButtonFormField<String>(

                        decoration: InputDecoration(
                          labelText: 'Country',

                            hintText: 'Country',
                            border: OutlineInputBorder()),
                        // value: widget.countryTextController!.text == "" ? selectedCountry:CountryAndState(name: widget.countryTextController!.text),
                        value:  selectedCountry,
                        // hint: Text(
                        //   'Salutation',
                        // ),
                        onChanged: ( salutation){
                          selectedCountry = salutation!;
                          widget.countryTextController!.text = salutation;
                          print("salutation $salutation");
                          // print("selectedCountry!.iso2! ${salutation.iso2!}");
                          // print("selectedCountry ${selectedCountry!.name!}");
                          selectedState = null;
                          controller.stateList([]);
                          controller.countryList.value.forEach((element) {
                            if(selectedCountry == element.name){
                              print("selectedCountry!.iso2! ${element.iso2!}");
                              // print("selectedCountry ${selectedCountry!.name!}");
                              controller.getState(element.iso2!);
                            }

                          });



                        },
                        // onChanged: (salutation) =>
                        //     setState(() => selectedSalutation = salutation),
                        validator: (value) => value == null ? 'This field is required' : null,
                        items: controller.countryList.value.map<DropdownMenuItem<String>>((CountryAndState value) {
                          return DropdownMenuItem<String>(
                            value: value.name,
                            child: Text(value.name!),
                          );
                        }).toList(),
                      );

                    } else {
                      print("controller.countryList  else ${controller.countryList.value.length}");
                      // print("controller.countryList ${controller.countryList[0].name}");
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),

                  SizedBox(
                    height: 20,
                  ),
                  Obx(() {
                    if (controller.isLoadingState.value == true) {
                      return SizedBox(
                        // height: 100,
                        // width: 300,
                        child: DropdownButtonFormField<String>(

                          decoration: InputDecoration(
                            // labelText: 'Email',
                              labelText: 'State',
                              hintText: 'State',
                              border: OutlineInputBorder()),
                          // value: widget.stateTextController!.text == "" ? selectedState:widget.stateTextController!.text,
                          value: selectedState,
                          // hint: Text(
                          //   // 'Salutation',
                          // ),
                          onChanged: (salutation){
                            widget.stateTextController!.text = salutation!;
                            selectedState = salutation;
                            print("salutation $salutation");
                          },
                          // onChanged: (salutation) =>
                          //     setState(() => selectedSalutation = salutation),
                          validator: (value) => value == null ? 'This field is required' : null,
                          isExpanded: true,
                          icon: Icon(Icons.arrow_drop_down),
                          items:
                          controller.stateList.value.map<DropdownMenuItem<String>>((CountryAndState value) {
                            return DropdownMenuItem<String>(
                              value: value.name,
                              child: Text(value.name!),
                            );
                          }).toList(),
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );

                    }
                  }),

                  // TextFormField(
                  //   controller: stateTextController,
                  //   textInputAction: TextInputAction.next,
                  //   keyboardType: TextInputType.text,
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return 'This field is required';
                  //     }
                  //     // if (!value.contains('@')) {
                  //     //   return 'A valid email is required';
                  //     // } else {
                  //     //   return null;
                  //     // }
                  //   },
                  //   // autofillHints: [AutofillHints.name],
                  //   decoration: const InputDecoration(
                  //       labelText: 'State',
                  //       hintText: 'State',
                  //       border: OutlineInputBorder()),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: widget.cityTextController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This field is required';
                      }
                      // if (!value.contains('@')) {
                      //   return 'A valid email is required';
                      // } else {
                      //   return null;
                      // }
                    },
                    // autofillHints: [AutofillHints.name],
                    decoration: const InputDecoration(
                        labelText: 'City',
                        hintText: 'City',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: widget.pincodeTextController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This field is required';
                      }
                      // if (!value.contains('@')) {
                      //   return 'A valid email is required';
                      // } else {
                      //   return null;
                      // }
                    },
                    // autofillHints: [AutofillHints.name],
                    decoration: const InputDecoration(
                        labelText: 'Pincode',
                        hintText: 'Pincode',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // TextFormField(
                  //   controller: countryTextController,
                  //   textInputAction: TextInputAction.next,
                  //   keyboardType: TextInputType.text,
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return 'This field is required';
                  //     }
                  //     // if (!value.contains('@')) {
                  //     //   return 'A valid email is required';
                  //     // } else {
                  //     //   return null;
                  //     // }
                  //   },
                  //   // autofillHints: [AutofillHints.name],
                  //   decoration: const InputDecoration(
                  //       labelText: 'Country',
                  //       hintText: 'Country',
                  //       border: OutlineInputBorder()),
                  // ),


                  // TextFormField(
                  //   controller: addressTypeTextController,
                  //   textInputAction: TextInputAction.done,
                  //   keyboardType: TextInputType.text,
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return 'This field is required';
                  //     }
                  //     // if (!value.contains('@')) {
                  //     //   return 'A valid email is required';
                  //     // } else {
                  //     //   return null;
                  //     // }
                  //   },
                  //   // autofillHints: [AutofillHints.name],
                  //   decoration: const InputDecoration(
                  //       labelText: 'Address Type',
                  //       hintText: 'Address Type',
                  //       border: OutlineInputBorder()),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  DropdownButtonFormField<String>(

                    decoration: InputDecoration(
                      labelText: 'Address Type',
                        hintText: 'Address Type',
                        border: OutlineInputBorder()),
                    value: widget.addressTypeTextController!.text == "" ? selectedSalutation:widget.addressTypeTextController!.text,
                    // hint: Text(
                    //   'Salutation',
                    // ),
                    onChanged: (salutation){
                      widget.addressTypeTextController!.text = salutation!;
                      print("salutation $salutation");
                    },
                    // onChanged: (salutation) =>
                    //     setState(() => selectedSalutation = salutation),
                    validator: (value) => value == null ? 'This field is required' : null,
                    items:
                    ['Work', 'Home'].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  Row(children: [
                    Transform.scale(
                      scale: 1.3,
                       child: Checkbox(

                         value:checkedValue,
                          activeColor: Colors.redAccent,
                         onChanged: (bool? value) {
                           setState(() {
                             widget.checkBoxValue!();
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
                       const Text('Make this my default address',style: TextStyle(fontSize: 18, ),)
                  ],),
                  SizedBox(
                    height: 10,
                  ),
                  // if (controller.isSignIn.value)
                  //   InkWell(
                  //     onTap: () {
                  //       //   navigator!.pushNamed(SajiloDokanRoutes.checkAccount);
                  //     },
                  //     child: const Text(
                  //       'Forget Password ?',
                  //       //   style: GoogleFonts.blinker(),
                  //     ),
                  //   ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Obx(() {
                if (controller.isLoadingAddAddress.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return InkWell(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (_formKey.currentState!.validate()) {
                          widget.saveAddress!();
                        } else {
                          // create();
                        }
                      },
                      child: DefaultBTN(
                        btnText: "Save Address",
                      ));
                }
              }),

              SizedBox(
                height: 10,
              ),

              // Center(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       SocialButton(
              //         imageName: 'assets/images/search.png',
              //         socialMedia: 'Google',
              //         color: Colors.redAccent,
              //         onPressed: login,
              //       ),
              //       SizedBox(
              //         width: 30,
              //       ),
              //       SocialButton(
              //         imageName: 'assets/images/facebook.png',
              //         socialMedia: 'Facebook',
              //         color: Colors.blue,
              //         onPressed: fblogin,
              //       )
              //     ],
              //   ),
              // ),

              Center(child: Text('___________')),
              SizedBox(
                height: 30,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       secondary,
              //       //style: GoogleFonts.rubik()
              //     ),
              //     InkWell(
              //       onTap: () {
              //         controller.toggleFormType();
              //       },
              //       child: Text(signInOrRegister,
              //           style: TextStyle(fontWeight: FontWeight.bold)),
              //     )
              //   ],
              // // ),
              // SizedBox(
              //   height: 50,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   controller.dispose();
  //   super.dispose();
  // }

  @override
  void initState() {


    if(widget.editMode!){
      selectedCountry = "India";
      selectedCountry = widget.countryTextController!.text;
      // selectedState = "Gujarat";

      selectedState = null;
      controller.stateList([]);
      controller.countryList.value.forEach((element) {
        if(selectedCountry == element.name){
          print("selectedCountry!.iso2! ${element.iso2!}");
          // print("selectedCountry ${selectedCountry!.name!}");
          controller.getState(element.iso2!);
        }

      });
      // selectedState = "Gujarat";
      selectedState = widget.stateTextController!.text;
    }else{
      controller.stateList([]);
    }


    print("widget.checkBox ${widget.checkBox}");
    if(widget.checkBox == 0){
      checkedValue = false;
    }else{
      checkedValue = true;
    }

    super.initState();
  }

  @override


  Widget build(BuildContext context) {
    return Container( height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: buildSignType());
  }
}
