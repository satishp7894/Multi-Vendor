import 'package:eshoperapp/config/theme.dart';
import 'package:eshoperapp/pages/landing_home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/carts.dart';
import '../../../routes/navigation.dart';
import '../../../utils/alert_dialog.dart';

class CheckoutCart extends StatelessWidget {

  final totalAmount;
   List productIds;
  RxString? imagePath;
  List<Carts> cartList;
  CheckoutCart({this.totalAmount, required this.productIds, required this
  .cartList, this.imagePath});
  final homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Container(
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
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Payment',
                    style: CustomTextStyle.title,
                  ),
                  Text(
                    totalAmount.toStringAsFixed(2),
                    style: CustomTextStyle.price,
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: (){
              String stringList = productIds.join(",");
              print("product list ${stringList}");
              if(productIds.isEmpty){
                AlertDialogs.showAlertDialog("Cart?", "Please select minimum 1 item", () async {
                });
              }else{
                List<Carts> finaCartList = [];
                cartList.forEach((element1) {
                  productIds.forEach((element2) {
                    print("element1.productId 11111 outside ${element1.productId}");
                    print("element2.productId 22222 outside ${element2}");
                    if(element1.productId == element2){
                      print("element1.productId 11111 ${element1.productId}");

                      print("element2.productId element1 ${element1.productName}");
                      finaCartList.add(element1);
                    }else{
                      print("element1.productId 11111 else ${element1.productId}");
                      print("element2.productId 22222 else ${element2}");
                    }
                  });

                });
                // homeController.checkOut(stringList);
                Get.toNamed(Routes.checkOut,arguments: [{"cartList": finaCartList}, {"imagePath": imagePath}]);
              }

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
                    'Check Out',
                    // textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
