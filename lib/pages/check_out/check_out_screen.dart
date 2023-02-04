import 'package:eshoperapp/constants/app_costants.dart';
import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/style/theme.dart' as Style;
import 'package:eshoperapp/utils/check_internet.dart';
import 'package:eshoperapp/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../config/theme.dart';
import '../../models/carts.dart';
import '../../models/shipping_address.dart';
import '../../routes/navigation.dart';
import '../../utils/alert_dialog.dart';
import '../../utils/snackbar_dialog.dart';
import '../../widgets/app_bar_title.dart';
import '../landing_home/home_controller.dart';
import '../shipping_address/shippig_address_controller.dart';
import 'check_out_controller.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  ShippingAddressController? shippingAddressController;
  CheckOutController? checkOutController;
  final homeController = Get.find<HomeController>();

  // OrderHistory? orderHistory;
  List<Carts>? cartList;
  List<int>? productIdList;
  String? imagePath;
  // int? index;
  bool? isFlag = true;
  bool? isFlag1 = true;
  double totalPrice = 0.0;
  double totalDiscount = 0.0;
  double totalAmount = 0.0;

  static const platform = MethodChannel("razorpay_flutter");
  String? paymentType;

  @override
  void initState() {
    // cartList = Get.arguments
    dynamic argumentData = Get.arguments;
    cartList = argumentData[0]['cartList'];
    imagePath = argumentData[1]['imagePath'];
    productIdList = argumentData[2]['productIdList'];
    // print("orderId ${orderHistory!.orderId}");
     shippingAddressController = Get.put(ShippingAddressController(
        apiRepositoryInterface: Get.find(),
        editMode: false,
        shippingAddress: ShippingAddress(),
        localRepositoryInterface: Get.find()));
    checkOutController = Get.find<CheckOutController>();
    shippingAddressController!.getUser();
    // shippingAddressController.getAddressId();

    // myOrderController!.orderDetail(orderHistory!.orderId!);


    // print("cartList total ------------- ${cartList[0].totalAmt!}");
    // cartList!.forEach((element) {
    //     totalPrice += double.parse(element.mrpPrice!);
    //     print("mrp ------------- ${element.mrpPrice!}");
    //     print("mrp ------------- $totalPrice");
    // });
    //
    // cartList!.forEach((element) {
    //   totalDiscount += double.parse(element.discountAmt!);
    //   print("discountAmt ------------- ${element.discountAmt!}");
    //   print("discountAmt ------------- $totalDiscount");
    // });
    //
    // cartList!.forEach((element) {
    //   double totalQty = double.parse(element.netPrice!) * double.parse(element.quantity!);
    //   totalAmount+= totalQty;
    //   print("totalAmt ------------- ${totalQty}");
    //   print("totalAmt ------------- $totalAmount");
    // });





    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final list = myOrderController!.productList
    //     .where((i) => i.price! <= 5000)
    //     .toList();


    return Scaffold(
      // leading: true,
      // title: null,
      backgroundColor: AppColors.lightGreyBg,
      // appBar: AppBar(
      //   backgroundColor: AppColors.white,
      //   leading: Image.asset(
      //     'assets/img/arrow_left.png',
      //     color: AppColors.appText,
      //   ),
      //   title: Text(
      //     "ADDRESS",
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
            AppbarTitleWidget(title: "ADDRESS",flag: false,),
            Expanded(
              child: ListView(
                children: [
                  //  SizedBox(
                  //   height: 8,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     InkWell(
                  //         onTap: () {
                  //           Get.back();
                  //         },
                  //         child: const Icon(
                  //           Icons.arrow_back_ios,
                  //           size: 22,
                  //         )),
                  //     const Text(
                  //       "Check Out",
                  //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  //     ),
                  //     const Icon(
                  //       Icons.search,
                  //       size: 25,
                  //     )
                  //   ],
                  // ),
                  // const SizedBox(
                  //   height: 8,
                  // ),

                  RefreshIndicator

                    (
                    onRefresh: () async {
                       isFlag = true;
                    isFlag1 = true;
                      CheckInternet.checkInternet();
                      await shippingAddressController!.getUser();
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height - 100,
                      child: ListView(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 16.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: const Text("Shipping Address",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500)),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),

                          Obx(() {
                            if (shippingAddressController!
                                    .isLoadingGetAddress.value ==
                                true) {

                              // if(isFlag!){
                              //   index = shippingAddressController!.index.toInt();
                              //   print("indexxxx $index");
                              //   isFlag = false;
                              // }else{
                              //   isFlag = false;
                              // }

                              MainResponse? mainResponse =
                                  shippingAddressController!.getAddressObj.value;
                              List<ShippingAddress>? shippingAddressData = [];
                              if (mainResponse.data != null) {
                                mainResponse.data!.forEach((v) {
                                  shippingAddressData
                                      .add(ShippingAddress.fromJson(v));
                                });
                              }
                              // mainResponse.data!.map((e) => customerProfileData!.add(UpdateCustomerPasswordData.fromJson(e))).toList();


                              String? imageUrl = mainResponse.imageUrl ?? "";
                              String? message = mainResponse.message ??
                                  AppConstants.noInternetConn;

                              // print("checkOutController!.index.toInt()  check out ${index!}");



                              if (shippingAddressData.isEmpty) {
                                return Container(
                                  // width: 100,
                                  // height: 100,
                                  child: ListView(
                                    // physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    children: [
                                  //     Container(
                                  //       width: 100,
                                  //       height: 100,
                                  //       //height: MediaQuery.of(context).size.height,
                                  //       alignment: Alignment.center,
                                  //       child: ElevatedButton(onPressed: () async {
                                  //         final result =  await
                                  //         Get.toNamed(Routes.addShippingAddress,arguments: [
                                  //           {"editMode": false},
                                  //           {"addressObj": ShippingAddress()}
                                  //         ]);
                                  //         print("Shipping Address Screen  $result");
                                  //         if(result != null){
                                  //           shippingAddressController!.getUser();
                                  //         }
                                  //       }, child: Padding(
                                  //         padding: const EdgeInsets.all(15.0),
                                  //         child: Text(
                                  //             "Add Addess".toUpperCase(),
                                  //     style: TextStyle(fontSize: 14)
                                  // ),
                                  //       ), style: ButtonStyle(
                                  //           foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                  //           backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                  //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  //               RoundedRectangleBorder(
                                  //                   borderRadius: BorderRadius.circular(10),
                                  //                   side: BorderSide(color: Colors.red)
                                  //               )
                                  //           )
                                  //       ),
                                  //       )
                                  //
                                  //
                                  //       // Center(
                                  //       //   child: Text(
                                  //       //     message!,
                                  //       //     style: const TextStyle(color: Colors.black45),
                                  //       //   ),
                                  //       // ),
                                  //     ),

                                      Container(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 20,bottom: 20),
                                          child: InkWell(
                                            onTap: () async {
                                              final result =  await
                                              Get.toNamed(Routes.addShippingAddress,
                                                  arguments: [
                                                {"editMode": false},
                                                {"addressObj": ShippingAddress()},
                                              ]);
                                              print("Shipping Address Screen  $result");
                                              if(result != null){
                                                 isFlag = true;
                                                 isFlag1 = true;
                                                shippingAddressController!.getUser();
                                                //shippingAddressController.getAddress(shippingAddressController.customerId.value);
                                              }
                                            },
                                            child: Container(
                                              width: MediaQuery.of(context).size.width,
                                              decoration: BoxDecoration(

                                                border: Border.all(
                                                  width: 0.8,
                                                  color: AppColors.black,),
                                                borderRadius: const BorderRadius.all(
                                                    Radius.circular(
                                                        1.0) //                 <--- border radius here
                                                ),
                                              ),
                                              child:  Padding(
                                                padding: EdgeInsets.all(6.0),
                                                child: Center(
                                                  child: Text("ADD ADDRESS",
                                                      style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: AppColors.black))
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              } else {


                                return Column(children: shippingAddressData.map((addressObj) {


                                  String address =
                                  addressObj.address != ""
                                      ? addressObj.address! + ", "
                                      : "";
                                  String city = addressObj.city! != ""
                                      ? addressObj.city!
                                      : "";
                                  String pincode = addressObj.pincode! != ""
                                      ? addressObj.pincode!
                                      : "";
                                  // String state = shippingAddressList![index].state! != "" ? shippingAddressList![index].state! + ", " : "";
                                  // String pincode = shippingAddressList![index].pincode! != "" ? shippingAddressList![index].pincode! + ", " : "";
                                  String fullAddress = address +
                                      city +
                                      addressObj.state! +
                                      " - " +
                                      addressObj.pincode!;

                                if(addressObj.setDefault == "1"){
                                  isFlag1 = false;
                                  // return  Text("ddd ${e.email}");
                                  // didUpdateWidget(oldWidget)
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.white,

                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                addressObj
                                                        .firstName! +
                                                    " " +
                                                    addressObj
                                                        .lastName!,
                                                  style: GoogleFonts.inriaSans(textStyle: const TextStyle(color: AppColors.black,fontWeight: FontWeight.w700,fontSize: 14))
                                              ),
                                              // Text(
                                              //     "Prachi M Patel",
                                              //     style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: AppColors.searchTitle))
                                              // ),
                                              // const SizedBox(
                                              //   width: 10,
                                              // ),
                                              Padding(
                                                padding: const EdgeInsets.only(right: 15.0),
                                                child:
                                                Container(
                                                  decoration: BoxDecoration(
                                                    // color: Colors.grey[300],
                                                    border: Border.all(
                                                        width: 1,
                                                        color: AppColors.appGreen),
                                                    borderRadius: const BorderRadius.all(
                                                        Radius.circular(
                                                            20) //                 <--- border radius here
                                                        ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(top: 1.0,bottom: 1.0,left: 8,right: 8),
                                                    child: Text(
                                                      addressObj
                                                          .addressType!,
                                                        style: GoogleFonts.inriaSans(textStyle: const TextStyle(color: AppColors.green,fontWeight: FontWeight.w700,fontSize: 12))
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // Image.asset(
                                              //   'assets/images/default.png',
                                              //   height: 90,
                                              // ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          // Container(
                                          //   width: MediaQuery.of(context).size.width- 130,
                                          //   child: Text(
                                          //     // fullAddress,
                                          //     "104, Hiral Jyot,\nHiral Park,\nNutan nagar",
                                          //
                                          //     // maxLines: 2,
                                          //     // overflow: TextOverflow.ellipsis,
                                          //     style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.appText1)),
                                          //   ),
                                          // ),
                                          Container(
                                            width: MediaQuery.of(context).size.width-85,
                                            child: Text(

                                                "${addressObj.address}",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 12,color: AppColors.appText1))
                                              // style: TextStyle(
                                              //   color: Colors.black54,
                                              //   fontSize: 16,
                                              // ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width-85,
                                            child: Text(

                                                "${addressObj.city} - ${addressObj.pincode}",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 12,color: AppColors.appText1))
                                              // style: TextStyle(
                                              //   color: Colors.black54,
                                              //   fontSize: 16,
                                              // ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width-85,
                                            child: Text(

                                                "${addressObj.state}",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 12,color: AppColors.appText1))
                                              // style: TextStyle(
                                              //   color: Colors.black54,
                                              //   fontSize: 16,
                                              // ),
                                            ),
                                          ),
                                          // Container(
                                          //   width: MediaQuery.of(context).size.width- 130,
                                          //   child: Text(
                                          //     "${city} - ${pincode
                                          //     }",
                                          //
                                          //
                                          //
                                          //     style: const TextStyle(
                                          //       color: Colors.black54,
                                          //       fontSize: 16,
                                          //     ),
                                          //   ),
                                          // ),
                                          // Container(
                                          //   width: MediaQuery.of(context).size.width- 130,
                                          //   child: Text(
                                          //     "Vapi-396191",
                                          //     style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.appText1)),
                                          //   ),
                                          // ),
                                          // Container(
                                          //   width: MediaQuery.of(context).size.width- 130,
                                          //   child: Text(
                                          //     "Gujarat",
                                          //     style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.appText1)),
                                          //   ),
                                          // ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          // Text(
                                          //   addressObj.mobile!,
                                          //   style: const TextStyle(
                                          //     color: Colors.black54,
                                          //     fontSize: 16,
                                          //   ),
                                          // ),
                                          Text(
                                              "Mobile : ${addressObj.mobile!}",
                                              style: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 12,color: AppColors.appText1))
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          InkWell(
                                              onTap: () async {
                                                final result =  await Get.toNamed(Routes.shippingAddress, arguments: true);

                                                print("Check Out Screen  $result");
                                                print("Check Out Screen  ${shippingAddressController!.customerId.value}");
                                                if(result != null){
                                                  isFlag = true;
                                                  isFlag1 = true;
                                                   shippingAddressController!.getUser();

                                                  // await shippingAddressController.getAddressId().then((value) {
                                                  //   shippingAddressController.getUser();
                                                  //   print("result checkOutController!.index.toInt() ${index!}");
                                                  // });
                                                  // shippingAddressController.index(result);


                                                }
                                                // Get.toNamed(Routes.shippingAddress, arguments: true);
                                              },
                                              child:
                                              Padding(
                                                padding: const EdgeInsets.only(left: 20.0,right: 20.0),
                                                child: Container(
                                                  width: MediaQuery.of(context).size.width,
                                                  decoration: BoxDecoration(

                                                    border: Border.all(
                                                        width: 0.8,
                                                      color: AppColors.black,),
                                                    borderRadius: const BorderRadius.all(
                                                        Radius.circular(
                                                            1.0) //                 <--- border radius here
                                                    ),
                                                  ),
                                                  child:  Padding(
                                                    padding: EdgeInsets.all(6.0),
                                                    child: Center(
                                                      child: Text("CHANGE OR ADD ADDRESS",
                                                          style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: AppColors.black))
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  );

                                } else{
                                  return Container();
                                }
                                }).toList());
                                 shippingAddressData.map((e) {
                                   Text("ddd");
                                }).toList();

                                // return Container(
                                //   decoration: BoxDecoration(
                                //     color: Colors.grey[100],
                                //     border: Border.all(
                                //         width: 0.5,
                                //         color: Colors.grey),
                                //     borderRadius: const BorderRadius.all(
                                //         Radius.circular(
                                //             5.0) //                 <--- border radius here
                                //     ),
                                //   ),
                                //   child: Padding(
                                //     padding: const EdgeInsets.all(5.0),
                                //     child: Row(
                                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //       children: [
                                //         Column(
                                //           mainAxisAlignment: MainAxisAlignment.center,
                                //           crossAxisAlignment: CrossAxisAlignment.start,
                                //           children: [
                                //             Row(
                                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //               crossAxisAlignment: CrossAxisAlignment.end,
                                //               children: [
                                //                 Row(
                                //                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //                   children: [
                                //                     Text(
                                //                       shippingAddressData[index!]
                                //                               .firstName! +
                                //                           " " +
                                //                           shippingAddressData[index!]
                                //                               .lastName!,
                                //                       style: const TextStyle(
                                //                         fontSize: 18,
                                //                       ),
                                //                     ),
                                //                     const SizedBox(
                                //                       width: 10,
                                //                     ),
                                //                     Container(
                                //                       decoration: BoxDecoration(
                                //                         color: Colors.grey[300],
                                //                         border: Border.all(
                                //                             width: 0.5,
                                //                             color: Colors.grey),
                                //                         borderRadius: const BorderRadius.all(
                                //                             Radius.circular(
                                //                                 5.0) //                 <--- border radius here
                                //                             ),
                                //                       ),
                                //                       child: Padding(
                                //                         padding:
                                //                             const EdgeInsets.all(4.0),
                                //                         child: Text(
                                //                           shippingAddressData[index!]
                                //                               .addressType!,
                                //                           style: const TextStyle(
                                //                             fontSize: 16,
                                //                           ),
                                //                         ),
                                //                       ),
                                //                     ),
                                //                     // Image.asset(
                                //                     //   'assets/images/default.png',
                                //                     //   height: 90,
                                //                     // ),
                                //                   ],
                                //                 ),
                                //
                                //               ],
                                //             ),
                                //             const SizedBox(
                                //               height: 8,
                                //             ),
                                //             Container(
                                //               width: MediaQuery.of(context).size.width- 130,
                                //               child: Text(
                                //                 fullAddress,
                                //                 maxLines: 2,
                                //                 overflow: TextOverflow.ellipsis,
                                //                 style: const TextStyle(
                                //                   color: Colors.black54,
                                //                   fontSize: 16,
                                //                 ),
                                //               ),
                                //             ),
                                //             const SizedBox(
                                //               height: 8,
                                //             ),
                                //             Text(
                                //               shippingAddressData[index!].mobile!,
                                //               style: const TextStyle(
                                //                 color: Colors.black54,
                                //                 fontSize: 16,
                                //               ),
                                //             ),
                                //           ],
                                //         ),
                                //         const SizedBox(width: 10,),
                                //         InkWell(
                                //             onTap: () async {
                                //               final result =  await
                                //               Get.toNamed(Routes.shippingAddress, arguments: true);
                                //
                                //               print("Check Out Screen  $result");
                                //               print("Check Out Screen  ${shippingAddressController!.customerId.value}");
                                //               if(result != null){
                                //                 await shippingAddressController!.getAddress(shippingAddressController!.customerId.value).then((value) {
                                //                   setState(() {
                                //                     index = result;
                                //                     print("Check Out Screen  index  $index");
                                //
                                //                     // shippingAddressController.getAddressId();
                                //                   });
                                //                 });
                                //
                                //                // await shippingAddressController.getAddressId().then((value) {
                                //                //   shippingAddressController.getUser();
                                //                //   print("result checkOutController!.index.toInt() ${index!}");
                                //                // });
                                //                 // shippingAddressController.index(result);
                                //
                                //
                                //               }
                                //               // Get.toNamed(Routes.shippingAddress, arguments: true);
                                //             },
                                //             child: Container(
                                //               decoration: BoxDecoration(
                                //                 color: Colors.grey[100],
                                //                 border: Border.all(
                                //                     width: 0.5,
                                //                     color: Colors.grey),
                                //                 borderRadius: const BorderRadius.all(
                                //                     Radius.circular(
                                //                         5.0) //                 <--- border radius here
                                //                 ),
                                //               ),
                                //               child: const Padding(
                                //                 padding: EdgeInsets.all(4.0),
                                //                 child: Text("Change",
                                //                     style: TextStyle(
                                //                         fontSize: 16,
                                //                         color: Colors.redAccent,
                                //                         fontWeight: FontWeight.w400)),
                                //               ),
                                //             )),
                                //         const SizedBox(width: 10,),
                                //       ],
                                //     ),
                                //   ),
                                // );
                              }




                            } else {
                              return Container(
                                  // height: 200,
                                  child: const Center(
                                      child: CircularProgressIndicator(
                                          color: Style.Colors.appColor)));
                            }
                          }),


                          Obx(() {
                            if (shippingAddressController!
                                .isLoadingGetAddress.value ==
                                true) {

                              // if(isFlag!){
                              //   index = shippingAddressController!.index.toInt();
                              //   print("indexxxx $index");
                              //   isFlag = false;
                              // }else{
                              //   isFlag = false;
                              // }

                              MainResponse? mainResponse =
                                  shippingAddressController!.getAddressObj.value;
                              List<ShippingAddress>? shippingAddressData = [];
                              if (mainResponse.data != null) {
                                mainResponse.data!.forEach((v) {
                                  shippingAddressData
                                      .add(ShippingAddress.fromJson(v));
                                });
                              }
                              // mainResponse.data!.map((e) => customerProfileData!.add(UpdateCustomerPasswordData.fromJson(e))).toList();


                              String? imageUrl = mainResponse.imageUrl ?? "";
                              String? message = mainResponse.message ??
                                  AppConstants.noInternetConn;

                              // print("checkOutController!.index.toInt()  check out ${index!}");



                              if (shippingAddressData.isEmpty) {
                                return Container();
                              } else {
                                return Column(children: shippingAddressData.map((addressObj) {

                                  if(addressObj.setDefault == "0"){
                                    // return  Text("ddd ${e.email}");
                                    // didUpdateWidget(oldWidget)

                                    print("isFlag ===============> ${isFlag}");
                                    print("isFlag1 ===============> ${isFlag1}");
                                    if(isFlag! && isFlag1 == true){
                                      isFlag = false;
                                      return  Container(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 20,bottom: 20),
                                          child: InkWell(
                                            onTap: () async {
                                            var result = await  Get.toNamed(Routes.shippingAddress, arguments: true);
                                            if(result != null){
                                              isFlag = true;
                                              isFlag1 = true;
                                              shippingAddressController!.getUser();

                                            }
                                            },
                                            child: Container(
                                              width: MediaQuery.of(context).size.width,
                                              decoration: BoxDecoration(

                                                border: Border.all(
                                                  width: 0.8,
                                                  color: AppColors.black,),
                                                borderRadius: const BorderRadius.all(
                                                    Radius.circular(
                                                        1.0) //                 <--- border radius here
                                                ),
                                              ),
                                              child:  Padding(
                                                padding: EdgeInsets.all(6.0),
                                                child: Center(
                                                  child: Text("SET DEFAULT ADDRESS",
                                                      style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: AppColors.black))
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }else{
                                      isFlag = false;
                                      return Container(

                                      );
                                    }


                                  } else{
                                    // isFlag = false;
                                    return Container();
                                  }
                                }).toList());
                                shippingAddressData.map((e) {
                                  Text("ddd");
                                }).toList();

                                // return Container(
                                //   decoration: BoxDecoration(
                                //     color: Colors.grey[100],
                                //     border: Border.all(
                                //         width: 0.5,
                                //         color: Colors.grey),
                                //     borderRadius: const BorderRadius.all(
                                //         Radius.circular(
                                //             5.0) //                 <--- border radius here
                                //     ),
                                //   ),
                                //   child: Padding(
                                //     padding: const EdgeInsets.all(5.0),
                                //     child: Row(
                                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //       children: [
                                //         Column(
                                //           mainAxisAlignment: MainAxisAlignment.center,
                                //           crossAxisAlignment: CrossAxisAlignment.start,
                                //           children: [
                                //             Row(
                                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //               crossAxisAlignment: CrossAxisAlignment.end,
                                //               children: [
                                //                 Row(
                                //                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //                   children: [
                                //                     Text(
                                //                       shippingAddressData[index!]
                                //                               .firstName! +
                                //                           " " +
                                //                           shippingAddressData[index!]
                                //                               .lastName!,
                                //                       style: const TextStyle(
                                //                         fontSize: 18,
                                //                       ),
                                //                     ),
                                //                     const SizedBox(
                                //                       width: 10,
                                //                     ),
                                //                     Container(
                                //                       decoration: BoxDecoration(
                                //                         color: Colors.grey[300],
                                //                         border: Border.all(
                                //                             width: 0.5,
                                //                             color: Colors.grey),
                                //                         borderRadius: const BorderRadius.all(
                                //                             Radius.circular(
                                //                                 5.0) //                 <--- border radius here
                                //                             ),
                                //                       ),
                                //                       child: Padding(
                                //                         padding:
                                //                             const EdgeInsets.all(4.0),
                                //                         child: Text(
                                //                           shippingAddressData[index!]
                                //                               .addressType!,
                                //                           style: const TextStyle(
                                //                             fontSize: 16,
                                //                           ),
                                //                         ),
                                //                       ),
                                //                     ),
                                //                     // Image.asset(
                                //                     //   'assets/images/default.png',
                                //                     //   height: 90,
                                //                     // ),
                                //                   ],
                                //                 ),
                                //
                                //               ],
                                //             ),
                                //             const SizedBox(
                                //               height: 8,
                                //             ),
                                //             Container(
                                //               width: MediaQuery.of(context).size.width- 130,
                                //               child: Text(
                                //                 fullAddress,
                                //                 maxLines: 2,
                                //                 overflow: TextOverflow.ellipsis,
                                //                 style: const TextStyle(
                                //                   color: Colors.black54,
                                //                   fontSize: 16,
                                //                 ),
                                //               ),
                                //             ),
                                //             const SizedBox(
                                //               height: 8,
                                //             ),
                                //             Text(
                                //               shippingAddressData[index!].mobile!,
                                //               style: const TextStyle(
                                //                 color: Colors.black54,
                                //                 fontSize: 16,
                                //               ),
                                //             ),
                                //           ],
                                //         ),
                                //         const SizedBox(width: 10,),
                                //         InkWell(
                                //             onTap: () async {
                                //               final result =  await
                                //               Get.toNamed(Routes.shippingAddress, arguments: true);
                                //
                                //               print("Check Out Screen  $result");
                                //               print("Check Out Screen  ${shippingAddressController!.customerId.value}");
                                //               if(result != null){
                                //                 await shippingAddressController!.getAddress(shippingAddressController!.customerId.value).then((value) {
                                //                   setState(() {
                                //                     index = result;
                                //                     print("Check Out Screen  index  $index");
                                //
                                //                     // shippingAddressController.getAddressId();
                                //                   });
                                //                 });
                                //
                                //                // await shippingAddressController.getAddressId().then((value) {
                                //                //   shippingAddressController.getUser();
                                //                //   print("result checkOutController!.index.toInt() ${index!}");
                                //                // });
                                //                 // shippingAddressController.index(result);
                                //
                                //
                                //               }
                                //               // Get.toNamed(Routes.shippingAddress, arguments: true);
                                //             },
                                //             child: Container(
                                //               decoration: BoxDecoration(
                                //                 color: Colors.grey[100],
                                //                 border: Border.all(
                                //                     width: 0.5,
                                //                     color: Colors.grey),
                                //                 borderRadius: const BorderRadius.all(
                                //                     Radius.circular(
                                //                         5.0) //                 <--- border radius here
                                //                 ),
                                //               ),
                                //               child: const Padding(
                                //                 padding: EdgeInsets.all(4.0),
                                //                 child: Text("Change",
                                //                     style: TextStyle(
                                //                         fontSize: 16,
                                //                         color: Colors.redAccent,
                                //                         fontWeight: FontWeight.w400)),
                                //               ),
                                //             )),
                                //         const SizedBox(width: 10,),
                                //       ],
                                //     ),
                                //   ),
                                // );
                              }




                            } else {
                              return Container(
                                // height: 200,
                                  child:  Container(
                                       ));
                            }
                          }),

                          // isFlag == true? Text("Please set default Shipping Address",
                          //     style: TextStyle(
                          //         fontSize: 16,
                          //         color: Colors.black,
                          //         fontWeight: FontWeight.w500)):Container(),

            //            Container(
            //         decoration: BoxDecoration(
            //         color: AppColors.white,
            //
            //         ),
            //   child: Padding(
            //     padding: const EdgeInsets.all(16.0),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             // Text(
            //             //   addressObj
            //             //           .firstName! +
            //             //       " " +
            //             //       addressObj
            //             //           .lastName!,
            //             //     style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: AppColors.searchTitle))
            //             // ),
            //             Text(
            //                 "Prachi M Patel",
            //                 style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: AppColors.searchTitle))
            //             ),
            //
            //             Container(
            //               height: 23,
            //               width: 56,
            //               decoration: BoxDecoration(
            //                 // color: Colors.grey[300],
            //                 border: Border.all(
            //                     width: 1,
            //                     color: AppColors.appGreen),
            //                 borderRadius: const BorderRadius.all(
            //                     Radius.circular(
            //                         20) //                 <--- border radius here
            //                 ),
            //               ),
            //               child: Center(
            //                 child: Text(
            //                     "Home",
            //                     style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.appGreen))
            //                 ),
            //               ),
            //             ),
            //             // Image.asset(
            //             //   'assets/images/default.png',
            //             //   height: 90,
            //             // ),
            //           ],
            //         ),
            //         const SizedBox(
            //           height: 8,
            //         ),
            //         Container(
            //           width: MediaQuery.of(context).size.width- 130,
            //           child: Text(
            //             // fullAddress,
            //             "104, Hiral Jyot,\nHiral Park,\nNutan nagar",
            //
            //             // maxLines: 2,
            //             // overflow: TextOverflow.ellipsis,
            //             style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.appText1)),
            //           ),
            //         ),
            //         // Container(
            //         //   width: MediaQuery.of(context).size.width- 130,
            //         //   child: Text(
            //         //     "${city} - ${pincode
            //         //     }",
            //         //
            //         //
            //         //
            //         //     style: const TextStyle(
            //         //       color: Colors.black54,
            //         //       fontSize: 16,
            //         //     ),
            //         //   ),
            //         // ),
            //         Container(
            //           width: MediaQuery.of(context).size.width- 130,
            //           child: Text(
            //             "Vapi-396191",
            //             style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.appText1)),
            //           ),
            //         ),
            //         Container(
            //           width: MediaQuery.of(context).size.width- 130,
            //           child: Text(
            //             "Gujarat",
            //             style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.appText1)),
            //           ),
            //         ),
            //         const SizedBox(
            //           height: 8,
            //         ),
            //         // Text(
            //         //   addressObj.mobile!,
            //         //   style: const TextStyle(
            //         //     color: Colors.black54,
            //         //     fontSize: 16,
            //         //   ),
            //         // ),
            //         Text(
            //           "Mobile: 1234567899",
            //           style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.appText1)),
            //         ),
            //         const SizedBox(
            //           height: 16,
            //         ),
            //         InkWell(
            //             onTap: () async {
            //               final result =  await
            //               Get.toNamed(Routes.shippingAddress, arguments: true);
            //
            //               print("Check Out Screen  $result");
            //               print("Check Out Screen  ${shippingAddressController!.customerId.value}");
            //               if(result != null){
            //                 await shippingAddressController!.getAddress(shippingAddressController!.customerId.value).then((value) {
            //                   // setState(() {
            //                   //   index = result;
            //                   //   print("Check Out Screen  index  $index");
            //                   //
            //                   //   // shippingAddressController.getAddressId();
            //                   // });
            //                 });
            //
            //                 // await shippingAddressController.getAddressId().then((value) {
            //                 //   shippingAddressController.getUser();
            //                 //   print("result checkOutController!.index.toInt() ${index!}");
            //                 // });
            //                 // shippingAddressController.index(result);
            //
            //
            //               }
            //               // Get.toNamed(Routes.shippingAddress, arguments: true);
            //             },
            //             child: Container(
            //               height: 34,
            //               width: MediaQuery.of(context).size.width,
            //               decoration: BoxDecoration(
            //
            //                 border: Border.all(
            //                   width: 0.8,
            //                   color: AppColors.black,),
            //                 borderRadius: const BorderRadius.all(
            //                     Radius.circular(
            //                         2.0) //                 <--- border radius here
            //                 ),
            //               ),
            //               child:  Padding(
            //                 padding: EdgeInsets.all(6.0),
            //                 child: Center(
            //                   child: Text("CHANGE OR ADD ADDRESS",
            //                       style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: AppColors.black))
            //                   ),
            //                 ),
            //               ),
            //             )),
            //       ],
            //     ),
            //   ),
            // ),

                          // const SizedBox(
                          //   height: 10.0,
                          // ),

                          // const Text("Payment Type",
                          //     style: TextStyle(
                          //         fontSize: 16,
                          //         color: Colors.black,
                          //         fontWeight: FontWeight.w500)),
                          // const SizedBox(
                          //   height: 10.0,
                          // ),
                          // DropdownButtonFormField<String>(
                          //
                          //   decoration: const InputDecoration(
                          //       // labelText: 'Payment Type',
                          //       hintText: 'Payment Type',
                          //       border: OutlineInputBorder()),
                          //    value: paymentType,
                          //   // hint: Text(
                          //   //   'Salutation',
                          //   // ),
                          //   onChanged: (salutation){
                          //     paymentType = salutation!;
                          //     print("salutation $salutation");
                          //   },
                          //   // onChanged: (salutation) =>
                          //   //     setState(() => selectedSalutation = salutation),
                          //   validator: (value) => value == null ? 'This field is required' : null,
                          //   items:
                          //   ['Cash On Delivery', 'Online Payment'].map<DropdownMenuItem<String>>((String value) {
                          //     return DropdownMenuItem<String>(
                          //       value: value,
                          //       child: Text(value),
                          //     );
                          //   }).toList(),
                          // ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child:  Text("DELIVERY ESTIMATES",
                                style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: AppColors.black))),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          // myOrderController.isLoading.value != false
                          //     ?

                          Container(
                            color: AppColors.white,
                            child: Column(
                              children: cartList!.map((element) {
                                // var index = element.value;
                                int idx = cartList!.indexOf(element)+1;
                                print("idx idx idx -----${idx}");
                                double mrp = double.parse(element.mrpPrice!) *
                                    double.parse(element.quantity!);
                                double totalQty = double.parse(element.netPrice!) * double.parse(element.quantity!);
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 0.0,top: 8.0,left: 15,right: 15),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 50,
                                            child: ClipRRect(
                                              // borderRadius:
                                              //     BorderRadius.circular(10.0),
                                              child: Center(
                                                child:
                                                Image.network(
                                                  imagePath! +
                                                      element.productId! +
                                                      "/" +
                                                      element.coverImg!,
                                                  height: 120,
                                                  width: 120,
                                                  fit: BoxFit.contain,
                                                ),

                                                // Image.asset(
                                                //
                                                //       element.coverImg!,
                                                //   // height: 120,
                                                //   // width: 120,
                                                //   fit: BoxFit.contain,
                                                // ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // Text(
                                                //   element.productName!,
                                                //   maxLines: 2,
                                                //   // style: GoogleFonts.ptSans(),
                                                //   overflow: TextOverflow.ellipsis,
                                                // ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Estimated delivery by ",
                                                        style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.black))
                                                    ),
                                                    Text(
                                                      "24 Sep 2022",
                                                        style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: AppColors.black))
                                                    ),
                                                  ],
                                                ),

                                              ],
                                            ),
                                          )
                                        ],
                                      ),

                                      // Container(
                                      //   color: Colors.red,
                                      //   height: 1,
                                      // )
                                      SizedBox(height: 8.0,),

                                      idx != cartList!.length ?
                                      LayoutBuilder(
                                        builder: (BuildContext context, BoxConstraints constraints) {
                                          final boxWidth = constraints.constrainWidth();
                                          const dashWidth = 3.0;
                                          // final dashHeight = height;
                                          final dashCount = (boxWidth / (2 * dashWidth)).floor();
                                          return Flex(
                                            children: List.generate(dashCount, (_) {
                                              return const SizedBox(
                                                width: dashWidth,
                                                height: 1,
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(color: AppColors.lightGreyBg),
                                                ),
                                              );
                                            }),
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            direction: Axis.horizontal,
                                          );
                                        },
                                      ):Container(),



                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),


                          SizedBox(height: 50.0,),
                          //     :
                          //
                          //
                          // CircularProgressIndicator(),
                      //     const SizedBox(
                      //       height: 10.0,
                      //     ),
                      //     const Text("Price Details",
                      //         style: TextStyle(
                      //             fontSize: 16,
                      //             color: Colors.black,
                      //             fontWeight: FontWeight.w500)),
                      //     priceDetailWidget(
                      //         "Price",
                      //         '\u{20B9}' +
                      //             "${totalPrice.toStringAsFixed(0)}",
                      //         Colors.grey,
                      //         FontWeight.w400,
                      //       FontWeight.w500,
                      //         ),
                      //     priceDetailWidget(
                      //       "Discount",
                      //       '- \u{20B9}' +
                      //           "${totalDiscount.toStringAsFixed(0)}",
                      //       Colors.grey,
                      //       FontWeight.w400,
                      //       FontWeight.w500,
                      //     ),
                      //     const SizedBox(
                      //       height: 10.0,
                      //     ),
                      // LayoutBuilder(
                      //   builder: (BuildContext context, BoxConstraints constraints) {
                      //     final boxWidth = constraints.constrainWidth();
                      //     const dashWidth = 3.0;
                      //     // final dashHeight = height;
                      //     final dashCount = (boxWidth / (2 * dashWidth)).floor();
                      //     return Flex(
                      //       children: List.generate(dashCount, (_) {
                      //         return const SizedBox(
                      //           width: dashWidth,
                      //           height: 1,
                      //           child: DecoratedBox(
                      //             decoration: BoxDecoration(color: Colors.grey),
                      //           ),
                      //         );
                      //       }),
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       direction: Axis.horizontal,
                      //     );
                      //   },
                      // ),
                      //     priceDetailWidget(
                      //       "Total Amount",
                      //       totalAmount.toStringAsFixed(0),
                      //       Colors.black,
                      //       FontWeight.w500,
                      //         FontWeight.w500
                      //     ),
                      //
                      //
                      //     const SizedBox(
                      //       height: 65.0,
                      //     ),

                          // orderInfoRowWidget(
                          //     "Shipping Address",
                          //     "3 NewBridge Count, CA 97454, United States",
                          //     Colors.grey,
                          //     Colors.black,
                          //     FontWeight.w400,
                          //     FontWeight.w400),
                          // orderInfoRowWidget(
                          //     "Payment method",
                          //     "**** **** **** 3974",
                          //     Colors.grey,
                          //     Colors.black,
                          //     FontWeight.w400,
                          //     FontWeight.w400),
                          // orderInfoRowWidget(
                          //     "Delivery method",
                          //     'FedEx, 3 day, 15\$',
                          //     Colors.grey,
                          //     Colors.black,
                          //     FontWeight.w400,
                          //     FontWeight.w400),
                          // orderInfoRowWidget(
                          //     "Discount",
                          //     "10%, Personal promo code",
                          //     Colors.grey,
                          //     Colors.black,
                          //     FontWeight.w400,
                          //     FontWeight.w400),
                          // orderInfoRowWidget("Total Amount", "210\$", Colors.grey,
                          //     Colors.black, FontWeight.w400, FontWeight.w400),
                        ],
                      ),
                    ),
                  ),



                  // const SizedBox(
                  //   height: 10,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),



      // searchOnTab: () {},
      // bottomNavigationBar:   Container(
      //   width: double.infinity,
      //   decoration: const BoxDecoration(
      //       color: Colors.white,
      //       boxShadow: [
      //         BoxShadow(
      //           color: Colors.black38,
      //           spreadRadius: 0,
      //           blurRadius: 10,
      //         ),
      //       ],
      //       borderRadius: BorderRadius.only(
      //           topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //
      //       Container(
      //         height: 60,
      //         child: Padding(
      //           padding: const EdgeInsets.only(left: 12.0),
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //
      //               Text(
      //                 totalPrice.toStringAsFixed(0),
      //                 // style: CustomTextStyle.title,
      //                 style: TextStyle( decoration:
      //                 TextDecoration
      //                     .combine([
      //                   TextDecoration
      //                       .lineThrough
      //                 ]),
      //                 color: Colors.grey),
      //               ),
      //               Text(
      //                 totalAmount.toStringAsFixed(0),
      //                 style: const TextStyle(fontSize: 18),
      //                 // style: CustomTextStyle.price,
      //               )
      //             ],
      //           ),
      //         ),
      //       ),
      //       InkWell(
      //         onTap: (){
      //           // openCheckout();
      //           FocusManager.instance.primaryFocus?.unfocus();
      //           print("paymentType $paymentType");
      //           if(paymentType == null){
      //             // AlertDialogs.showSimpleDialog("Payment Type","Please select payment type");
      //             // Get.snackbar('Payment Type',"Please select payment type" ,duration: const Duration(seconds: 8), snackPosition: SnackPosition.BOTTOM,);
      //             SnackBarDialog.showSnackbar('Payment Type','Please select payment type');
      //           }else if(paymentType == "Cash On Delivery"){
      //             homeController.placeOrder(paymentType!);
      //           }else{
      //
      //           }
      //
      //           // String stringList = productIds.join(",");
      //           // print("product list ${stringList}");
      //           // if(productIds.isEmpty){
      //           //   AlertDialogs.showAlertDialog("Cart?", "Please select minimum 1 item", () async {
      //           //   });
      //           // }else{
      //           //   List<Carts> finaCartList = [];
      //           //   cartList.forEach((element1) {
      //           //     productIds.forEach((element2) {
      //           //       print("element1.productId 11111 outside ${element1.productId}");
      //           //       print("element2.productId 22222 outside ${element2}");
      //           //       if(element1.productId == element2){
      //           //         print("element1.productId 11111 ${element1.productId}");
      //           //
      //           //         print("element2.productId element1 ${element1.productName}");
      //           //         finaCartList.add(element1);
      //           //       }else{
      //           //         print("element1.productId 11111 else ${element1.productId}");
      //           //         print("element2.productId 22222 else ${element2}");
      //           //       }
      //           //     });
      //           //
      //           //   });
      //           //   // homeController.checkOut(stringList);
      //           //   Get.toNamed(Routes.checkOut,arguments: [{"cartList": finaCartList}, {"imagePath": imagePath}]);
      //           // }
      //
      //         },
      //         child: Container(
      //           height: 60,
      //           decoration: const BoxDecoration(
      //               color: Colors.redAccent,
      //               borderRadius: BorderRadius.only(topRight: Radius.circular(10))),
      //           child: const Padding(
      //             padding: EdgeInsets.symmetric(horizontal: 20),
      //             child: Center(
      //               child: Text(
      //                 'Place Order',
      //                 // textAlign: TextAlign.center,
      //                 style: TextStyle(color: Colors.white, fontSize: 18),
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),


      bottomNavigationBar: Wrap(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            // height: 60,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 1, color: AppColors.tileLine),
              ),
            ),
            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0,bottom: 8.0,left: 16.0,right: 16.0),
                child: Container(
                  height: 36,
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
                print("productIdList ====$productIdList");
                Get.toNamed(Routes.payment,arguments: [{"productIdList": productIdList}]);
                // openCheckout();
              },
            ),
          ),
        ],
      ),
    );
  }

  rowWidget(String title, des, Color color1, color2, FontWeight fontWeight1,
      fontWeight2) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style:
              TextStyle(fontSize: 16, color: color1, fontWeight: fontWeight1),
        ),
        Text(
          des,
          style: TextStyle(
            fontSize: 16,
            color: color2,
            fontWeight: fontWeight2,
          ),
        )
      ],
    );
  }

  priceDetailWidget(String title, value,Color color1, FontWeight fontWeight1,fontWeight2){
   return Padding(
     padding: const EdgeInsets.only(top: 8.0),
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
         Text(
           title,
           style: TextStyle(
               fontSize: 16, fontWeight: fontWeight1),
         ),
         Text(
           value,
           style: TextStyle(
               fontSize: 16, color: color1, fontWeight: fontWeight2),
         ),
       ],
     ),
   );
  }

  orderInfoRowWidget(String title, des, Color color1, color2,
      FontWeight fontWeight1, fontWeight2) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 16, color: color1, fontWeight: fontWeight1),
                ),
                Text(
                  ": ",
                  style: TextStyle(
                      fontSize: 16, color: color1, fontWeight: fontWeight1),
                ),
              ],
            ),
          ),
          Expanded(
            child: Text(
              des,
              softWrap: true,
              style: TextStyle(
                fontSize: 16,
                color: color2,
                fontWeight: fontWeight2,
              ),
            ),
          )
        ],
      ),
    );
  }


  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Success Response: ${response.paymentId}');
    /*Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error Response: ${response.message}');
    /* Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External SDK Response: ${response.walletName}');
    /* Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT); */
  }
}
