import 'package:eshoperapp/config/theme.dart';
import 'package:eshoperapp/pages/profile/profile_controller.dart';
import 'package:eshoperapp/widgets/default_btn.dart';
import 'package:eshoperapp/widgets/default_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/validation.dart';


class ChangePassForm extends StatefulWidget {
  final TextEditingController? currentPassword;
  final TextEditingController? newPassword;
  final TextEditingController? confirmPassword;
  final VoidCallback? submitAction;

  ChangePassForm(
      {this.currentPassword,
      this.newPassword,
      this.confirmPassword,
      this.submitAction});

  @override
  State<ChangePassForm> createState() => _ChangePassFormState();
}

class _ChangePassFormState extends State<ChangePassForm> {
  void create() async {
    Get.snackbar('Error', 'Correct your email!');
  }

  final _formKey = GlobalKey<FormState>();

  final bool remember = false;
  bool validationCharacter = false;
  bool validationNumeric = false;
  bool validationUpperCase = false;

  bool validationCharacter1 = false;
  bool validationNumeric1 = false;
  bool validationUpperCase1 = false;

  bool validationCharacter2 = false;
  bool validationNumeric2 = false;
  bool validationUpperCase2 = false;

  final controller = Get.find<ProfileController>();

  // void socialLogin(String? idToken, String provider) async {
  Widget buildSignType() {
    String? selectedSalutation;
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
              height: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [


                Container(
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return 'This field is required';
                    //   }
                    //   if (value.length < 4) {
                    //     return 'Enter a minimum 4 character';
                    //   } else {
                    //     return null;
                    //   }
                    // },
                    onChanged: (text){
                      setState(() {
                        print("text  ${text}");
                      });
                    },
                    controller: widget.currentPassword,
                    obscureText: controller.showCurrentPassword.value,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            controller.toggleShowCurrentPassword();
                          },
                          icon: controller.showCurrentPassword.value
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility)),
                      hintText: 'Old Password',
                      labelText: 'Old Password*',
                      // border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(children:
                [validation8Character(widget.currentPassword!.text,"8 Characters", "currentPassword"),
                  SizedBox(width: 5,),
                  validation1UpperCase(widget.currentPassword!.text,"1 uppercase", "currentPassword"),
                  SizedBox(width: 5,),
                  validation1Numeric(widget.currentPassword!.text,"1 numeric", "currentPassword")
                ],),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return 'This field is required';
                    //   }
                    //   if (value.length < 4) {
                    //     return 'Enter a minimum 4 character';
                    //   } else {
                    //     return null;
                    //   }
                    // },
                    onChanged: (text){
                      setState(() {
                        print("text  ${text}");
                      });
                    },
                    controller: widget.newPassword,
                    obscureText: controller.showNewPassword.value,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            controller.toggleShowNewPassword();
                          },
                          icon: controller.showNewPassword.value
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility)),
                      hintText: 'New Password',
                      labelText: 'New Password*',
                      // border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(children:
                [validation8Character(widget.newPassword!.text,"8 Characters","newPassword"),
                  SizedBox(width: 5,),
                  validation1UpperCase(widget.newPassword!.text,"1 uppercase", "newPassword"),
                  SizedBox(width: 5,),
                  validation1Numeric(widget.newPassword!.text,"1 numeric", "newPassword")
                ],),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child:
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return 'This field is required';
                    //   }
                    //   if (value.length < 4) {
                    //     return 'Enter a minimum 4 character';
                    //   } else {
                    //     return null;
                    //   }
                    // },
                    onChanged: (text){
                      setState(() {
                        print("text  ${text}");
                      });
                    },
                    controller: widget.confirmPassword,
                    obscureText: controller.showConfirmPassword.value,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            controller.toggleShowConfirmPassword();
                          },
                          icon: controller.showConfirmPassword.value
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility)),
                      hintText: 'Confirm New Password',
                      labelText: 'Confirm New Password*',
                      // border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(children:
                [validation8Character(widget.confirmPassword!.text,"8 Characters", "confirmPassword"),
                  SizedBox(width: 5,),
                  validation1UpperCase(widget.confirmPassword!.text,"1 uppercase","confirmPassword"),
                  SizedBox(width: 5,),
                  validation1Numeric(widget.confirmPassword!.text,"1 numeric","confirmPassword")
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
              height: 20,
            ),
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return InkWell(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      // if (_formKey.currentState!.validate()) {
                      //   widget.submitAction!();
                      // } else {
                      //   // create();
                      // }

                      if (validationCharacter && validationCharacter1 && validationCharacter2 && validationNumeric && validationNumeric1 && validationNumeric2
                      && validationUpperCase && validationUpperCase1 && validationUpperCase2) {
                        widget.submitAction!();
                      } else {
                        // create();
                      }
                    },
                    // child: DefaultBTN(
                    //   btnText: "Submit",
                    // )
                  child:
                  validationCharacter && validationCharacter1 && validationCharacter2 && validationNumeric && validationNumeric1 && validationNumeric2
                      && validationUpperCase && validationUpperCase1 && validationUpperCase2 ?

                  Container(
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.all( 12.0),
                      child: Center(child: Text("Change Password", style: GoogleFonts.inriaSans(
                          textStyle: TextStyle(
                              fontSize: 18,
                              color: AppColors.white,
                              fontWeight: FontWeight.w700)),)),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.appRed,
                      // border: Border.all(color: AppColors.appText1, width: 1),
                      // color: Colors.grey[100],
                      borderRadius: const BorderRadius.all(Radius.circular(
                          1.0) //                 <--- border radius here
                      ),
                    ),
                  ):
                  Container(
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.all( 12.0),
                      child: Center(child: Text("Change Password", style: GoogleFonts.inriaSans(
                          textStyle: TextStyle(
                              fontSize: 18,
                              color: AppColors.white,
                              fontWeight: FontWeight.w700)),)),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.appText1,
                      // border: Border.all(color: AppColors.appText1, width: 1),
                      // color: Colors.grey[100],
                      borderRadius: const BorderRadius.all(Radius.circular(
                          1.0) //                 <--- border radius here
                      ),
                    ),
                  ),

                );
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

            // Center(child: Text('___________')),
            // SizedBox(
            //   height: 10,
            // ),
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
    return Obx(() {
      return buildSignType();
    });
  }

  validation8Character(String value, String text, String type) {
    if(value.length >= 8){
      if(type == "currentPassword"){
        validationCharacter = true;
      }  else if(type == "newPassword"){
        validationCharacter1 = true;
      } else if(type == "confirmPassword"){
        validationCharacter2 = true;
      }

      // return const Text("text");
      return  Container(
        width: 100,
        child: Padding(
          padding: const EdgeInsets.all( 8.0),
          child: Center(child: Text(text, style: GoogleFonts.inriaSans(
              textStyle: TextStyle(
                  fontSize: 12,
                  color: AppColors.appRed,
                  fontWeight: FontWeight.w700)),)),
        ),
        decoration: BoxDecoration(
          color: AppColors.validationBg,
         // border: Border.all(color: AppColors.appText1, width: 1),
          // color: Colors.grey[100],
          borderRadius: const BorderRadius.all(Radius.circular(
              1.0) //                 <--- border radius here
          ),
        ),
      );
    }else{
      if(type == "currentPassword"){
        validationCharacter = false;
      }  else if(type == "newPassword"){
        validationCharacter1 = false;
      } else if(type == "confirmPassword"){
        validationCharacter2 = false;
      }
      return  Container(
        width: 100,
        child: Padding(
          padding: const EdgeInsets.all( 8.0),
          child: Center(child: Text(text, style: GoogleFonts.inriaSans(
              textStyle: TextStyle(
                  fontSize: 12,
                  color: AppColors.appText1,
                  fontWeight: FontWeight.w700)),)),
        ),
        decoration: BoxDecoration(
          color: AppColors.validationBg1,
          // border: Border.all(color: AppColors.appText1, width: 1),
          // color: Colors.grey[100],
          borderRadius: const BorderRadius.all(Radius.circular(
              1.0) //                 <--- border radius here
          ),
        ),
      );
    }

  }
  validation1UpperCase(String value, String text, String type) {
    if(value.contains(RegExp(r'[A-Z]'))){
      if(type == "currentPassword"){
        validationUpperCase = true;
      }  else if(type == "newPassword"){
        validationUpperCase1 = true;
      } else if(type == "confirmPassword"){
        validationUpperCase2 = true;
      }
      // return const Text("text");
      return  Container(
        width: 100,
        child: Padding(
          padding: const EdgeInsets.all( 8.0),
          child: Center(child: Text(text, style: GoogleFonts.inriaSans(
              textStyle: TextStyle(
                  fontSize: 12,
                  color: AppColors.appRed,
                  fontWeight: FontWeight.w700)),)),
        ),
        decoration: BoxDecoration(
          color: AppColors.validationBg,
          // border: Border.all(color: AppColors.appText1, width: 1),
          // color: Colors.grey[100],
          borderRadius: const BorderRadius.all(Radius.circular(
              1.0) //                 <--- border radius here
          ),
        ),
      );
    }else{
      if(type == "currentPassword"){
        validationUpperCase = false;
      }  else if(type == "newPassword"){
        validationUpperCase1 = false;
      } else if(type == "confirmPassword"){
        validationUpperCase2 = false;
      }
      return  Container(
        width: 100,
        child: Padding(
          padding: const EdgeInsets.all( 8.0),
          child: Center(child: Text(text, style: GoogleFonts.inriaSans(
              textStyle: TextStyle(
                  fontSize: 12,
                  color: AppColors.appText1,
                  fontWeight: FontWeight.w700)),)),
        ),
        decoration: BoxDecoration(
          color: AppColors.validationBg1,
          // border: Border.all(color: AppColors.appText1, width: 1),
          // color: Colors.grey[100],
          borderRadius: const BorderRadius.all(Radius.circular(
              1.0) //                 <--- border radius here
          ),
        ),
      );
    }

  }
  validation1Numeric(String value, String text,String type) {
    if(value.contains(RegExp(r'[0-9]'))){
      if(type == "currentPassword"){
        validationNumeric = true;
      }  else if(type == "newPassword"){
        validationNumeric1 = true;
      } else if(type == "confirmPassword"){
        validationNumeric2 = true;
      }
      // return const Text("text");
      return  Container(
        width: 100,
        child: Padding(
          padding: const EdgeInsets.all( 8.0),
          child: Center(child: Text(text, style: GoogleFonts.inriaSans(
              textStyle: TextStyle(
                  fontSize: 12,
                  color: AppColors.appRed,
                  fontWeight: FontWeight.w700)),)),
        ),
        decoration: BoxDecoration(
          color: AppColors.validationBg,
          // border: Border.all(color: AppColors.appText1, width: 1),
          // color: Colors.grey[100],
          borderRadius: const BorderRadius.all(Radius.circular(
              1.0) //                 <--- border radius here
          ),
        ),
      );
    }else{
      if(type == "currentPassword"){
        validationNumeric = false;
      }  else if(type == "newPassword"){
        validationNumeric1 = false;
      } else if(type == "confirmPassword"){
        validationNumeric2 = false;
      }
      return  Container(
        width: 100,
        child: Padding(
          padding: const EdgeInsets.all( 8.0),
          child: Center(child: Text(text, style: GoogleFonts.inriaSans(
              textStyle: TextStyle(
                  fontSize: 12,
                  color: AppColors.appText1,
                  fontWeight: FontWeight.w700)),)),
        ),
        decoration: BoxDecoration(
          color: AppColors.validationBg1,
          // border: Border.all(color: AppColors.appText1, width: 1),
          // color: Colors.grey[100],
          borderRadius: const BorderRadius.all(Radius.circular(
              1.0) //                 <--- border radius here
          ),
        ),
      );
    }

  }
}
