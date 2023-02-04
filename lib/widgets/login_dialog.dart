import 'package:eshoperapp/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../routes/navigation.dart';
import '../utils/snackbar_dialog.dart';
import 'default_btn.dart';

class LoginDialog extends StatelessWidget {
  final TextEditingController? mobile;
  final BuildContext? context;
  LoginDialog({this.mobile,this.context});
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/logos/app_logo.png',fit: BoxFit.fill,height: 37,width: 80,),
                    InkWell(
                        onTap: (){
                          mobile!.clear();
                          Get.back();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset("assets/img/close.png",fit: BoxFit.fill,height: 15,width: 15,),
                        ))
                  ],
                ),
                SizedBox(height: 16,),
                Row(
                  children: [
                    Text("Login",
                        style: GoogleFonts.inriaSans(
                            textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.black))),
                    SizedBox(width: 5,),
                    Text("or",
                        style: GoogleFonts.inriaSans(
                            textStyle: TextStyle(
                                fontSize: 10,
                                color: AppColors.black))),
                    SizedBox(width: 5,),
                    Text("Signup",
                        style: GoogleFonts.inriaSans(
                            textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.black))),
                  ],
                ),
                SizedBox(height: 16,),
                Container(
                  child: TextFormField(
                    // focusNode: myFocusNode,
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
                      contentPadding: EdgeInsets.only(top:30),
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
                SizedBox(height: 16,),
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
                SizedBox(height: 16,),
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
                        Get.back();
                        Get.toNamed(Routes.otpScreen1,arguments: [
                          {"editMode": false},
                          {"phone": mobile!.text},
                        ]);
                        mobile!.clear();
                      }
                    },
                    child: DefaultBTN(
                      btnText: "CONTINUE",
                    )),


              ],
            ),
          ),
        ],
      ),
    );
  }
}
