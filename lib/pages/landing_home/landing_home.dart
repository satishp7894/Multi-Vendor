// import 'package:eshoperapp/pages/home/home_screen.dart';
// import 'package:eshoperapp/widgets/bottom_menu.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'home_controller.dart';
//
//
// class LandingHome extends StatefulWidget {
//   const LandingHome({Key? key}) : super(key: key);
//
//   @override
//   State<LandingHome> createState() => _LandingHomeState();
// }
//
// class _LandingHomeState extends State<LandingHome> {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<HomeController>(
//         init: HomeController(
//             apiRepositoryInterface: Get.find(),
//             localRepositoryInterface: Get.find()),
//         builder: (landingHomeController){
//               return Scaffold(
//         body: Column(
//           children: [
//             Expanded(
//               child: Obx(() {
//                 int currentIndex = landingHomeController.selectedIndex.value;
//                 return IndexedStack(
//                   index: currentIndex,
//                   children: [
//                     Home(index: currentIndex,),
//                     Home(index: currentIndex,),
//                     Home(index: currentIndex,),
//                     Home(index: currentIndex,),
//                     // CategorieScreen(currentIndex),
//                     // CartScreen(currentIndex),
//                     // AccountScreen(currentIndex)
//                   ],
//                 );
//               }),
//             ),
//           ],
//         ),
//         bottomNavigationBar: Obx(
//           () => BottomMenu(
//             bottomMenuIndex: landingHomeController.selectedIndex.value,
//             onChanged: (index) {
//               landingHomeController.updateIndexSelected(index);
//             },
//           ),
//         ));
//         }
//
//     );
//   }
// }
//
// // class LandingHome extends GetWidget<HomeController> {
// //   @override
// //   Widget build(BuildContext context) {
// //     // return Scaffold(
// //     //     body: Column(
// //     //       children: [
// //     //         // Expanded(
// //     //         //   child: Obx(() {
// //     //         //     int currentIndex = controller.selectedIndex.value;
// //     //         //     return IndexedStack(
// //     //         //       index: currentIndex,
// //     //         //       children: [
// //     //         //         Home(index: currentIndex,),
// //     //         //         CategorieScreen(currentIndex),
// //     //         //         CartScreen(currentIndex),
// //     //         //         AccountScreen(currentIndex)
// //     //         //       ],
// //     //         //     );
// //     //         //   }),
// //     //         // ),
// //     //       ],
// //     //     ),
// //     //     bottomNavigationBar: Obx(
// //     //       () => BottomMenu(
// //     //         bottomMenuIndex: controller.selectedIndex.value,
// //     //         onChanged: (index) {
// //     //           controller.updateIndexSelected(index);
// //     //         },
// //     //       ),
// //     //     ));
// //
// //     return Scaffold(body: Center(child: Text("hfhsdhjdbhds")),);
// //   }
// // }

import 'package:eshoperapp/models/customer.dart';
import 'package:eshoperapp/pages/cart/cart_screen.dart';
import 'package:eshoperapp/pages/category/category.dart';
import 'package:eshoperapp/pages/home/home_screen.dart';
import 'package:eshoperapp/pages/profile/profile_controller.dart';
import 'package:eshoperapp/pages/profile/profile_screen.dart';
import 'package:eshoperapp/routes/navigation.dart';
import 'package:eshoperapp/utils/alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class LandingHome extends StatefulWidget {
  const LandingHome({Key? key}) : super(key: key);

  @override
  State<LandingHome> createState() => _LandingHomeState();
}

class _LandingHomeState extends State<LandingHome> {

   // final profileController = Get.find<ProfileController>();

   final profileController = Get.put(ProfileController(
       apiRepositoryInterface: Get.find(),
       customer: Customer(),
       localRepositoryInterface: Get.find()));
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(
            apiRepositoryInterface: Get.find(),
            localRepositoryInterface: Get.find()),
        builder: (homeController) {
          return Scaffold(
            appBar: appBar(homeController,profileController),
            body: body(homeController),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black38, spreadRadius: 0, blurRadius: 10),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0)),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  onTap: homeController.changeTabIndex,
                  currentIndex: homeController.tabIndex,
                  items:  [
                    BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.home ,size: 35,),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.square_grid_2x2_fill, size: 35,),
                      label: 'Category',
                    ),
                    BottomNavigationBarItem(
                      // icon: Icon(CupertinoIcons.cart, color: Colors.red),
                      // icon:
                      // Icon(CupertinoIcons.cart),
                      icon:  Stack(
                        children: <Widget>[
                          Icon(CupertinoIcons.cart, size: 35,),
                          Positioned(
                            top: 0,
                            right: 0,
                            child:  Container(
                              padding: const EdgeInsets.only(left: 5, right: 5, top: 2,bottom: 2),
                              decoration:  BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 12,
                                minHeight: 12,
                              ),
                              child:  Center(
                                child: Obx((){
                                  return Text(
                                    homeController.cartList.value.length.toString(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold
                                    ),
                                    // textAlign: TextAlign.center,
                                  );
                                })
                                ,
                              ),
                            ),
                          )
                        ],
                      ),
                      label: 'Cart',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.person_alt_circle, size: 35,),
                      label: 'Profile',
                    ),
                  ],
                  selectedItemColor: Colors.red,
                  unselectedItemColor: Colors.grey,
                  unselectedIconTheme: const IconThemeData(size: 30),
                  selectedIconTheme: const IconThemeData(size: 34),
                ),
              ),
            ),
          );
        });
  }


  appBar(HomeController homeController, ProfileController profileController) {
    if (homeController.tabIndex == 0) {
      return AppBar(

        backgroundColor: Colors.white,
        // centerTitle: true,
        title: RichText(
          text: const TextSpan(
            //text: 'Default',
            style: TextStyle(color: Color(0xFFFC7663)),
            /*defining default style is optional */
            children: <TextSpan>[
              TextSpan(
                text: 'm',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color: Color(0xFFFC7663)),
              ),
              TextSpan(
                text: 'V',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Color(0xFFFC7663)),
              ),
              TextSpan(
                text: 'ENDOR',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Color(0xFFFC7663)),
              ),
            ],
          ),
        ),
        elevation: 5,
        // leading: Icon(
        //   Icons.search,
        //   color: Color(0xFFFC7663),
        //   size: 35,
        // ),
        actions: [
          // IconButton(
          //   onPressed: () {},
          //   icon: Icon(Icons.notifications_none),
          //   color: Colors.red,
          // ),
          // IconButton(
          //     onPressed: () {},
          //     icon: Icon(Icons.favorite_border),
          //
          //
          //
          //     color: Colors.red),


          Obx((){
            if (profileController.isUserDataRefresh.value == true) {
              print(
                  "profileController.isUserDataRefresh.value if ${profileController.isUserDataRefresh.value}");
              profileController.getUser();
              profileController.isUserDataRefresh(false);
            } else {
              print(
                  "profileController.isUserDataRefresh.value  else ${profileController.isUserDataRefresh.value}");
            }

            return IconButton(
              onPressed: () async {
                profileController.customerId == "" ?Get.toNamed(Routes.login):
                Get.defaultDialog(
                  title: "Logout?",
                  barrierDismissible : false,
                  middleText: "Are you sure you want to logout from this App?",
                  titleStyle: TextStyle(color: Colors.black),
                  middleTextStyle: TextStyle(color: Colors.black),
                  confirm: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        // style: flatButtonStyle,
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
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
                        },
                        child: Text(
                          "OK",
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    ],
                  ),
                  // cancel: Text("Cancel"),
                  // custom: Text("djdn",style: TextStyle(color: Colors.red),)
                );
                // homeController.logout();
                // ShowAlertDialog.showAlertLogoutConfirm(context,"Logout?","Are you sure you want to logout from this App?",homeController);
              },
              icon: Icon(profileController.customerId == "" ?
              Icons.login:Icons.logout,
                size: 30,
              ),
              color: Color(0xFFFC7663));})

        ],
      );
    } else if (homeController.tabIndex == 1) {
      // return AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.white,
      //   title: Text(
      //     "Categories",
      //     style: TextStyle(
      //         color: Color(0xFFFC7663), fontSize: 20, fontWeight: FontWeight.bold),
      //   ),
      //   elevation: 0.5,
      //   //    leading: Icon(Icons.search, color: Colors.red),
      //   actions: [
      //     // IconButton(
      //     //   onPressed: () {},
      //     //   icon: const Icon(Icons.notifications_none),
      //     //   color: Colors.red,
      //     // ),
      //     // IconButton(
      //     //     onPressed: () {},
      //     //     icon: const Icon(Icons.favorite_border),
      //     //     color: Colors.red),
      //     IconButton(
      //         onPressed: () async {
      //          // ShowAlertDialog.showAlertLogoutConfirm(context,"Logout?","Are you sure you want to logout from this App?",homeController);
      //         },
      //         icon: const Icon(Icons.logout,size: 30,),
      //         color: Color(0xFFFC7663))
      //   ],
      // );

      return null;
    } else if (homeController.tabIndex == 2) {
      // return AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.white,
      //   title: Text(
      //     "Cart",
      //     style: TextStyle(
      //         color: Color(0xFFFC7663), fontSize: 20, fontWeight: FontWeight.bold),
      //   ),
      //   elevation: 0.5,
      //   //  leading: Icon(Icons.search, color: Colors.red),
      //   actions: [
      //     // IconButton(
      //     //   onPressed: () {},
      //     //   icon: Icon(Icons.notifications_none),
      //     //   color: Colors.red,
      //     // ),
      //     // IconButton(
      //     //     onPressed: () {},
      //     //     icon: Icon(Icons.favorite_border),
      //     //     color: Colors.red),
      //     IconButton(
      //         onPressed: () async {
      //           //ShowAlertDialog.showAlertLogoutConfirm(context,"Logout?","Are you sure you want to logout from this App?",homeController);
      //         },
      //         icon: Icon(Icons.logout,size: 30,),
      //         color: Color(0xFFFC7663))
      //   ],
      // );

      return null;
    } else if (homeController.tabIndex == 3) {
      // return AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.white,
      //   title: Text(
      //     "Profile",
      //     style: TextStyle(
      //         color: Color(0xFFFC7663), fontSize: 20, fontWeight: FontWeight.bold),
      //   ),
      //   elevation: 0.5,
      //   // leading: Icon(Icons.search, color: Colors.red),
      //   actions: [
      //     // IconButton(
      //     //   onPressed: () {},
      //     //   icon: const Icon(Icons.notifications_none),
      //     //   color: Colors.red,
      //     // ),
      //     // IconButton(
      //     //     onPressed: () {},
      //     //     icon: Icon(Icons.favorite_border),
      //     //     color: Colors.red),
      //     IconButton(
      //         onPressed: () async {
      //           //ShowAlertDialog.showAlertLogoutConfirm(context,"Logout?","Are you sure you want to logout from this App?",homeController);
      //         },
      //         icon: Icon(Icons.logout,size: 30,),
      //         color:Color(0xFFFC7663))
      //   ],
      // );
      return null;
    }
  }

  body(HomeController homeController) {
    return PageView(
      //  physics: NeverScrollableScrollPhysics(),
      controller: homeController.pageController,
      onPageChanged: (pageIndex) {
        homeController.changeTabIndex(pageIndex);
      },
      children: [
        Home(),
        CategorieScreen(),
        CartScreen(homeController.tabIndex,false),
        ProfileScreen()
      ],
    );
  }

  indicatorWidget(int tabIndex, int i) {
    if (tabIndex == i) {
      return Container(
        width: 50,
        height: 3,
        color: Colors.red,
      );
    } else {
      return Container();
    }
  }
}
