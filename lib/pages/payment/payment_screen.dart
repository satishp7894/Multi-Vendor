import 'package:eshoperapp/pages/payment/payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/theme.dart';
import '../../utils/snackbar_dialog.dart';
import '../../widgets/app_bar_title.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  final paymentController = Get.put(PaymentController(
      apiRepositoryInterface: Get.find(),
      localRepositoryInterface: Get.find()));

  String? paymentType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: AppColors.ratingText,
      // appBar: AppBar(
      //   backgroundColor: AppColors.white,
      //   leading: Image.asset(
      //     'assets/img/arrow_left.png',
      //     color: AppColors.appText,
      //   ),
      //   title: Text(
      //     "PAYMENT",
      //     style: GoogleFonts.inriaSans(
      //         textStyle: const TextStyle(
      //             fontSize: 20,
      //             color: AppColors.appText,
      //             fontWeight: FontWeight.w700)),
      //   ),
      //   elevation: 1,
      // ),

      body: SafeArea(
        // height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            AppbarTitleWidget(title: "PAYMENT",flag: false,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16,),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                            "PAYMENT OPTIONS",
                            style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: AppColors.paymentOptionText))
                        ),
                      ),
                      SizedBox(height: 16,),
                      Container(

                        child: Column(


                          children: [

                          ...List.generate(
                              paymentController.paymentList.length,
                                  (index) {


                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 1.0),
                                  child: InkWell(
                                    onTap: () async {

                                      setState(() {
                                        paymentController.paymentList.forEach((element) => element.isSelected = false);
                                        paymentController.paymentList[index].isSelected = true;
                                        paymentType = paymentController.paymentList[index].text;
                                      });
                                    },
                                    child:

                                    Container(
                                      color: AppColors.white,
                                      child: Padding(
                                        padding:  EdgeInsets.only(left: 16.0, right: 16.0,top: 20.0,bottom: 20.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[

                                             Row(
                                               children: [
                                                 Image.asset(paymentController.paymentList[index].iconPath,fit: BoxFit.fill,height: 16,width: 25,),
                                                 SizedBox(width: 10,),
                                                 Text(paymentController.paymentList[index].text,
                                                     style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: AppColors.paymentOptionText))),
                                               ],
                                             ),
                                             paymentController.paymentList[index].isSelected ?Image.asset("assets/img/active.png",fit: BoxFit.fill,height: 18,width: 18,):Image.asset("assets/img/deactive.png",fit: BoxFit.fill,height: 18,width: 18,)
                                          ],
                                        ),
                                      ),
                                    )

                                    // Row(
                                    //   children: [
                                    //     Text(
                                    //         "${paymentController.paymentList[index].text}",
                                    //         style: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 15,color: AppColors.appText1))
                                    //     ),
                                    //     // Radio(
                                    //     //   value: index,
                                    //     //   groupValue: groupValue,
                                    //     //   onChanged: (value) async {
                                    //     //     setState(() {
                                    //     //       groupValue = int.parse(value.toString());
                                    //     //       //changeDeliveryAddress(widget.shippingAddressList![index].addressId!,int.parse(value!.toString()));
                                    //     //     });
                                    //     //     print("value value value $value");
                                    //     //     // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                    //     //     // sharedPreferences.setInt(AppConstants.prefAddressId!, int.parse(value.toString()));
                                    //     //     // print("value value value $value");
                                    //     //     // Get.back(result: value);
                                    //     //
                                    //     //
                                    //     //   },
                                    //     // )
                                    //   ],
                                    // ),
                                  ),
                                );
                              }



                          ),

                        ],),
                      ),

                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child:
                    // Container(
                    //   color: AppColors.white,
                    //
                    //   width: MediaQuery.of(context).size.width,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(15.0),
                    //     child: Container(
                    //       child: Column(
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //
                    //         children: [
                    //           Text("PRICE DETAILS(2 ITEMS)",
                    //               style: GoogleFonts.inriaSans(
                    //                   textStyle: const TextStyle(
                    //                       fontSize: 16,
                    //                       fontWeight: FontWeight.w700,
                    //                       color: AppColors.appText))),
                    //           SizedBox(height: 8,),
                    //           Container(
                    //             height: 1,
                    //             width: MediaQuery.of(context).size.width,
                    //             color: Colors.grey[200],
                    //           ),
                    //           SizedBox(height: 8,),
                    //           Row(
                    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               Text("Total MRP",
                    //                   style: GoogleFonts.inriaSans(
                    //                       textStyle: const TextStyle(
                    //                           fontSize: 14,
                    //                           fontWeight: FontWeight.w400,
                    //                           color: AppColors.black))),
                    //               Text("₹3,289",
                    //                   style: GoogleFonts.inriaSans(
                    //                       textStyle: const TextStyle(
                    //                           fontSize: 14,
                    //                           fontWeight: FontWeight.w400,
                    //                           color: AppColors.black))),
                    //             ],
                    //           ),
                    //           SizedBox(height: 8,),
                    //           Row(
                    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               Text("Discount on MRP",
                    //                   style: GoogleFonts.inriaSans(
                    //                       textStyle: const TextStyle(
                    //                           fontSize: 14,
                    //                           fontWeight: FontWeight.w400,
                    //                           color: AppColors.black))),
                    //               Text("-₹1,252",
                    //                   style: GoogleFonts.inriaSans(
                    //                       textStyle: const TextStyle(
                    //                           fontSize: 14,
                    //                           fontWeight: FontWeight.w400,
                    //                           color: AppColors.appGreen))),
                    //             ],
                    //           ),
                    //           SizedBox(height: 8,),
                    //           Row(
                    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               Text("Coupon Discount",
                    //                   style: GoogleFonts.inriaSans(
                    //                       textStyle: const TextStyle(
                    //                           fontSize: 14,
                    //                           fontWeight: FontWeight.w400,
                    //                           color: AppColors.black))),
                    //               Text("Apply Coupon",
                    //                   style: GoogleFonts.inriaSans(
                    //                       textStyle: const TextStyle(
                    //                           fontSize: 14,
                    //                           fontWeight: FontWeight.w400,
                    //                           color: AppColors.appRed))),
                    //             ],
                    //           ),
                    //           SizedBox(height: 8,),
                    //           Row(
                    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               Row(
                    //                 children: [
                    //                   Text("Convenience Fee",
                    //                       style: GoogleFonts.inriaSans(
                    //                           textStyle: const TextStyle(
                    //                               fontSize: 14,
                    //                               fontWeight: FontWeight.w400,
                    //                               color: AppColors.black))),
                    //                   Text(" Know More",
                    //                       style: GoogleFonts.inriaSans(
                    //                           textStyle: const TextStyle(
                    //                               fontSize: 14,
                    //                               fontWeight: FontWeight.w400,
                    //                               color: AppColors.appRed))),
                    //                 ],
                    //               ),
                    //               Row(
                    //                 children: [
                    //                   Text("₹99",
                    //                       style: GoogleFonts.inriaSans(
                    //                           textStyle: TextStyle(
                    //                               fontSize: 14,
                    //                               decoration:
                    //                               TextDecoration
                    //                                   .combine([
                    //                                 TextDecoration
                    //                                     .lineThrough
                    //                               ]),
                    //                               fontWeight:
                    //                               FontWeight.w400,
                    //                               color: AppColors
                    //                                   .black))),
                    //                   SizedBox(width: 5.0,),
                    //                   Text("FREE",
                    //                       style: GoogleFonts.inriaSans(
                    //                           textStyle: const TextStyle(
                    //                               fontSize: 14,
                    //                               fontWeight: FontWeight.w400,
                    //                               color: AppColors.appRed))),
                    //                 ],
                    //               ),
                    //             ],
                    //           ),
                    //           SizedBox(height: 8,),
                    //           Container(
                    //             height: 1,
                    //             width: MediaQuery.of(context).size.width,
                    //             color: Colors.grey[200],
                    //           ),
                    //           SizedBox(height: 8,),
                    //           Row(
                    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               Text("Total Amount",
                    //                   style: GoogleFonts.inriaSans(
                    //                       textStyle: const TextStyle(
                    //                           fontSize: 14,
                    //                           fontWeight: FontWeight.w700,
                    //                           color: AppColors.black))),
                    //               Text("₹2,039",
                    //                   style: GoogleFonts.inriaSans(
                    //                       textStyle: const TextStyle(
                    //                           fontSize: 14,
                    //                           fontWeight: FontWeight.w700,
                    //                           color: AppColors.black))),
                    //             ],
                    //           ),
                    //         ],),
                    //     ),
                    //   ),
                    // ),
                    Container(
                      color: AppColors.white,

                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text("PRICE DETAILS(2 ITEMS)",
                                  style: GoogleFonts.inriaSans(
                                      textStyle: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.black))),
                              SizedBox(height: 8,),
                              Container(
                                height: 1,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.grey[200],
                              ),
                              SizedBox(height: 8,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Total MRP",
                                      style: GoogleFonts.inriaSans(
                                          textStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.black))),
                                  Text("₹3,289",
                                      style: GoogleFonts.inriaSans(
                                          textStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.black))),
                                ],
                              ),
                              SizedBox(height: 8,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Discount on MRP",
                                      style: GoogleFonts.inriaSans(
                                          textStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.black))),
                                  Text("-₹1,252",
                                      style: GoogleFonts.inriaSans(
                                          textStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.appGreen))),
                                ],
                              ),
                              SizedBox(height: 8,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Coupon Discount",
                                      style: GoogleFonts.inriaSans(
                                          textStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.black))),
                                  Text("Apply Coupon",
                                      style: GoogleFonts.inriaSans(
                                          textStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.appRed))),
                                ],
                              ),
                              SizedBox(height: 8,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text("Convenience Fee",
                                          style: GoogleFonts.inriaSans(
                                              textStyle: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.black))),
                                      Text(" Know More",
                                          style: GoogleFonts.inriaSans(
                                              textStyle: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.appRed))),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("₹99",
                                          style: GoogleFonts.inriaSans(
                                              textStyle: TextStyle(
                                                  fontSize: 12,
                                                  decoration:
                                                  TextDecoration
                                                      .combine([
                                                    TextDecoration
                                                        .lineThrough
                                                  ]),
                                                  fontWeight:
                                                  FontWeight.w400,
                                                  color: AppColors
                                                      .black))),
                                      SizedBox(width: 5.0,),
                                      Text("FREE",
                                          style: GoogleFonts.inriaSans(
                                              textStyle: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.appRed))),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 8,),
                              Container(
                                height: 1,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.grey[200],
                              ),
                              SizedBox(height: 8,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Total Amount",
                                      style: GoogleFonts.inriaSans(
                                          textStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.black))),
                                  Text("₹2,039",
                                      style: GoogleFonts.inriaSans(
                                          textStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.black))),
                                ],
                              ),
                            ],),
                        ),
                      ),
                    )
                  )
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Wrap(
        children: [
          Container(

            width: MediaQuery.of(context).size.width,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border(
                top: BorderSide(width: 1, color: AppColors.tileLine),
              ),
            ),
            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0,bottom: 8.0,left: 20.0,right: 20.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: AppColors.appRed,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8.0,
                        top: 8.0,
                      ),
                      child: Text(
                        "CONTINUE",
                        style: GoogleFonts.inriaSans(
                          textStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                        // style: const TextStyle(
                        //     fontSize: 23,
                        //     fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () {
                // Get.toNamed(Routes.payment);
                // openCheckout();
                          if(paymentType == null){
                            // AlertDialogs.showSimpleDialog("Payment Type","Please select payment type");
                            // Get.snackbar('Payment Type',"Please select payment type" ,duration: const Duration(seconds: 8), snackPosition: SnackPosition.BOTTOM,);
                            SnackBarDialog.showSnackbar('Payment Type','Please select payment option');
                          }else if(paymentType == "Cash On Delivery"){
                            // homeController.placeOrder(paymentType!);
                            SnackBarDialog.showSnackbar('Payment Type','Cash On Delivery');
                          }else{
                            paymentController.openCheckout();
                          }
              },
            ),
          ),
        ],
      ),
    );
  }
}
