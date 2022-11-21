import 'package:eshoperapp/config/theme.dart';
import 'package:eshoperapp/widgets/default_btn.dart';
import 'package:eshoperapp/widgets/default_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/snackbar_dialog.dart';
import '../login_controller.dart';

class SignForm extends StatelessWidget {
  void create() async {
    Get.snackbar('Error', 'Correct your email!');
  }

  final TextEditingController? customerName;
  final TextEditingController? gender;
  final TextEditingController? email;
  final TextEditingController? mobile;
  final TextEditingController? password;
  final VoidCallback? logOrRegAction;

  SignForm(
      {this.customerName,
      this.gender,
      this.email,
      this.password,
      this.mobile,
      this.logOrRegAction});

  final _formKey = GlobalKey<FormState>();

  final bool remember = false;

  final controller = Get.find<LoginController>();

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
    final title = controller.isSignIn.value ? 'Login' : 'Create Account';
    final primary = controller.isSignIn.value
        ? 'You can find all products of \n the Dot Brand.'
        : '';

    final btnText = controller.isSignIn.value ? 'CONTINUE' : 'CONTINUE';
    final secondary =
        controller.isSignIn.value ? 'Don’t have an account?' : 'Already have an account?';

    final signInOrRegister = controller.isSignIn.value ? 'Sign Up' : 'Sign In';

    FocusNode myFocusNode = FocusNode();
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!controller.isSignIn.value)
          Image.asset( 'assets/img/signup.png',fit: BoxFit.fill,height: 380,width: 380,),
          if (controller.isSignIn.value)
            DefaultLogo(),
          if (controller.isSignIn.value)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Center(
                child: Text(primary,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inriaSans(
                        textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: AppColors.appText))),
              ),
            ],
          ),
          if (controller.isSignIn.value)
          const SizedBox(
            height: 80,
          ),
          // if (!controller.isSignIn.value)
          Padding(
            padding: const EdgeInsets.only(left: AppSizes.sidePadding,right: AppSizes.sidePadding),
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
            padding: const EdgeInsets.only(left: AppSizes.sidePadding,right: AppSizes.sidePadding),
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
                //   TextFormField(
                //     controller: mobile,
                //     keyboardType: TextInputType.number,
                //     textInputAction: TextInputAction.next,
                //     validator: (value) {
                //       if (value!.isEmpty) {
                //         return 'This field is required';
                //       }
                //       if (value.length < 10) {
                //         return 'Enter a minimum 10 number';
                //       } else if (value.length > 10) {
                //         return 'Enter a maximum 10 number';
                //       }
                //       {
                //         return null;
                //       }
                //     },
                //
                //     // autofillHints: [AutofillHints.num],
                //     decoration: const InputDecoration(
                //         labelText: 'Mobile',
                //         hintText: 'Mobile ',
                //         border: OutlineInputBorder()),
                //   ),

                Container(
                  child: TextFormField(
                    focusNode: myFocusNode,
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This field is required';
                      }
                      if (value.length < 4) {
                        return 'Enter a minimum 4 character';
                      } else {
                        return null;
                      }
                    },
                    controller: mobile,
                    // obscureText: controller.showPassword.value,
                    style: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 14,color: AppColors.black)),
                    cursorColor: AppColors.appText1,
                    decoration: InputDecoration(
                          labelStyle : GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 12)),
                        // labelStyle: TextStyle(
                        //     color: myFocusNode.hasFocus ? Colors.purple : AppColors.appText1
                        // ),
                      contentPadding: EdgeInsets.only(top:35),
                      // suffixIcon: IconButton(
                      //     onPressed: () {
                      //       controller.toggleShowPassword();
                      //     },
                      //     icon: controller.showPassword.value
                      //         ? Icon(Icons.visibility_off)
                      //         : Icon(Icons.visibility)),
                      prefixIcon: Container(
                        width: 50,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8,right: 8),
                              child: Text("+91",style: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 14)),),
                            ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(
                                      width: 1,
                                      height: 30,
                                      color: AppColors.appText1,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      hintStyle: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 12)),


                      hintText: 'Mobile Number*',
                      labelText: 'Mobile Number*',
                      enabledBorder:OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),
                      borderRadius: BorderRadius.circular(2.0),

                      ),
                      focusedBorder:OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                        // labelStyle:  GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 15))

                      // border: OutlineInputBorder(),

                    ),
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
                SizedBox(height: 8.0,),
                Row(
                  children: [
                    Text(
                      "By continuing, I agree to the",
                      style: GoogleFonts.inriaSans(
                        textStyle: const TextStyle(fontSize: 10),
                      ),
                    ),
                    Text(" terms of use", style: GoogleFonts.inriaSans(
                      textStyle: const TextStyle(fontSize: 10,color: AppColors.appRed),
                    )),
                    Text(" & ", style: GoogleFonts.inriaSans(
                      textStyle: const TextStyle(fontSize: 10),
                    )),
                    Text("Privacy Policy", style: GoogleFonts.inriaSans(
                      textStyle: const TextStyle(fontSize: 10,color: AppColors.appRed),
                    )),
                  ],
                ),

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
            padding: const EdgeInsets.only(left: AppSizes.sidePadding,right: AppSizes.sidePadding),
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return
                  InkWell(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      // if (_formKey.currentState!.validate()) {
                      //   logOrRegAction!();
                      // } else {
                      //   // create();
                      // }
                            if (mobile!.text.isEmpty) {
                              // return 'This field is required';
                              SnackBarDialog.showSnackbar('Error',"Please enter a mobile number");
                            } else if (mobile!.text.length < 10) {
                              //return 'Enter a minimum 10 number';
                              SnackBarDialog.showSnackbar('Error',"Enter a minimum 10 number");
                            } else if (mobile!.text.length > 10) {
                             // return 'Enter a maximum 10 number';
                              SnackBarDialog.showSnackbar('Error',"Enter a maximum 10 number");
                            }else{
                              logOrRegAction!();
                            }
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                secondary,
                //style: GoogleFonts.rubik()
                style: GoogleFonts.inriaSerif(
                  textStyle: const TextStyle(fontSize: 12,color: AppColors.appText1,fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(width: 4.0,),
              InkWell(
                onTap: () {
                  controller.toggleFormType();
                },
                child: Text(signInOrRegister,
                    style:GoogleFonts.inriaSans(
                      textStyle: const TextStyle(fontSize: 12,color: AppColors.appRed, fontWeight: FontWeight.w400),
                    ),),
              )
            ],
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return buildSignType();
    });
  }
}
