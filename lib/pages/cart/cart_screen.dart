import 'package:eshoperapp/config/theme.dart';
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
import 'package:google_fonts/google_fonts.dart';
import '../../routes/navigation.dart';
import '../../utils/snackbar_dialog.dart';
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

  final homeController = Get.put(HomeController(
      apiRepositoryInterface: Get.find(),
      localRepositoryInterface: Get.find()));

  // final homeController = Get.find<HomeController>();
  // final controller = Get.put(CartController(localRepositoryInterface:Get.find() , apiRepositoryInterface: Get.find()));

  final ScrollController _scrollController = ScrollController();





  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      // appBar: AppBar(
      //   elevation: 1,
      //   backgroundColor: Colors.white,
      //   leading: IconButton(
      //     icon: Image.asset("assets/img/close.png",fit: BoxFit.fill,height: 17,width: 17,),
      //
      //     // Icon(
      //     //   Icons.arrow_back,
      //     //   color: Style.Colors.appColor,
      //     //   size: 30,
      //     // ),
      //     onPressed: () =>  Get.back(),
      //   ),
      //   // title: Text("${categories!.categoryName!}", style: TextStyle(fontSize: 20,color: Style.Colors.appColor)),
      //   title: Text("SHOPPING BAG",
      //       style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: AppColors.appText))),
      //   actions: [
      //     IconButton(
      //         padding: EdgeInsets.zero,
      //         onPressed: ()  {
      //           Get.toNamed(Routes.wishList);
      //         },
      //         icon: Image.asset('assets/img/heart.png',fit: BoxFit.fill,height: 22,width: 22,)),
      //   ],
      // ),
      backgroundColor:AppColors.ratingText,
      body:

      SafeArea(
        child: Column(
          children: [
            Column(children: [
              Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(child: Padding(
                          padding: const EdgeInsets.only(left: AppSizes.sidePadding,right: AppSizes.sidePadding,top: 26,bottom: 8),
                          child: Image.asset('assets/img/close.png',fit: BoxFit.fill,height: 12,width: 12,),
                        ),onTap: (){
                          Get.back();
                        },),
                        // SizedBox(width: 16,),
                        Padding(
                          padding: const EdgeInsets.only(left: 0,right: 0,top: 26,bottom: 8),
                          child: Text('SHOPPING BAG',
                              style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: AppColors.appText))),
                        ),
                      ],
                    ),

                    InkWell(child: Padding(
                      padding: const EdgeInsets.only(left: AppSizes.sidePadding,right: AppSizes.sidePadding,top: 26,bottom: 8),
                      child: Image.asset('assets/img/heart.png',fit: BoxFit.fill,height: 18,width: 18,),
                    ),
                      onTap: (){
                        Get.toNamed(Routes.wishList);
                      },),
                  ],
                ),
              ),
              Container(height: 0.5,width: MediaQuery.of(context).size.width,color: AppColors.tileLine,),
            ],),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  CheckInternet.checkInternet();
                  // cardController.homecontroller.getSlider();
                  // cardController.homecontroller.getBrand();
                  // cardController.homecontroller.bestSellerProduct();
                  // cardController.homecontroller.allProducts();
                  await cardController.homecontroller.loadUser(true);
                  return cardController.homecontroller.newProducts(true);
                },
                child: Obx(() {
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
                                // cardController.getCartDataBottomView!.add(Carts.fromJson(v));
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

                              return Center(
                                child:
                                Column(

                                  children: [
                                    // SizedBox(height: 30,),
                                    Image.asset(
                                      'assets/img/empty_bag.png',
                                      fit: BoxFit.fill,
                                      width: 204,
                                      height: 267,
                                    ),
                                    // SizedBox(height: 20,),
                                    Text(
                                      "Hey, it feels so light!",
                                      style: GoogleFonts.inriaSans(
                                          textStyle: const TextStyle(
                                              fontSize: 20,
                                              color: AppColors.appText,
                                              fontWeight: FontWeight.w700)),
                                    ),
                                    SizedBox(height: 8,),
                                    Text("There is nothing in your bag. Lets’s add some items",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.inriaSans(

                                          textStyle: const TextStyle(

                                              fontSize: 14,
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w400)),
                                    ),

                                  ],),
                              );
                            }else{
                              // cardController.selectAllCartInit(getCartData);
                              return Column(
                                //controller: _scrollController,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // color: Colors.white,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Row(
                                        //   mainAxisAlignment:
                                        //   MainAxisAlignment.spaceBetween,
                                        //   children: [
                                        //     Padding(
                                        //       padding: const EdgeInsets.symmetric(
                                        //           horizontal: 15),
                                        //       child: ItemNuber(
                                        //         itemNumber: cardController.cartList.length,
                                        //       ),
                                        //     ),
                                        //     TextButton(
                                        //         onPressed: () {
                                        //           cardController.homecontroller.productIds.clear();
                                        //           AlertDialogs.showAlertDialog("Delete?", "Are you sure you want to delete from all Items?", () async {
                                        //             // Get.back();
                                        //             Navigator.pop(context);
                                        //             cardController.homecontroller.emptyCart(cardController.homecontroller.customerId.value);
                                        //           });
                                        //         },
                                        //         child: Text(
                                        //           'Clear all',
                                        //           style: TextStyle(
                                        //               color: Colors.redAccent,
                                        //               fontSize: 16),
                                        //         ))
                                        //   ],
                                        // ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: (){
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
                                                child: cardController.homecontroller.isAllCartSelected(getCartData)
                                                    ? Image.asset("assets/img/checked.png",fit: BoxFit.fill,height: 20,width: 20,)
                                                    : Image.asset("assets/img/unchecked.png",fit: BoxFit.fill,height: 20,width: 20,),

                                                  // ? Icon(Icons.check_box,size: 28,color: AppColors.appRed,)
                                                  //     : Icon(
                                                  // Icons.check_box_outline_blank,size: 28),
                                              ),
                                              SizedBox(width: 8,),
                                              Text(
                                                '${getCartData.length}/${cardController.homecontroller.productIds.length} ITEMS SELECTED',
                                                style: GoogleFonts.inriaSans(
                                                    textStyle:
                                                    const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                        FontWeight
                                                            .w700,
                                                        color: AppColors
                                                            .black)),
                                              ),

                                              Text(
                                            "(\u{20B9} ${homeController.totalAmount.toInt()})",
                                                // '(₹2,039)',
                                                style: GoogleFonts.inriaSans(
                                                    textStyle:
                                                    const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                        FontWeight
                                                            .w700,
                                                        color: AppColors
                                                            .appRed)),
                                              ),
                                              Spacer(),
                                              InkWell(

                                                child: Image.asset(
                                                  "assets/img/wishlist_heart.png",
                                                  fit: BoxFit.fill,
                                                  height: 20,
                                                  width: 20,
                                                ),
                                                onTap: (){
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return Dialog(

                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(0.0)),
                                                          //this right here
                                                          child: Container(
                                                            height: 135,
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets.all(8.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(child: Text("Move ${cardController.homecontroller.productIds.length} items to wishlist?",style: GoogleFonts.inriaSans(textStyle: TextStyle(color: AppColors.black,fontWeight: FontWeight.w400,fontSize: 16)))),
                                                                      InkWell(

                                                                        child: Icon(Icons.close,color: AppColors.black,),onTap: (){Get.back();},)

                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 16.0),
                                                                  child: Text("Are you sure you want to move ${cardController.homecontroller.productIds.length} items from bag?",style: GoogleFonts.inriaSans(textStyle: TextStyle(color: AppColors.appText1,fontWeight: FontWeight.w400,fontSize: 14))),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                                                  child: Container(height: 1,width: MediaQuery.of(context).size.width,color: AppColors.appLine,),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets.only(top: 5.0,bottom: 5.0),
                                                                  child: Row(
                                                                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                    children: [
                                                                      Expanded(
                                                                        child: InkWell(

                                                                          child: Center(child: Text("NO",style: GoogleFonts.inriaSans(textStyle: TextStyle(color: AppColors.appLine,fontWeight: FontWeight.w700,fontSize: 14)))),
                                                                          onTap: (){
                                                                            Get.back();
                                                                          },
                                                                        ),
                                                                      ),
                                                                      Container(height: 22,width: 1.5,color: AppColors.appLine,),
                                                                      Expanded(
                                                                        child: InkWell(
                                                                          child: Center(
                                                                            child: Text("MOVE TO WISHLIST",style: GoogleFonts.inriaSans(textStyle: TextStyle(color: AppColors.appRed,fontWeight: FontWeight.w700,fontSize: 14)),
                                                                            ),
                                                                          ),
                                                                          onTap: ()  async {



                                                                            // List<int> productIdList = [];
                                                                            String productIdS="";
                                                                            print("cardController.homecontroller.productIds ==================? ${cardController.homecontroller.productIds}");
                                                                            getCartData.forEach((element1) {
                                                                              cardController.homecontroller.productIds.forEach((element2) {
                                                                                print("element1.productId 11111 outside ${element1.productId}");
                                                                                print("element2.productId 22222 outside ${element2}");
                                                                                if(element1.productId == element2){
                                                                                  print("element1.productId 11111 ${element1.productId}");

                                                                                  print("element2.productId element1 ${element1.productName}");
                                                                                  // productIdList.add(int.parse(element1.productId!));
                                                                                  productIdS = productIdS+element1.productId!.toString()+",";
                                                                                }else{
                                                                                  print("element1.productId 11111 else ${element1.productId}");
                                                                                  print("element2.productId 22222 else ${element2}");
                                                                                }
                                                                              });

                                                                            });

                                                                            print(" productIdS ================ > $productIdS");
                                                                            print(" customerId ================ > ${cardController.homecontroller.customerId.value}");
                                                                            Get.back();

                                                                            cardController.homecontroller.moveToWishList(productIdS,cardController.homecontroller.customerId.value);

                                                                          },
                                                                        ),
                                                                      )
                                                                    ],),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5,),

                                  Column(
                                    children: [
                                      ...List.generate(
                                          getCartData.length,
                                              (index) {
                                            double mrp = double.parse(getCartData[index].mrpPrice!) * double.parse(getCartData[index].quantity!);
                                            double totalQty = double.parse(getCartData[index].netPrice!) * double.parse(getCartData[index].quantity!);
                                            return InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>  ProductDetailsScreen(
                                                          products: Products(productId: getCartData[index].productId!,productName: getCartData[index].productName!,variantCode: getCartData[index].variantCode!),
                                                          // article: articles[index],
                                                        )));
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom: 8.0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(bottom: 8,right: 16.0,left: 16.0,top: 3),
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


                                                          child: Stack(
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets.only(top: 15.0),
                                                                child: SizedBox(
                                                                  height: 100,
                                                                  width: 104,
                                                                  child: Image.network(
                                                                    // 'https://onlinehatiya.herokuapp.com' +
                                                                    //     cart!.product!.image!,

                                                                    imageUrl + getCartData[index].productId! + "/" + getCartData[index].coverImg!,
                                                                    // getCartData[index].coverImg!,
                                                                    fit: BoxFit.cover,),
                                                                ),
                                                              ),
                                                              Obx(() {

                                                                return InkWell(
                                                                  onTap: (){
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
                                                                  child: cardController.homecontroller.selectedCarts.contains(getCartData[index].cartId)
                                                                      ? Padding(
                                                                    padding: const EdgeInsets.only(left: 2.0),
                                                                    child: Container(
                                                                        alignment: Alignment.topLeft,


                                                                        child:

                                                                        //const Icon(Icons.check_box,color: AppColors.appRed,size: 28,)
                                                                        Image.asset("assets/img/checked.png",fit: BoxFit.fill,height: 20,width: 20,)

                                                                    ),
                                                                  )
                                                                      : Padding(
                                                                    padding: const EdgeInsets.only(left: 2.0),
                                                                    child: Container(
                                                                        alignment: Alignment.topLeft,child:
                                                                    Image.asset("assets/img/unchecked.png",fit: BoxFit.fill,height: 20,width: 20,)
                                                                    // const Icon(Icons.check_box_outline_blank,size: 28)


                                                                    ),
                                                                  ),
                                                                );
                                                                // return IconButton(
                                                                //     padding: EdgeInsets.all(0),
                                                                //     onPressed: () {
                                                                //       // productIds.clear();
                                                                //       cardController.selectCart(cardController.cartList[index]);
                                                                //       print("productIds first ${cardController.homecontroller.productIds}");
                                                                //       // print("contains ${productIds.contains(getCartData[index].cartId.toString())}");
                                                                //       // // print("contains ${productIds.where((item) => item.contains(getCartData[index].cartId.toString()))}" );
                                                                //       // if(productIds.contains(getCartData[index].cartId.toString())){
                                                                //       //   productIds.removeAt(index);
                                                                //       // }else{
                                                                //       //   productIds.add(getCartData[index].productId!);
                                                                //       // }
                                                                //       //
                                                                //       // print("productIds ${productIds}");
                                                                //
                                                                //       // List<String> myList = ['US', 'SG', 'US'];
                                                                //       print(cardController.homecontroller.productIds.where((item) => item.contains(cardController.cartList[index].productId!)));
                                                                //       var contain = cardController.homecontroller.productIds.where((item) => item.contains(cardController.cartList[index].productId!));
                                                                //       if (contain.isEmpty){
                                                                //         cardController.homecontroller.productIds.add(cardController.cartList[index].productId!);
                                                                //         print("productIds if ${cardController.homecontroller.productIds}");
                                                                //       }else{
                                                                //         cardController.homecontroller.productIds.removeWhere((item) => item == cardController.cartList[index].productId);
                                                                //         // productIds.removeAt(index);
                                                                //         print("productIds ${cardController.homecontroller.productIds}");
                                                                //       }
                                                                //
                                                                //
                                                                //     },
                                                                //     // icon: homeController.selectedCarts.contains(cart!.id)
                                                                //     icon: cardController.homecontroller.selectedCarts.contains(cardController.cartList[index].cartId)
                                                                //         ? const Icon(Icons.check_box)
                                                                //         : const Icon(Icons.check_box_outline_blank));
                                                              }),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 12, right: 10,top: 11),
                                                            child: SizedBox(
                                                              height: 110,
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                children: [
                                                                  Text(getCartData[index].productName!,
                                                                      maxLines: 1,
                                                                      style: GoogleFonts.inriaSans(
                                                                          textStyle: const TextStyle(
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.w700,
                                                                              color: AppColors.black))
                                                                  ),
                                                                  // const SizedBox(
                                                                  //   height: 3,
                                                                  // ),
                                                                  Text(getCartData[index].shortCode!,
                                                                      // style: GoogleFonts.ptSans(),
                                                                      overflow: TextOverflow.ellipsis,
                                                                      maxLines: 1,
                                                                      style: GoogleFonts.inriaSans(
                                                                          textStyle: const TextStyle(
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.w400,
                                                                              color: AppColors.black))
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 4,
                                                                  ),

                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              Container(

                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.all(2.0),
                                                                                  child: Text('${getCartData[index].quantity}',
                                                                                      style: GoogleFonts.inriaSans(
                                                                                          textStyle: TextStyle(
                                                                                              fontSize: 12,
                                                                                              fontWeight:
                                                                                              FontWeight.w400,
                                                                                              color: AppColors
                                                                                                  .black))
                                                                                  ),
                                                                                ),
                                                                                decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(3),
                                                                                    color:Colors.grey[100]
                                                                                ),
                                                                              ),
                                                                              SizedBox(width: 12,),
                                                                              Container(
                                                                                decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(3),
                                                                                    color: Colors.grey[100]
                                                                                ),
                                                                                child: InkWell(
                                                                                    onTap: () {
                                                                                      cardController.quantity(int.parse(getCartData[index].quantity!));
                                                                                      cardController.showButtomSheed(
                                                                                          context, () {

                                                                                      }, int.parse(getCartData[index].productId!),cardController.homecontroller.customerId.value);
                                                                                    },
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.all(2.0),
                                                                                      child: Text('Qty:${getCartData[index].quantity} ▾',
                                                                                          style: GoogleFonts.inriaSans(
                                                                                              textStyle: TextStyle(
                                                                                                  fontSize: 12,
                                                                                                  fontWeight:
                                                                                                  FontWeight.w400,
                                                                                                  color: AppColors
                                                                                                      .black))
                                                                                      ),
                                                                                    )),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          const SizedBox(
                                                                            height: 4,
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              Text(
                                                                                  '\u{20B9} ' + "${totalQty.toStringAsFixed(0)}",
                                                                                  style: GoogleFonts.inriaSans(
                                                                                      textStyle: TextStyle(
                                                                                          fontSize: 12,
                                                                                          fontWeight:
                                                                                          FontWeight.w700,
                                                                                          color: AppColors
                                                                                              .black))
                                                                              ),
                                                                              SizedBox(width: 5,),
                                                                              Text(
                                                                                '\u{20B9} ' + "${mrp.toStringAsFixed(0)}",
                                                                                style: GoogleFonts.inriaSans(
                                                                                    textStyle: TextStyle(
                                                                                        fontSize: 12,
                                                                                        decoration:
                                                                                        TextDecoration
                                                                                            .combine([
                                                                                          TextDecoration
                                                                                              .lineThrough
                                                                                        ]),
                                                                                        fontWeight:
                                                                                        FontWeight.w700,
                                                                                        color: AppColors
                                                                                            .appText1)),
                                                                              ),
                                                                              SizedBox(width: 5,),
                                                                              Text(
                                                                                 getCartData[index].discount.toString()+" % OFF" ,
                                                                                  style: GoogleFonts.inriaSans(
                                                                                      textStyle: TextStyle(
                                                                                          fontSize: 12,
                                                                                          fontWeight:
                                                                                          FontWeight.w700,
                                                                                          color: AppColors
                                                                                              .appRed))
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(height: 4,),
                                                                          Row(
                                                                            children: [
                                                                              Image.asset("assets/img/Shape.png",fit: BoxFit.fill,height: 12,width: 12,),
                                                                              SizedBox(width: 5,),
                                                                              Text("Delivery by ",
                                                                                  style: GoogleFonts.inriaSans(
                                                                                      textStyle: TextStyle(
                                                                                          fontSize: 10,
                                                                                          fontWeight:
                                                                                          FontWeight.w700,
                                                                                          color: AppColors
                                                                                              .appText1))
                                                                              ),

                                                                              Text(" 24 Sep 2022",
                                                                                  style: GoogleFonts.inriaSans(
                                                                                      textStyle: TextStyle(
                                                                                          fontSize: 10,
                                                                                          fontWeight:
                                                                                          FontWeight.w700,
                                                                                          color: AppColors
                                                                                              .black))
                                                                              ),
                                                                            ],
                                                                          ),

                                                                        ],
                                                                      ),
                                                                      // SizedBox(width: 8,),
                                                                      //

                                                                    ],
                                                                  ),

                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 8.0,right: 2),
                                                          child: InkWell(

                                                            child: Image.asset("assets/img/close.png",fit: BoxFit.fill,height: 17,width: 17,),onTap: (){
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

                                                          },),
                                                        )
                                                      ],
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,

                                                    ),
                                                  ),
                                                ),
                                              ),
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
                                  Container(

                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0,
                                          left: 16.0,bottom: 8),
                                      child: Text("COUPONS",
                                          style: GoogleFonts.inriaSans(
                                              textStyle: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.appText))),
                                    ),
                                    // color: Colors.green,
                                  ),
                                  Container(

                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 16.0,right: 16.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                "assets/img/coupons.png",
                                                fit: BoxFit.fill,
                                                height: 20,
                                                width: 20,
                                              ),
                                              SizedBox(width: 12,),
                                              Text("Apply Coupon",
                                                  style: GoogleFonts.inriaSans(
                                                      textStyle: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold,
                                                          color: AppColors.black))),
                                            ],
                                          ),
                                          Image.asset(
                                            "assets/img/arrow_right.png",
                                            fit: BoxFit.fill,
                                            height: 15,
                                            width: 8,
                                          )
                                        ],),
                                    ),color: AppColors.white,
                                  height: 40,
                                  ),
                                  SizedBox(height: 16.0,),
                                  Container(
                                    color: AppColors.white,

                                    width: MediaQuery.of(context).size.width,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,

                                          children: [
                                            Text("PRICE DETAILS(${cardController.homecontroller.productIds.length} ITEMS)",
                                                style: GoogleFonts.inriaSans(
                                                    textStyle: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.bold,
                                                        color: AppColors.black))),
                                            SizedBox(height: 8,),
                                            Container(
                                              height: 1,
                                              width: MediaQuery.of(context).size.width,
                                              color: Colors.grey[200],
                                            ),
                                            SizedBox(height: 8,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text("Total MRP",
                                                    style: GoogleFonts.inriaSans(
                                                        textStyle: const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w400,
                                                            color: AppColors.black))),
                                                Text("₹ ${homeController.totalMRP.toInt()}",
                                                    style: GoogleFonts.inriaSans(
                                                        textStyle: const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w400,
                                                            color: AppColors.black))),
                                              ],
                                            ),
                                            SizedBox(height: 8,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text("Discount on MRP",
                                                    style: GoogleFonts.inriaSans(
                                                        textStyle: const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w400,
                                                            color: AppColors.black))),
                                                Text("-₹ ${homeController.totalDISCOUNT.toInt()}",
                                                    style: GoogleFonts.inriaSans(
                                                        textStyle: const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w400,
                                                            color: AppColors.appGreen))),
                                              ],
                                            ),
                                            SizedBox(height: 8,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text("Coupon Discount",
                                                    style: GoogleFonts.inriaSans(
                                                        textStyle: const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w400,
                                                            color: AppColors.black))),
                                                Text("Apply Coupon",
                                                    style: GoogleFonts.inriaSans(
                                                        textStyle: const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w400,
                                                            color: AppColors.appRed))),
                                              ],
                                            ),
                                            SizedBox(height: 8,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text("Convenience Fee",
                                                        style: GoogleFonts.inriaSans(
                                                            textStyle: const TextStyle(
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.w400,
                                                                color: AppColors.black))),
                                                    Text(" Know More",
                                                        style: GoogleFonts.inriaSans(
                                                            textStyle: const TextStyle(
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.w400,
                                                                color: AppColors.appRed))),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text("₹99",
                                                        style: GoogleFonts.inriaSans(
                                                            textStyle: TextStyle(
                                                                fontSize: 12,
                                                                decoration:
                                                                TextDecoration
                                                                    .combine([
                                                                  TextDecoration
                                                                      .lineThrough
                                                                ]),
                                                                fontWeight:
                                                                FontWeight.w400,
                                                                color: AppColors
                                                                    .black))),
                                                    SizedBox(width: 5.0,),
                                                    Text("FREE",
                                                        style: GoogleFonts.inriaSans(
                                                            textStyle: const TextStyle(
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.w400,
                                                                color: AppColors.appRed))),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 8,),
                                            Container(
                                              height: 1,
                                              width: MediaQuery.of(context).size.width,
                                              color: Colors.grey[200],
                                            ),
                                            SizedBox(height: 8,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text("Total Amount",
                                                    style: GoogleFonts.inriaSans(
                                                        textStyle: const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w700,
                                                            color: AppColors.black))),
                                                Text("₹ ${homeController.totalAmount.toInt()}",
                                                    style: GoogleFonts.inriaSans(
                                                        textStyle: const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w700,
                                                            color: AppColors.black))),
                                              ],
                                            ),
                                          ],),
                                      ),
                                    ),
                                  )




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


                      ],
                    );
                  } else {
                    if (cardController.homecontroller.isRefresh.value !=
                        true) {
                      return Container(
                        // height: MediaQuery.of(context).size.height-120,
                          child: Center(
                              child: CircularProgressIndicator(
                                  color: AppColors.appColor))
                      );
                    } else {
                      return Container(
                        // height: 200,
                      );
                    }
                  }
                }),
              ),
            ),
          ],
        ),
      ),


      bottomNavigationBar:
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

            return Container(height: 0,

            );
          }else{
            // cardController.selectAllCartInit(getCartData);
            return Wrap(
              children: [
                Container(

                  width: MediaQuery.of(context).size.width,
                  child: Column(children: [
                    // Container(
                    //
                    //   width: MediaQuery.of(context).size.width,
                    //   height: 20,
                    //   color: AppColors.selectedItem,
                    //   child: Center(
                    //     child: Text("${cardController.homecontroller.productIds.length} Items selected for order", style: GoogleFonts.inriaSans(
                    //         textStyle: TextStyle(
                    //             fontSize: 12,
                    //             fontWeight:
                    //             FontWeight.w400,
                    //             color: AppColors
                    //                 .black))),
                    //   ),
                    // ),
                    InkWell(
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
                                "PLACE ORDER",
                                style: GoogleFonts.inriaSans(
                                  textStyle: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
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
                        // String stringList = cardController.homecontroller.productIds.join(",");
                        // print("product list ${stringList}");
                        //
                        // if(profileController.customerId.value == ""){
                        //   AlertDialogs.showLoginRequiredDialog();
                        // }else if(cartList.isEmpty){
                        //   AlertDialogs.showAlertDialog("Cart?", "Please minimum 1 item add to cart", ()  {
                        //     Get.back();
                        //   });
                        // } else if(productIds.isEmpty){
                        //   AlertDialogs.showAlertDialog("Cart?", "Please select minimum 1 item", ()  {
                        //     Get.back();
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


                        if(cardController.homecontroller.productIds.isEmpty){
                          SnackBarDialog.showSnackbar('Error',"Please select minimum 1 item");
                        }else{
                          List<Carts> finaCartList = [];
                          List<int> productIdList = [];
                          print("cardController.homecontroller.productIds ==================? ${cardController.homecontroller.productIds}");
                          getCartData.forEach((element1) {
                            cardController.homecontroller.productIds.forEach((element2) {
                              print("element1.productId 11111 outside ${element1.productId}");
                              print("element2.productId 22222 outside ${element2}");
                              if(element1.productId == element2){
                                print("element1.productId 11111 ${element1.productId}");

                                print("element2.productId element1 ${element1.productName}");
                                finaCartList.add(element1);
                                productIdList.add(int.parse(element1.productId!));
                              }else{
                                print("element1.productId 11111 else ${element1.productId}");
                                print("element2.productId 22222 else ${element2}");
                              }
                            });

                          }

                          );
                          // homeController.checkOut(stringList);
                          Get.toNamed(Routes.checkOut,arguments: [{"cartList": finaCartList}, {"imagePath": imageUrl},{"productIdList": productIdList}]);
                        }


                      },
                    )
                  ],),
                ),
              ],
            );
          }

        } else {
          return Container(height: 0,);
          return  Container(
              height: 90,
              child: Center(child: CircularProgressIndicator(color: Style.Colors.appColor)));

        }
      }),


      // cardController.getCartDataBottomView!.isEmpty?Container(height: 0,):
      //
      //
      // Wrap(
      //   children: [
      //     Container(
      //
      //       width: MediaQuery.of(context).size.width,
      //       child: Column(children: [
      //         Container(
      //
      //           width: MediaQuery.of(context).size.width,
      //           height: 20,
      //           color: AppColors.selectedItem,
      //           child: Center(
      //             child: Text("2 Items selected for order", style: GoogleFonts.inriaSans(
      //                 textStyle: TextStyle(
      //                     fontSize: 12,
      //                     fontWeight:
      //                     FontWeight.w400,
      //                     color: AppColors
      //                         .black))),
      //           ),
      //         ),
      //         InkWell(
      //           child: Padding(
      //             padding: const EdgeInsets.only(top: 8.0,bottom: 8.0,left: 16.0,right: 16.0),
      //             child: Container(
      //               height: 36,
      //               width: MediaQuery.of(context).size.width,
      //               color: AppColors.appRed,
      //               child: Center(
      //                 child: Padding(
      //                   padding: const EdgeInsets.only(
      //                     bottom: 8.0,
      //                     top: 8.0,
      //                   ),
      //                   child: Text(
      //                     "PLACE ORDER",
      //                     style: GoogleFonts.inriaSans(
      //                       textStyle: const TextStyle(
      //                           fontSize: 16,
      //                           color: Colors.white,
      //                           fontWeight: FontWeight.bold),
      //                     ),
      //                     // style: const TextStyle(
      //                     //     fontSize: 23,
      //                     //     fontWeight: FontWeight.w500),
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           ),
      //           onTap: () {
      //             // String stringList = cardController.homecontroller.productIds.join(",");
      //             // print("product list ${stringList}");
      //             //
      //             // if(profileController.customerId.value == ""){
      //             //   AlertDialogs.showLoginRequiredDialog();
      //             // }else if(cartList.isEmpty){
      //             //   AlertDialogs.showAlertDialog("Cart?", "Please minimum 1 item add to cart", ()  {
      //             //     Get.back();
      //             //   });
      //             // } else if(productIds.isEmpty){
      //             //   AlertDialogs.showAlertDialog("Cart?", "Please select minimum 1 item", ()  {
      //             //     Get.back();
      //             //   });
      //             // }else{
      //             //   List<Carts> finaCartList = [];
      //             //   cartList.forEach((element1) {
      //             //     productIds.forEach((element2) {
      //             //       print("element1.productId 11111 outside ${element1.productId}");
      //             //       print("element2.productId 22222 outside ${element2}");
      //             //       if(element1.productId == element2){
      //             //         print("element1.productId 11111 ${element1.productId}");
      //             //
      //             //         print("element2.productId element1 ${element1.productName}");
      //             //         finaCartList.add(element1);
      //             //       }else{
      //             //         print("element1.productId 11111 else ${element1.productId}");
      //             //         print("element2.productId 22222 else ${element2}");
      //             //       }
      //             //     });
      //             //
      //             //   });
      //             //   // homeController.checkOut(stringList);
      //             //   Get.toNamed(Routes.checkOut,arguments: [{"cartList": finaCartList}, {"imagePath": imagePath}]);
      //             // }
      //
      //
      //             List<Carts> finaCartList = [];
      //             // cardController.cartList.forEach((element1) {
      //             //   cardController.homecontroller.productIds.forEach((element2) {
      //             //     print("element1.productId 11111 outside ${element1.productId}");
      //             //     print("element2.productId 22222 outside ${element2}");
      //             //     if(element1.productId == element2){
      //             //       print("element1.productId 11111 ${element1.productId}");
      //             //
      //             //       print("element2.productId element1 ${element1.productName}");
      //             //       finaCartList.add(element1);
      //             //     }else{
      //             //       print("element1.productId 11111 else ${element1.productId}");
      //             //       print("element2.productId 22222 else ${element2}");
      //             //     }
      //             //   });
      //             //
      //             // }
      //             //
      //             // );
      //             // homeController.checkOut(stringList);
      //             Get.toNamed(Routes.checkOut,arguments: [{"cartList": finaCartList}, {"imagePath": "imagePath"}]);
      //           },
      //         )
      //       ],),
      //     ),
      //   ],
      // )





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
      // bottomNavigationBar:
      // Obx((){
      //   return  CheckoutCart(
      //     totalAmount: cardController.homecontroller.totalAmount.value,
      //     productIds: cardController.homecontroller.productIds,
      //       cartList : cardController.homecontroller.cartList,
      //     imagePath: cardController.homecontroller.imagePath,
      //   );
      // })

    );
  }
}
