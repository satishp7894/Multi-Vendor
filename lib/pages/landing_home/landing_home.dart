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
import 'package:flutter_arc_speed_dial/flutter_speed_dial_menu_button.dart';
import 'package:flutter_arc_speed_dial/main_menu_floating_action_button.dart';
// import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';

import '../../config/theme.dart';
import '../../constants/app_costants.dart';
import '../../utils/bottom_painter.dart';
import '../../widgets/login_dialog.dart';
import 'home_controller.dart';

class LandingHome extends StatefulWidget {
  const LandingHome({Key? key}) : super(key: key);

  @override
  State<LandingHome> createState() => _LandingHomeState();
}

class _LandingHomeState extends State<LandingHome> with TickerProviderStateMixin {
  late AnimationController controller;
  late TextEditingController? mobile;
   // final profileController = Get.find<ProfileController>();

   final profileController = Get.put(ProfileController(
       apiRepositoryInterface: Get.find(),
       customer: Customer(),
       localRepositoryInterface: Get.find()));

   @override
  void initState() {
    // TODO: implement initState
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
  bool _isShowDial = false;




  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(
            apiRepositoryInterface: Get.find(),
            localRepositoryInterface: Get.find()),
        builder: (homeController) {
          return Scaffold(
            // appBar: appBar(homeController,profileController),
            body: body(homeController),

            floatingActionButton: homeController.tabIndex == 0 ?

            // CustomFab(),


            Padding(
              padding: const EdgeInsets.all(0.0),
              child: SpeedDial(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset('assets/img/finger_up.png'),
                ),
                closedForegroundColor: AppColors.fbBackground,
                openForegroundColor: AppColors.fbBackground,
                closedBackgroundColor: AppColors.fbBackground,
                openBackgroundColor: AppColors.fbBackground,
                // labelsStyle: /* Your label TextStyle goes here */,
                labelsBackgroundColor: AppColors.fbBackground,

                // controller: /* Your custom animation controller goes here */,
                speedDialChildren: <SpeedDialChild>[

                  SpeedDialChild(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.fbBackground, width: 1.3),
                        borderRadius: BorderRadius.circular(100)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Image.asset("assets/img/women_icon.png"),
                      ),
                    ),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.white,
                    // label: 'Women',
                    onPressed: () async {
                      SharedPreferences sharedPreferences = await SharedPreferences.getInstance() ;
                      sharedPreferences.setString(AppConstants.chooseType!, "Women");
                      setState(() {

                        // _text = 'You pressed \"Let\'s go for a walk!\"';

                        homeController.init();
                      });
                    },
                    // closeSpeedDialOnPressed: false,
                  ),
                  SpeedDialChild(

                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.fbBackground, width: 1.3),
                          borderRadius: BorderRadius.circular(100)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Image.asset("assets/img/man_icon.png"),
                      ),
                    ),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.white,
                    // label: 'Men',
                    onPressed: () async {
                      SharedPreferences sharedPreferences = await SharedPreferences.getInstance() ;
                      sharedPreferences.setString(AppConstants.chooseType!, "Men");
                      setState(() {

                        // _text = 'You pressed \"Let\'s go for a walk!\"';

                        homeController.init();
                      });
                    },
                  ),
                  SpeedDialChild(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.fbBackground, width: 1.3),
                          borderRadius: BorderRadius.circular(100)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Image.asset("assets/img/kids_icon.png"),
                      ),
                    ),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.white,
                    // label: 'Kids',
                    onPressed: () async {
                      SharedPreferences sharedPreferences = await SharedPreferences.getInstance() ;
                      sharedPreferences.setString(AppConstants.chooseType!, "Kids");
                      setState(() {

                        // _text = 'You pressed \"Let\'s go for a walk!\"';

                        homeController.init();
                      });
                    },
                  ),
                  //  Your other SpeedDialChildren go here.
                ],
              ),
            ):Container(),
            // floatingActionButton:FloatingActionButton(
            //     //Floating action button on Scaffold
            //   onPressed: (){
            //     //code to execute on button press
            //   },
            //   child:
            //   Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Image.asset('assets/img/three_person.png'),
            //       Image.asset('assets/img/finger_up.png'),
            //     ],
            //   ),
            //     backgroundColor: AppColors.white//icon inside button
            // ),

            // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            //floating action button position to center

            bottomNavigationBar: BottomAppBar( //bottom navigation bar on scaffold
              color:Colors.white,
              elevation: 10,
              // shape: CircularNotchedRectangle(), //shape of notch
              notchMargin: 8, //notche margin between floating button and bottom appbar
              child: Container(


                child: Stack(
                  children: [
                    // Container(
                    //   // height: 200,
                    //
                    //   decoration: BoxDecoration(
                    //     // color: AppColors.appGreen,
                    //     boxShadow: [BoxShadow(color: Colors.grey,blurRadius: 8,offset: Offset(3,5))],
                    //   ),
                    //   width: MediaQuery.of(context).size.width,
                    //   // padding: const EdgeInsets.only(top: 80.0),
                    //   child: CustomPaint(
                    //     painter: ProfileCardPainter(
                    //         color: AppColors.white, avatarRadius: 100), //3
                    //   ),
                    // ),
                    // // Image.asset('assets/img/circle_clipper.png',width: MediaQuery.of(context).size.width),
                    // ClipPath(
                    //   clipper:  DolDurmaClipper(right:  (MediaQuery.of(context).size.width - 70) / 2, holeRadius: 72),
                    //   child: Container(
                    //     height: 90,
                    //     color: Colors.black.withOpacity(0.1),
                    //     // child: Center(
                    //     //     child: Text("WaveClipperTwo(flip: true,reverse: true)")),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                      child: Row( //children inside bottom appbar
                        // mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[

                          IconButton(icon: homeController.tabIndex == 0 ? Image.asset('assets/img/select_home.png',fit: BoxFit.fill,height: 20,width: 20,):Image.asset('assets/img/home.png',fit: BoxFit.fill,height: 20,width: 20,), onPressed: () {
                            homeController.changeTabIndex(0);
                            homeController.tabIndex = 0;
                          },),
                          IconButton(icon: homeController.tabIndex == 1 ? Image.asset('assets/img/select_category.png',fit: BoxFit.fill,height: 20,width: 20,):Image.asset('assets/img/category.png',fit: BoxFit.fill,height: 20,width: 20,), onPressed: () {
                            homeController.changeTabIndex(1);
                            homeController.tabIndex = 1;
                          },),
                          IconButton( icon:Image.asset('assets/img/bag.png',fit: BoxFit.fill,height: 20,width: 20,), onPressed: () {
          // IconButton(icon: homeController.tabIndex == 2 ? Image.asset('assets/img/select_bag.png',):Image.asset('assets/img/bag.png',), onPressed: () {
                            // homeController.changeTabIndex(2);
                            // homeController.tabIndex = 2;
                            print("homeController.customerId.value =======================> ${homeController.customerId.value}");
                            if(homeController.customerId.value != ""){
                              Get.toNamed(Routes.cart);
                            }else{
                              showModalBottomSheet(
                                context: context,
                                // isDismissible:false,
                                isScrollControlled: true,
                                transitionAnimationController: controller,
                                builder: (BuildContext context) {

                                  return LoginDialog(mobile: mobile,);

                                },
                              );
                            }


                          },),
                          IconButton(icon: homeController.tabIndex == 2 ? Image.asset('assets/img/select_profile.png',fit: BoxFit.fill,height: 20,width: 20,):Image.asset('assets/img/profile.png',fit: BoxFit.fill,height: 20,width: 20,), onPressed: () {
                            homeController.changeTabIndex(2);
                            homeController.tabIndex = 2;
                          },),
                        ],
                      ),
                    ),


                  ],
                ),
                height: 65,
              ),
            ),
            // bottomNavigationBar: Container(
            //    height: 75,
            //   decoration: BoxDecoration(
            //     // boxShadow: [
            //     //   BoxShadow(
            //     //       color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            //     // ],
            //   ),
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.only(
            //         topLeft: Radius.circular(15.0),
            //         topRight: Radius.circular(15.0)),
            //     child: BottomNavigationBar(
            //
            //       type: BottomNavigationBarType.fixed,
            //       onTap: homeController.changeTabIndex,
            //       currentIndex: homeController.tabIndex,
            //       items:  [
            //         BottomNavigationBarItem(
            //           icon: homeController.tabIndex == 0 ? Image.asset('assets/img/select_home.png'):Image.asset('assets/img/home.png'),
            //
            //           //Icon(CupertinoIcons.home ,size: 35,),
            //           label: '',
            //
            //         ),
            //         BottomNavigationBarItem(
            //           icon: homeController.tabIndex == 1 ? Image.asset('assets/img/select_category.png'):Image.asset('assets/img/category.png'),
            //           //Icon(CupertinoIcons.square_grid_2x2_fill, size: 35,),
            //           label: '',
            //         ),
            //         BottomNavigationBarItem(
            //           // icon: Icon(CupertinoIcons.cart, color: Colors.red),
            //           // icon:
            //           // Icon(CupertinoIcons.cart),
            //           icon:  Stack(
            //             children: <Widget>[
            //               //Icon(CupertinoIcons.cart, size: 35,),
            //               homeController.tabIndex == 2 ? Image.asset('assets/img/bag.png'):Image.asset('assets/img/bag.png'),
            //               // Positioned(
            //               //   top: 0,
            //               //   right: 0,
            //               //   child:  Container(
            //               //     padding: const EdgeInsets.only(left: 5, right: 5, top: 2,bottom: 2),
            //               //     decoration:  BoxDecoration(
            //               //       color: Colors.red,
            //               //       borderRadius: BorderRadius.circular(100),
            //               //     ),
            //               //     constraints: const BoxConstraints(
            //               //       minWidth: 12,
            //               //       minHeight: 12,
            //               //     ),
            //               //     child:  Center(
            //               //       child: Obx((){
            //               //         return Text(
            //               //           homeController.cartList.value.length.toString(),
            //               //           style: const TextStyle(
            //               //               color: Colors.white,
            //               //               fontSize: 10,
            //               //               fontWeight: FontWeight.bold
            //               //           ),
            //               //           // textAlign: TextAlign.center,
            //               //         );
            //               //       })
            //               //       ,
            //               //     ),
            //               //   ),
            //               // )
            //             ],
            //           ),
            //           label: '',
            //         ),
            //         BottomNavigationBarItem(
            //           icon:  homeController.tabIndex == 3 ? Image.asset('assets/img/select_profile.png'):Image.asset('assets/img/profile.png'),
            //
            //           //Icon(CupertinoIcons.person_alt_circle, size: 35,),
            //           label: '',
            //         ),
            //       ],
            //       selectedItemColor: Colors.red,
            //       unselectedItemColor: Colors.grey,
            //       unselectedIconTheme: const IconThemeData(size: 30),
            //       selectedIconTheme: const IconThemeData(size: 30),
            //     ),
            //   ),
            // ),
          );
        });
  }


  appBar(HomeController homeController, ProfileController profileController) {
    if (homeController.tabIndex == 0) {
      return null;
      return
        PreferredSize(
          preferredSize: Size.fromHeight(55.0),
          child: AppBar(

          backgroundColor: Colors.white,

          title: Image.asset('assets/logos/app_logo.png',fit: BoxFit.fill,height: 70,width: 100,),
          // centerTitle: true,
          // title: RichText(
          //   text: const TextSpan(
          //     //text: 'Default',
          //     style: TextStyle(color: Color(0xFFFC7663)),
          //     /*defining default style is optional */
          //     children: <TextSpan>[
          //       TextSpan(
          //         text: 'm',
          //         style: TextStyle(
          //             fontWeight: FontWeight.bold,
          //             fontSize: 35,
          //             color: Color(0xFFFC7663)),
          //       ),
          //       TextSpan(
          //         text: 'V',
          //         style: TextStyle(
          //             fontWeight: FontWeight.bold,
          //             fontSize: 40,
          //             color: Color(0xFFFC7663)),
          //       ),
          //       TextSpan(
          //         text: 'ENDOR',
          //         style: TextStyle(
          //             fontWeight: FontWeight.bold,
          //             fontSize: 25,
          //             color: Color(0xFFFC7663)),
          //       ),
          //     ],
          //   ),
          // ),
          elevation: 0,
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


            // Obx((){
            //   if (profileController.isUserDataRefresh.value == true) {
            //     print(
            //         "profileController.isUserDataRefresh.value if ${profileController.isUserDataRefresh.value}");
            //     profileController.getUser();
            //     profileController.isUserDataRefresh(false);
            //   } else {
            //     print(
            //         "profileController.isUserDataRefresh.value  else ${profileController.isUserDataRefresh.value}");
            //   }
            //
            //   return IconButton(
            //     onPressed: () async {
            //       profileController.customerId == "" ?Get.toNamed(Routes.login):
            //       Get.defaultDialog(
            //         title: "Logout?",
            //         barrierDismissible : false,
            //         middleText: "Are you sure you want to logout from this App?",
            //         titleStyle: TextStyle(color: Colors.black),
            //         middleTextStyle: TextStyle(color: Colors.black),
            //         confirm: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceAround,
            //           children: [
            //             TextButton(
            //               // style: flatButtonStyle,
            //               onPressed: () {
            //                 Get.back();
            //               },
            //               child: Text(
            //                 "Cancel",
            //                 style: TextStyle(color: Colors.red),
            //               ),
            //             ),
            //             TextButton(
            //               // style: flatButtonStyle,
            //               onPressed: () async {
            //                 bool? logout = await profileController.logout();
            //                 print("logout  $logout");
            //                 if (logout == true) {
            //                   print("logout if $logout");
            //                   profileController.getUser();
            //                   Get.back();
            //                 } else {
            //                   print("logout else $logout");
            //                 }
            //               },
            //               child: Text(
            //                 "OK",
            //                 style: TextStyle(color: Colors.red),
            //               ),
            //             )
            //           ],
            //         ),
            //         // cancel: Text("Cancel"),
            //         // custom: Text("djdn",style: TextStyle(color: Colors.red),)
            //       );
            //       // homeController.logout();
            //       // ShowAlertDialog.showAlertLogoutConfirm(context,"Logout?","Are you sure you want to logout from this App?",homeController);
            //     },
            //     icon: Icon(profileController.customerId == "" ?
            //     Icons.login:Icons.logout,
            //       size: 30,
            //     ),
            //     color: Color(0xFFFC7663));}),
            IconButton(
                padding: EdgeInsets.zero,
                onPressed: ()  {
                  Get.toNamed(Routes.searchScreen);
                },
                icon: Image.asset('assets/img/search.png',fit: BoxFit.fill,height: 18,width: 18,)),
            IconButton(
                padding: EdgeInsets.zero,
                onPressed: ()  {
                  Get.toNamed(Routes.wishList);
                },
                icon: Image.asset('assets/img/heart.png',fit: BoxFit.fill,height: 18,width: 18,)),

            IconButton(
                padding: EdgeInsets.zero,
                onPressed: ()  {
                  Get.toNamed(Routes.notification);
                },
                icon: Image.asset('assets/img/Notification.png',fit: BoxFit.fill,height: 22,width: 22,)),


          ],
      ),
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
       physics: NeverScrollableScrollPhysics(),
      controller: homeController.
      pageController,
      onPageChanged: (pageIndex) {
        homeController.changeTabIndex(pageIndex);
      },
      children: [
        Home(),
        CategorieScreen(),
        // CartScreen(homeController.tabIndex,false),
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



// class CustomFab extends StatefulWidget {
//   @override
//   _CustomFabState createState() => _CustomFabState();
// }
//
// class _CustomFabState extends State<CustomFab>
//     with SingleTickerProviderStateMixin {
//   AnimationController? _animationController;
//   Animation<double>? _translateAnimation;
//   Animation<double>? _rotationAnimation;
//
//   Animation<double>? _iconRotation;
//
//   bool _isExpanded = false;
//
//   void animate() {
//     if (!_isExpanded) {
//       _animationController!.forward();
//     } else {
//       _animationController!.reverse();
//     }
//
//     _isExpanded = !_isExpanded;
//   }
//
//   Widget fab1() {
//     return InkWell(
//       onTap: (){
//         print("cons.map");
//       },
//       child: Container(
//         height: 60,
//         width: 60,
//         child: Transform.rotate(
//           angle: _iconRotation!.value,
//           child: Icon(Icons.map),
//         ),
//       ),
//     );
//   }
//
//   Widget fab2() {
//     return InkWell(
//       onTap: (){
//         print("Icons.home");
//       },
//       child: Container(
//         height: 60,
//         width: 60,
//         child: Transform.rotate(
//           angle: _iconRotation!.value,
//           child: Icon(Icons.home),
//         ),
//       ),
//     );
//   }
//
//   // Widget fab3() {
//   //   return Container(
//   //     height: 60,
//   //     width: 60,
//   //     child: FittedBox(
//   //       child: FloatingActionButton(
//   //         heroTag: "btn5",
//   //         child: Icon(Icons.add),
//   //         backgroundColor: Color(0xffFFC852),
//   //         onPressed: () async {
//   //           animate();
//   //           // await Permission.contacts.request();
//   //           // if (await Permission.contacts.status.isGranted) {
//   //           //   animate();
//   //           // }
//   //         },
//   //       ),
//   //     ),
//   //   );
//   // }
//
//     Widget fab3() {
//     return Container(
//       height: 60,
//       width: 60,
//       child: FloatingActionButton(
//         // heroTag: "btn5",
//         // child: Transform.rotate(
//         //   angle: _rotationAnimation!.value,
//         //   child:  Column(
//         //     mainAxisAlignment: MainAxisAlignment.center,
//         //     crossAxisAlignment: CrossAxisAlignment.center,
//         //     children: [
//         //       Image.asset('assets/img/three_person.png'),
//         //       Image.asset('assets/img/finger_up.png'),
//         //     ],
//         //   ),
//         // ),
//
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Image.asset('assets/img/three_person.png'),
//             Image.asset('assets/img/finger_up.png'),
//           ],
//         ),
//         backgroundColor: AppColors.white,
//         onPressed: () async {
//           // await Permission.contacts.request();
//           // if (await Permission.contacts.status.isGranted) {
//           //   animate();
//           // }
//
//           animate();
//         },
//       ),
//     );
//   }
//
//   // @override
//   // void initState() {
//   //   _animationController =
//   //   AnimationController(vsync: this, duration: Duration(milliseconds: 400))
//   //     ..addListener(() {
//   //       setState(() {});
//   //     });
//   //   _translateAnimation = Tween<double>(begin: 0, end: 80)
//   //       .chain(
//   //     CurveTween(
//   //       curve: _isExpanded ? Curves.fastOutSlowIn : Curves.bounceOut,
//   //     ),
//   //   )
//   //       .animate(_animationController!);
//   //
//   //   _iconRotation = Tween<double>(begin: 3.14 / 2, end: 0)
//   //       .chain(
//   //     CurveTween(curve: Curves.bounceInOut),
//   //   )
//   //       .animate(_animationController!);
//   //   _rotationAnimation = Tween<double>(begin: 0, end: 3 * 3.14 / 4)
//   //       .chain(
//   //     CurveTween(
//   //       curve: Curves.bounceInOut,
//   //     ),
//   //   )
//   //       .animate(_animationController!);
//   //   super.initState();
//   // }
//
//     @override
//   void initState() {
//     _animationController =
//     AnimationController(vsync: this, duration: Duration(milliseconds: 400))
//       ..addListener(() {
//         setState(() {});
//       });
//     _translateAnimation = Tween<double>(begin: 0, end: 60)
//         .chain(
//       CurveTween(
//         curve: _isExpanded ? Curves.slowMiddle : Curves.slowMiddle,
//       ),
//     )
//         .animate(_animationController!);
//
//     _iconRotation = Tween<double>(begin: 3.14 / 2, end: 0)
//         .chain(
//       CurveTween(curve: Curves.bounceInOut),
//     )
//         .animate(_animationController!);
//     _rotationAnimation = Tween<double>(begin: 0, end: 3 * 3.14 / 4)
//         .chain(
//       CurveTween(
//         curve: Curves.bounceInOut,
//       ),
//     )
//         .animate(_animationController!);
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _animationController!.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if(_isExpanded){
//       return Container(
//         color: Colors.red,
//         height: 150,// You need to give your "action area" a bigger size.
//         width: 200,
//         // height: 65,// You need to give your "action area" a bigger size.
//         // width: 65,
//         child: Stack(
//           // clipBehavior: Clip.none,
//           children: [
//             // Transform(
//             // ),
//             // Transform(
//             //   transform:
//             //   Matrix4.translationValues(-_translateAnimation!.value, 0, 0),
//             //   child: fab2(),
//             // ),
//             // fab3(),
//
//             Positioned(// These numbers just for example, you can make your own size or position.
//               left: 200 / 2 - 30,
//               // left: 65 / 2 - 30,
//               bottom: _translateAnimation!.value + 40,
//               // bottom: _translateAnimation!.value + 10,
//               child: fab1(),
//             ),
//             Positioned(
//               left: 200 / 2 - 30 -_translateAnimation!.value,
//               // left: 65 / 2 - 30 -_translateAnimation!.value,
//               bottom: 60,
//               // bottom: 5,
//               child: fab2(),
//             ),
//             Positioned(
//               right: 200 / 2 - 30 -_translateAnimation!.value,
//               // right: 65 / 2 - 30 -_translateAnimation!.value,
//               bottom: 60,
//               // bottom: 5,
//               child: fab2(),
//             ),
//             Positioned(
//               left: 200 / 2 - 30,
//               // left: 65 / 2 - 30,
//               bottom:  25,
//               // bottom: 5,
//               child: fab3(),
//             ),
//           ],
//         ),
//       );
//     }else{
//       return Container(
//         // color: Colors.red,
//         // height: 200,// You need to give your "action area" a bigger size.
//         // width: 200,
//         height: 60,// You need to give your "action area" a bigger size.
//         width: 60,
//         child: Stack(
//           clipBehavior: Clip.none,
//           children: [
//             // Transform(
//             //   transform:
//             //   Matrix4.translationValues(0, -_translateAnimation!.value, 0),
//             //   child: fab1(),
//             // ),
//             // Transform(
//             //   transform:
//             //   Matrix4.translationValues(-_translateAnimation!.value, 0, 0),
//             //   child: fab2(),
//             // ),
//             // fab3(),
//
//             Positioned(// These numbers just for example, you can make your own size or position.
//               // left: 200 / 2 - 30,
//               left: 60 / 2 - 30,
//               bottom: _translateAnimation!.value + 0,
//               // bottom: _translateAnimation!.value + 10,
//               child: fab1(),
//             ),
//             Positioned(
//               // left: 200 / 2 - 30 -_translateAnimation!.value,
//               left: 60 / 2 - 30 -_translateAnimation!.value,
//               bottom: 0,
//               // bottom: 5,
//               child: fab2(),
//             ),
//             Positioned(
//               // right: 200 / 2 - 30 -_translateAnimation!.value,
//               right: 60 / 2 - 30 -_translateAnimation!.value,
//               bottom: 0,
//               // bottom: 5,
//               child: fab2(),
//             ),
//             Positioned(
//               // left: 200 / 2 - 30,
//               left: 60 / 2 - 30,
//               bottom: 0,
//               // bottom: 5,
//               child: fab3(),
//             ),
//           ],
//         ),
//       );
//     }
//
//   }
// }

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {

    // final shapeBounds = Rect.fromLTWH(0, 0, size.width, size.height - AVATAR_RADIUS);
    final shapeBounds = Rect.fromLTWH(0, 0, size.width, size.height);
    //1
    // final centerAvatar = Offset(shapeBounds.center.dx, shapeBounds.bottom);
    final centerAvatar = Offset(shapeBounds.center.dx, shapeBounds.bottom);
    //2
    final avatarBounds = Rect.fromCircle(center: centerAvatar, radius: 38.0);

    Path path = Path()
      ..moveTo(shapeBounds.left, shapeBounds.top) //3
      ..lineTo(shapeBounds.bottomLeft.dx, shapeBounds.bottomLeft.dy)
      ..arcTo(avatarBounds, -3.141592653589793238, 3.141592653589793238, false) //5
      ..lineTo(shapeBounds.bottomRight.dx, shapeBounds.bottomRight.dy) //6
      ..lineTo(shapeBounds.topRight.dx, shapeBounds.topRight.dy) //7
      ..close();

    return path;
  }


  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}


class DolDurmaClipper extends CustomClipper<Path> {
  DolDurmaClipper({required this.right, required this.holeRadius});

  final double right;
  final double holeRadius;

  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width - right - holeRadius, 0.0)
      ..arcToPoint(
        Offset(size.width - right, 0),
        clockwise: false,
        radius: Radius.circular(4),
      )
      ..lineTo(size.width, 0.0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width - right, size.height)
      ..arcToPoint(
        Offset(size.width - right - holeRadius, size.height),
        clockwise: false,
        radius: Radius.circular(10),
      );

    path.lineTo(0.0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(DolDurmaClipper oldClipper) => true;
}








class CustomFab extends StatefulWidget {
  @override
  _CustomFabState createState() => _CustomFabState();
}

class _CustomFabState extends State<CustomFab>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _translateAnimation;
  Animation<double>? _rotationAnimation;

  Animation<double>? _iconRotation;

  bool _isExpanded = false;
  double value = 2.5;
  double value1 = 2.5;

  void animate() {
    if (!_isExpanded) {
      value = -28;
      value1 = -5;
      _animationController!.forward();
    } else {
      value = 2.5;
      value1 = 2.5;
      _animationController!.reverse();
    }

    _isExpanded = !_isExpanded;
  }

  Widget fab3() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.all(
            const Radius.circular(100)
        ),
        border: Border.all(
          width: 1,
          color: AppColors.black,
          // style: BorderStyle.solid,
        ),
      ),
      height: 55,
      width: 55,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: const BorderRadius.all(
                const Radius.circular(100)
            ),
            border: Border.all(
              width: 1,
              color: AppColors.black,
              // style: BorderStyle.solid,
            ),
          ),
          child: Image.asset("assets/img/kids_icon.png"),
        ),
      ),
    );
  }

  Widget fab1() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: (){
        print("women_icon");
        _isExpanded = !_isExpanded;
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.all(
              const Radius.circular(100)
          ),
          border: Border.all(
            width: 1,
            color: AppColors.black,
            // style: BorderStyle.solid,
          ),
        ),
        height: 55,
        width: 55,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: const BorderRadius.all(
                  const Radius.circular(100)
              ),
              border: Border.all(
                width: 1,
                color: AppColors.black,
                // style: BorderStyle.solid,
              ),
            ),
            child: Image.asset("assets/img/women_icon.png"),
          ),
        ),
      ),
    );
  }

  Widget fab2() {
    return GestureDetector(
      onTap: () {
        print('TAP BOTTOM');
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.all(
              const Radius.circular(100)
          ),
          border: Border.all(
            width: 1,
            color: AppColors.black,
            // style: BorderStyle.solid,
          ),
        ),
        height: 55,
        width: 55,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: const BorderRadius.all(
                  const Radius.circular(100)
              ),
              border: Border.all(
                width: 1,
                color: AppColors.black,
                // style: BorderStyle.solid,
              ),
            ),
            child: Image.asset("assets/img/man_icon.png"),
          ),
        ),
      ),
    );
  }

  Widget fab0() {
    return Container(
      height: 60,
      width: 60,
      child: FloatingActionButton(
        // heroTag: "btn5",
        // child: Transform.rotate(
        //   angle: _rotationAnimation!.value,
        //   child:  Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       Image.asset('assets/img/three_person.png'),
        //       Image.asset('assets/img/finger_up.png'),
        //     ],
        //   ),
        // ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/img/three_person.png'),
            Image.asset('assets/img/finger_up.png'),
          ],
        ),
        backgroundColor: AppColors.white,
        onPressed: () async {
          // await Permission.contacts.request();
          // if (await Permission.contacts.status.isGranted) {
          //   animate();
          // }

          animate();
        },
      ),
    );
  }

  @override
  void initState() {
    _animationController =
    AnimationController(vsync: this, duration: Duration(milliseconds: 400))
      ..addListener(() {
        setState(() {});
      });
    _translateAnimation = Tween<double>(begin: 0, end: 60)
        .chain(
      CurveTween(
        curve: _isExpanded ? Curves.slowMiddle : Curves.slowMiddle,
      ),
    )
        .animate(_animationController!);

    _iconRotation = Tween<double>(begin: 3.14 / 2, end: 0)
        .chain(
      CurveTween(curve: Curves.bounceInOut),
    )
        .animate(_animationController!);
    _rotationAnimation = Tween<double>(begin: 0, end: 3 * 3.14 / 4)
        .chain(
      CurveTween(
        curve: Curves.bounceInOut,
      ),
    )
        .animate(_animationController!);
    super.initState();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      child: Stack(

        fit: StackFit.loose,
        children: [
          Positioned(
            child: Transform(
              transform:
              Matrix4.translationValues(0, -_translateAnimation!.value+value1, 0),
              child: fab1(),
            ),
          ),
          Transform(
            transform:
            Matrix4.translationValues(-_translateAnimation!.value, value, 0),
            child: fab2(),
          ),
          Transform(
            transform:
            Matrix4.translationValues(_translateAnimation!.value, value, 0),
            child: fab3(),
          ),
          fab0(),
        ],
      ),
    );
  }
}
