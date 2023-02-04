import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/theme.dart';
import '../../constants/app_costants.dart';
import '../../models/check_login.dart';
import '../../models/customer.dart';
import '../../routes/navigation.dart';
import '../../utils/snackbar_dialog.dart';
import '../../widgets/default_btn.dart';
import '../landing_home/home_controller.dart';
import '../login/login_controller.dart';
import '../profile/profile_controller.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {


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
  // bool argumentData = Get.arguments;
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
                Text("Enter the OTP sent to +91 $phone",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inriaSans(
                        textStyle: TextStyle(
                            fontSize: 12,

                            color: AppColors.black))),
                SizedBox(
                  height: 48,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _textFieldOTP(text1, first: true, last: false),
                      // SizedBox(
                      //   width: 10,
                      // ),
                      _textFieldOTP(text2, first: false, last: false),
                      // SizedBox(
                      //   width: 10,
                      // ),
                      _textFieldOTP(text3, first: false, last: false),
                      // SizedBox(
                      //   width: 10,
                      // ),
                      _textFieldOTP(text4, first: false, last: false),
                      // SizedBox(
                      //   width: 10,
                      // ),
                      _textFieldOTP(text5, first: false, last: false),
                      // SizedBox(
                      //   width: 10,
                      // ),
                      _textFieldOTP(text6, first: false, last: true),
                    ],
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                CountdownTimer(
                  endTime: endTime,
                  widgetBuilder: (_, CurrentRemainingTime? time) {
                    if (time == null) {
                      return   Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                      mainAxisAlignment: MainAxisAlignment.center,
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
                        print("otpNumber5 ${text5.text}");
                        print("otpNumber6 ${text6.text}");
                        validateOtp();

                      },
                      child: DefaultBTN(
                        btnText: editMode == true ?"Continue":"Verify & Create Account",
                      )),
                )
              ],
            ),
          ),
        ],
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


          CheckLogin? checkLogin = await registerController.checkLogin(phone);
          if (checkLogin.status!) {
            // Get.back();
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



    }
      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(builder: (context) => const Home()),(route)=>false
      // );
    }
  }

  Widget _textFieldOTP(TextEditingController textEditingController,
      {bool? first, last}) {
    // return Material(
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(100.0),
    //    // side: BorderSide(color: Theme.of(context).primaryColor),
    //   ),
    //   elevation: 10,
    //
    //   child: Container(
    //      width: 56,
    //     height: 56,
    //     decoration: const BoxDecoration(
    //       color: AppColors.white,
    //       shape: BoxShape.circle
    //       // borderRadius: const BorderRadius.only(
    //       //   topRight: const Radius.circular(100),
    //       //   topLeft: Radius.circular(100),
    //       //   bottomLeft: Radius.circular(100),
    //       //   bottomRight: Radius.circular(100),
    //       // ),
    //     ),
    //
    //     child: TextField(
    //       controller: textEditingController,
    //       autofocus: true,
    //       onChanged: (value) {
    //         if (value.length == 1 && last == false) {
    //           FocusScope.of(context).nextFocus();
    //         }
    //         if (value.length == 0 && first == false) {
    //           FocusScope.of(context).previousFocus();
    //         }
    //       },
    //       showCursor: false,
    //       readOnly: false,
    //       textAlign: TextAlign.center,
    //
    //       style: TextStyle(
    //           fontSize: 24,
    //           fontWeight: FontWeight.bold,
    //           color: AppColors.black),
    //       keyboardType: TextInputType.number,
    //       maxLength: 1,
    //       decoration: InputDecoration(
    //         fillColor: AppColors.white,
    //         hintText: '*',
    //         hintStyle: TextStyle(
    //             fontWeight: FontWeight.bold,
    //             color: AppColors.grey,
    //             fontSize: 15),
    //         filled: true,
    //
    //         // label: Text('*'),
    //         counter: Offstage(),
    //         enabledBorder: OutlineInputBorder(
    //             borderSide: BorderSide(width: 0.5, color: AppColors.white),
    //             borderRadius: BorderRadius.circular(100)),
    //         focusedBorder: OutlineInputBorder(
    //             borderSide: BorderSide(width: 0.5, color:AppColors.white),
    //             borderRadius: BorderRadius.circular(100)),
    //       ),
    //     ),
    //   ),
    // );

    return Container(

      height: 55,
      width: 55,

      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey,blurRadius: 8,offset: Offset(3,5))],
        borderRadius: BorderRadius.circular(100),
        // border: Border.all(color: Colors.orange,width: 1)
      ),
      child:
      Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: TextField(

          controller: textEditingController,
          // autofocus: true,
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
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.black),
          keyboardType: TextInputType.number,
          maxLength: 1,

          decoration: InputDecoration(
              fillColor: Colors.white,
              hintText:'*' ,
              // contentPadding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
              contentPadding: EdgeInsets.zero,
              hintStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,fontSize: 15),
              // filled: true,

              // label: Text('*'),
              counter: Offstage(),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none
            // enabledBorder: OutlineInputBorder(
            //     borderSide: BorderSide(width: 0.5, color: Color(0xFFBA68C8)),
            //     borderRadius: BorderRadius.circular(100)),
            // focusedBorder: OutlineInputBorder(
            //     borderSide: BorderSide(width: 1, color: Colors.purple),
            //     borderRadius: BorderRadius.circular(100)),
          ),
        ),
      ),
    );
  }
}
