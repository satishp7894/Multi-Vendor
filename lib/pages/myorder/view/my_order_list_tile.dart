import 'package:eshoperapp/models/category.dart';
import 'package:eshoperapp/models/order_history.dart';
import 'package:eshoperapp/pages/myorder/myorder_controller.dart';
import 'package:eshoperapp/routes/navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyOrderTile extends StatelessWidget {
  final controller = Get.find<MyOrderController>();
  final ValueChanged<int>? onChanged;
  final List<Category>? categoriesList;

  final OrderHistory? orderHistory;
  final int? index;
  final String? imageUrl;

  MyOrderTile({Key? key, this.categoriesList, this.onChanged, this.orderHistory, this.index, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String orderDate = DateFormat("dd-MMM-yyyy").format(DateTime.parse(orderHistory!.orderDate!));
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            rowWidget("Order No : ", orderHistory!.orderNumber!, Colors.grey, Colors.black,
                FontWeight.w400, FontWeight.bold),
            rowWidget(orderDate, "", Colors.grey, Colors.grey,
                FontWeight.w400, FontWeight.w400),
          ]),
          SizedBox(
            height: 15.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              rowWidget("Tracking No : ", "IWJKD001SS", Colors.grey,
                  Colors.black, FontWeight.w400, FontWeight.bold),
              Container()
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              rowWidget("Quantity :  ", orderHistory!.totalQuantity!, Colors.grey, Colors.black,
                  FontWeight.w400, FontWeight.bold),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Amount :  ",
                    style:
                    TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    double.parse(orderHistory!.totalAmount!).toStringAsFixed(2),
                    style:
                    TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                  )
                ],
              )
              // rowWidget("Total Amount :  ", orderHistory!.totalAmount!, Colors.grey, Colors.black,
              //     FontWeight.w400, FontWeight.bold)
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.myOrderDetails,arguments: orderHistory);
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(
                              100.0) //                 <--- border radius here
                          ),
                      border: Border.all(color: Colors.red)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text("Details",style: TextStyle(color: Colors.red)),
                  ),
                ),
              ),
              Text(
                "Delivered",
                style: TextStyle(color: Colors.red),
              )
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(color: Colors.red,height: 0.2,)
        ],
      ),
    );
  }

  rowWidget(String title,String des, Color color1, color2, FontWeight fontWeight1,
      fontWeight2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style:
              TextStyle(fontSize: 16, color: color1, fontWeight: fontWeight1),
        ),
        Text(
          des,
          style:
              TextStyle(fontSize: 16, color: color2, fontWeight: fontWeight2),
        )
      ],
    );
  }
}
