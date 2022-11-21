import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/theme.dart';
import '../../widgets/app_bar_title.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[200],
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   leading: Image.asset(
      //     'assets/img/arrow_left.png',
      //     color: AppColors.appText,
      //   ),
      //   title: Text(
      //     "Notification",
      //     style: GoogleFonts.inriaSans(
      //         textStyle: const TextStyle(
      //             fontSize: 20,
      //             color: AppColors.appText,
      //             fontWeight: FontWeight.w700)),
      //   ),
      //   elevation: 1,
      //
      // ),
      body: SafeArea(
        child: Column(
          children: [
            AppbarTitleWidget(title: "Notification",flag: false,),
            Expanded(
              child: Container(
                color: AppColors.ratingText,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "TODAY",
                        style: GoogleFonts.inriaSans(
                            textStyle: const TextStyle(
                                fontSize: 16,
                                color: AppColors.appText,
                                fontWeight: FontWeight.w400)),
                      ),
                      SizedBox(height: 6,),

                      Container(

                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: const BorderRadius
                                  .all(
                              const Radius.circular(10)),
                          // border: Border.all(
                          //   width: 1,
                          //   color: AppColors
                          //       .bestSellingBorder,
                          //   // style: BorderStyle.solid,
                          // ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text(
                            "“BIG SALE” coming soon...",
                            style: GoogleFonts.inriaSans(
                                textStyle: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w400)),
                          )
                          ,
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0,bottom: 8.0,right: 40,left: 40),
                              child: Image.asset(
                                'assets/img/bigsale.png',
                                fit: BoxFit.fill,
                                height: 130,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),

                            Text(
                              "2 Hours ago",
                              style: GoogleFonts.inriaSans(
                                  textStyle: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.appText1,
                                      fontWeight: FontWeight.w400)),
                            )

                          ],),
                        ),
                        width: MediaQuery.of(context).size.width,
                      ),
                      SizedBox(height: 16,),
                      Text(
                        "YESTERDAY",
                        style: GoogleFonts.inriaSans(
                            textStyle: const TextStyle(
                                fontSize: 16,
                                color: AppColors.appText,
                                fontWeight: FontWeight.w400)),
                      ),
                      SizedBox(height: 6,),
                      Container(

                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: const BorderRadius
                              .all(
                              const Radius.circular(10)),
                          // border: Border.all(
                          //   width: 1,
                          //   color: AppColors
                          //       .bestSellingBorder,
                          //   // style: BorderStyle.solid,
                          // ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(

                            children: [
                              Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: const BorderRadius
                                        .all(
                                        const Radius.circular(100)),

                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(7.0),
                                    child: Image.asset(
                                      'assets/img/Selected_Shape.png',

                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 15,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Best selling kurta Sets from GlobalDesi  \nat lowest prices. Avail 10% instant \ndiscount* on HDFC Cards only till \n1st October",
                                    style: GoogleFonts.inriaSans(
                                        textStyle: const TextStyle(
                                            fontSize: 14,
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w400)),
                                  )
                                  ,
                                  SizedBox(height: 5,),

                                  Text(
                                    "2 Hours ago",
                                    style: GoogleFonts.inriaSans(
                                        textStyle: const TextStyle(
                                            fontSize: 12,
                                            color: AppColors.appText1,
                                            fontWeight: FontWeight.w400)),
                                  )

                                ],),

                            ],
                          ),
                        ),
                        width: MediaQuery.of(context).size.width,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
