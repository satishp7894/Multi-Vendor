import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/theme.dart';
import '../../routes/navigation.dart';
import '../../widgets/app_bar_title.dart';


class SavedCardScreen extends StatefulWidget {
  const SavedCardScreen({Key? key}) : super(key: key);

  @override
  State<SavedCardScreen> createState() => _SavedCardScreenState();
}

class _SavedCardScreenState extends State<SavedCardScreen> {

  int? groupValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   leading: Image.asset(
      //     'assets/img/arrow_left.png',
      //     color: AppColors.appText,
      //   ),
      //   title: Text(
      //     "SAVED CARDS",
      //     style: GoogleFonts.inriaSans(
      //         textStyle: const TextStyle(
      //             fontSize: 20,
      //             color: AppColors.appText,
      //             fontWeight: FontWeight.w700)),
      //   ),
      //   elevation: 1,
      // ),

      body:


      // Empty Cards



      // SafeArea(
      //   child: Column(
      //     children: [
      //       AppbarTitleWidget(title: "SAVED CARDS",flag: false,),
      //       Expanded(
      //         child: Center(
      //           child:
      //           Column(
      //
      //             children: [
      //             SizedBox(height: 10,),
      //             Image.asset(
      //               'assets/img/saved_cards.png',
      //               fit: BoxFit.fill,
      //               width: 217,
      //               height: 163,
      //             ),
      //             SizedBox(height: 10,),
      //             Text(
      //               "SAVE YOUR CREDIT/DEBIT CARDS",
      //               style: GoogleFonts.inriaSans(
      //                   textStyle: const TextStyle(
      //                       fontSize: 18,
      //                       color: AppColors.appText,
      //                       fontWeight: FontWeight.w700)),
      //             ),
      //             SizedBox(height: 16,),
      //             Text(
      //
      //               "It’s convenient to pay with saved cards. \nYour card information will be secure.",
      //               textAlign: TextAlign.center,
      //               style: GoogleFonts.inriaSans(
      //
      //                   textStyle: const TextStyle(
      //
      //                       fontSize: 12,
      //                       color: AppColors.appText1,
      //                       fontWeight: FontWeight.w700)),
      //             ),
      //               SizedBox(height: 16,),
      //               InkWell(
      //                 onTap: (){
      //                   Get.toNamed(Routes.addCards);
      //                 },
      //                 child: Container(
      //                   width: 135,
      //                     height: 42,
      //                     decoration: BoxDecoration(
      //                         color: Colors.white,
      //                         borderRadius: const BorderRadius.all(Radius.circular(10)),
      //                         border: Border.all(color:  AppColors.savedCardBorder)),
      //                     child: Padding(
      //                       padding: const EdgeInsets.all(8.0),
      //                       child: Center(
      //                         child: Text('ADD CARD',
      //                             style: GoogleFonts.inriaSans(
      //                                 textStyle: const TextStyle(
      //                                     fontSize: 16,
      //                                     fontWeight:
      //                                     FontWeight
      //                                         .w700,
      //                                     color: AppColors
      //                                         .appRed))),
      //                       ),
      //                     )),
      //               ),
      //           ],),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),


      SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              AppbarTitleWidget(title: "SAVED CARDS",flag: false,),
              Expanded(
                child: ListView.builder(

                    itemCount: 3,
                    itemBuilder: (BuildContext c,int index){

                      if(groupValue == index){
                        return Padding(
                          padding:  index == 0 ?const EdgeInsets.all(16.0):const EdgeInsets.only(left: 16.0,bottom: 16,right: 16),
                          child: InkWell(
                            onTap: (){

                              setState(() {
                                groupValue = int.parse(index.toString());
                              });

                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(5)
                                ),
                                border: Border.all(
                                  width: 1,
                                  color: AppColors.appRed,
                                  // style: BorderStyle.solid,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0,bottom: 8.0,right: 11),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        // Radio(
                                        //   value: index,
                                        //   groupValue:  groupValue,
                                        //   onChanged: (value) async {
                                        //     setState(() {
                                        //       //shippingAddressController!.addressTypeTextController!.text = value.toString();
                                        //       // groupValue = int.parse(value!.toString());
                                        //     });
                                        //     print("value value value $value");
                                        //     // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                        //     // sharedPreferences.setInt(AppConstants.prefAddressId!, int.parse(value.toString()));
                                        //     // print("value value value $value");
                                        //     // Get.back(result: value);
                                        //
                                        //
                                        //   },
                                        //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        // ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10.0,right: 8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border:
                                              Border.all(color: AppColors.appRed, width: 1),
                                              color: AppColors.white,
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(
                                                      100.0) //                 <--- border radius here
                                              ),
                                              // boxShadow: const [
                                              //   BoxShadow(
                                              //     color: Colors.black26,
                                              //     blurRadius: 10,
                                              //     offset:
                                              //     Offset(4, 8), // Shadow position
                                              //   ),
                                              // ],
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(1.5),
                                              child: Container(
                                               height: 13,width: 13,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppColors.appRed,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        Image.asset("assets/img/visa.png",fit: BoxFit.fill,height: 32,width: 56,)
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text("**** **** **** 1111",style: CustomTextStyle.cardNumber,),
                                        Text("VISA",style: CustomTextStyle.cardNumber,)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }else{
                        return Padding(
                          padding:  index == 0 ?const EdgeInsets.all(16.0):const EdgeInsets.only(left: 16.0,bottom: 16,right: 16),
                          child: InkWell(
                            onTap: (){

                              setState(() {
                                groupValue = int.parse(index.toString());
                              });

                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(5)
                                ),
                                border: Border.all(
                                  width: 1,
                                  color: AppColors.bestSellingBorder,
                                  // style: BorderStyle.solid,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0,bottom: 8.0,right: 11),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        // Radio(
                                        //   value: index,
                                        //   groupValue:  groupValue,
                                        //   onChanged: (value) async {
                                        //     setState(() {
                                        //       //shippingAddressController!.addressTypeTextController!.text = value.toString();
                                        //       // groupValue = int.parse(value!.toString());
                                        //     });
                                        //     print("value value value $value");
                                        //     // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                        //     // sharedPreferences.setInt(AppConstants.prefAddressId!, int.parse(value.toString()));
                                        //     // print("value value value $value");
                                        //     // Get.back(result: value);
                                        //
                                        //
                                        //   },
                                        //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        // ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10.0,right: 8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border:
                                              Border.all(color: AppColors.bestSellingBorder, width: 1),
                                              color: AppColors.white,
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(
                                                      100.0) //                 <--- border radius here
                                              ),
                                              // boxShadow: const [
                                              //   BoxShadow(
                                              //     color: Colors.black26,
                                              //     blurRadius: 10,
                                              //     offset:
                                              //     Offset(4, 8), // Shadow position
                                              //   ),
                                              // ],
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(1.5),
                                              child: Container(
                                                height: 13,width: 13,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppColors.bestSellingBorder,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Image.asset("assets/img/visa.png",fit: BoxFit.fill,height: 32,width: 56,)
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text("**** **** **** 1111",style: CustomTextStyle.cardNumber,),
                                        Text("VISA",style: CustomTextStyle.cardNumber,)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }


                }),
              ),
            ],
          ),
        ),
      ),


      bottomNavigationBar: Wrap(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 60,

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
                        "SAVE",
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
                // if (_formKey.currentState!.validate()) {
                //   print("_formKey true");
                // } else {
                //   print("_formKey false");
                //   // create();
                // }
                // openCheckout();

                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(

                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(0.0)),
                       //this right here
                        child: Container(
                          height: 85,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(child: Center(child: Text("Are you sure you want to Logout?",style: GoogleFonts.inriaSans(textStyle: TextStyle(color: AppColors.black,fontWeight: FontWeight.w400,fontSize: 16))))),
                                  Icon(Icons.close,color: AppColors.black,)

                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                child: Container(height: 1,width: MediaQuery.of(context).size.width,color: AppColors.appLine,),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0,bottom: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(

                                      child: Text("NO",style: GoogleFonts.inriaSans(textStyle: TextStyle(color: AppColors.appLine,fontWeight: FontWeight.w700,fontSize: 14))),

                                       ),
                                    Container(height: 22,width: 1.5,color: AppColors.appLine,),
                                    InkWell(
                                      child: Text("YES",style: GoogleFonts.inriaSans(textStyle: TextStyle(color: AppColors.appRed,fontWeight: FontWeight.w700,fontSize: 14)),
                                      ),
                                      onTap: (){

                                      },
                                    )
                                  ],),
                              )
                            ],
                          ),
                        ),
                      );
                    });

              },
            ),
          ),
        ],
      ),

    );
  }
}
