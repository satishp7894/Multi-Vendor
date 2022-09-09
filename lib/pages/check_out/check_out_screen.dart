import 'package:eshoperapp/constants/app_costants.dart';
import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/style/theme.dart' as Style;
import 'package:eshoperapp/utils/check_internet.dart';
import 'package:eshoperapp/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../models/carts.dart';
import '../../models/shipping_address.dart';
import '../../routes/navigation.dart';
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

  // OrderHistory? orderHistory;
  List<Carts>? cartList;
  RxString? imagePath;
  int? index;
  bool? isFlag = true;
  double totalPrice = 0.0;
  double totalDiscount = 0.0;
  double totalAmount = 0.0;
  Razorpay? _razorpay;
  static const platform = const MethodChannel("razorpay_flutter");

  @override
  void initState() {
    // cartList = Get.arguments
    dynamic argumentData = Get.arguments;
    cartList = argumentData[0]['cartList'];
    imagePath = argumentData[1]['imagePath'];
    // print("orderId ${orderHistory!.orderId}");
     shippingAddressController = Get.put(ShippingAddressController(
        apiRepositoryInterface: Get.find(),
        editMode: false,
        shippingAddress: ShippingAddress(),
        localRepositoryInterface: Get.find()));
    checkOutController = Get.find<CheckOutController>();
    // shippingAddressController.getAddressId();

    // myOrderController!.orderDetail(orderHistory!.orderId!);


    // print("cartList total ------------- ${cartList[0].totalAmt!}");
    cartList!.forEach((element) {
        totalPrice += double.parse(element.mrp!);
        print("mrp ------------- ${element.mrp!}");
        print("mrp ------------- $totalPrice");
    });

    cartList!.forEach((element) {
      totalDiscount += double.parse(element.discountAmt!);
      print("discountAmt ------------- ${element.discountAmt!}");
      print("discountAmt ------------- $totalDiscount");
    });

    cartList!.forEach((element) {
      totalAmount+= double.parse(element.totalAmt!);
      print("totalAmt ------------- ${element.totalAmt!}");
      print("totalAmt ------------- $totalAmount");
    });
    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              //  SizedBox(
              //   height: 8,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 22,
                      )),
                  const Text(
                    "Check Out",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const Icon(
                    Icons.search,
                    size: 25,
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),

              RefreshIndicator

                (
                onRefresh: () async {
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
                        height: 10.0,
                      ),
                      const Text("Shipping Address",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(
                        height: 10.0,
                      ),

                      Obx(() {
                        if (shippingAddressController!
                                .isLoadingGetAddress.value ==
                            true) {

                          if(isFlag!){
                            index = shippingAddressController!.index.toInt();
                            print("indexxxx $index");
                            isFlag = false;
                          }else{
                            isFlag = false;
                          }

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

                          String address =
                              shippingAddressData[index!].address != ""
                                  ? shippingAddressData[index!].address! + ", "
                                  : "";
                          String city = shippingAddressData[index!].city! != ""
                              ? shippingAddressData[index!].city! + ", "
                              : "";
                          // String state = shippingAddressList![index].state! != "" ? shippingAddressList![index].state! + ", " : "";
                          // String pincode = shippingAddressList![index].pincode! != "" ? shippingAddressList![index].pincode! + ", " : "";
                          String fullAddress = address +
                              city +
                              shippingAddressData[index!].state! +
                              " - " +
                              shippingAddressData[index!].pincode!;
                          String? imageUrl = mainResponse.imageUrl ?? "";
                          String? message = mainResponse.message ??
                              AppConstants.noInternetConn;

                          // print("checkOutController!.index.toInt()  check out ${index!}");

                          if (shippingAddressData.isEmpty) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: ListView(
                                // physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height -
                                        100,
                                    //height: MediaQuery.of(context).size.height,
                                    alignment: Alignment.center,
                                    child: Center(
                                      child: Text(
                                        message!,
                                        style: const TextStyle(color: Colors.black45),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                border: Border.all(
                                    width: 0.5,
                                    color: Colors.grey),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                        5.0) //                 <--- border radius here
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Row(
                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  shippingAddressData[index!]
                                                          .firstName! +
                                                      " " +
                                                      shippingAddressData[index!]
                                                          .lastName!,
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[300],
                                                    border: Border.all(
                                                        width: 0.5,
                                                        color: Colors.grey),
                                                    borderRadius: const BorderRadius.all(
                                                        Radius.circular(
                                                            5.0) //                 <--- border radius here
                                                        ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(4.0),
                                                    child: Text(
                                                      shippingAddressData[index!]
                                                          .addressType!,
                                                      style: const TextStyle(
                                                        fontSize: 16,
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

                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width- 130,
                                          child: Text(
                                            fullAddress,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          shippingAddressData[index!].mobile!,
                                          style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 10,),
                                    InkWell(
                                        onTap: () async {
                                          final result =  await
                                          Get.toNamed(Routes.shippingAddress, arguments: true);

                                          print("Check Out Screen  $result");
                                          print("Check Out Screen  ${shippingAddressController!.customerId.value}");
                                          if(result != null){
                                            await shippingAddressController!.getAddress(shippingAddressController!.customerId.value).then((value) {
                                              setState(() {
                                                index = result;
                                                print("Check Out Screen  index  $index");

                                                // shippingAddressController.getAddressId();
                                              });
                                            });

                                           // await shippingAddressController.getAddressId().then((value) {
                                           //   shippingAddressController.getUser();
                                           //   print("result checkOutController!.index.toInt() ${index!}");
                                           // });
                                            // shippingAddressController.index(result);


                                          }
                                          // Get.toNamed(Routes.shippingAddress, arguments: true);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            border: Border.all(
                                                width: 0.5,
                                                color: Colors.grey),
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(
                                                    5.0) //                 <--- border radius here
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: const Text("Change",
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.redAccent,
                                                    fontWeight: FontWeight.w400)),
                                          ),
                                        )),
                                    SizedBox(width: 10,),
                                  ],
                                ),
                              ),
                            );
                          }
                        } else {
                          return Container(
                              // height: 200,
                              child: const Center(
                                  child: CircularProgressIndicator(
                                      color: Style.Colors.appColor)));
                        }
                      }),

                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text("Order Summary",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(
                        height: 10.0,
                      ),
                      // myOrderController.isLoading.value != false
                      //     ?
                      Column(
                        children: cartList!.map((element) {
                          double mrp = double.parse(element.mrp!) *
                              double.parse(element.quantity!);
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 120,
                                      width: 120,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Center(
                                          child: Image.network(
                                            imagePath! +
                                                element.productId! +
                                                "/" +
                                                element.image!,
                                            height: 120,
                                            width: 120,
                                            fit: BoxFit.contain,
                                          ),
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
                                          Text(
                                            element.productName!,
                                            maxLines: 2,
                                            // style: GoogleFonts.ptSans(),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          // Row(
                                          //   children: [
                                          //     ProductRating(
                                          //       rating: element.avaragereview,
                                          //       isReadOnly: true,
                                          //       size: 15,
                                          //       filledIconData: Icons.star,
                                          //       borderColor: Colors.red,
                                          //       color: Colors.red,
                                          //       halfFilledIconData: Icons.star_half,
                                          //       defaultIconData: Icons.star_border,
                                          //       starCount: 5,
                                          //       allowHalfRating: true,
                                          //     )
                                          //     // Text(
                                          //     //   ' ' +
                                          //     //       element.avaragereview.toString(),
                                          //     //   style: TextStyle(color: Colors.red),
                                          //     // )
                                          //   ],
                                          // ),
                                          // SizedBox(
                                          //   height: 5,
                                          // ),
                                          // Text(
                                          //   'Rs ' + double.parse(element.netPrice!).toStringAsFixed(2),
                                          //   style: TextStyle(color: Colors.redAccent),
                                          // )

                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        '\u{20B9} ' +
                                                            "${mrp.toStringAsFixed(0)}",
                                                        style: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .combine([
                                                              TextDecoration
                                                                  .lineThrough
                                                            ]),
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.grey),
                                                      ),
                                                      Text(
                                                        '\u{20B9} ' +
                                                            "${double.parse(element.totalAmt!).toStringAsFixed(0)}",
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    '\u{20B9} ' +
                                                        element.discount
                                                            .toString() +
                                                        " % off",
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Colors.redAccent),
                                                  ),
                                                ],
                                              ),
                                              Text('Qty:${element.quantity}')
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Container(
                                  color: Colors.red,
                                  height: 0.2,
                                )
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      //     :
                      //
                      //
                      // CircularProgressIndicator(),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text("Price Details",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                      priceDetailWidget(
                          "Price",
                          '\u{20B9}' +
                              "${totalPrice.toStringAsFixed(0)}",
                          Colors.grey,
                          FontWeight.w400,
                        FontWeight.w500,
                          ),
                      priceDetailWidget(
                        "Discount",
                        '- \u{20B9}' +
                            "${totalDiscount.toStringAsFixed(0)}",
                        Colors.grey,
                        FontWeight.w400,
                        FontWeight.w500,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                  LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      final boxWidth = constraints.constrainWidth();
                      const dashWidth = 3.0;
                      // final dashHeight = height;
                      final dashCount = (boxWidth / (2 * dashWidth)).floor();
                      return Flex(
                        children: List.generate(dashCount, (_) {
                          return SizedBox(
                            width: dashWidth,
                            height: 1,
                            child: DecoratedBox(
                              decoration: BoxDecoration(color: Colors.grey),
                            ),
                          );
                        }),
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        direction: Axis.horizontal,
                      );
                    },
                  ),
                      priceDetailWidget(
                        "Total Amount",
                        totalAmount.toStringAsFixed(0),
                        Colors.black,
                        FontWeight.w500,
                          FontWeight.w500
                      ),


                      const SizedBox(
                        height: 65.0,
                      ),

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
      ),
      // searchOnTab: () {},
      bottomNavigationBar:   Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                spreadRadius: 0,
                blurRadius: 10,
              ),
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Container(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      totalPrice.toStringAsFixed(0),
                      // style: CustomTextStyle.title,
                      style: TextStyle( decoration:
                      TextDecoration
                          .combine([
                        TextDecoration
                            .lineThrough
                      ]),
                      color: Colors.grey),
                    ),
                    Text(
                      totalAmount.toStringAsFixed(0),
                      style: TextStyle(fontSize: 18),
                      // style: CustomTextStyle.price,
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: (){
                openCheckout();
                // String stringList = productIds.join(",");
                // print("product list ${stringList}");
                // if(productIds.isEmpty){
                //   AlertDialogs.showAlertDialog("Cart?", "Please select minimum 1 item", () async {
                //   });
                // }else{
                //   List<Carts> finaCartList = [];
                //   cartList.forEach((element1) {
                //     productIds.forEach((element2) {
                //       print("element1.productId 11111 outside ${element1.productId}");
                //       print("element2.productId 22222 outside ${element2}");
                //       if(element1.productId == element2){
                //         print("element1.productId 11111 ${element1.productId}");
                //
                //         print("element2.productId element1 ${element1.productName}");
                //         finaCartList.add(element1);
                //       }else{
                //         print("element1.productId 11111 else ${element1.productId}");
                //         print("element2.productId 22222 else ${element2}");
                //       }
                //     });
                //
                //   });
                //   // homeController.checkOut(stringList);
                //   Get.toNamed(Routes.checkOut,arguments: [{"cartList": finaCartList}, {"imagePath": imagePath}]);
                // }

              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: Text(
                      'Pay Now',
                      // textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
      ,
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

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_4sP1JemLPLT9dX',
      'amount': 100,
      'name': 'MultiVendor',
      'description': 'Fine T-Shirt',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': shippingAddressController!.checkLoginData.value.mobile, 'email': shippingAddressController!.checkLoginData.value.email},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay!.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
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
