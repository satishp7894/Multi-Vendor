import 'package:eshoperapp/models/customer.dart';
import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/pages/profile/profile_controller.dart';
import 'package:eshoperapp/pages/profile/views/list_item_cart.dart';
import 'package:eshoperapp/routes/navigation.dart';
import 'package:eshoperapp/style/theme.dart' as Style;
import 'package:eshoperapp/utils/alert_dialog.dart';
import 'package:eshoperapp/utils/check_internet.dart';
import 'package:eshoperapp/utils/webview_screen.dart';
import 'package:eshoperapp/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/theme.dart';
import '../../utils/snackbar_dialog.dart';
import '../../widgets/default_btn.dart';
import '../../widgets/login_dialog.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with TickerProviderStateMixin {
  late AnimationController controller;
  late TextEditingController? mobile;
  final profileController = Get.put(ProfileController(
      apiRepositoryInterface: Get.find(),
      customer: Customer(),
      localRepositoryInterface: Get.find()));

  @override
  void initState() {
    controller = BottomSheet.createAnimationController(this);
    // Animation duration for displaying the BottomSheet
    controller.duration = const Duration(milliseconds: 600);
    // Animation duration for retracting the BottomSheet
    controller.reverseDuration = const Duration(milliseconds: 600);
    // Set animation curve duration for the BottomSheet
    controller.drive(CurveTween(curve: Curves.easeIn));
    mobile = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final user = controller.user();

    return SafeArea(
        child: SajiloDokanScaffold(
      leading: false,
      // title: "",
      // background: Colors.grey[200],
          background: AppColors.ratingText,
      searchOnTab: () {},
      body: Column(
        children: [
          Container(
            color: AppColors.white,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(left: AppSizes.sidePadding,right: AppSizes.sidePadding,top: 26,bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('My Account', style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: AppColors.appText))),

                  ],
                ),
              ),
              Container(height: 1,width: MediaQuery.of(context).size.width,color: AppColors.tileLine,),
            ],),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () {
                CheckInternet.checkInternet();
                // profileController.customerProfile();
                return profileController.getUser();
              },
              child: ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(height: 16.0,),
                  Obx(() {
                    if (profileController.isUserDataRefresh.value == true) {
                      print(
                          "profileController.isUserDataRefresh.value if ${profileController.isUserDataRefresh.value}");
                      profileController.getUser();
                      profileController.isUserDataRefresh(false);
                    } else {
                      print(
                          "profileController.isUserDataRefresh.value  else ${profileController.isUserDataRefresh.value}");
                    }
                    if (profileController.customerId.value == "") {
                      return Container(
                        color: AppColors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15,bottom: 15),
                          child: Column(
                            children: [
                              Container(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.redAccent, width: 1),
                                      color: AppColors.white,
                                      borderRadius: const BorderRadius.all(
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
                                    height: 110,
                                    width: 110,
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          // border:
                                          // Border.all(color: Colors.redAccent, width: 1),
                                          color: AppColors.profileCircleBg,
                                          borderRadius: const BorderRadius.all(
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
                                        child: Center(
                                          child: Image.asset(
                                            "assets/img/user.png",
                                            fit: BoxFit.fill,
                                            height: 60,
                                            width: 65,
                                          ),
                                          // child: Text(
                                          //   customerProfileData[0].customerName !=
                                          //       null
                                          //       ? customerProfileData[0].customerName![0]
                                          //       : '',
                                          //   style: GoogleFonts.salsa(textStyle: const TextStyle( fontSize: 40),),
                                          // ),
                                        ),
                                      ),
                                    ),

                                    // ClipOval(
                                    //   child: Image.network(
                                    //     'https://images.contentstack.io/v3/assets/blt36c2e63521272fdc/blt2e5f7f145e6f737c/5e9d17c4cb84e463e2ebd703/370x370_Chris-Dale.jpg',
                                    //     width: 75,
                                    //     height: 75,
                                    //     fit: BoxFit.cover,
                                    //   ),
                                    // ),
                                  ),
                                  const SizedBox(
                                    width: 15.0,
                                  ),
                                  InkWell(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.appRed, width: 1),
                                        color: AppColors.appRed,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(
                                                10.0) //                 <--- border radius here
                                            ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 8.0,
                                          top: 8.0,
                                          right: 20.0,
                                          left: 20.0,
                                        ),
                                        child: Text(
                                          "LOGIN/SIGNUP",
                                          style: GoogleFonts.salsa(
                                            textStyle: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          // style: const TextStyle(
                                          //     fontSize: 23,
                                          //     fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      // Get.offNamed(Routes.login);
                                      showModalBottomSheet(
                                        context: context,
                                        isDismissible:false,
                                        isScrollControlled: true,
                                        transitionAnimationController: controller,
                                        builder: (BuildContext context) {

                                          return LoginDialog(mobile: mobile,context: context,);
                                          // return  Padding(
                                          //   padding: MediaQuery.of(context).viewInsets,
                                          //   child: Wrap(
                                          //     children: [
                                          //       Padding(
                                          //         padding: const EdgeInsets.all(10.0),
                                          //         child: Column(
                                          //           mainAxisAlignment: MainAxisAlignment.start,
                                          //           crossAxisAlignment: CrossAxisAlignment.start,
                                          //           children: [
                                          //             Row(
                                          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          //               children: [
                                          //                 Image.asset('assets/logos/app_logo.png',fit: BoxFit.fill,height: 37,width: 80,),
                                          //                 InkWell(
                                          //                     onTap: (){
                                          //                       Get.back();
                                          //                     },
                                          //                     child: Image.asset("assets/img/close.png",fit: BoxFit.fill,height: 15,width: 15,))
                                          //               ],
                                          //             ),
                                          //             SizedBox(height: 16,),
                                          //             Row(
                                          //               children: [
                                          //                 Text("Login",
                                          //                     style: GoogleFonts.inriaSans(
                                          //                         textStyle: TextStyle(
                                          //                             fontSize: 16,
                                          //                             fontWeight: FontWeight.w700,
                                          //                             color: AppColors.black))),
                                          //                 SizedBox(width: 5,),
                                          //                 Text("or",
                                          //                     style: GoogleFonts.inriaSans(
                                          //                         textStyle: TextStyle(
                                          //                             fontSize: 10,
                                          //                             color: AppColors.black))),
                                          //                 SizedBox(width: 5,),
                                          //                 Text("Signup",
                                          //                     style: GoogleFonts.inriaSans(
                                          //                         textStyle: TextStyle(
                                          //                             fontSize: 16,
                                          //                             fontWeight: FontWeight.w700,
                                          //                             color: AppColors.black))),
                                          //               ],
                                          //             ),
                                          //             SizedBox(height: 16,),
                                          //             Container(
                                          //               child: TextFormField(
                                          //                 // focusNode: myFocusNode,
                                          //                 textAlign: TextAlign.start,
                                          //                 keyboardType: TextInputType.phone,
                                          //                 textInputAction: TextInputAction.done,
                                          //                 validator: (value) {
                                          //                   if (value!.isEmpty) {
                                          //                     return 'This field is required';
                                          //                   }
                                          //                   if (value.length < 4) {
                                          //                     return 'Enter a minimum 4 character';
                                          //                   } else {
                                          //                     return null;
                                          //                   }
                                          //                 },
                                          //                 controller: mobile,
                                          //                 // obscureText: controller.showPassword.value,
                                          //                 style: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 14,color: AppColors.black)),
                                          //                 cursorColor: AppColors.appText1,
                                          //                 decoration: InputDecoration(
                                          //                   labelStyle : GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 12)),
                                          //                   // labelStyle: TextStyle(
                                          //                   //     color: myFocusNode.hasFocus ? Colors.purple : AppColors.appText1
                                          //                   // ),
                                          //                   contentPadding: EdgeInsets.only(top:30),
                                          //                   // suffixIcon: IconButton(
                                          //                   //     onPressed: () {
                                          //                   //       controller.toggleShowPassword();
                                          //                   //     },
                                          //                   //     icon: controller.showPassword.value
                                          //                   //         ? Icon(Icons.visibility_off)
                                          //                   //         : Icon(Icons.visibility)),
                                          //                   prefixIcon: Container(
                                          //                     width: 50,
                                          //                     child: Row(
                                          //                       // mainAxisAlignment: MainAxisAlignment.center,
                                          //                       children: [
                                          //                         Padding(
                                          //                           padding: const EdgeInsets.only(left: 8,right: 8),
                                          //                           child: Text("+91",style: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 14)),),
                                          //                         ),
                                          //                         Padding(
                                          //                           padding: const EdgeInsets.only(right: 8.0),
                                          //                           child: Container(
                                          //                             width: 1,
                                          //                             height: 30,
                                          //                             color: AppColors.appText1,
                                          //                           ),
                                          //                         ),
                                          //                       ],
                                          //                     ),
                                          //                   ),
                                          //                   hintStyle: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 12)),
                                          //
                                          //
                                          //                   hintText: 'Mobile Number*',
                                          //                   labelText: 'Mobile Number*',
                                          //                   enabledBorder:OutlineInputBorder(
                                          //                     borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),
                                          //                     borderRadius: BorderRadius.circular(2.0),
                                          //
                                          //                   ),
                                          //                   focusedBorder:OutlineInputBorder(
                                          //                     borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),
                                          //                     borderRadius: BorderRadius.circular(2.0),
                                          //                   ),
                                          //                   // labelStyle:  GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 15))
                                          //
                                          //                   // border: OutlineInputBorder(),
                                          //
                                          //                 ),
                                          //               ),
                                          //             ),
                                          //             SizedBox(height: 16,),
                                          //             Row(
                                          //               children: [
                                          //                 Text(
                                          //                   "By continuing, I agree to the",
                                          //                   style: GoogleFonts.inriaSans(
                                          //                     textStyle: const TextStyle(fontSize: 10),
                                          //                   ),
                                          //                 ),
                                          //                 Text(" terms of use", style: GoogleFonts.inriaSans(
                                          //                   textStyle: const TextStyle(fontSize: 10,color: AppColors.appRed),
                                          //                 )),
                                          //                 Text(" & ", style: GoogleFonts.inriaSans(
                                          //                   textStyle: const TextStyle(fontSize: 10),
                                          //                 )),
                                          //                 Text("Privacy Policy", style: GoogleFonts.inriaSans(
                                          //                   textStyle: const TextStyle(fontSize: 10,color: AppColors.appRed),
                                          //                 )),
                                          //               ],
                                          //             ),
                                          //             SizedBox(height: 16,),
                                          //             InkWell(
                                          //                 onTap: () {
                                          //                   FocusManager.instance.primaryFocus?.unfocus();
                                          //                   // if (_formKey.currentState!.validate()) {
                                          //                   //   logOrRegAction!();
                                          //                   // } else {
                                          //                   //   // create();
                                          //                   // }
                                          //                   if (mobile!.text.isEmpty) {
                                          //                     // return 'This field is required';
                                          //                     SnackBarDialog.showSnackbar('Error',"Please enter a mobile number");
                                          //                   } else if (mobile!.text.length < 10) {
                                          //                     //return 'Enter a minimum 10 number';
                                          //                     SnackBarDialog.showSnackbar('Error',"Enter a minimum 10 number");
                                          //                   } else if (mobile!.text.length > 10) {
                                          //                     // return 'Enter a maximum 10 number';
                                          //                     SnackBarDialog.showSnackbar('Error',"Enter a maximum 10 number");
                                          //                   }else{
                                          //                     Get.toNamed(Routes.otpScreen1);
                                          //                   }
                                          //                 },
                                          //                 child: DefaultBTN(
                                          //                   btnText: "CONTINUE",
                                          //                 )),
                                          //
                                          //
                                          //           ],
                                          //         ),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      print(
                          "profileController.isLoadingCustomerProfile.value   ${profileController.isLoadingCustomerProfile.value}");
                      if (profileController.isLoadingCustomerProfile.value != true) {
                        MainResponse? mainResponse =
                            profileController.customerProfileObj.value;
                        List<Customer>? customerProfileData = [];
                        // mainResponse.data!.map((e) => customerProfileData!.add(UpdateCustomerPasswordData.fromJson(e))).toList();
                        if (mainResponse.data != null) {
                          mainResponse.data!.forEach((v) {
                            customerProfileData.add(Customer.fromJson(v));
                          });
                        }

                        // for (var v in mainResponse.data!) {
                        //   customerProfileData!.add(UpdateCustomerPasswordData.fromJson(v));
                        // }
                        // List<UpdateCustomerPasswordData>? sliderList =
                        // mainResponse.data != null ? mainResponse.data : [];
                        String? message = mainResponse.message ?? "";
                        if (customerProfileData.isEmpty) {
                          profileController.logout();
                          return SizedBox(
                            height: 150.0,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      message,
                                      style: const TextStyle(color: Colors.black45),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        } else {
                          return InkWell(
                            onTap: () async {
                              print("My Profile");
                              final result = await Get.toNamed(Routes.editProfile,
                                  // arguments: customerProfileData[0]
                              );
                              print("My Profile  $result");

                              if (result != null) {
                                profileController.getUser();
                              }
                            },
                            child: Container(
                              color: AppColors.white,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15, right: 15,bottom: 15),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.redAccent, width: 1),

                                            borderRadius: const BorderRadius.all(
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
                                          height: 110,
                                          width: 110,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                // border: Border.all(
                                                //     color: Colors.redAccent, width: 1),
                                                color: AppColors.appBg,
                                                borderRadius: const BorderRadius.all(
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

                                              child: Center(
                                                child: Text(
                                                  customerProfileData[0].customerName !=
                                                          null
                                                      ? customerProfileData[0]
                                                          .customerName![0]
                                                      : '',
                                                  style: GoogleFonts.salsa(
                                                    textStyle:
                                                        const TextStyle(fontSize: 40),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

                                          // ClipOval(
                                          //   child: Image.network(
                                          //     'https://images.contentstack.io/v3/assets/blt36c2e63521272fdc/blt2e5f7f145e6f737c/5e9d17c4cb84e463e2ebd703/370x370_Chris-Dale.jpg',
                                          //     width: 75,
                                          //     height: 75,
                                          //     fit: BoxFit.cover,
                                          //   ),
                                          // ),
                                        ),
                                        const SizedBox(
                                          width: 15.0,
                                        ),
                                        Text(
                                          customerProfileData[0].customerName != null
                                              ? customerProfileData[0].customerName!
                                              : '',
                                          style: GoogleFonts.salsa(
                                            textStyle: const TextStyle(fontSize: 20),
                                          ),
                                          // style: const TextStyle(
                                          //     fontSize: 23,
                                          //     fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      } else {
                        // profileController.logout();
                        return const SizedBox(
                            height: 150,
                            child: Center(
                                child: CircularProgressIndicator(
                                    color: Style.Colors.appColor)));
                      }








                      return Container(
                        color: AppColors.white,
                        height: 146,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Column(
                            children: [
                              Container(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 105,
                                    width: 105,
                                    decoration: BoxDecoration(
                                      border:
                                      Border.all(color: Colors.redAccent, width: 1),
                                      color: AppColors.white,
                                      borderRadius: const BorderRadius.all(
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
                                      padding: const EdgeInsets.all(3.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          // border:
                                          // Border.all(color: Colors.redAccent, width: 1),
                                          color: AppColors.profileCircleBg,
                                          borderRadius: const BorderRadius.all(
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

                                        child: Center(
                                          child:
                                          Text(
                                            "P",
                                            style: GoogleFonts.salsa(
                                              textStyle: const TextStyle(
                                                  fontSize: 40,
                                                  color: AppColors.appText,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            // style: const TextStyle(
                                            //     fontSize: 23,
                                            //     fontWeight: FontWeight.w500),
                                          ),
                                          // child: Text(
                                          //   customerProfileData[0].customerName !=
                                          //       null
                                          //       ? customerProfileData[0].customerName![0]
                                          //       : '',
                                          //   style: GoogleFonts.salsa(textStyle: const TextStyle( fontSize: 40),),
                                          // ),
                                        ),

                                        // ClipOval(
                                        //   child: Image.network(
                                        //     'https://images.contentstack.io/v3/assets/blt36c2e63521272fdc/blt2e5f7f145e6f737c/5e9d17c4cb84e463e2ebd703/370x370_Chris-Dale.jpg',
                                        //     width: 75,
                                        //     height: 75,
                                        //     fit: BoxFit.cover,
                                        //   ),
                                        // ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15.0,
                                  ),
                                  Container(

                                    child: Text(
                                      "Prachi",


                                      style: GoogleFonts.salsa(
                                        textStyle: const TextStyle(
                                            fontSize: 20,
                                            color: AppColors.appText,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      // style: const TextStyle(
                                      //     fontSize: 23,
                                      //     fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  }),

                  // const SizedBox(
                  //   width: 15.0,
                  // ),
                  // ListItemCart(
                  //   icon: Icons.person,
                  //   title: 'My Profile',
                  //   onPressed: () async {
                  //     print("My Profile");
                  //     print("My Profile");
                  //     final result =  await  Get.toNamed(Routes.editProfile,arguments: customerProfileData[0]);
                  //     print("My Profile  $result");
                  //
                  //     if(result != null){
                  //       profileController.customerProfile();
                  //     }
                  //   },
                  // ),
                  SizedBox(height: 16,),
                  Obx(() {
                    if (profileController.customerId.value == "") {
                      return Column(
                        children: [
                          ListItemCart(
                            iconPath: "assets/img/order.png",
                            title: 'Orders',
                            subTitle: "Save your card for faster checkout",
                            onPressed: () {
                              // AlertDialogs.showLoginRequiredDialog();
                              Get.toNamed(Routes.myOrder);
                            },
                          ),
                          ListItemCart(
                            iconPath: "assets/img/bank_cards.png",
                            title: 'Wishlist',
                            subTitle: "Your most loved styles",
                            onPressed: () {
                              Get.toNamed(Routes.wishList);
                            },
                          ),
                          // ListItemCart(
                          //   iconPath: "assets/img/help_center.png",
                          //   title: 'Help Center',
                          //   subTitle: "Raise a concern",
                          //   onPressed: () {
                          //     Get.toNamed(Routes.helpCenter);
                          //   },
                          // ),
                          ListItemCart(
                            iconPath: "assets/img/setting.png",
                            title: 'Coupons',
                            subTitle: "Manage coupons for additional discounts",
                            last:false,
                            onPressed: () {
                              Get.toNamed(Routes.coupons);
                            },
                          ),
                          // ListItemCart(
                          //   iconPath:"assets/img/search.png",
                          //   title: 'Contact Us',
                          //   onPressed: () {},
                          // ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          ListItemCart(
                            iconPath: "assets/img/order.png",
                            title: 'My Orders',
                            subTitle: "Save your card for faster checkout",
                            onPressed: () {
                              Get.toNamed(Routes.myOrder);
                            },
                          ),
                          ListItemCart(
                            iconPath: "assets/img/bank_cards.png",
                            title: 'Saved Cards',
                            subTitle: "Save your card for faster checkout",
                            onPressed: () {
                              Get.toNamed(Routes.savedCard);
                            },
                          ),
                          ListItemCart(
                            iconPath: "assets/img/address.png",
                            title: 'Address',
                            subTitle: "Update/ change your shipping address",
                            onPressed: () {
                              Get.toNamed(Routes.shippingAddress, arguments: false);
                            },
                          ),
                          ListItemCart(
                            iconPath: "assets/img/coupons.png",
                            title: 'Coupons',
                            subTitle: "Manage coupons for additional discounts",
                            onPressed: () {
                              Get.toNamed(Routes.coupons);
                            },
                          ),
                          ListItemCart(
                            iconPath: "assets/img/help_center.png",
                            title: 'Help Center',
                            subTitle: "Raise a concern",
                            onPressed: () {
                              Get.toNamed(Routes.helpCenter);
                            },
                          ),
                          // ListItemCart(
                          //   iconPath: "assets/img/search.png",
                          //   title: 'Shopping Cart',
                          //   onPressed: () {
                          //     Get.toNamed(Routes.cart);
                          //   },
                          // ),
                          // ListItemCart(
                          //   iconPath:"assets/img/search.png",
                          //   title: 'Change Password',
                          //   onPressed: () {
                          //     // Get.toNamed(Routes.changePasword);
                          //
                          //     Get.toNamed(
                          //       Routes.changePassword,
                          //     );
                          //
                          //     // if(result != null){
                          //     //   profileController.getUser();
                          //     // }
                          //   },
                          // ),
                          // ListItemCart(
                          //   iconPath: "assets/img/search.png",
                          //   title: 'Forget Password',
                          //   onPressed: () {
                          //     // Get.toNamed(Routes.forgetPasword);
                          //
                          //     Get.toNamed(
                          //       Routes.forgetPassword,
                          //     );
                          //   },
                          // ),
                          ListItemCart(
                            iconPath: "assets/img/save_as.png",
                            title: 'Manage Your Account',
                            subTitle: "Manage profile information",
                            onPressed: () {
                              Get.toNamed(Routes.editProfile,
                                  // arguments: Customer()
                              );
                            },
                          ),
                          ListItemCart(
                            iconPath: "assets/img/setting.png",
                            title: 'Settings',
                            subTitle: "Manage notificaton & delete account",

                            onPressed: () {
                              Get.toNamed(Routes.setting);
                            },
                          ),
                          // ListItemCart(
                          //   iconPath: "assets/img/search.png",
                          //   title: 'Contact Us',
                          //   onPressed: () {},
                          // ),
                        ],
                      );
                    }
                  }),

                  Obx(() {
                    if (profileController.customerId.value == "") {
                      return SizedBox(height: 16,);
                      // return InkWell(
                      //   onTap: () {
                      //     Get.toNamed(
                      //       Routes.login,
                      //     );
                      //   },
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(left: 28.0,right: 25.0, top: 20),
                      //     child: Container(
                      //       decoration: BoxDecoration(
                      //
                      //         border: Border.all(
                      //             color: AppColors.appRed, width: 1),
                      //         // color: Colors.grey[100],
                      //         borderRadius: const BorderRadius.all(
                      //             Radius.circular(
                      //                 10.0) //                 <--- border radius here
                      //         ),
                      //       ),
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(12.0),
                      //         child: Center(child: Text("LOG OUT",style: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 16,color: AppColors.appRed,fontWeight: FontWeight.w400)),)),
                      //       ),
                      //     ),
                      //   ),
                      // );
                      return ListItemCart(
                        iconPath: "assets/img/search.png",
                        title: 'Login',
                        onPressed: () {
                          Get.toNamed(
                            Routes.login,
                          );

                          // if(result != null){
                          //   profileController.getUser();
                          // }
                        },
                      );
                    } else {
                      return InkWell(
                        onTap: () {
                          // Get.defaultDialog(
                          //   title: "Logout?",
                          //   barrierDismissible: false,
                          //   middleText:
                          //       "Are you sure you want to logout from this App?",
                          //   titleStyle: const TextStyle(color: Colors.black),
                          //   middleTextStyle: const TextStyle(color: Colors.black),
                          //   confirm: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //     children: [
                          //       TextButton(
                          //         // style: flatButtonStyle,
                          //         onPressed: () {
                          //           Get.back();
                          //         },
                          //         child: const Text(
                          //           "Cancel",
                          //           style: TextStyle(color: Colors.red),
                          //         ),
                          //       ),
                          //       TextButton(
                          //         // style: flatButtonStyle,
                          //         onPressed: () async {
                          //           bool? logout = await profileController.logout();
                          //           print("logout  $logout");
                          //           if (logout == true) {
                          //             print("logout if $logout");
                          //             profileController.getUser();
                          //             Get.back();
                          //           } else {
                          //             print("logout else $logout");
                          //           }
                          //           // controller.logout();
                          //         },
                          //         child: const Text(
                          //           "OK",
                          //           style: TextStyle(color: Colors.red),
                          //         ),
                          //       )
                          //     ],
                          //   ),
                          // );

                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(

                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(0.0)),
                                  //this right here
                                  child: Container(
                                    height: 85,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Expanded(child: Center(child: Text("Are you sure you want to Logout?",style: GoogleFonts.inriaSans(textStyle: TextStyle(color: AppColors.black,fontWeight: FontWeight.w400,fontSize: 16))))),
                                              InkWell(

                                                  child: Icon(Icons.close,color: AppColors.black,),onTap: (){Get.back();},)

                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                          child: Container(height: 1,width: MediaQuery.of(context).size.width,color: AppColors.appLine,),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5.0,bottom: 5.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              InkWell(

                                                child: Text("NO",style: GoogleFonts.inriaSans(textStyle: TextStyle(color: AppColors.appLine,fontWeight: FontWeight.w700,fontSize: 14))),
                                                  onTap: (){
                                                    Get.back();
                                                  },
                                              ),
                                              Container(height: 22,width: 1.5,color: AppColors.appLine,),
                                              InkWell(
                                                child: Text("YES",style: GoogleFonts.inriaSans(textStyle: TextStyle(color: AppColors.appRed,fontWeight: FontWeight.w700,fontSize: 14)),
                                                ),
                                                onTap: () async {
                                                            bool? logout = await profileController.logout();
                                                            print("logout  $logout");
                                                            if (logout == true) {
                                                              print("logout if $logout");
                                                              profileController.getUser();
                                                              profileController.homecontroller.loadUser(true);
                                                              Get.back();
                                                            } else {
                                                              print("logout else $logout");
                                                            }
                                                },
                                              )
                                            ],),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 16.0, top: 16,bottom: 16),
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.appRed, width: 1),
                              // color: Colors.grey[100],
                              borderRadius: const BorderRadius.all(Radius.circular(
                                      10.0) //                 <--- border radius here
                                  ),
                            ),
                            child: Center(
                                child: Text(
                              "LOG OUT",
                              style: GoogleFonts.inriaSans(
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.appRed,
                                      fontWeight: FontWeight.w700)),
                            )),
                          ),
                        ),
                      );
                      // return ListItemCart(
                      //   iconPath: "assets/img/search.png",
                      //   title: 'Logout',
                      //   onPressed: () {
                      //     Get.defaultDialog(
                      //       title: "Logout?",
                      //       barrierDismissible: false,
                      //       middleText:
                      //           "Are you sure you want to logout from this App?",
                      //       titleStyle: const TextStyle(color: Colors.black),
                      //       middleTextStyle: const TextStyle(color: Colors.black),
                      //       confirm: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //         children: [
                      //           TextButton(
                      //             // style: flatButtonStyle,
                      //             onPressed: () {
                      //               Get.back();
                      //             },
                      //             child: const Text(
                      //               "Cancel",
                      //               style: TextStyle(color: Colors.red),
                      //             ),
                      //           ),
                      //           TextButton(
                      //             // style: flatButtonStyle,
                      //             onPressed: () async {
                      //               bool? logout = await profileController.logout();
                      //               print("logout  $logout");
                      //               if (logout == true) {
                      //                 print("logout if $logout");
                      //                 profileController.getUser();
                      //                 Get.back();
                      //               } else {
                      //                 print("logout else $logout");
                      //               }
                      //               // controller.logout();
                      //             },
                      //             child: const Text(
                      //               "OK",
                      //               style: TextStyle(color: Colors.red),
                      //             ),
                      //           )
                      //         ],
                      //       ),
                      //     );
                      //   },
                      // );
                    }
                  }),

                  // SizedBox(height: 15.0,),
                  Container(
                    color: AppColors.aboutUsBg,
                    // height: 200,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0,bottom: 16,left: 60),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(

                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "FAQ",
                                  style: GoogleFonts.inriaSans(
                                      textStyle: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.white,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Text(
                                  "S",
                                  style: GoogleFonts.inriaSans(
                                      textStyle: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.white,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const WebViewScreen(title: "FAQs",webUrl: "https://loccon.in/privacy.html",)),
                              );
                            },
                          ),
                          SizedBox(height: 8,),
                          InkWell(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const WebViewScreen(title: "ABOUT US",webUrl: "https://loccon.in/privacy.html",)),
                              );
                            },
                            child: Text(
                              "ABOUT US",
                              style: GoogleFonts.inriaSans(
                                  textStyle: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          SizedBox(height: 8,),
                          InkWell(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const WebViewScreen(title: "TERMS OF USE",webUrl: "https://loccon.in/privacy.html",)),
                              );
                            },
                            child: Text(
                              "TERMS OF USE",
                              style: GoogleFonts.inriaSans(
                                  textStyle: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          SizedBox(height: 8,),
                          InkWell(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const WebViewScreen(title: "PRIVACY POLICY",webUrl: "https://loccon.in/privacy.html",)),
                              );
                            },
                            child: Text(
                              "PRIVACY POLICY",
                              style: GoogleFonts.inriaSans(
                                  textStyle: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  // Container(
                  //   color: Colors.white.withOpacity(0.4),
                  //   child: const Center(
                  //     child: Padding(
                  //       padding: EdgeInsets.all(8.0),
                  //       child: Text(
                  //         'Continue Shopping',
                  //         style:
                  //             TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // ProductGridviewTile(
                  //   productList: controller.productList,
                  // ),
                ],
              ),
            ),
          ),
        ],
      ), title: null,
      // bottomMenuIndex: index,
    ));
  }
}
