import 'package:eshoperapp/config/theme.dart';
import 'package:eshoperapp/models/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/customer.dart';
import '../../profile/profile_controller.dart';

class AddToCard extends StatelessWidget {
  final VoidCallback? onChanged;
  final VoidCallback? addToWishList;
  final bool? wishList;
  AddToCard({this.onChanged,this.addToWishList, this.product,this.wishList });
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
      height: 77,
        color: AppColors.white,
      // decoration: BoxDecoration(
      //     color: Colors.white,
      //     border: Border.all(color: Colors.black.withOpacity(0.2))),
      child: Column(
        children: [
          Container(
            height: 1,width: MediaQuery.of(context).size.width,
            color: AppColors.toggleBg,
          ),
          Container(
            height: 76,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      addToWishList!();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0,right: 8.0,bottom: 16,top: 16),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(Radius.circular(2)),
                              border: Border.all(color: AppColors.toggleBg)),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                wishList == false?
                                Image.asset(
                                  "assets/img/heart.png",
                                  fit: BoxFit.fill,height: 18,width: 18,
                                ): Image.asset(
                                  "assets/img/Heart_WishList.png",
                                  fit: BoxFit.fill,height: 18,width: 18,
                                ),
                                SizedBox(width: 4,),
                                Text('WISHLIST',
                                    style: GoogleFonts.inriaSans(
                                        textStyle: const TextStyle(
                                            fontSize: 16,
                                            fontWeight:
                                            FontWeight
                                                .bold,
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
                      padding: const EdgeInsets.only(left: 8.0,right: 16.0,bottom: 16,top: 16),
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
                                  fit: BoxFit.fill,height: 20,width: 20,
                                ),
                                SizedBox(width: 4,),
                                Text('ADD TO BAG',
                                    style: GoogleFonts.inriaSans(
                                        textStyle: const TextStyle(
                                            fontSize: 16,
                                            fontWeight:
                                            FontWeight
                                                .bold,
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
