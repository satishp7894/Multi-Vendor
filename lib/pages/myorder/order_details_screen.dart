import 'package:eshoperapp/constants/app_costants.dart';
import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/models/order_detail.dart';
import 'package:eshoperapp/models/order_history.dart';
import 'package:eshoperapp/package/product_rating.dart';
import 'package:eshoperapp/pages/myorder/myorder_controller.dart';
import 'package:eshoperapp/utils/check_internet.dart';
import 'package:eshoperapp/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eshoperapp/style/theme.dart' as Style;

class OrderDetaisScreen extends StatefulWidget {
  const OrderDetaisScreen({Key? key}) : super(key: key);

  @override
  State<OrderDetaisScreen> createState() => _OrderDetaisScreenState();
}

class _OrderDetaisScreenState extends State<OrderDetaisScreen> {
  MyOrderController? myOrderController;
  OrderHistory? orderHistory;

  @override
  void initState() {
    orderHistory = Get.arguments;
    print("orderId ${orderHistory!.orderId}");
    myOrderController = Get.find<MyOrderController>();
    myOrderController!.orderDetail(orderHistory!.orderId!);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // final list = myOrderController!.productList
    //     .where((i) => i.price! <= 5000)
    //     .toList();
    return SajiloDokanScaffold(
      leading: true,
      title: null,
      body:




      SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(

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
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 22,
                      )),
                  const Text(
                    "Order Details",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Icon(
                    Icons.search,
                    size: 25,
                  )
                ],
              ),
               SizedBox(
                height: 8,
              ),

              RefreshIndicator(
                onRefresh: () async {
                  CheckInternet.checkInternet();
                  await myOrderController!.orderDetail(orderHistory!.orderId!);
                },
                child: Obx(() {
                  if (myOrderController!.isLoadingOrderDetail.value != true) {
                    MainResponse? mainResponse = myOrderController!.orderDetailObj.value;
                    List<OrderDetail>? getOrderDetailData = [];
                    if(mainResponse.data != null){
                      mainResponse.data!.forEach((v) {
                        getOrderDetailData.add( OrderDetail.fromJson(v));
                      });
                    }
                    // mainResponse.data!.map((e) => customerProfileData!.add(UpdateCustomerPasswordData.fromJson(e))).toList();


                    String? imageUrl = mainResponse.imageUrl ?? "";
                    String? message = mainResponse.message ?? AppConstants.noInternetConn;
                    if (getOrderDetailData.isEmpty) {
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
                    }else{

                      return

                        Container(
                          height: MediaQuery.of(context).size.height-100,
                          child: ListView(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 12,
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    rowWidget("Order No : ", orderHistory!.orderNumber, Colors.grey,
                                        Colors.black, FontWeight.w400, FontWeight.bold),
                                    rowWidget(orderHistory!.orderDate!, "", Colors.grey, Colors.grey,
                                        FontWeight.w400, FontWeight.w400),
                                  ]),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  rowWidget("Tracking No : ", "IWJKD001SS", Colors.grey,
                                      Colors.black, FontWeight.w400, FontWeight.bold),
                                  Text(
                                    "Delivered",
                                    style: TextStyle(color: Colors.red),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text("${getOrderDetailData.length} items",style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500),),
                              SizedBox(
                                height: 10.0,
                              ),
                              // myOrderController.isLoading.value != false
                              //     ?
                              Column(
                                children: getOrderDetailData.map((element) {
                                  double mrp = double.parse(element.mrpPrice!) * double.parse(element.quantity!);
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
                                                borderRadius: BorderRadius.circular(10.0),
                                                child: Center(
                                                  child: Image.network(
                                                    imageUrl + element.productId! +"/"+
                                                        element.coverImg!,
                                                    height: 120,
                                                    width: 120,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10,),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    element.productName!,
                                                    maxLines: 2,
                                                    // style: GoogleFonts.ptSans(),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(
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
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                '\u{20B9} ' + "${mrp.toStringAsFixed(0)}",
                                                                style:  TextStyle(
                                                                    decoration: TextDecoration.combine(
                                                                        [ TextDecoration.lineThrough]),
                                                                    fontSize: 16,
                                                                    fontWeight: FontWeight.bold,
                                                                    color: Colors.grey),
                                                              ),
                                                              Text(
                                                                '\u{20B9} ' + "${double.parse(element.totalAmt!).toStringAsFixed(0)}",
                                                                style: const TextStyle(
                                                                    fontSize: 16,
                                                                    fontWeight: FontWeight.bold,
                                                                    color: Colors.black),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(width: 10,),
                                                          Text(
                                                            '\u{20B9} ' + element.discount.toString() + " % off",
                                                            style: const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.bold,
                                                                color: Colors.redAccent),
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
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                        Container(color: Colors.red,height: 0.2,)
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                              //     :
                              //
                              //
                              // CircularProgressIndicator(),
                              const Text("Order information",style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500)),

                              orderInfoRowWidget("Shipping Address", "3 NewBridge Count, CA 97454, United States", Colors.grey,
                                  Colors.black, FontWeight.w400, FontWeight.w400),
                              orderInfoRowWidget("Payment method", "**** **** **** 3974", Colors.grey,
                                  Colors.black, FontWeight.w400, FontWeight.w400),
                              orderInfoRowWidget("Delivery method", 'FedEx, 3 day, 15\$', Colors.grey,
                                  Colors.black, FontWeight.w400, FontWeight.w400),
                              orderInfoRowWidget("Discount", "10%, Personal promo code", Colors.grey,
                                  Colors.black, FontWeight.w400, FontWeight.w400),
                              orderInfoRowWidget("Total Amount", "210\$", Colors.grey,
                                  Colors.black, FontWeight.w400, FontWeight.w400),

                            ],
                          ),
                        );

                    }

                  } else {
                    return  Container(
                        height: MediaQuery.of(context).size.height-160,
                        child: Center(child: CircularProgressIndicator(color: Style.Colors.appColor)));

                  }
                }),
              ),


            ],
          ),
        ),
      ),
      searchOnTab: () {},
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
          style:
              TextStyle(fontSize: 16, color: color2, fontWeight: fontWeight2,),
        )
      ],
    );
  }

  orderInfoRowWidget(String title, des, Color color1, color2, FontWeight fontWeight1,
      fontWeight2) {
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
                  style:
                  TextStyle(fontSize: 16, color: color1, fontWeight: fontWeight1),
                ),
                Text(
                  ": ",
                  style:
                  TextStyle(fontSize: 16, color: color1, fontWeight: fontWeight1),
                ),
              ],
            ),
          ),
          Expanded(
            child: Text(
              des,
              softWrap: true,
              style:
              TextStyle(fontSize: 16, color: color2, fontWeight: fontWeight2,),
            ),
          )
        ],
      ),
    );
  }
}
