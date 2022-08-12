import 'package:eshoperapp/package/product_rating.dart';
import 'package:eshoperapp/pages/myorder/myorder_controller.dart';
import 'package:eshoperapp/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetaisScreen extends StatefulWidget {
  const OrderDetaisScreen({Key? key}) : super(key: key);

  @override
  State<OrderDetaisScreen> createState() => _OrderDetaisScreenState();
}

class _OrderDetaisScreenState extends State<OrderDetaisScreen> {
  @override
  Widget build(BuildContext context) {
    final myOrderController = Get.find<MyOrderController>();
    final list = myOrderController.productList
        .where((i) => i.price! <= 5000)
        .toList();
    return SajiloDokanScaffold(
      leading: true,
      title: null,
      body: SafeArea(
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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            rowWidget("Order No : ", "1924444", Colors.grey,
                                Colors.black, FontWeight.w400, FontWeight.bold),
                            rowWidget("25-10-2020", "", Colors.grey, Colors.grey,
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
                      Text("${list.length} items",style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500),),
                      SizedBox(
                        height: 10.0,
                      ),
                      // myOrderController.isLoading.value != false
                      //     ?
                      Column(
                        children: list.map((element) {
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
                                            'https://onlinehatiya.herokuapp.com' +
                                                element.image!,
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
                                            element.title!,
                                            maxLines: 2,
                                            // style: GoogleFonts.ptSans(),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              ProductRating(
                                                rating: element.avaragereview,
                                                isReadOnly: true,
                                                size: 15,
                                                filledIconData: Icons.star,
                                                borderColor: Colors.red,
                                                color: Colors.red,
                                                halfFilledIconData: Icons.star_half,
                                                defaultIconData: Icons.star_border,
                                                starCount: 5,
                                                allowHalfRating: true,
                                              )
                                              // Text(
                                              //   ' ' +
                                              //       element.avaragereview.toString(),
                                              //   style: TextStyle(color: Colors.red),
                                              // )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Rs ' + element.price.toString(),
                                            style: TextStyle(color: Colors.redAccent),
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
                ),
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
