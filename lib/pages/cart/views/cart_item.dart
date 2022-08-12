import 'package:eshoperapp/models/cart.dart';
import 'package:eshoperapp/pages/landing_home/home_controller.dart';
import 'package:eshoperapp/routes/navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../cart_controller.dart';

class CartItem extends StatelessWidget {
  final Cart? cart;
  final int? cartIndex;
  CartItem({this.cart, this.cartIndex});
  final homeController = Get.find<HomeController>();
  final controller = Get.put(CartController(localRepositoryInterface:Get.find() , apiRepositoryInterface: Get.find()));
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(() {
          return SizedBox(
              height: 20,
              child: IconButton(
                  onPressed: () {
                    controller.selectCart(cart!);
                  },
                  icon: homeController.selectedCarts.contains(cart!.id)
                      ? const Icon(Icons.check_box)
                      : const Icon(Icons.check_box_outline_blank)));
        }),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Colors.grey))),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context, Routes.productDetails,
                         // arguments: ProductDetailsArguments(product: cart!.product)
                      );
                    },


                    child: SizedBox(
                      height: 60,
                      width: 50,
                      child: Image.network(
                          'https://onlinehatiya.herokuapp.com' +
                              cart!.product!.image!,
                          height: 100),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(cart!.product!.title!,
                             // style: GoogleFonts.ptSans(),
                              overflow: TextOverflow.ellipsis),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            cart!.product!.description!,
                            maxLines: 2,
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '\u{20B9} ' + cart!.amount.toString(),
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent),
                              ),
                              InkWell(
                                  onTap: () {
                                    controller.quantity(cart!.quantity!);
                                    controller.showButtomSheed(
                                        context, () {

                                    }, cart!.id);
                                  },
                                  child: Text('Qty:${cart!.quantity} ▾'))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        homeController.removeProductFromCart(cart!.id);
                      },
                      icon: const Icon(Icons.cancel))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
