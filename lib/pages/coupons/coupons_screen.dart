import 'package:eshoperapp/models/coupon_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/theme.dart';
import '../../constants/app_costants.dart';
import '../../models/main_response.dart';
import '../../widgets/app_bar_title.dart';
import '../profile/profile_controller.dart';

class CouponsScreen extends StatefulWidget {
  const CouponsScreen({Key? key}) : super(key: key);

  @override
  State<CouponsScreen> createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> {
  final controller = Get.find<ProfileController>();

  @override
  void initState() {
    controller.getCouponList("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ratingText,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   leading: Image.asset(
      //     'assets/img/arrow_left.png',
      //     color: AppColors.appText,
      //   ),
      //   title: Text(
      //     "COUPONS",
      //     style: GoogleFonts.inriaSans(
      //         textStyle: const TextStyle(
      //             fontSize: 20,
      //             color: AppColors.appText,
      //             fontWeight: FontWeight.w700)),
      //   ),
      //   elevation: 1,
      // ),

      body: SafeArea(
        child: Column(
          children: [
            AppbarTitleWidget(
              title: "COUPONS",
              flag: false,
            ),
            Obx(() {
              if (controller.isLoadingCouponList.value != true) {
                MainResponse? mainResponse =
                    controller.getCouponListObj.value;
                List<CouponListModel>? getCouponListData = [];
                // print(
                //     "bestSellerProductObj.data! ${mainResponse.data!}");
                if (mainResponse.data != null) {
                  mainResponse.data!.forEach((v) {
                    getCouponListData.add(CouponListModel.fromJson(v));
                  });
                }
                // mainResponse.data!.map((e) => customerProfileData!.add(UpdateCustomerPasswordData.fromJson(e))).toList();

                String? imageUrl = mainResponse.imageUrl ?? "";
                String? message =
                    mainResponse.message ?? AppConstants.noInternetConn;

                if (getCouponListData.isEmpty) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height-100,
                    child: ListView(
                      // physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height-100,
                          //height: MediaQuery.of(context).size.height,
                          alignment: Alignment.center,
                          child: Center(
                            child: Text(
                              message!,
                              style: TextStyle(color: Colors.black45),
                            ),
                          ),
                        ),

                      ],
                    ),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                      itemCount: getCouponListData.length,
                      itemBuilder: (BuildContext c, int index) {
                        return Padding(
                          padding: index == 0
                              ? const EdgeInsets.only(
                                  bottom: 8.0,
                                  left: 16.0,
                                  right: 16.0,
                                  top: 16.0)
                              : const EdgeInsets.only(
                                  bottom: 8.0, left: 16.0, right: 16.0),
                          child: Container(
                            color: AppColors.white,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              right: BorderSide(
                                                  width: 1,
                                                  color:
                                                      AppColors.appText1))),
                                      child: Center(
                                        child: Text(
                                            // "20% \nOFF"
                                                "OFFER"
                                            ,
                                            style: GoogleFonts.inriaSans(
                                                textStyle: const TextStyle(
                                                    fontSize: 18,
                                                    color: AppColors
                                                        .appLightBlue,

                                                ))),
                                      ),
                                      height: 80,
                                      width: 100,
                                    ),
                                    // Container(color: AppColors.appText1,width: 1,height: 60,),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 8.0),
                                            child: Text(
                                                // "On minimum purchase of "
                                                getCouponListData[index].couponTitle!,
                                                style: GoogleFonts.inriaSans(
                                                    textStyle:
                                                        const TextStyle(
                                                            fontSize: 14,
                                                            color: AppColors
                                                                .appText1,

                                                            fontWeight:
                                                                FontWeight
                                                                    .w400)),maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text("Code: ",
                                                  style: GoogleFonts.inriaSans(
                                                      textStyle:
                                                          const TextStyle(
                                                              fontSize: 14,
                                                              color: AppColors
                                                                  .appText1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400))),
                                              Text(getCouponListData[index].couponCode!,
                                                  style: GoogleFonts.inriaSans(
                                                      textStyle:
                                                          const TextStyle(
                                                              fontSize: 16,
                                                              color: AppColors
                                                                  .black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400))),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  color: AppColors.appText1,
                                  width: MediaQuery.of(context).size.width,
                                  height: 1,
                                ),
                                // SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0,
                                      bottom: 8,
                                      left: 16,
                                      right: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              Text("Expiry: ",
                                                  style: GoogleFonts.inriaSans(
                                                      textStyle:
                                                          const TextStyle(
                                                              fontSize: 12,
                                                              color: AppColors
                                                                  .black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400))),
                                              Text(getCouponListData[index].expiryDate!,
                                                  style: GoogleFonts.inriaSans(
                                                      textStyle:
                                                          const TextStyle(
                                                              fontSize: 12,
                                                              color: AppColors
                                                                  .appText1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                            ],
                                          ),
                                          // SizedBox(
                                          //   width: 8,
                                          // ),
                                          // Container(
                                          //   color: AppColors.appText1,
                                          //   width: 1,
                                          //   height: 15,
                                          // ),
                                          // SizedBox(
                                          //   width: 8,
                                          // ),
                                          // Text("11:59:00 PM ",
                                          //     style: GoogleFonts.inriaSans(
                                          //         textStyle: const TextStyle(
                                          //             fontSize: 12,
                                          //             color: AppColors.black,
                                          //             fontWeight:
                                          //                 FontWeight.w400))),
                                        ],
                                      ),
                                      Text("Details",
                                          style: GoogleFonts.inriaSans(
                                              textStyle: const TextStyle(
                                                  fontSize: 14,
                                                  color: AppColors.appRed,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ],
                                  ),
                                ),
                                // SizedBox(height: 10,),
                              ],
                            ),
                          ),
                        );
                      });
                }
              } else {
                return SizedBox(
                    height: MediaQuery.of(context).size.height - 90 ,
                    child: const Center(
                        child: const CircularProgressIndicator(
                            color: AppColors.appColor)));
              }
            }),
          ],
        ),
      ),
    );
  }
}
