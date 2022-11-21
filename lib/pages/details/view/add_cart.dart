import 'package:eshoperapp/config/theme.dart';
import 'package:eshoperapp/models/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/customer.dart';
import '../../profile/profile_controller.dart';

class AddToCard extends StatelessWidget {
  final VoidCallback? onChanged;
  AddToCard({this.onChanged, this.product, });
  final Product? product;
  // final String? customerId;
  final profileController = Get.put(ProfileController(
      apiRepositoryInterface: Get.find(),
      customer: Customer(),
      localRepositoryInterface: Get.find()));
  @override
  Widget build(BuildContext context) {
    return
      Container(
      height: 70,
      // decoration: BoxDecoration(
      //     color: Colors.white,
      //     border: Border.all(color: Colors.black.withOpacity(0.2))),
      child: Column(
        children: [
          Container(
            height: 1,width: MediaQuery.of(context).size.width,
            color: Colors.black.withOpacity(0.2),
          ),
          Container(
            height: 69,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      onChanged!();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0,right: 5.0,bottom: 10,top: 10),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(Radius.circular(2)),
                              border: Border.all(color: Colors.black.withOpacity(0.2))),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/img/heart.png",
                                ),
                                SizedBox(width: 8,),
                                Text('WISHLIST',
                                    style: GoogleFonts.inriaSans(
                                        textStyle: const TextStyle(
                                            fontSize: 18,
                                            fontWeight:
                                            FontWeight
                                                .w700,
                                            color: AppColors
                                                .black))),
                              ],
                            ),
                          )),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      onChanged!();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0,right: 10.0,bottom: 10,top: 10),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: const BorderRadius.all(Radius.circular(2)),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/img/bag.png",color: AppColors.white,
                                ),
                                SizedBox(width: 8,),
                                Text('ADD TO BAG',
                                    style: GoogleFonts.inriaSans(
                                        textStyle: const TextStyle(
                                            fontSize: 18,
                                            fontWeight:
                                            FontWeight
                                                .w700,
                                            color: AppColors
                                                .white))),
                              ],
                            ),
                          )),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
