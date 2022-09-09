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
      title: "My Profile",
      background: Colors.grey.withOpacity(0.1),
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
                return Container();
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
                              height: 30,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white, width: 2),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(
                                                100.0) //                 <--- border radius here
                                            ),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 10,
                                            offset:
                                                Offset(4, 8), // Shadow position
                                          ),
                                        ],
                                      ),
                                      child: ClipOval(
                                        child: Image.network(
                                          'https://images.contentstack.io/v3/assets/blt36c2e63521272fdc/blt2e5f7f145e6f737c/5e9d17c4cb84e463e2ebd703/370x370_Chris-Dale.jpg',
                                          width: 75,
                                          height: 75,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        top: 0,
                                        right: 0,
                                        child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              border: Border.all(
                                                  color: Colors.red, width: 2),
                                              borderRadius: const BorderRadius
                                                      .all(
                                                  Radius.circular(
                                                      100.0) //                 <--- border radius here
                                                  ),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  blurRadius: 10,
                                                  offset: Offset(
                                                      4, 8), // Shadow position
                                                ),
                                              ],
                                            ),
                                            child: const Padding(
                                              padding: EdgeInsets.all(1.0),
                                              child: Icon(
                                                Icons.edit,
                                                size: 20,
                                                color: Colors.white,
                                              ),
                                            )))
                                  ],
                                ),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // Wrap(
                                    //   children: [
                                    //     Text(mainResponse.data.toString()),
                                    //   ],
                                    // )
                                    Text(
                                      customerProfileData[0].customerName !=
                                              null
                                          ? customerProfileData[0].customerName!
                                          : '',
                                      style: const TextStyle(
                                          fontSize: 23,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      customerProfileData[0].email != null
                                          ? customerProfileData[0].email!
                                          : '',
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      customerProfileData[0].mobile != null
                                          ? customerProfileData[0].mobile!
                                          : '',
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                } else {
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
                      icon: Icons.badge,
                      title: 'My Orders',
                      onPressed: () {
                        AlertDialogs.showLoginRequiredDialog();
                      },
                    ),
                    ListItemCart(
                      icon: Icons.location_city,
                      title: 'Shipping Address',
                      onPressed: () {
                        AlertDialogs.showLoginRequiredDialog();
                      },
                    ),
                    ListItemCart(
                      icon: Icons.card_giftcard,
                      title: 'Shopping Cart',
                      onPressed: () {
                        Get.toNamed(Routes.cart);
                      },
                    ),
                    ListItemCart(
                      icon: Icons.change_circle_rounded,
                      title: 'Change Password',
                      onPressed: () {
                        AlertDialogs.showLoginRequiredDialog();
                      },
                    ),
                    ListItemCart(
                      icon: Icons.change_circle_rounded,
                      title: 'Forget Password',
                      onPressed: () {
                        Get.toNamed(Routes.forgetPassword);

                        // AlertDialogs.showLoginRequiredDialog();
                      },
                    ),
                    ListItemCart(
                      icon: Icons.settings,
                      title: 'Settings',
                      onPressed: () {},
                    ),
                    ListItemCart(
                      icon: Icons.chat,
                      title: 'Contact Us',
                      onPressed: () {},
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    ListItemCart(
                      icon: Icons.badge,
                      title: 'My Orders',
                      onPressed: () {
                        Get.toNamed(Routes.myOrder);
                      },
                    ),
                    ListItemCart(
                      icon: Icons.location_city,
                      title: 'Shipping Address',
                      onPressed: () {
                        Get.toNamed(Routes.shippingAddress, arguments: false);
                      },
                    ),
                    ListItemCart(
                      icon: Icons.card_giftcard,
                      title: 'Shopping Cart',
                      onPressed: () {
                        Get.toNamed(Routes.cart);
                      },
                    ),
                    ListItemCart(
                      icon: Icons.change_circle_rounded,
                      title: 'Change Password',
                      onPressed: () {
                        // Get.toNamed(Routes.changePasword);

                        Get.toNamed(
                          Routes.changePassword,
                        );

                        // if(result != null){
                        //   profileController.getUser();
                        // }
                      },
                    ),
                    ListItemCart(
                      icon: Icons.change_circle_rounded,
                      title: 'Forget Password',
                      onPressed: () {
                        // Get.toNamed(Routes.forgetPasword);

                        Get.toNamed(
                          Routes.forgetPassword,
                        );
                      },
                    ),
                    ListItemCart(
                      icon: Icons.settings,
                      title: 'Settings',
                      onPressed: () {},
                    ),
                    ListItemCart(
                      icon: Icons.chat,
                      title: 'Contact Us',
                      onPressed: () {},
                    ),
                  ],
                );
              }
            }),

            Obx(() {
              if (profileController.customerId.value == "") {
                return ListItemCart(
                  icon: Icons.login,
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
                return ListItemCart(
                  icon: Icons.logout,
                  title: 'Logout',
                  onPressed: () {
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
                );
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
