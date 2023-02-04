import 'package:eshoperapp/models/order_histrory_model.dart';
import 'package:eshoperapp/pages/landing_home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../config/theme.dart';
import '../../constants/app_costants.dart';
import '../../models/main_response.dart';
import '../../routes/navigation.dart';
import '../../widgets/app_bar_title.dart';
import 'myorder_controller.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  final myOrderController = Get.find<MyOrderController>();
  final homeController = Get.find<HomeController>();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ratingText,
    //     appBar: AppBar(
    //   backgroundColor: Colors.white,
    //   leading: Image.asset(
    //     'assets/img/arrow_left.png',
    //     color: AppColors.appText,
    //   ),
    //   title: Text(
    //     "ORDERS",
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
          AppbarTitleWidget(title: "ORDERS",flag: false,),
          Expanded(
            child: ListView(
                children: [
                  SizedBox(height: 16,),
                  Container(
                    color: AppColors.white,
                    height: 72,
                    child: Center(
                      child: Container(
                        height: 40,
                        child: Row(
                          children: [
                            Flexible(
                              flex: 6,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16.0,right: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: const BorderRadius.all(Radius.circular(2)),
                                    border: Border.all(color: AppColors.toggleBg,)
                                  ),

                                  height: 40,
                                  // color: AppColors.appText,
                                  child:
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/img/search.png',fit: BoxFit.fill,height: 12,width: 12,
                                        ),
                                        SizedBox(width: 10,),
                                        // Text('Search In Orders',style: GoogleFonts.inriaSans(textStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,color: AppColors.appLine)),),
                                        Expanded(
                                          child: TextFormField(
                                            // onFieldSubmitted: (val){
                                            //   print("onFieldSubmitted");
                                            //   myOrderController.searchInOrder(homeController.customerId.value,val);
                                            // },
                                            textInputAction: TextInputAction.done,
                                            cursorColor: AppColors.appText1,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.fromLTRB(0,0,0,10),
                                              hintText: 'Search for brands & Products',
                                              // labelText: 'Search for brands & Products',
                                              // border: OutlineInputBorder(),
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                            ),
                                            style:  GoogleFonts.inriaSans(
                                                textStyle:
                                                const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                    FontWeight
                                                        .w400,
                                                    color: AppColors
                                                        .black)),
                                            onChanged: (val){
                                              // setState(() {
                                                print("text  ${val}");
                                                print("onFieldSubmitted");
                                                myOrderController.searchKeyword(val.toString());
                                                myOrderController.searchInOrder(homeController.customerId.value,val,myOrderController.groupValueStatus.value,myOrderController.groupValueTime.value);
                                              // });
                                            },
                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                           Obx(() => Flexible(
                             flex: 4,
                             child: InkWell(
                               onTap: (){
                                 // myOrderController.groupValueStatus("All");
                                 // myOrderController.groupValueTime("Anytime");
                                 showModalBottomSheet(
                                   isDismissible : false,
                                   isScrollControlled:true,
                                   enableDrag :false,
                                   // context and builder are
                                   // required properties in this widget

                                   context: context,
                                   builder: (BuildContext context) {

                                     // we set up a container inside which
                                     // we create center column and display text

                                     // Returning SizedBox instead of a Container
                                     return Wrap(
                                       children: [
                                         Padding(
                                           padding: const EdgeInsets.only(left: 16.0,top: 16.0,right: 16.0,bottom: 16.0),
                                           child: Column(

                                             children:  [

                                               Row(
                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                 children: [
                                                   Text('Filters Orders',  style: GoogleFonts.inriaSans(
                                                       textStyle: const TextStyle(
                                                           fontSize: 18,
                                                           color: AppColors.black,
                                                           fontWeight: FontWeight.bold)),),
                                                   InkWell(
                                                       onTap: (){
                                                         Get.back();
                                                       },
                                                       child: Image.asset("assets/img/close.png",fit: BoxFit.fill,height: 13,width: 13,))
                                                 ],
                                               ),
                                               SizedBox(height: 20,),
                                               Text('Status',  style: GoogleFonts.inriaSans(
                                                   textStyle: const TextStyle(
                                                       fontSize: 14,
                                                       color: AppColors.black,
                                                       fontWeight: FontWeight.w700)),),

                                               Obx(() => Column(children: [
                                                 ...List.generate(
                                                     myOrderController.statusList.length,
                                                         (index) {


                                                       return InkWell(

                                                         child: Padding(
                                                           padding: index == 0 ? const EdgeInsets.only(bottom: 16.0,top: 16.0):const EdgeInsets.only(bottom: 16.0),
                                                           child: Row(
                                                             children: [

                                                               Container(
                                                                 width: 20,
                                                                 height: 20,
                                                                 child: Radio(

                                                                   value: myOrderController.statusList[index],
                                                                   groupValue: myOrderController.statusValue.value,
                                                                   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                   onChanged: (value)  {
                                                                     print("value value value $value");
                                                                     myOrderController.statusValue(value!.toString());
                                                                   },
                                                                 ),
                                                               ),
                                                               SizedBox(width: 12,),
                                                               Text(myOrderController.statusList[index],  style: GoogleFonts.inriaSans(
                                                                   textStyle: const TextStyle(
                                                                       fontSize: 14,
                                                                       color: AppColors.black,
                                                                       fontWeight: FontWeight.w400)),),

                                                             ],
                                                           ),
                                                         ),
                                                         onTap: (){
                                                           myOrderController.statusValue(myOrderController.statusList[index].toString());
                                                         },
                                                       );
                                                     }



                                                 )
                                               ],)),
                                               SizedBox(height: 14,),
                                               Container(
                                                 height: 1,width: MediaQuery.of(context).size.width,
                                                 color: AppColors.filterLine,
                                               ),
                                               SizedBox(height: 24,),
                                               Text('Time',  style: GoogleFonts.inriaSans(
                                                   textStyle: const TextStyle(
                                                       fontSize: 14,
                                                       color: AppColors.black,
                                                       fontWeight: FontWeight.w700)),),

                                               Obx(() =>
                                                   Column(children: [
                                                 ...List.generate(
                                                     myOrderController.timeList.length,
                                                         (index) {


                                                       return InkWell(
                                                         onTap: (){
                                                           myOrderController.timeValue( myOrderController.timeList[index].toString());
                                                         },
                                                         child: Padding(
                                                           padding: index == 0 ? const EdgeInsets.only(bottom: 16.0,top: 16.0):const EdgeInsets.only(bottom: 16.0),
                                                           child: Row(
                                                             children: [

                                                               Container(
                                                                 width: 20,
                                                                 height: 20,
                                                                 child: Radio(

                                                                   value: myOrderController.timeList[index],
                                                                   groupValue:myOrderController.timeValue.value,
                                                                   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                   onChanged: (value)  {
                                                                     print("value value value $value");
                                                                     myOrderController.timeValue(value!.toString());
                                                                   },
                                                                 ),
                                                               ),
                                                               SizedBox(width: 12,),
                                                               Text(myOrderController.timeList[index],  style: GoogleFonts.inriaSans(
                                                                   textStyle: const TextStyle(
                                                                       fontSize: 14,
                                                                       color: AppColors.black,
                                                                       fontWeight: FontWeight.w400)),),



                                                             ],
                                                           ),
                                                         ),
                                                       );
                                                     }



                                                 )
                                               ],)),
                                               SizedBox(height: 14,),
                                               Container(
                                                 height: 1,width: MediaQuery.of(context).size.width,
                                                 color: AppColors.filterLine,
                                               ),
                                               SizedBox(height: 24,),
                                               Container(
                                                 // height: 33,
                                                 child: Row(
                                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                   children: [
                                                     Expanded(
                                                       child: InkWell(
                                                         onTap: () {
                                                           // onChanged!();
                                                           myOrderController.groupValueStatus("All");
                                                           myOrderController.groupValueTime("Anytime");
                                                           myOrderController.statusValue("All");
                                                           myOrderController.timeValue("Anytime");
                                                           myOrderController.searchInOrder(homeController.customerId.value,myOrderController.searchKeyword.value,
                                                               "All",
                                                               "Anytime");
                                                           Get.back();
                                                         },
                                                         child:
                                                         Padding(
                                                           padding: const EdgeInsets.only(left: 0.0,right: 10.0,bottom: 0,top: 0),
                                                           child: Container(

                                                             decoration: BoxDecoration(
                                                                 color: Colors.white,
                                                                 borderRadius: const BorderRadius.all(Radius.circular(2)),
                                                                 border: Border.all(color: Colors.black.withOpacity(0.2))),

                                                             child: Center(
                                                               child: Text('CLEAR FILTER',
                                                                   style: GoogleFonts.inriaSans(
                                                                       textStyle: const TextStyle(
                                                                           fontSize: 16,
                                                                           fontWeight:
                                                                           FontWeight
                                                                               .bold,
                                                                           color: AppColors
                                                                               .black))),
                                                             ),height: 38,),
                                                         ),
                                                       ),
                                                     ),
                                                     Expanded(
                                                       child:



                                                       InkWell(
                                                         onTap: () {
                                                           // onChanged!();
                                                           print("customerId =======> ${homeController.customerId.value}");
                                                           print("searchKeyword =======> ${myOrderController.searchKeyword.value}");
                                                           print("groupValueStatus =======> ${myOrderController.statusValue.value}");
                                                           print("groupValueTime =======> ${myOrderController.timeValue.value}");
                                                           myOrderController.groupValueStatus(myOrderController.statusValue.value);
                                                           myOrderController.groupValueTime(myOrderController.timeValue.value);
                                                           myOrderController.searchInOrder(homeController.customerId.value,myOrderController.searchKeyword.value,
                                                               myOrderController.statusValue.value,
                                                               myOrderController.timeValue.value);
                                                           Get.back();
                                                         },
                                                         child: Padding(
                                                           padding: const EdgeInsets.only(left: 10.0,right: 0.0,bottom: 0,top: 0),
                                                           child: Container(
                                                               decoration: BoxDecoration(
                                                                 color: Colors.redAccent,
                                                                 borderRadius: const BorderRadius.all(Radius.circular(2)),
                                                               ),
                                                               child: Center(
                                                                 child: Text('APPLY',
                                                                     style: GoogleFonts.inriaSans(
                                                                         textStyle: const TextStyle(
                                                                             fontSize: 16,
                                                                             fontWeight:
                                                                             FontWeight
                                                                                 .bold,
                                                                             color: AppColors
                                                                                 .white))),
                                                               ),height: 38),
                                                         ),
                                                       ),
                                                     )
                                                   ],
                                                 ),
                                               ),
                                             ],
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                           ),
                                         ),
                                       ],
                                     );
                                   },
                                 );

                               },
                               child: Padding(
                                 padding: const EdgeInsets.only(left: 8.0,right: 14),
                                 child: Container(
                                   height: 60,
                                   decoration: BoxDecoration(
                                       color: AppColors.white,
                                       borderRadius: const BorderRadius.all(Radius.circular(2)),
                                       border: Border.all(color: AppColors.toggleBg,)
                                   ),
                                   child: Padding(
                                     padding: const EdgeInsets.only(left: 16.0),
                                     child:


                                     Row(
                                       // mainAxisAlignment: MainAxisAlignment.center,
                                       children: [
                                         Image.asset(
                                           'assets/img/filter.png',fit: BoxFit.fill,height: 24,width: 24,
                                         ),
                                         SizedBox(width: 16,),
                                         Text('FILTERS',style: GoogleFonts.inriaSans(textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: AppColors.appLine)),),
                                         SizedBox(width: 5,),
                                         myOrderController.groupValueStatus.value == "All" && myOrderController.groupValueTime.value == "Anytime"?Container()
                                             :Container(
                                           height: 10,width: 10,
                                           decoration: BoxDecoration(
                                               shape: BoxShape.circle,
                                               color: AppColors.appColor
                                           ),)
                                       ],
                                     ),
                                   ),
                                 ),
                               ),
                             ),
                           ))



                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16,),

                  Obx(() {

                    if (myOrderController.isLoadingGetOrderHistory.value == true) {
                      MainResponse? mainResponse = myOrderController.getOrderHistoryObj.value;
                      List<OrderHistoryModel>? orderHistoryProcessingData = [];
                      List<OrderHistoryModel>? orderHistoryDeliveredData = [];
                      if(mainResponse.data != null){
                        for(int i=0;i<mainResponse.data!.length;i++){
                          if(mainResponse.data![i]['deliver_date']==null){
                            orderHistoryProcessingData.add( OrderHistoryModel.fromJson(mainResponse.data![i]));
                          }else{
                            orderHistoryDeliveredData.add( OrderHistoryModel.fromJson(mainResponse.data![i]));
                          }
                        }

                      }
                      // mainResponse.data!.map((e) => customerProfileData!.add(UpdateCustomerPasswordData.fromJson(e))).toList();

                      // shippingAddressDataOther = shippingAddressData.removeAt(0) as List<ShippingAddress>?;
                      String? imageUrl = mainResponse.imageUrl ?? "";
                      String? message = mainResponse.message ?? AppConstants.noInternetConn;
                      if (orderHistoryProcessingData.isEmpty && orderHistoryDeliveredData.isEmpty) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: ListView(
                            // physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height-200,
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
                      }else{
                        return Column(children: [
                          orderHistoryProcessingData.isNotEmpty?
                          Container(
                            color: AppColors.white,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
                              child: Column(
                                children: [
                                  Row(children: [
                                    Image.asset("assets/img/box.png", fit: BoxFit.fill,height: 30,width: 30,),
                                    SizedBox(width: 8,),
                                    Column(

                                      crossAxisAlignment:CrossAxisAlignment.start,children: [
                                      Text(
                                        "Processing",
                                        style: GoogleFonts.inriaSans(
                                            textStyle: const TextStyle(
                                                fontSize: 14,
                                                color: AppColors.appRed,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      // SizedBox(width: 5,),
                                      // Text(
                                      //   "Expected on 1 Oct 2022",
                                      //   style: GoogleFonts.inriaSans(
                                      //       textStyle: const TextStyle(
                                      //           fontSize: 14,
                                      //           color: AppColors.appText1,
                                      //           fontWeight: FontWeight.bold)),
                                      // ),
                                    ],)
                                  ],),
                                  SizedBox(height: 16.0,),
                                  Column(children: orderHistoryProcessingData.map((processingObj) {
                                    final DateTime now = DateTime.parse(processingObj.orderDate!);
                                    final DateFormat formatter = DateFormat('dd MMM yyyy');
                                    final String dateValue = formatter.format(now);
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 16.0),
                                      child: Column(

                                        children: [
                                          InkWell(

                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: AppColors.ratingText,
                                                // border: Border.all(
                                                //     color: AppColors.appRed, width: 1),
                                                // color: Colors.grey[100],
                                                borderRadius: const BorderRadius.all(
                                                    Radius.circular(
                                                        2.0) //                 <--- border radius here
                                                ),
                                              ),
                                              child: Padding(
                                                padding:  EdgeInsets.all(4.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          child: ClipRRect(
                                                              borderRadius: BorderRadius.all(Radius.circular(2)),child: Image.network(imageUrl+processingObj.productId!+"/"+processingObj.coverImg!, fit: BoxFit.cover,height: 85,width: 85,)),
                                                          // color: Colors.red,
                                                        ),
                                                        SizedBox(width: 8,),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              "Ordered on $dateValue",
                                                              style: GoogleFonts.inriaSans(
                                                                  textStyle: const TextStyle(
                                                                      fontSize: 14,
                                                                      color: AppColors.appText1,
                                                                      fontWeight: FontWeight.bold)),
                                                            ),
                                                            Text(
                                                              processingObj.brandName!,
                                                              style: GoogleFonts.inriaSans(
                                                                  textStyle: const TextStyle(
                                                                      fontSize: 14,
                                                                      color: AppColors.black,
                                                                      fontWeight: FontWeight.w700)),
                                                            ),
                                                            Container(
                                                              width: 240,
                                                              child: Text(
                                                                processingObj.productName!,
                                                                maxLines: 1,
                                                                overflow:
                                                                TextOverflow.ellipsis,
                                                                style: GoogleFonts.inriaSans(
                                                                    textStyle: const TextStyle(
                                                                        fontSize: 14,
                                                                        color: AppColors.appText1,
                                                                        fontWeight: FontWeight.w300)),
                                                              ),
                                                            ),
                                                            // Text(
                                                            //   "Size: 38",
                                                            //   style: GoogleFonts.inriaSans(
                                                            //       textStyle: const TextStyle(
                                                            //           fontSize: 14,
                                                            //           color: AppColors.appText1,
                                                            //           fontWeight: FontWeight.w300)),
                                                            // ),
                                                          ],),

                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(right: 16.0),
                                                      child: Image.asset("assets/img/arrow_right.png",fit: BoxFit.fill,height: 12,width: 8,),
                                                    ),

                                                  ],),
                                              ),

                                            ),
                                            onTap: (){
                                              Get.toNamed(Routes.myOrderDetails,arguments: processingObj);
                                            },
                                          ),
                                          // SizedBox(height: 1,),
                                          // Container(
                                          //   color: AppColors.ratingText,
                                          //   height: 30,
                                          //   child: Padding(
                                          //     padding: const EdgeInsets.only(left: 16.0),
                                          //     child: Row(
                                          //       // mainAxisAlignment: MainAxisAlignment.center,
                                          //       children: [
                                          //         Container(
                                          //           height: 8,width: 8,decoration: BoxDecoration(shape: BoxShape.circle,color: AppColors.appText1,),
                                          //         ),
                                          //         SizedBox(width: 5,),
                                          //         Text(
                                          //           "Arrived at Surat on Tue, 27 Oct 2022 at 12:30 A.M.",
                                          //           style: GoogleFonts.inriaSans(
                                          //               textStyle: const TextStyle(
                                          //                   fontSize: 12,
                                          //                   color: AppColors.appText1,
                                          //                   fontWeight: FontWeight.w700)),
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    );
                                  }


                                      ).toList(),),
                                ],
                              ),
                            ),
                          ):Container(),
                          orderHistoryProcessingData.isNotEmpty?SizedBox(height: 16,):Container(),
                          orderHistoryDeliveredData.isNotEmpty?
                          Container(
                            color: AppColors.white,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
                              child: Column(
                                children: [
                                  Row(children: [
                                    Image.asset("assets/img/delivered.png", fit: BoxFit.fill,height: 30,width: 30,),
                                    SizedBox(width: 8,),
                                    Column(

                                      crossAxisAlignment:CrossAxisAlignment.start,children: [
                                      Text(
                                        "Delivered",
                                        style: GoogleFonts.inriaSans(
                                            textStyle: const TextStyle(
                                                fontSize: 14,
                                                color: AppColors.appGreen,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      // SizedBox(width: 5,),
                                      // Text(
                                      //   "Expected on 1 Oct 2022",
                                      //   style: GoogleFonts.inriaSans(
                                      //       textStyle: const TextStyle(
                                      //           fontSize: 14,
                                      //           color: AppColors.appText1,
                                      //           fontWeight: FontWeight.bold)),
                                      // ),
                                    ],)
                                  ],),
                                  SizedBox(height: 16.0,),
                                  Column(children: orderHistoryDeliveredData.map((deliveredObj) {
                                    final DateTime now = DateTime.parse(deliveredObj.deliverDate!);
                                    final DateFormat formatter = DateFormat('dd MMM yyyy');
                                    final String dateValue = formatter.format(now);
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 16.0),
                                      child: Column(

                                        children: [
                                          InkWell(

                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: AppColors.ratingText,
                                                // border: Border.all(
                                                //     color: AppColors.appRed, width: 1),
                                                // color: Colors.grey[100],
                                                borderRadius: const BorderRadius.all(
                                                    Radius.circular(
                                                        2.0) //                 <--- border radius here
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(

                                                          child: ClipRRect(
                                                              borderRadius: BorderRadius.all(Radius.circular(2)),child: Image.network(imageUrl+deliveredObj.productId!+"/"+deliveredObj.coverImg!, fit: BoxFit.cover,height: 85,width: 85,)),
                                                       // color: Colors.red,
                                                        ),
                                                        SizedBox(width: 8,),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              "Delivered on $dateValue",
                                                              style: GoogleFonts.inriaSans(
                                                                  textStyle: const TextStyle(
                                                                      fontSize: 14,
                                                                      color: AppColors.appText1,
                                                                      fontWeight: FontWeight.bold)),
                                                            ),
                                                            Text(
                                                              deliveredObj.brandName!,
                                                              style: GoogleFonts.inriaSans(
                                                                  textStyle: const TextStyle(
                                                                      fontSize: 14,
                                                                      color: AppColors.black,
                                                                      fontWeight: FontWeight.w700)),
                                                            ),
                                                            Container(
                                                              width: 240,
                                                              child: Text(
                                                                deliveredObj.productName!,
                                                                maxLines: 1,
                                                                overflow:
                                                                TextOverflow.ellipsis,
                                                                style: GoogleFonts.inriaSans(
                                                                    textStyle: const TextStyle(
                                                                        fontSize: 14,
                                                                        color: AppColors.appText1,
                                                                        fontWeight: FontWeight.w300)),
                                                              ),
                                                            ),
                                                            // Text(
                                                            //   "Size: 38",
                                                            //   style: GoogleFonts.inriaSans(
                                                            //       textStyle: const TextStyle(
                                                            //           fontSize: 14,
                                                            //           color: AppColors.appText1,
                                                            //           fontWeight: FontWeight.w300)),
                                                            // ),
                                                          ],),

                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(right: 16.0),
                                                      child: Image.asset("assets/img/arrow_right.png",fit: BoxFit.fill,height: 12,width: 8,),
                                                    ),

                                                  ],),
                                              ),

                                            ),
                                            onTap: (){
                                              Get.toNamed(Routes.myOrderDetails,arguments: deliveredObj);
                                            },
                                          ),
                                          // SizedBox(height: 1,),
                                          // Container(
                                          //   color: AppColors.ratingText,
                                          //   height: 30,
                                          //   child: Padding(
                                          //     padding: const EdgeInsets.only(left: 16.0),
                                          //     child: Row(
                                          //       // mainAxisAlignment: MainAxisAlignment.center,
                                          //       children: [
                                          //         Container(
                                          //           height: 8,width: 8,decoration: BoxDecoration(shape: BoxShape.circle,color: AppColors.appText1,),
                                          //         ),
                                          //         SizedBox(width: 5,),
                                          //         Text(
                                          //           "Arrived at Surat on Tue, 27 Oct 2022 at 12:30 A.M.",
                                          //           style: GoogleFonts.inriaSans(
                                          //               textStyle: const TextStyle(
                                          //                   fontSize: 12,
                                          //                   color: AppColors.appText1,
                                          //                   fontWeight: FontWeight.w700)),
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    );

                                  }).toList(),),
                                ],
                              ),
                            ),
                          ):Container(),
                        ],);
                      }

                    } else {
                      return  Container(
                        // height: 200,
                          child: Center(child: CircularProgressIndicator(color: AppColors.appColor)));

                    }
                  }),










                  // Padding(
                  //   padding: const EdgeInsets.only(right: 14.0,left: 14.0),
                  //   child: Row(children: [
                  //     Stack(
                  //       children: [
                  //         Image.asset("assets/img/box.png", fit: BoxFit.fill,height: 40,width: 40,),
                  //         Positioned(
                  //             bottom: 5,
                  //             right: 0,
                  //             child: Image.asset("assets/img/delivered.png", fit: BoxFit.fill,height: 12,width: 12,)),
                  //       ],
                  //     ),
                  //     SizedBox(width: 8,),
                  //     Column(
                  //
                  //       crossAxisAlignment:CrossAxisAlignment.start,children: [
                  //       Text(
                  //         "Delivered",
                  //         style: GoogleFonts.inriaSans(
                  //             textStyle: const TextStyle(
                  //                 fontSize: 16,
                  //                 color: AppColors.appGreen,
                  //                 fontWeight: FontWeight.w700)),
                  //       ),
                  //       SizedBox(width: 5,),
                  //       Text(
                  //         "Expected on 1 Oct 2022",
                  //         style: GoogleFonts.inriaSans(
                  //             textStyle: const TextStyle(
                  //                 fontSize: 16,
                  //                 color: AppColors.appText1,
                  //                 fontWeight: FontWeight.w700)),
                  //       ),
                  //     ],)
                  //   ],),
                  // ),
                  // SizedBox(height: 20,),
                  //
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 14.0,right: 14.0),
                  //   child: Column(children: myOrderController.list1.map((e) =>  Padding(
                  //     padding: const EdgeInsets.only(bottom: 20),
                  //     child: Column(
                  //
                  //       children: [
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Row(
                  //               children: [
                  //                 Image.asset("assets/img/product4.png", fit: BoxFit.fill,height: 100,width: 100,),
                  //                 SizedBox(width: 8,),
                  //                 Column(
                  //                   crossAxisAlignment: CrossAxisAlignment.start,
                  //                   children: [
                  //                     Text(
                  //                       "Roadster",
                  //                       style: GoogleFonts.inriaSans(
                  //                           textStyle: const TextStyle(
                  //                               fontSize: 18,
                  //                               color: AppColors.black,
                  //                               fontWeight: FontWeight.w700)),
                  //                     ),
                  //                     Text(
                  //                       "Men Green Casual Shirt",
                  //                       style: GoogleFonts.inriaSans(
                  //                           textStyle: const TextStyle(
                  //                               fontSize: 16,
                  //                               color: AppColors.appText1,
                  //                               fontWeight: FontWeight.w300)),
                  //                     ),
                  //                     Text(
                  //                       "Size: 38",
                  //                       style: GoogleFonts.inriaSans(
                  //                           textStyle: const TextStyle(
                  //                               fontSize: 16,
                  //                               color: AppColors.appText1,
                  //                               fontWeight: FontWeight.w300)),
                  //                     ),
                  //                   ],)
                  //               ],
                  //             ),
                  //             Image.asset("assets/img/arrow_right.png"),
                  //           ],),
                  //         SizedBox(height: 8,),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             Container(
                  //               height: 10,width: 10,decoration: BoxDecoration(shape: BoxShape.circle,color: AppColors.appText1,),
                  //             ),
                  //             SizedBox(width: 5,),
                  //             Text(
                  //               "Arrived at Surat on Tue, 27 Oct 2022 at 12:30 A.M.",
                  //               style: GoogleFonts.inriaSans(
                  //                   textStyle: const TextStyle(
                  //                       fontSize: 14,
                  //                       color: AppColors.appText1,
                  //                       fontWeight: FontWeight.w700)),
                  //             ),
                  //           ],
                  //         ),
                  //       ],
                  //     ),
                  //   ),).toList(),),
                  // )


                ],
            ),
          ),
        ],
      ),
    ),
    );
    // return SajiloDokanScaffold(
    //   leading: true,
    //   title: null,
    //   body:
    //
    //   SafeArea(
    //     child: Padding(
    //       padding: const EdgeInsets.all(12.0),
    //       child: Column(
    //         // physics: const NeverScrollableScrollPhysics(),
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               InkWell(
    //                   onTap: (){
    //                     Get.back();
    //                   },
    //                   child: Icon(Icons.arrow_back_ios,size: 25,)),
    //               Icon(Icons.search,size: 30,)
    //             ],),
    //           SizedBox(height: 12,),
    //           const Padding(
    //             padding: EdgeInsets.all(8.0),
    //             child: Text("My Orders",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
    //           ),
    //           SizedBox(height: 8,),
    //
    //         RefreshIndicator(
    //             onRefresh: () async {
    //               CheckInternet.checkInternet();
    //               await myOrderController.loadUser();
    //             },
    //             child: Obx(() {
    //               if (myOrderController.isLoadingGetOrderHistory.value != true) {
    //                 MainResponse? mainResponse = myOrderController.getOrderHistoryObj.value;
    //                 List<OrderHistory>? getOrderHistoryData = [];
    //                 if(mainResponse.data != null){
    //                   mainResponse.data!.forEach((v) {
    //                     getOrderHistoryData.add( OrderHistory.fromJson(v));
    //                   });
    //                 }
    //                 // mainResponse.data!.map((e) => customerProfileData!.add(UpdateCustomerPasswordData.fromJson(e))).toList();
    //
    //
    //                 String? imageUrl = mainResponse.imageUrl ?? "";
    //                 String? message = mainResponse.message ?? AppConstants.noInternetConn;
    //                 if (getOrderHistoryData.isEmpty) {
    //                   return Container(
    //                     width: MediaQuery.of(context).size.width,
    //                     height: MediaQuery.of(context).size.height-160,
    //                     child: ListView(
    //                       // physics: NeverScrollableScrollPhysics(),
    //                       shrinkWrap: true,
    //                       children: [
    //                         Container(
    //                           width: MediaQuery.of(context).size.width,
    //                           height: MediaQuery.of(context).size.height-260,
    //                           //height: MediaQuery.of(context).size.height,
    //                           alignment: Alignment.center,
    //                           child: Center(
    //                             child: Text(
    //                               message!,
    //                               style: TextStyle(color: Colors.black45),
    //                             ),
    //                           ),
    //                         ),
    //
    //                       ],
    //                     ),
    //                   );
    //                 }else{
    //
    //                   return   Container(
    //                     height: MediaQuery.of(context).size.height-160,
    //                     child: ListView(
    //                       children: [
    //
    //                         ...List.generate(getOrderHistoryData.length, (index) => MyOrderTile(orderHistory: getOrderHistoryData[index],index: index,imageUrl: imageUrl,))
    //                       ],
    //                     ),
    //                   );
    //
    //                 }
    //
    //               } else {
    //                 return  Container(
    //                     height: MediaQuery.of(context).size.height-160,
    //                     child: Center(child: CircularProgressIndicator(color: Style.Colors.appColor)));
    //
    //               }
    //             }),
    //           ),
    //
    //         ],
    //       ),
    //     ),
    //   ),
    //
    //
    //   searchOnTab: () {},
    // );
  }
}
