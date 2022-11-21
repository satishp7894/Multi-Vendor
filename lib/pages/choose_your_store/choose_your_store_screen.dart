import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/theme.dart';
import '../../routes/navigation.dart';
import '../../widgets/app_bar.dart';



class ChooseYourStoreScreen extends StatefulWidget {
  const ChooseYourStoreScreen({Key? key}) : super(key: key);

  @override
  State<ChooseYourStoreScreen> createState() => _ChooseYourStoreScreenState();
}

class _ChooseYourStoreScreenState extends State<ChooseYourStoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      // appBar:  AppBar(
      //
      //   backgroundColor: Colors.white,
      //   title: Image.asset('assets/logos/app_logo.png',fit: BoxFit.fill,height: 70,width: 100,),
      //   // centerTitle: true,
      //   // title: RichText(
      //   //   text: const TextSpan(
      //   //     //text: 'Default',
      //   //     style: TextStyle(color: Color(0xFFFC7663)),
      //   //     /*defining default style is optional */
      //   //     children: <TextSpan>[
      //   //       TextSpan(
      //   //         text: 'm',
      //   //         style: TextStyle(
      //   //             fontWeight: FontWeight.bold,
      //   //             fontSize: 35,
      //   //             color: Color(0xFFFC7663)),
      //   //       ),
      //   //       TextSpan(
      //   //         text: 'V',
      //   //         style: TextStyle(
      //   //             fontWeight: FontWeight.bold,
      //   //             fontSize: 40,
      //   //             color: Color(0xFFFC7663)),
      //   //       ),
      //   //       TextSpan(
      //   //         text: 'ENDOR',
      //   //         style: TextStyle(
      //   //             fontWeight: FontWeight.bold,
      //   //             fontSize: 25,
      //   //             color: Color(0xFFFC7663)),
      //   //       ),
      //   //     ],
      //   //   ),
      //   // ),
      //   elevation: 0,
      //   // leading: Icon(
      //   //   Icons.search,
      //   //   color: Color(0xFFFC7663),
      //   //   size: 35,
      //   // ),
      //   actions: [
      //     // IconButton(
      //     //   onPressed: () {},
      //     //   icon: Icon(Icons.notifications_none),
      //     //   color: Colors.red,
      //     // ),
      //     // IconButton(
      //     //     onPressed: () {},
      //     //     icon: Icon(Icons.favorite_border),
      //     //
      //     //
      //     //
      //     //     color: Colors.red),
      //
      //
      //     // Obx((){
      //     //   if (profileController.isUserDataRefresh.value == true) {
      //     //     print(
      //     //         "profileController.isUserDataRefresh.value if ${profileController.isUserDataRefresh.value}");
      //     //     profileController.getUser();
      //     //     profileController.isUserDataRefresh(false);
      //     //   } else {
      //     //     print(
      //     //         "profileController.isUserDataRefresh.value  else ${profileController.isUserDataRefresh.value}");
      //     //   }
      //     //
      //     //   return IconButton(
      //     //     onPressed: () async {
      //     //       profileController.customerId == "" ?Get.toNamed(Routes.login):
      //     //       Get.defaultDialog(
      //     //         title: "Logout?",
      //     //         barrierDismissible : false,
      //     //         middleText: "Are you sure you want to logout from this App?",
      //     //         titleStyle: TextStyle(color: Colors.black),
      //     //         middleTextStyle: TextStyle(color: Colors.black),
      //     //         confirm: Row(
      //     //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     //           children: [
      //     //             TextButton(
      //     //               // style: flatButtonStyle,
      //     //               onPressed: () {
      //     //                 Get.back();
      //     //               },
      //     //               child: Text(
      //     //                 "Cancel",
      //     //                 style: TextStyle(color: Colors.red),
      //     //               ),
      //     //             ),
      //     //             TextButton(
      //     //               // style: flatButtonStyle,
      //     //               onPressed: () async {
      //     //                 bool? logout = await profileController.logout();
      //     //                 print("logout  $logout");
      //     //                 if (logout == true) {
      //     //                   print("logout if $logout");
      //     //                   profileController.getUser();
      //     //                   Get.back();
      //     //                 } else {
      //     //                   print("logout else $logout");
      //     //                 }
      //     //               },
      //     //               child: Text(
      //     //                 "OK",
      //     //                 style: TextStyle(color: Colors.red),
      //     //               ),
      //     //             )
      //     //           ],
      //     //         ),
      //     //         // cancel: Text("Cancel"),
      //     //         // custom: Text("djdn",style: TextStyle(color: Colors.red),)
      //     //       );
      //     //       // homeController.logout();
      //     //       // ShowAlertDialog.showAlertLogoutConfirm(context,"Logout?","Are you sure you want to logout from this App?",homeController);
      //     //     },
      //     //     icon: Icon(profileController.customerId == "" ?
      //     //     Icons.login:Icons.logout,
      //     //       size: 30,
      //     //     ),
      //     //     color: Color(0xFFFC7663));}),
      //     IconButton(
      //         padding: EdgeInsets.zero,
      //         onPressed: ()  {
      //           Get.toNamed(Routes.searchScreen);
      //         },
      //         icon: Image.asset('assets/img/search.png',fit: BoxFit.fill,height: 18,width: 18,)),
      //     IconButton(
      //         padding: EdgeInsets.zero,
      //         onPressed: ()  {
      //           Get.toNamed(Routes.wishList);
      //         },
      //         icon: Image.asset('assets/img/heart.png',fit: BoxFit.fill,height: 18,width: 18,)),
      //
      //     IconButton(
      //         padding: EdgeInsets.zero,
      //         onPressed: ()  {
      //           Get.toNamed(Routes.notification);
      //         },
      //         icon: Image.asset('assets/img/Notification.png',fit: BoxFit.fill,height: 22,width: 22,)),
      //
      //   ],
      // ),

      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              // Container(height: 0.5,width: MediaQuery.of(context).size.width,color: AppColors.tileLine,),
              AppbarWidget(flag: false,),
              Expanded(
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    // SizedBox(height: 56,),
                  Text("Choose Your Store",style:  GoogleFonts.inriaSerif(
                      textStyle: const TextStyle(
                          fontSize: 24,
                          color: AppColors.black,
                          fontWeight: FontWeight.bold))),
                    SizedBox(height: 32,),
                    storeContainer("assets/img/store_women.png","Women"),
                    SizedBox(height: 24,),
                    storeContainer("assets/img/store_man.png","Men"),
                    SizedBox(height: 24,),
                    storeContainer("assets/img/store_kids.png","Kids")

                ],),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget storeContainer(String path,label){
    return InkWell(
      onTap: (){
        Get.toNamed(Routes.landingHome);
      },
      child: Column(
        children: [
          ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: const Radius.circular(100),
                topLeft: const Radius.circular(100),
                bottomLeft: const Radius.circular(100),
                bottomRight: const Radius.circular(100),
              ),
              // borderRadius:
              // BorderRadius.circular(15),
              child: Image.asset(path,fit: BoxFit.fill,height: 100,
                width: 100,)),
          SizedBox(height: 8,),
          Text(label,style:CustomTextStyle.storeLabel)
        ],
      ),
    );
  }
}
