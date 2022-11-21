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

import '../../config/theme.dart';
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
            floatingActionButton: CustomFab(),
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

            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            //floating action button position to center

            bottomNavigationBar: BottomAppBar( //bottom navigation bar on scaffold
              color:Colors.white,
              elevation: 10,
              shape: CircularNotchedRectangle(), //shape of notch
              notchMargin: 8, //notche margin between floating button and bottom appbar
              child: Container(

                child: Padding(
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
                        Get.toNamed(Routes.cart);
                      },),
                      IconButton(icon: homeController.tabIndex == 2 ? Image.asset('assets/img/select_profile.png',fit: BoxFit.fill,height: 20,width: 20,):Image.asset('assets/img/profile.png',fit: BoxFit.fill,height: 20,width: 20,), onPressed: () {
                        homeController.changeTabIndex(2);
                        homeController.tabIndex = 2;
                      },),
                    ],
                  ),
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
    return InkWell(
      onTap: (){
        print("women_icon");
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
    return Stack(

      // clipBehavior: Clip.antiAliasWithSaveLayer,
      children: [
        Transform(
          transform:
          Matrix4.translationValues(0, -_translateAnimation!.value+value1, 0),
          child: fab1(),
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
    );
  }
}
