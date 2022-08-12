import 'package:eshoperapp/routes/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlertDialogs{
  static showAlertAndBack(BuildContext context, String title, String message) {
    showDialog(context: context,
      builder: (BuildContext c) {
        return Container(
          height: 150,
          width: 80,
          alignment: Alignment.center,
          decoration:BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30)
          ),
          child: CupertinoAlertDialog(
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(title,style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                Text(message,style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal),),
                Divider(thickness: 1, color: Colors.grey,),
                SizedBox(height: 10,),

                TextButton(
                    onPressed: ()async{
                      Get.back();
                    },
                    child: Text("Okay", style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.normal), textAlign: TextAlign.center,))
              ],
            ),
          ),
        );
      },
    );
  }
  static showAlertDialog( String title, String message, VoidCallback? onTap) {
    Get.defaultDialog(
      title: title,
      barrierDismissible: false,
      middleText:
      message,
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
              Get.back();
              onTap!();
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
  }

  static showInternetDialog( String title, String message) {



    Get.defaultDialog(
        title: '',
        content:
        Container(
          height: 135,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(title,style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text(message,style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal),),
              Divider(thickness: 1, color: Colors.grey,),
              SizedBox(height: 10,),
              TextButton(
                  onPressed: ()async{
                    Get.back();
                    // Navigator.pop(context);
                  },
                  child: Text("Okay", style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.normal), textAlign: TextAlign.center,))
            ],
          ),
        ),
        radius: 10.0);

    // showDialog(context: context,
    //   builder: (BuildContext c) {
    //     return
    //       Container(
    //       height: 150,
    //       width: 80,
    //       alignment: Alignment.center,
    //       decoration:BoxDecoration(
    //           color: Colors.transparent,
    //           borderRadius: BorderRadius.circular(30)
    //       ),
    //       child: CupertinoAlertDialog(
    //         content: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           children: [
    //             Text(title,style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
    //             SizedBox(height: 10,),
    //             Text(message,style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal),),
    //             Divider(thickness: 1, color: Colors.grey,),
    //             SizedBox(height: 10,),
    //             TextButton(
    //                 onPressed: ()async{
    //                   Get.back();
    //                   // Navigator.pop(context);
    //                 },
    //                 child: Text("Okay", style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.normal), textAlign: TextAlign.center,))
    //           ],
    //         ),
    //       ),
    //     );
    //   },
    // );
  }

  static showLoginRequiredDialog( ) {



    Get.defaultDialog(
        title: "Login?",
        barrierDismissible: false,
        middleText:
        "Login Required?",
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
              onPressed: ()  {
                Get.back();
                Get.toNamed(
                  Routes.login,
                );
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

    // showDialog(context: context,
    //   builder: (BuildContext c) {
    //     return
    //       Container(
    //       height: 150,
    //       width: 80,
    //       alignment: Alignment.center,
    //       decoration:BoxDecoration(
    //           color: Colors.transparent,
    //           borderRadius: BorderRadius.circular(30)
    //       ),
    //       child: CupertinoAlertDialog(
    //         content: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           children: [
    //             Text(title,style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
    //             SizedBox(height: 10,),
    //             Text(message,style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal),),
    //             Divider(thickness: 1, color: Colors.grey,),
    //             SizedBox(height: 10,),
    //             TextButton(
    //                 onPressed: ()async{
    //                   Get.back();
    //                   // Navigator.pop(context);
    //                 },
    //                 child: Text("Okay", style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.normal), textAlign: TextAlign.center,))
    //           ],
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}