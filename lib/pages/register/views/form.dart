import 'package:eshoperapp/config/theme.dart';
import 'package:eshoperapp/widgets/default_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/snackbar_dialog.dart';
import '../register_controller.dart';

class SignUPForm extends StatelessWidget {
  void create() async {
    Get.snackbar('Error', 'Correct your email!');
  }

  final TextEditingController? customerName;
  final TextEditingController? gender;
  final TextEditingController? email;
  final TextEditingController? mobile;
  final TextEditingController? password;
  final VoidCallback? regAction;
  bool isEmail(String em) {

    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  SignUPForm(
      {this.customerName,
      this.gender,
      this.email,
      this.password,
      this.mobile,
      this.regAction});

  final _formKey = GlobalKey<FormState>();

  final bool remember = false;

  final controller = Get.find<RegisterController>();

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
    final title = 'Create Account';
    final primary = '';

    final btnText = 'CONTINUE';
    final secondary = 'Already have an account?';

    final signInOrRegister = 'Sign In';

    FocusNode myFocusNode = FocusNode();
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              // color: Colors.red,
              child: Image.asset(
            'assets/img/signup.png',
            fit: BoxFit.fitHeight,
            height: 300,
            width: 300,
          )),

          // if (!controller.isSignIn.value)
          Padding(
            padding: const EdgeInsets.only(
                left: AppSizes.sidePadding, right: AppSizes.sidePadding),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(title,
                  style: GoogleFonts.inriaSerif(
                      textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.black))),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: AppSizes.sidePadding, right: AppSizes.sidePadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // if (!controller.isSignIn.value)
                //   TextFormField(
                //     controller: customerName,
                //     textInputAction: TextInputAction.next,
                //     keyboardType: TextInputType.text,
                //     validator: (value) {
                //       if (value!.isEmpty) {
                //         return 'This field is required';
                //       }
                //       // if (!value.contains('@')) {
                //       //   return 'A valid email is required';
                //       // } else {
                //       //   return null;
                //       // }
                //     },
                //     autofillHints: [AutofillHints.name],
                //     decoration: const InputDecoration(
                //         labelText: 'Full Name',
                //         hintText: 'Full Name ',
                //         border: OutlineInputBorder()),
                //   ),
                // const SizedBox(
                //   height: 20,
                // ),
                // Container(
                //   child: TextFormField(
                //     controller: email,
                //     textInputAction: TextInputAction.next,
                //     // autofillHints: [AutofillHints.email],
                //     keyboardType: TextInputType.emailAddress,
                //     validator: (value) {
                //       String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                //       RegExp regExp = RegExp(pattern);
                //       if (value!.isEmpty) {
                //         return 'This field is required';
                //       }
                //       if(!regExp.hasMatch(value)) {
                //         return "A valid email is required";
                //       }
                //       else {
                //         return null;
                //       }
                //       // if (!value.contains('@')) {
                //       //   return 'A valid email is required';
                //       // } else {
                //       //   return null;
                //       // }
                //     },
                //     decoration: InputDecoration(
                //         labelText: 'Email',
                //         hintText: 'Email ',
                //         border: OutlineInputBorder()
                //     ),
                //   ),
                // ),
                // if (!controller.isSignIn.value)
                //   SizedBox(
                //     height: 20,
                //   ),
                // if (!controller.isSignIn.value)
                //   DropdownButtonFormField<String>(
                //     decoration: InputDecoration(
                //       // labelText: 'Email',
                //       hintText: 'Gender ',
                //       // border: OutlineInputBorder()
                //     ),
                //     value: selectedSalutation,
                //     // hint: Text(
                //     //   'Salutation',
                //     // ),
                //     onChanged: (salutation) {
                //       gender!.text = salutation!;
                //       print("salutation $salutation");
                //     },
                //     // onChanged: (salutation) =>
                //     //     setState(() => selectedSalutation = salutation),
                //     validator: (value) =>
                //         value == null ? 'This field is required' : null,
                //     items: ['Male', 'Female']
                //         .map<DropdownMenuItem<String>>((String value) {
                //       return DropdownMenuItem<String>(
                //         value: value,
                //         child: Text(value),
                //       );
                //     }).toList(),
                //   ),
                // SizedBox(
                //   height: 20,
                // ),
                // if (!controller.isSignIn.value)
                TextFormField(
                  controller: customerName,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This field is required';
                    }

                  },

                  // autofillHints: [AutofillHints.num],
                  decoration: InputDecoration(
                      labelStyle: GoogleFonts.inriaSans(
                          textStyle: TextStyle(fontSize: 12)),
                      contentPadding: EdgeInsets.only(top: 0, left: 16),
                      border: OutlineInputBorder(),
                      hintStyle: GoogleFonts.inriaSans(
                          textStyle: TextStyle(fontSize: 12)),
                      hintText: 'Full Name*',
                      labelText: 'Full Name*',
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColors.appText1, width: 1.0),
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColors.appText1, width: 1.0),
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: AppColors.red, width: 1.0),
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: AppColors.red, width: 1.0),
                        borderRadius: BorderRadius.circular(2.0),
                      )),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This field is required';
                    }
                    if (!isEmail(value)) {
                      return 'Please Enter a Valid Email';
                    } else
                    {
                      return null;
                    }
                  },

                  // autofillHints: [AutofillHints.num],
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 0, left: 16),
                      labelStyle: GoogleFonts.inriaSans(
                          textStyle: TextStyle(fontSize: 12)),
                      border: OutlineInputBorder(),
                      hintStyle: GoogleFonts.inriaSans(
                          textStyle: TextStyle(fontSize: 12)),
                      hintText: 'Email*',
                      labelText: 'Email*',
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColors.appText1, width: 1.0),
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColors.appText1, width: 1.0),
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: AppColors.red, width: 1.0),
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: AppColors.red, width: 1.0),
                        borderRadius: BorderRadius.circular(2.0),
                      )
                      // labelStyle:  GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 15))

                      // border: OutlineInputBorder(),

                      ),
                ),


                // Container(
                //   decoration: BoxDecoration(
                //     borderRadius: const BorderRadius.only(
                //       topRight: const Radius.circular(1),
                //       topLeft: Radius.circular(1),
                //       bottomLeft: Radius.circular(1),
                //       bottomRight: Radius.circular(1),
                //     ),
                //     border: Border.all(
                //       width: 1,
                //       color: AppColors.appText1,
                //       // style: BorderStyle.solid,
                //     ),
                //   ),
                //   child: Row(
                //     children: [
                //       Text(" +91 "),
                //       Container(
                //         width: 1,
                //         height: 20,
                //         color: AppColors.appText,
                //       ),
                //       SizedBox(
                //         width: 5.0,
                //       ),
                //       Expanded(
                //         child: TextFormField(
                //           textAlign: TextAlign.start,
                //           keyboardType: TextInputType.phone,
                //           textInputAction: TextInputAction.done,
                //
                //           validator: (value) {
                //             if (value!.isEmpty) {
                //               return 'This field is required';
                //             }
                //
                //             // if (value.length < 4) {
                //             //   return 'Enter a minimum 4 character';
                //             // } else {
                //             //   return null;
                //             // }
                //           },
                //           controller: password,
                //           // obscureText: controller.showPassword.value,
                //           decoration: InputDecoration(
                //             border: InputBorder.none,
                //
                //             // contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                //             // suffixIcon: IconButton(
                //             //     onPressed: () {
                //             //       controller.toggleShowPassword();
                //             //     },
                //             //     icon: controller.showPassword.value
                //             //         ? Icon(Icons.visibility_off)
                //             //         : Icon(Icons.visibility)),
                //             // prefixIcon: Column(
                //             //   mainAxisAlignment: MainAxisAlignment.center,
                //             //   children: [
                //             //     Text(" +91 |",style: GoogleFonts.alumniSans(textStyle: TextStyle(fontSize: 20)),),
                //             //   ],
                //             // ),
                //             // hintStyle: GoogleFonts.alumniSans(textStyle: TextStyle(fontSize: 20)),
                //             // hintText: 'Mobile Number*',
                //             // // labelText: 'Mobile Number*',
                //             // border: OutlineInputBorder(),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 8.0,
                // ),
                // Row(
                //   children: [
                //     Text(
                //       "By continuing, I agree to the",
                //       style: GoogleFonts.inriaSans(
                //         textStyle: const TextStyle(fontSize: 10),
                //       ),
                //     ),
                //     Text(" terms of use",
                //         style: GoogleFonts.inriaSans(
                //           textStyle: const TextStyle(
                //               fontSize: 10, color: AppColors.appRed),
                //         )),
                //     Text(" & ",
                //         style: GoogleFonts.inriaSans(
                //           textStyle: const TextStyle(fontSize: 10),
                //         )),
                //     Text("Privacy Policy",
                //         style: GoogleFonts.inriaSans(
                //           textStyle: const TextStyle(
                //               fontSize: 10, color: AppColors.appRed),
                //         )),
                //   ],
                // ),

                // SizedBox(
                //   height: 10,
                // ),
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
          ),
          SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: AppSizes.sidePadding, right: AppSizes.sidePadding),
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return InkWell(
                    onTap: () {
                      // FocusManager.instance.primaryFocus?.unfocus();
                      if (_formKey.currentState!.validate()) {
                        regAction!();
                      } else {
                        // create();
                      }
                      // if (mobile!.text.isEmpty) {
                      //   // return 'This field is required';
                      //   SnackBarDialog.showSnackbar('Error',"Please enter a mobile number");
                      // } else if (mobile!.text.length < 10) {
                      //   //return 'Enter a minimum 10 number';
                      //   SnackBarDialog.showSnackbar('Error',"Enter a minimum 10 number");
                      // } else if (mobile!.text.length > 10) {
                      //  // return 'Enter a maximum 10 number';
                      //   SnackBarDialog.showSnackbar('Error',"Enter a maximum 10 number");
                      // }else{
                      //   logOrRegAction!();
                      // }
                    },
                    child: DefaultBTN(
                      btnText: btnText,
                    ));
              }
            }),
          ),

          // SizedBox(
          //   height: 10,
          // ),

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

          // Center(child: Text('___________')),
          SizedBox(
            height: 24,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Text(
          //       secondary,
          //       //style: GoogleFonts.rubik()
          //       style: GoogleFonts.inriaSerif(
          //         textStyle: const TextStyle(
          //             fontSize: 12,
          //             color: AppColors.appText1,
          //             fontWeight: FontWeight.w400),
          //       ),
          //     ),
          //     SizedBox(
          //       width: 4.0,
          //     ),
          //     InkWell(
          //       onTap: () {},
          //       child: Text(
          //         signInOrRegister,
          //         style: GoogleFonts.inriaSans(
          //           textStyle: const TextStyle(
          //               fontSize: 12,
          //               color: AppColors.appRed,
          //               fontWeight: FontWeight.w400),
          //         ),
          //       ),
          //     )
          //   ],
          // ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildSignType();
  }
}
