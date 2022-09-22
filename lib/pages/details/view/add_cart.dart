import 'package:eshoperapp/models/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/customer.dart';
import '../../profile/profile_controller.dart';

class AddToCard extends StatelessWidget {
  final VoidCallback? onChanged;
  AddToCard({this.onChanged, this.product, });
  final Product? product;
  // final String? customerId;
  final profileController = Get.put(ProfileController(
      apiRepositoryInterface: Get.find(),
      customer: Customer(),
      localRepositoryInterface: Get.find()));
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black.withOpacity(0.2))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                onChanged!();
              },
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text('Buy',
                        style: TextStyle(fontSize: 18, color: Colors.black)),
                  )),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                onChanged!();
              },
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                  ),
                  child: Center(
                    child: Text('Add to Cart',
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
