import 'package:eshoperapp/constants/app_costants.dart';
import 'package:eshoperapp/models/carts.dart';
import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/models/products.dart';
import 'package:eshoperapp/pages/cart/views/cart_item.dart';
import 'package:eshoperapp/pages/cart/views/checkout_cart.dart';
import 'package:eshoperapp/pages/cart/views/items_number.dart';
import 'package:eshoperapp/pages/landing_home/home_controller.dart';
import 'package:eshoperapp/utils/alert_dialog.dart';
import 'package:eshoperapp/utils/check_internet.dart';
import 'package:eshoperapp/widgets/product_gridview_tile.dart';
import 'package:eshoperapp/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:eshoperapp/style/theme.dart' as Style;
import '../details/prodcut_details_screen.dart';
import 'cart_controller.dart';

class CartScreen extends StatefulWidget {
  final int index;
  final bool leading;

  CartScreen(this.index, this.leading);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // final controller = Get.put(HomeController(
  //     localRepositoryInterface: Get.find(),
  //     apiRepositoryInterface: Get.find()));

  final cardController = Get.put(CartController(
      apiRepositoryInterface: Get.find(),
      localRepositoryInterface: Get.find()));

  // final homeController = Get.find<HomeController>();
  // final controller = Get.put(CartController(localRepositoryInterface:Get.find() , apiRepositoryInterface: Get.find()));

  final ScrollController _scrollController = ScrollController();





  @override
  Widget build(BuildContext context) {
    return SajiloDokanScaffold(
        title: "Shopping Cart",
        searchOnTab: (){

        },
        leading: widget.leading,
        body: RefreshIndicator(
          onRefresh: () async {
            CheckInternet.checkInternet();
            cardController.homecontroller.getSlider();
            cardController.homecontroller.getBrand();
            cardController.homecontroller.bestSellerProduct();
            cardController.homecontroller.allProducts();
            await cardController.homecontroller.loadUser(false);
            return cardController.homecontroller.newProducts(true);
          },
          child:
          Scaffold(
              // appBar: AppBar(
              //   centerTitle: true,
              //   elevation: 0,
              //   title: Text(
              //     'Shopping Cart',
              //     style: TextStyle(color: Colors.black),
              //   ),
              // ),
              backgroundColor: Colors.grey.withOpacity(0.1),
              body:

              Obx(() {
                if (cardController.homecontroller.isLoadingNewProducts.value !=
                    true) {
                  return  ListView(
                    children: [


                      Obx(() {
                        if (cardController.homecontroller.isLoadingGetCartItems.value != true) {
                          MainResponse? mainResponse = cardController.homecontroller.getCartItemsObj.value;
                          List<Carts>? getCartData = [];

                          if(mainResponse.data != null){
                            mainResponse.data!.forEach((v) {
                              getCartData.add(Carts.fromJson(v));
                            });

                          }


                          // print("getCartData total ------------- ${getCartData[0].totalAmt!}");
                          // cardController.homecontroller.cartList(getCartData);
                          Future.delayed(Duration.zero, () { // <-- add this
                            cardController.homecontroller.refreshTotal();
                          });

                          // cardController.homecontroller.refreshTotal();
                          // mainResponse.data!.map((e) => customerProfileData!.add(UpdateCustomerPasswordData.fromJson(e))).toList();


                          String? imageUrl = mainResponse.imageUrl ?? "";
                          String? message = mainResponse.message ?? AppConstants.noInternetConn;


                          Future.delayed(Duration(seconds: 1), () {
                            // Do something
                            // cardController.homecontroller.selectAllCart(getCartData);
                          });
                          if (getCartData.isEmpty) {
                            // return Container(
                            //   height: 90.0,
                            //   width: MediaQuery.of(context).size.width,
                            //   child: Column(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     crossAxisAlignment: CrossAxisAlignment.center,
                            //     children: <Widget>[
                            //       Column(
                            //         children: <Widget>[
                            //           Text(
                            //             message!,
                            //             style: TextStyle(color: Colors.black45),
                            //           )
                            //         ],
                            //       )
                            //     ],
                            //   ),
                            // );

                            return Container();
                          }else{
                            // cardController.selectAllCartInit(getCartData);
                            return Column(
                              //controller: _scrollController,
                              children: [
                                Container(
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: ItemNuber(
                                              itemNumber: getCartData.length,
                                            ),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                cardController.homecontroller.productIds.clear();
                                                AlertDialogs.showAlertDialog("Delete?", "Are you sure you want to delete from all Items?", () async {
                                                  // Get.back();
                                                  Navigator.pop(context);
                                                  cardController.homecontroller.emptyCart(cardController.homecontroller.customerId.value);
                                                });
                                              },
                                              child: Text(
                                                'Clear all',
                                                style: TextStyle(
                                                    color: Colors.redAccent,
                                                    fontSize: 16),
                                              ))
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                cardController.selectAllCart(getCartData);

                                               print("controller.isAllCartSelected(getCartData) ${cardController.homecontroller.isAllCartSelected(getCartData)}");
                                               if(cardController.homecontroller.isAllCartSelected(getCartData)){
                                                 cardController.homecontroller.productIds.clear();
                                                 getCartData.forEach((element) {
                                                   cardController.homecontroller.productIds.add(element.productId);
                                                 });
                                                 print("productIds ${cardController.homecontroller.productIds}");
                                               }else{
                                                 cardController.homecontroller.productIds.clear();
                                                 print("productIds ${cardController.homecontroller.productIds}");
                                               }

                                              },
                                              icon: cardController.homecontroller.isAllCartSelected(getCartData)
                                                  ? Icon(Icons.check_box)
                                                  : Icon(
                                                  Icons.check_box_outline_blank)),
                                          Text(
                                            'Select All',
                                            style: TextStyle(
                                                color: Colors.redAccent, fontSize: 16),
                                          ),
                                          Spacer()
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  children: [
                                    ...List.generate(
                                        getCartData.length,
                                            (index) {
                                              double mrp = double.parse(getCartData[index].mrpPrice!) * double.parse(getCartData[index].quantity!);
                                              double totalQty = double.parse(getCartData[index].netPrice!) * double.parse(getCartData[index].quantity!);
                                            return Row(
                                            children: [
                                              Obx(() {
                                                return SizedBox(
                                                    height: 20,
                                                    child: IconButton(
                                                        onPressed: () {
                                                          // productIds.clear();
                                                          cardController.selectCart(getCartData[index]);
                                                          print("productIds first ${cardController.homecontroller.productIds}");
                                                          // print("contains ${productIds.contains(getCartData[index].cartId.toString())}");
                                                          // // print("contains ${productIds.where((item) => item.contains(getCartData[index].cartId.toString()))}" );
                                                          // if(productIds.contains(getCartData[index].cartId.toString())){
                                                          //   productIds.removeAt(index);
                                                          // }else{
                                                          //   productIds.add(getCartData[index].productId!);
                                                          // }
                                                          //
                                                          // print("productIds ${productIds}");

                                                          // List<String> myList = ['US', 'SG', 'US'];
                                                          print(cardController.homecontroller.productIds.where((item) => item.contains(getCartData[index].productId!)));
                                                          var contain = cardController.homecontroller.productIds.where((item) => item.contains(getCartData[index].productId!));
                                                          if (contain.isEmpty){
                                                            cardController.homecontroller.productIds.add(getCartData[index].productId!);
                                                            print("productIds if ${cardController.homecontroller.productIds}");
                                                          }else{
                                                            cardController.homecontroller.productIds.removeWhere((item) => item == getCartData[index].productId);
                                                            // productIds.removeAt(index);
                                                            print("productIds ${cardController.homecontroller.productIds}");
                                                          }


                                                        },
                                                        // icon: homeController.selectedCarts.contains(cart!.id)
                                                        icon: cardController.homecontroller.selectedCarts.contains(getCartData[index].cartId)
                                                            ? const Icon(Icons.check_box)
                                                            : const Icon(Icons.check_box_outline_blank)));
                                              }),
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>  ProductDetailsScreen(
                                                              products: Products(productId: getCartData[index].productId!,productName: getCartData[index].productName!),
                                                              // article: articles[index],
                                                            )));





                                                    // Navigator.pushNamed(
                                                    //     context, Routes.productDetails,
                                                    //    // arguments: ProductDetailsArguments(product: cart!.product)
                                                    // );
                                                  },
                                                  child: Container(
                                                    decoration: const BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border(bottom: BorderSide(color: Colors.grey))),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(15),
                                                      child: Row(
                                                        children: [
                                                          InkWell(
                                                            // onTap: () {
                                                            //   Navigator.push(
                                                            //       context,
                                                            //       MaterialPageRoute(
                                                            //           builder: (context) =>  ProductDetailsScreen(
                                                            //             products: Products(productId: cart!.productId!,productName: cart!.productName!),
                                                            //             // article: articles[index],
                                                            //           )));
                                                            //
                                                            //
                                                            //
                                                            //
                                                            //
                                                            //   // Navigator.pushNamed(
                                                            //   //     context, Routes.productDetails,
                                                            //   //    // arguments: ProductDetailsArguments(product: cart!.product)
                                                            //   // );
                                                            // },


                                                            child: SizedBox(
                                                              height: 50,
                                                              width: 50,
                                                              child: Image.network(
                                                                // 'https://onlinehatiya.herokuapp.com' +
                                                                //     cart!.product!.image!,

                                                                imageUrl + getCartData[index].productId! + "/" + getCartData[index].coverImg!,
                                                                fit: BoxFit.fill,),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(left: 10, right: 10),
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Text(getCartData[index].productName!,
                                                                      // style: GoogleFonts.ptSans(),
                                                                      overflow: TextOverflow.ellipsis,
                                                                  maxLines: 2,
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  // Text(
                                                                  //   "cart!.product!.description!",
                                                                  //   maxLines: 2,
                                                                  //   style: const TextStyle(fontSize: 14),
                                                                  // ),
                                                                  // const SizedBox(
                                                                  //   height: 5,
                                                                  // ),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                                          Row(
                                                                            children: [
                                                                              Text(
                                                                                '\u{20B9} ' + "${totalQty.toStringAsFixed(0)}",
                                                                                style: const TextStyle(
                                                                                    fontSize: 16,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Colors.black),
                                                                              ),
                                                                              SizedBox(width: 5,),
                                                                              Text(
                                                                                '\u{20B9} ' + getCartData[index].discount.toString() +" % off",
                                                                                style: const TextStyle(
                                                                                    fontSize: 14,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Colors.redAccent),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(width: 10,),

                                                                      InkWell(
                                                                          onTap: () {
                                                                            cardController.quantity(int.parse(getCartData[index].quantity!));
                                                                            cardController.showButtomSheed(
                                                                                context, () {

                                                                            }, int.parse(getCartData[index].productId!),cardController.homecontroller.customerId.value);
                                                                          },
                                                                          child: Text('Qty:${getCartData[index].quantity} ▾'))
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          IconButton(
                                                              onPressed: () {
                                                                // homeController.removeProductFromCart(int.parse(cart!.cartId!));

                                                                AlertDialogs.showAlertDialog("Delete?", "Are you sure you want to delete from this Item?", () async {
                                                                  Navigator.pop(context);
                                                                  print("productIds ${cardController.homecontroller.productIds}");
                                                                  var contain = cardController.homecontroller.productIds.where((item) => item.contains(getCartData[index].productId!));
                                                                  if (contain.isEmpty){

                                                                    print("productIds if cancel ${cardController.homecontroller.productIds}");
                                                                  }else{
                                                                    cardController.homecontroller.productIds.removeWhere((item) => item == getCartData[index].productId);
                                                                    // productIds.removeAt(index);
                                                                    print("productIds cancel ${cardController.homecontroller.productIds}");
                                                                  }
                                                                   cardController.homecontroller.removeFromCart(getCartData[index].productId!,cardController.homecontroller.customerId.value,index);
                                                                  // if(isBool){
                                                                  //
                                                                  //
                                                                  // }

                                                                });
                                                              },
                                                              icon: const Icon(Icons.cancel))
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                            }




                                        //
                                        //         CartItem(
                                        //   cartIndex: index,
                                        //   cart: getCartData[index],
                                        //   imageUrl: imageUrl,
                                        //
                                        // )




                                    )
                                  ],
                                ),

                              ],
                            );
                          }

                        } else {
                          return Container();
                          return  Container(
                              height: 90,
                              child: Center(child: CircularProgressIndicator(color: Style.Colors.appColor)));

                        }
                      }),

                      Obx(() {
                        if (cardController.homecontroller.isLoadingNewProducts.value != true) {
                          MainResponse? mainResponse = cardController.homecontroller.newProductsObj.value;
                          List<Products>? newProductsData = [];
                          if(mainResponse.data !=null){
                            mainResponse.data!.forEach((v) {
                              newProductsData.add( Products.fromJson(v));
                            });
                          }
                          // mainResponse.data!.map((e) => customerProfileData!.add(UpdateCustomerPasswordData.fromJson(e))).toList();


                          String? imageUrl = mainResponse.imageUrl ?? "";
                          String? message = mainResponse.message ?? AppConstants.noInternetConn;
                          if (newProductsData.isEmpty) {
                            return Container(
                              height: 200.0,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        message!,
                                        style: TextStyle(color: Colors.black45),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          }else{
                            return Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  color: Colors.white.withOpacity(0.4),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Continue Shopping',
                                        style: TextStyle(
                                            fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                  child: ProductGridviewTile(
                                    products: newProductsData,
                                    imageUrl: imageUrl,
                                  ),
                                ),
                              ],
                            );
                          }

                        } else {
                          return  Container(
                            height: 200,
                            // child: Center(child: CircularProgressIndicator(color: Style.Colors.appColor))
                          );

                        }
                      }),


                      // Obx(() {
                      //   return controller.isCartLoad.value
                      //       ? Container(
                      //     color: Colors.grey.withOpacity(0.4),
                      //     height: double.infinity,
                      //     width: double.infinity,
                      //     child: SizedBox(
                      //       height: 30,
                      //       width: 30,
                      //       child: Center(
                      //         child: CircularProgressIndicator(
                      //           color: Colors.redAccent,
                      //         ),
                      //       ),
                      //     ),
                      //   )
                      //       : SizedBox.shrink();
                      // })
                    ],
                  );
                } else {
                  if (cardController.homecontroller.isRefresh.value !=
                      true) {
                    return Container(
                        // height: MediaQuery.of(context).size.height-120,
                        child: Center(
                            child: CircularProgressIndicator(
                                color: Colors.green))
                    );
                  } else {
                    return Container(
                      // height: 200,
                    );
                  }
                }
              }),



              // NotificationListener<ScrollNotification>(
              //   onNotification: (scrollNotification) {
              //     if (_scrollController.position.userScrollDirection ==
              //         ScrollDirection.reverse) {
              //       cardController.isVisible(false);
              //
              //       //the setState function
              //     } else if (_scrollController.position.userScrollDirection ==
              //         ScrollDirection.forward) {
              //       cardController.isVisible(true);
              //
              //       //setState function
              //     }
              //     return true;
              //   },
              //   child:
              //
              // ),
              bottomNavigationBar:
              Obx((){
                return  CheckoutCart(
                  totalAmount: cardController.homecontroller.totalAmount.value,
                  productIds: cardController.homecontroller.productIds,
                    cartList : cardController.homecontroller.cartList,
                  imagePath: cardController.homecontroller.imagePath,
                );
              })

             ),
        ));
  }
}
