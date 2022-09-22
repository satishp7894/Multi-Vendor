// import 'package:eshoperapp/models/cart.dart';
// import 'package:eshoperapp/models/carts.dart';
// import 'package:eshoperapp/models/products.dart';
// import 'package:eshoperapp/pages/details/prodcut_details_screen.dart';
// import 'package:eshoperapp/pages/landing_home/home_controller.dart';
// import 'package:eshoperapp/routes/navigation.dart';
// import 'package:eshoperapp/utils/alert_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../cart_controller.dart';
//
// class CartItem extends StatelessWidget {
//   // final Cart? cart;
//   final Carts? cart;
//   final int? cartIndex;
//   final String? imageUrl;
//   CartItem({this.cart, this.cartIndex, this.imageUrl});
//   final homeController = Get.find<HomeController>();
//   final controller = Get.put(CartController(localRepositoryInterface:Get.find() , apiRepositoryInterface: Get.find()));
//   List<String> productIds = [];
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Obx(() {
//           return SizedBox(
//               height: 20,
//               child: IconButton(
//                   onPressed: () {
//                     controller.selectCart(cart!);
//                     if(productIds.contains(cart!.cartId)){
//                       productIds.removeAt(cartIndex!);
//                     }else{
//                       productIds.add(cart!.productId!);
//                     }
//
//                     print("productIds ${productIds}");
//                   },
//                   // icon: homeController.selectedCarts.contains(cart!.id)
//                   icon: homeController.selectedCarts.contains(cart!.cartId)
//                       ? const Icon(Icons.check_box)
//                       : const Icon(Icons.check_box_outline_blank)));
//         }),
//         Expanded(
//           child: InkWell(
//             onTap: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) =>  ProductDetailsScreen(
//                         products: Products(productId: cart!.productId!,productName: cart!.productName!),
//                         // article: articles[index],
//                       )));
//
//
//
//
//
//               // Navigator.pushNamed(
//               //     context, Routes.productDetails,
//               //    // arguments: ProductDetailsArguments(product: cart!.product)
//               // );
//             },
//             child: Container(
//               decoration: const BoxDecoration(
//                   color: Colors.white,
//                   border: Border(bottom: BorderSide(color: Colors.grey))),
//               child: Padding(
//                 padding: const EdgeInsets.all(15),
//                 child: Row(
//                   children: [
//                     InkWell(
//                       // onTap: () {
//                       //   Navigator.push(
//                       //       context,
//                       //       MaterialPageRoute(
//                       //           builder: (context) =>  ProductDetailsScreen(
//                       //             products: Products(productId: cart!.productId!,productName: cart!.productName!),
//                       //             // article: articles[index],
//                       //           )));
//                       //
//                       //
//                       //
//                       //
//                       //
//                       //   // Navigator.pushNamed(
//                       //   //     context, Routes.productDetails,
//                       //   //    // arguments: ProductDetailsArguments(product: cart!.product)
//                       //   // );
//                       // },
//
//
//                       child: SizedBox(
//                         height: 70,
//                         width: 70,
//                         child: Image.network(
//                             // 'https://onlinehatiya.herokuapp.com' +
//                             //     cart!.product!.image!,
//
//                             imageUrl! + cart!.productId! + "/" + cart!.coverImg!,
//                             fit: BoxFit.fill,),
//                       ),
//                     ),
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 20, right: 40),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(cart!.productName!,
//                                // style: GoogleFonts.ptSans(),
//                                 overflow: TextOverflow.ellipsis),
//                             const SizedBox(
//                               height: 5,
//                             ),
//                             Text(
//                               "cart!.product!.description!",
//                               maxLines: 2,
//                               style: const TextStyle(fontSize: 14),
//                             ),
//                             const SizedBox(
//                               height: 5,
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   '\u{20B9} ' + cart!.mrpPrice.toString(),
//                                   style: const TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.redAccent),
//                                 ),
//                                 InkWell(
//                                     onTap: () {
//                                       controller.quantity(int.parse(cart!.quantity!));
//                                       controller.showButtomSheed(
//                                           context, () {
//
//                                       }, int.parse(cart!.productId!),homeController.customerId.value);
//                                     },
//                                     child: Text('Qty:${cart!.quantity} ▾'))
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                         onPressed: () {
//                           // homeController.removeProductFromCart(int.parse(cart!.cartId!));
//
//                           AlertDialogs.showAlertDialog("Delete?", "Are you sure you want to delete from this Item?", () async {
//                             // Get.back();
//                             homeController.removeFromCart(cart!.productId!,homeController.customerId.value,cartIndex);
//                           });
//                         },
//                         icon: const Icon(Icons.cancel))
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
