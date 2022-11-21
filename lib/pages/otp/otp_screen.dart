import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/theme.dart';
import '../../widgets/default_btn.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String otpNumber1 = "";
  String otpNumber2 = "";
  String otpNumber3 = "";
  String otpNumber4 = "";
  final text1 = TextEditingController();
  final text2 = TextEditingController();
  final text3 = TextEditingController();
  final text4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: Center(
          child: IconButton(
            icon: Image.asset(
              "assets/img/arrow_left.png",
              fit: BoxFit.fill,
              height: 14,width: 17,
            ),
            onPressed: () => Get.back(),
          ),
        ),
        title: Text(
          "OTP",
          style: GoogleFonts.inriaSans(
              textStyle: TextStyle(
                  color: AppColors.appText,
                  fontSize: 18,
                  fontWeight: FontWeight.w700)),
        ),
      ),
      body: Column(
        children: [
          Container(height: 0.5,width: MediaQuery.of(context).size.width,color: AppColors.tileLine,),
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 24),
                  child: Image.asset(
                    'assets/img/otp.png',
                    fit: BoxFit.fill,
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text("Verification code",
                      style: GoogleFonts.inriaSans(
                          textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black))),
                ),
                SizedBox(
                  height: 24,
                ),
                Text("Enter the OTP sent to +91 1234567891",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inriaSans(
                        textStyle: TextStyle(
                            fontSize: 12,

                            color: AppColors.black))),
                SizedBox(
                  height: 48,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _textFieldOTP(text1, first: true, last: false),
                      SizedBox(
                        width: 10,
                      ),
                      _textFieldOTP(text2, first: false, last: false),
                      SizedBox(
                        width: 10,
                      ),
                      _textFieldOTP(text3, first: false, last: false),
                      SizedBox(
                        width: 10,
                      ),
                      _textFieldOTP(text4, first: false, last: true),
                    ],
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Resend OTP in",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inriaSans(
                            textStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.appText))),
                    Text(" 00:15",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inriaSans(
                            textStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.appRed))),
                  ],
                ),
                SizedBox(
                  height: 56,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: AppSizes.sidePadding, right:AppSizes.sidePadding),
                  child: InkWell(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        // if (_formKey.currentState!.validate()) {
                        //   logOrRegAction!();
                        // } else {
                        //   // create();
                        // }
                        print("otpNumber1 ${text1.text}");
                        print("otpNumber2 ${text2.text}");
                        print("otpNumber3 ${text3.text}");
                        print("otpNumber4 ${text4.text}");
                        validateOtp();

                      },
                      child: DefaultBTN(
                        btnText: "Verify & Create Acoount",
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void validateOtp() {
    if(text1.text.isEmpty || text2.text.isEmpty || text3.text.isEmpty || text4.text.isEmpty ){
      print("Invalid Otp");
      // Fluttertoast.showToast(
      //     msg: "Invalid Otp",
      //     toastLength: Toast.LENGTH_LONG,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0
      // );
      //Toast.show("Invalid Otp", duration: Toast.lengthShort, gravity:  Toast.bottom,backgroundColor: appWhiteColor);
    }else{
      print("Otp ${text1.text + text2.text + text3.text + text4.text}");
      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(builder: (context) => const Home()),(route)=>false
      // );
    }
  }

  Widget _textFieldOTP(TextEditingController textEditingController,
      {bool? first, last}) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100.0),
       // side: BorderSide(color: Theme.of(context).primaryColor),
      ),
      elevation: 10,

      child: Container(
         width: 56,
        height: 56,
        decoration: const BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle
          // borderRadius: const BorderRadius.only(
          //   topRight: const Radius.circular(100),
          //   topLeft: Radius.circular(100),
          //   bottomLeft: Radius.circular(100),
          //   bottomRight: Radius.circular(100),
          // ),
        ),

        child: TextField(
          controller: textEditingController,
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,

          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.black),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            fillColor: AppColors.white,
            hintText: '*',
            hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.grey,
                fontSize: 15),
            filled: true,

            // label: Text('*'),
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0.5, color: AppColors.white),
                borderRadius: BorderRadius.circular(100)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0.5, color:AppColors.white),
                borderRadius: BorderRadius.circular(100)),
          ),
        ),
      ),
    );
  }
}
