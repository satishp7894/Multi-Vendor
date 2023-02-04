import 'package:eshoperapp/pages/login/login_controller.dart';
import 'package:eshoperapp/pages/register/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/theme.dart';
import '../../constants/app_costants.dart';
import '../../models/check_login.dart';
import '../../models/customer.dart';
import '../../routes/navigation.dart';
import '../../utils/snackbar_dialog.dart';
import '../../widgets/app_bar_title.dart';
import '../../widgets/default_btn.dart';
import '../landing_home/home_controller.dart';
import '../profile/profile_controller.dart';

class OTPScreen1 extends StatefulWidget {
  const OTPScreen1({Key? key}) : super(key: key);

  @override
  State<OTPScreen1> createState() => _OTPScreen1State();
}

class _OTPScreen1State extends State<OTPScreen1> {
  final registerController =  Get.put(LoginController(
      apiRepositoryInterface: Get.find(), localRepositoryInterface: Get.find()));

  final profileController =
  Get.put(ProfileController(
      apiRepositoryInterface: Get.find(), customer: Customer(), localRepositoryInterface: Get.find()));
  final homeController = Get.find<HomeController>();
  String otpNumber1 = "";
  String otpNumber2 = "";
  String otpNumber3 = "";
  String otpNumber4 = "";
  final text1 = TextEditingController();
  final text2 = TextEditingController();
  final text3 = TextEditingController();
  final text4 = TextEditingController();
  final text5 = TextEditingController();
  final text6 = TextEditingController();

  dynamic argumentData = Get.arguments;
  bool editMode = false;
  String phone = "";
  String? verificationId ;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;

  @override
  void initState() {
    editMode = argumentData[0]["editMode"];
    phone = argumentData[1]["phone"];
    print("phone initState===== $phone");
    sendCode(phone);
    super.initState();
  }

  Future sendCode(String phone) async{
    // Auth.auth().settings.isAppVerificationDisabledForTesting = TRUE
    FirebaseAuth auth = FirebaseAuth.instance;
    // await auth.setSettings(forceRecaptchaFlow: true);
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91 $phone',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);

      },
      timeout: const Duration(seconds: 90),
      verificationFailed: (FirebaseAuthException e) {
        print("FirebaseAuthException ============ ${e.code}");
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
          SnackBarDialog.showSnackbar('Error',"The provided phone number is not valid.");
        }

        // Handle other errors
      },
      codeSent: (String verification, int? resendToken) {
        setState(() {
          verificationId = verification;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {

      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      // appBar: AppBar(
      //   elevation: 0,
      //   centerTitle: true,
      //   leading: Center(
      //     child: IconButton(
      //       icon: Image.asset(
      //         "assets/img/arrow_left.png",
      //         fit: BoxFit.fill,
      //         height: 14,width: 17,
      //       ),
      //       onPressed: () => Get.back(),
      //     ),
      //   ),
      //   title: Text(
      //     "OTP",
      //     style: GoogleFonts.inriaSans(
      //         textStyle: TextStyle(
      //             color: AppColors.appText,
      //             fontSize: 18,
      //             fontWeight: FontWeight.w700)),
      //   ),
      // ),
      body: SafeArea(
        child: Column(

          children: [
            // Container(height: 0.5,width: MediaQuery.of(context).size.width,color: AppColors.tileLine,),
            AppbarTitleWidget(title: "",flag: false,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0,right: 16),
                child: ListView(

                  children: [
                    SizedBox(
                      height: 32,
                    ),
                    Container(
                      child: Text("Verify with OTP",
                          style: GoogleFonts.inriaSans(
                              textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black))),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text("Sent via SMS to +91 $phone",
                        style: GoogleFonts.inriaSans(
                            textStyle: TextStyle(
                                fontSize: 12,

                                color: AppColors.black))),
                    SizedBox(
                      height: 24,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _textFieldOTP(text1, first: true, last: false),
                        SizedBox(
                          width: 24,
                        ),
                        _textFieldOTP(text2, first: false, last: false),
                        SizedBox(
                          width: 24,
                        ),
                        _textFieldOTP(text3, first: false, last: false),
                        SizedBox(
                          width: 24,
                        ),
                        _textFieldOTP(text4, first: false, last: false),
                        SizedBox(
                          width: 24,
                        ),
                        _textFieldOTP(text5, first: false, last: false),
                        SizedBox(
                          width: 24,
                        ),
                        _textFieldOTP(text6, first: false, last: true),
                      ],
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    // Row(
                    //   children: [
                    //     Text("Resend OTP in",
                    //         textAlign: TextAlign.center,
                    //         style: GoogleFonts.inriaSans(
                    //             textStyle: TextStyle(
                    //                 fontSize: 12,
                    //                 fontWeight: FontWeight.w400,
                    //                 color: AppColors.appText))),
                    //     Text(" 00:15",
                    //         textAlign: TextAlign.center,
                    //         style: GoogleFonts.inriaSans(
                    //             textStyle: TextStyle(
                    //                 fontSize: 12,
                    //                 fontWeight: FontWeight.w400,
                    //                 color: AppColors.appRed))),
                    //   ],
                    // ),

                    CountdownTimer(
                      endTime: endTime,
                      widgetBuilder: (_, CurrentRemainingTime? time) {
                        if (time == null) {
                          return   Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: (){
                                  sendCode(phone);
                                  setState(() {
                                    endTime= DateTime.now().millisecondsSinceEpoch + 1000 * 120;
                                  });
                                },
                                child: Text("Resend OTP in",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inriaSans(
                                        textStyle: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.appText))),
                              ),

                              Text(" 00:00",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inriaSans(
                                      textStyle: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.appRed))),
                            ],
                          );
                        }
                        return   Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Resend OTP in",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inriaSans(
                                    textStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.appText))),
                            Text(" 0${time.min ?? "0"}:${time.sec.toString().length == 2 ?time.sec:time.sec.toString().length == 1 ? "0${time.sec}":"00"}",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inriaSans(
                                    textStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.appRed))),
                          ],
                        );
                      },
                    ),
                    // SizedBox(
                    //   height: 56,
                    // ),
                    // InkWell(
                    //     onTap: () {
                    //       FocusManager.instance.primaryFocus?.unfocus();
                    //       // if (_formKey.currentState!.validate()) {
                    //       //   logOrRegAction!();
                    //       // } else {
                    //       //   // create();
                    //       // }
                    //       print("otpNumber1 ${text1.text}");
                    //       print("otpNumber2 ${text2.text}");
                    //       print("otpNumber3 ${text3.text}");
                    //       print("otpNumber4 ${text4.text}");
                    //       validateOtp();
                    //
                    //     },
                    //     child: DefaultBTN(
                    //       btnText: "Verify & Create Account",
                    //     ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> validateOtp() async {
    if(text1.text.isEmpty || text2.text.isEmpty || text3.text.isEmpty || text4.text.isEmpty || text5.text.isEmpty || text6.text.isEmpty ){
      print("Invalid Otp");
      SnackBarDialog.showSnackbar('Error',"Invalid Otp");
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

      try{


        FirebaseAuth? auth = FirebaseAuth.instance;
        PhoneAuthCredential? credential = PhoneAuthProvider.credential(verificationId: verificationId!, smsCode: text1.text + text2.text + text3.text + text4.text + text5.text + text6.text);

        // Sign the user in (or link) with the credential
        final result = await auth.signInWithCredential(credential);
        if(result.user != null){

          SnackBarDialog.showSnackbar('Success',"Verified Otp");
          print("Otp ${text1.text + text2.text + text3.text + text4.text + text5.text + text6.text}");
          print("Otp verificationId =============${verificationId!}");
          print("Otp result =============${result.user}");

          // Get.toNamed(
          //   Routes.register,
          // );

          CheckLogin? checkLogin = await registerController.checkLogin(phone);
          if (checkLogin.status!) {
            Get.back();
            registerController.customerNameTexcontroller.clear();
            registerController.genderTextController.clear();
            registerController.emailTextController.clear();
            registerController.mobileTextController.clear();
            registerController.passwordTextController.clear();
            profileController.isUserDataRefresh(true);
            // Get.snackbar('Success', checkLogin.message!,duration: const Duration(seconds: 8), snackPosition: SnackPosition.BOTTOM,);
            // SnackBarDialog.showSnackbar('Success',checkLogin.message!);
            await profileController.getUser();
            await homeController.loadUser(true);
            homeController.getCartItems(profileController.customerId.value, true);
            SharedPreferences sharedPreferences = await SharedPreferences.getInstance() ;

            print("sharedPreferences.getString(AppConstants.chooseType!) ===============> ${sharedPreferences.getString(AppConstants.chooseType!)}");

            if(sharedPreferences.getString(AppConstants.chooseType!) != null ){
              Get.offAllNamed(Routes.landingHome);
            }else{
              Get.offAndToNamed(Routes.chooseYourStoreScreen);
            }
          } else {
            Get.toNamed(Routes.register,arguments: [
              {"editMode": false},
              {"phone": phone},
            ]);
            // Get.snackbar('Error', checkLogin.message!,duration: const Duration(seconds: 8), snackPosition: SnackPosition.BOTTOM,);
            // SnackBarDialog.showSnackbar('Error',checkLogin.message!);
          }
        }

      }catch(e){

        print("Invalid Otp else ${e.toString()} ");
        SnackBarDialog.showSnackbar('Error',"Invalid Otp");
        // CheckLogin? checkLogin = await registerController.checkLogin(phone);
        // if (checkLogin.status!) {
        //   Get.back();
        //   registerController.customerNameTexcontroller.clear();
        //   registerController.genderTextController.clear();
        //   registerController.emailTextController.clear();
        //   registerController.mobileTextController.clear();
        //   registerController.passwordTextController.clear();
        //   profileController.isUserDataRefresh(true);
        //   // Get.snackbar('Success', checkLogin.message!,duration: const Duration(seconds: 8), snackPosition: SnackPosition.BOTTOM,);
        //   // SnackBarDialog.showSnackbar('Success',checkLogin.message!);
        //   await profileController.getUser();
        //   await homeController.loadUser(true);
        //   homeController.getCartItems(profileController.customerId.value, true);
        //   Get.offAllNamed(Routes.landingHome);
        // } else {
        //   Get.toNamed(Routes.register,arguments: [
        //     {"editMode": false},
        //     {"phone": phone},
        //   ]);
        //   // Get.snackbar('Error', checkLogin.message!,duration: const Duration(seconds: 8), snackPosition: SnackPosition.BOTTOM,);
        //   // SnackBarDialog.showSnackbar('Error',checkLogin.message!);
        // }

      }
      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(builder: (context) => const Home()),(route)=>false
      // );
    }
  }

  Widget _textFieldOTP(TextEditingController textEditingController,
      {bool? first, last}) {
    return Container(
       width: 35,
      // height: 60,
      decoration: const BoxDecoration(
        // color: AppColors.red,
        // shape: BoxShape.circle
        // borderRadius: const BorderRadius.only(
        //   topRight: const Radius.circular(5),
        //   topLeft: Radius.circular(5),
        //   bottomLeft: Radius.circular(5),
        //   bottomRight: Radius.circular(5),
        // ),
      ),

      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        controller: textEditingController,
        autofocus: true,

        onChanged: (value) {
          if (value.length == 1 && last == false) {
            FocusScope.of(context).nextFocus();
          }
          if (value.length == 0 && first == false) {
            FocusScope.of(context).previousFocus();
          }

          if(value.isNotEmpty && last == true){
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
            print("otpNumber5 ${text5.text}");
            print("otpNumber6 ${text6.text}");
            validateOtp();
          }
        },
        showCursor: false,
        readOnly: false,
        textAlign: TextAlign.center,

        style: TextStyle(
            // fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.black),
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top:30,bottom: 0),
          fillColor: AppColors.white,
          hintText: '*',
          hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.grey,
             ),
          filled: true,

          // label: Text('*'),
          counter: Offstage(),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: AppColors.appText1),
              borderRadius: BorderRadius.circular(0)
              ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color:AppColors.red),
              borderRadius: BorderRadius.circular(0)
            ),
        ),
      ),
    );
  }
}
