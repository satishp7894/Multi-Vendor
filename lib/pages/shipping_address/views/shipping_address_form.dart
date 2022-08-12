import 'package:eshoperapp/config/theme.dart';
import 'package:eshoperapp/pages/profile/profile_controller.dart';
import 'package:eshoperapp/widgets/default_btn.dart';
import 'package:eshoperapp/widgets/default_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../shippig_address_controller.dart';

class ShippingAddressForm extends StatelessWidget {
  void create() async {
    Get.snackbar('Error', 'Correct your email!');
  }

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
      this.saveAddress});

  final _formKey = GlobalKey<FormState>();

  final bool remember = false;

  final controller = Get.find<ShippingAddressController>();

  // void socialLogin(String? idToken, String provider) async {
  //   final result = await controller.googleAuth(idToken, provider);
  //   if (result) {
  //     Get.offAllNamed(SajiloDokanRoutes.landingHome);
  //   } else {
  //     Get.snackbar('Error', 'Incorrect Password');
  //   }
  // }

  // final googlesignIn = GoogleSignIn(
  //   scopes: [
  //     'https://www.googleapis.com/auth/userinfo.email',
  //     'https://www.googleapis.com/auth/userinfo.profile',
  //   ],
  // );
  //
  // Future<void> fblogin() async {
  //   final result = await FacebookAuth.instance.login(permissions: [
  //     'public_profile',
  //     'email',
  //   ]);
  //   if (result.status == LoginStatus.success) {
  //     log(result.accessToken!.token);
  //     socialLogin(result.accessToken!.token, 'facebook');
  //   } else {
  //     return null;
  //   }
  // }

  // Future<void> login() async {
  //   await googlesignIn
  //       .signIn()
  //       .then((result) => result!.authentication)
  //       .then((googleKey) => socialLogin(googleKey.idToken, 'google'))
  //       .catchError((err) => null);
  // }

  Widget buildSignType() {
    String? selectedSalutation;
    print("addressTypeTextController ${addressTypeTextController!.text}");
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
            Stack(
              alignment: Alignment.center,
              children: [
                // Positioned(
                //   child: Container(
                //     child: Obx(() {
                //       if (controller.isLoading.value) {
                //         return const Center(
                //           child: CircularProgressIndicator(),
                //         );
                //       } else {
                //         return const SizedBox.shrink();
                //       }
                //     }),
                //   ),
                // ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextFormField(
                      controller: firstNameTextController,
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
                      controller: lastNameTextController,
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
                      controller: emailTextController,
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
                      controller: mobileTextController,
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
                      controller: addressTextController,
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
                    TextFormField(
                      controller: localityTextController,
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
                          labelText: 'Locality',
                          hintText: 'Locality',
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: landmarkTextController,
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
                          labelText: 'Landmark',
                          hintText: 'Landmark',
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: cityTextController,
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
                      controller: stateTextController,
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
                          labelText: 'State',
                          hintText: 'State',
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: pincodeTextController,
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
                          labelText: 'Pincode',
                          hintText: 'Pincode',
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: countryTextController,
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
                          labelText: 'Country',
                          hintText: 'Country',
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
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
                        // labelText: 'Email',
                          hintText: 'Address Type ',
                          border: OutlineInputBorder()),
                      value: addressTypeTextController!.text == "" ? selectedSalutation:addressTypeTextController!.text,
                      // hint: Text(
                      //   'Salutation',
                      // ),
                      onChanged: (salutation){
                        addressTypeTextController!.text = salutation!;
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
                      height: 20,
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
                )
              ],
            ),
            SizedBox(
              height: 20,
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
                        saveAddress!();
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
              height: 10,
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
            // ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildSignType();
  }
}
