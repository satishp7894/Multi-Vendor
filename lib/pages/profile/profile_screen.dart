import 'package:eshoperapp/models/customer.dart';
import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/pages/profile/profile_controller.dart';
import 'package:eshoperapp/pages/profile/views/list_item_cart.dart';
import 'package:eshoperapp/routes/navigation.dart';
import 'package:eshoperapp/style/theme.dart' as Style;
import 'package:eshoperapp/utils/alert_dialog.dart';
import 'package:eshoperapp/utils/check_internet.dart';
import 'package:eshoperapp/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final profileController = Get.put(ProfileController(
      apiRepositoryInterface: Get.find(),
      customer: Customer(),
      localRepositoryInterface: Get.find()));

  @override
  Widget build(BuildContext context) {
    // final user = controller.user();

    return SafeArea(
        child: SajiloDokanScaffold(
      leading: false,
      title: "My Account",
      background: Colors.white,
      searchOnTab: () {},
      body: RefreshIndicator(
        onRefresh: () {
          CheckInternet.checkInternet();
          // profileController.customerProfile();
          return profileController.getUser();
        },
        child: ListView(
          children: [
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
                return Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
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
                              color: Colors.grey[100],
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
                              Get.toNamed(
                                Routes.login,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
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
                            arguments: customerProfileData[0]);
                        print("My Profile  $result");

                        if (result != null) {
                          profileController.getUser();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
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
                                    color: Colors.grey[100],
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
            Obx(() {
              if (profileController.customerId.value == "") {
                return Column(
                  children: [
                    ListItemCart(
                      iconPath: "assets/img/order.png",
                      title: 'My Orders',
                      subTitle: "Save your card for faster checkout",
                      onPressed: () {
                        AlertDialogs.showLoginRequiredDialog();
                      },
                    ),
                    ListItemCart(
                      iconPath: "assets/img/address.png",
                      title: 'Address',
                      subTitle: "Update/ change your shipping address",
                      onPressed: () {
                        AlertDialogs.showLoginRequiredDialog();
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
                    //   iconPath: "assets/img/search.png",
                    //   title: 'Change Password',
                    //   onPressed: () {
                    //     AlertDialogs.showLoginRequiredDialog();
                    //   },
                    // ),
                    // ListItemCart(
                    //   iconPath: "assets/img/search.png",
                    //   title: 'Forget Password',
                    //   onPressed: () {
                    //     Get.toNamed(Routes.forgetPassword);
                    //
                    //     // AlertDialogs.showLoginRequiredDialog();
                    //   },
                    // ),
                    ListItemCart(
                      iconPath: "assets/img/setting.png",
                      title: 'Settings',
                      subTitle: "Manage notificaton & delete account",
                      onPressed: () {},
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
                      iconPath: "assets/img/save_as.png",
                      title: 'Saved Cards',
                      subTitle: "Save your card for faster checkout",
                      onPressed: () {},
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
                      onPressed: () {},
                    ),
                    ListItemCart(
                      iconPath: "assets/img/help_center.png",
                      title: 'Help Center',
                      subTitle: "Raise a concern",
                      onPressed: () {
                        Get.toNamed(Routes.shippingAddress, arguments: false);
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
                      onPressed: () {},
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
                return Container();
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
                    Get.defaultDialog(
                      title: "Logout?",
                      barrierDismissible: false,
                      middleText:
                          "Are you sure you want to logout from this App?",
                      titleStyle: const TextStyle(color: Colors.black),
                      middleTextStyle: const TextStyle(color: Colors.black),
                      confirm: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            // style: flatButtonStyle,
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text(
                              "Cancel",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          TextButton(
                            // style: flatButtonStyle,
                            onPressed: () async {
                              bool? logout = await profileController.logout();
                              print("logout  $logout");
                              if (logout == true) {
                                print("logout if $logout");
                                profileController.getUser();
                                Get.back();
                              } else {
                                print("logout else $logout");
                              }
                              // controller.logout();
                            },
                            child: const Text(
                              "OK",
                              style: TextStyle(color: Colors.red),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 28.0, right: 25.0, top: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.appRed, width: 1),
                        // color: Colors.grey[100],
                        borderRadius: const BorderRadius.all(Radius.circular(
                                10.0) //                 <--- border radius here
                            ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Center(
                            child: Text(
                          "LOG OUT",
                          style: GoogleFonts.inriaSans(
                              textStyle: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.appRed,
                                  fontWeight: FontWeight.w400)),
                        )),
                      ),
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

            const SizedBox(
              height: 10,
            ),
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
      // bottomMenuIndex: index,
    ));
  }
}
