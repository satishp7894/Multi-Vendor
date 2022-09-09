import 'package:eshoperapp/constants/app_costants.dart';
import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/models/product.dart';
import 'package:eshoperapp/models/product_detail.dart';
import 'package:eshoperapp/models/products.dart';
import 'package:eshoperapp/package/product_rating.dart';
import 'package:eshoperapp/pages/details/product_details_controller.dart';
import 'package:eshoperapp/pages/details/view/add_cart.dart';
import 'package:eshoperapp/pages/landing_home/home_controller.dart';
import 'package:eshoperapp/routes/navigation.dart';
import 'package:eshoperapp/utils/check_internet.dart';
import 'package:eshoperapp/widgets/product_gridview_tile.dart';
import 'package:eshoperapp/widgets/product_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:share/share.dart';

import '../../config/theme.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Products? products;
  const ProductDetailsScreen({Key? key, required this.products}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  ProductDetailsController? productDetailsController;
  Products? products;
  final homecontroller = Get.put(HomeController(
      localRepositoryInterface: Get.find(),
      apiRepositoryInterface: Get.find()));

  @override
  void initState() {
    // TODO: implement initState
    // TODO: implement initState
    // dynamic argumentData = Get.arguments;
    products = widget.products;
    print("productObj productDetailId ${products!.productId}");
    productDetailsController = Get.put(ProductDetailsController(
        apiRepositoryInterface: Get.find(), productDetailId: products!.productId!, localRepositoryInterface: Get.find()));
    productDetailsController!.productDetails(products!.productId!, false);
    super.initState();
  }

  @override
  void dispose() {
    productDetailsController!.selectedImage!(0);
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.appColor,size: 30,),
          onPressed: () =>
              Navigator.of(context, rootNavigator: true).pop(),
        ),
        title: Text(products!.productName.toString(),style: const TextStyle(fontSize: 20,color: AppColors.appColor)),
        // actions: [
        //   Center(
        //     child: Padding(
        //       padding: const EdgeInsets.only(right: 20.0),
        //       child: InkWell(
        //         onTap: (){
        //           Navigator.of(context).pushNamed(Routes.cart);
        //         },
        //         child: Stack(
        //           children: <Widget>[
        //             Icon(CupertinoIcons.cart,color: Colors.black,size: 30,),
        //         Positioned(
        //           right: 0,
        //           child: Container(
        //             padding: const EdgeInsets.all(1),
        //             decoration: BoxDecoration(
        //               color: Colors.red,
        //               borderRadius: BorderRadius.circular(6),
        //             ),
        //             constraints: const BoxConstraints(
        //               minWidth: 12,
        //               minHeight: 12,
        //             ),
        //             child: Text(
        //               // "homecontroller.cartList.length.toString()",
        //               "5",
        //               style: const TextStyle(
        //                 color: Colors.white,
        //                 fontSize: 8,
        //               ),
        //               textAlign: TextAlign.center,
        //             ),
        //           ),
        //         )
        //
        //           ],
        //         ),
        //       ),
        //     ),
        //   ),
        // ],
      ),
      //body: Center(child: Text(controller.totalAmount.toString())),
      body:

      RefreshIndicator(
        onRefresh: () {
          CheckInternet.checkInternet();
          return productDetailsController!.productDetails(products!.productId!, true);;
        },
            child:
            Obx((){

                if(productDetailsController!.isLoadingProductDetail.value != true){

                  MainResponse? mainResponse = productDetailsController!.productDetailObj.value;
                  List<ProductDetail>? productDetailData = [];

                  // mainResponse.data!.map((e) => customerProfileData!.add(UpdateCustomerPasswordData.fromJson(e))).toList();

                  if(mainResponse.data != null){
                    mainResponse.data!.forEach((v) {
                      productDetailData.add( ProductDetail.fromJson(v));
                    });
                    print("productDetailData[0].description ${productDetailData[0].description}");
                  }


                  String? imageUrl = mainResponse.imageUrl ?? "";
                  String? message = mainResponse.message ?? AppConstants.noInternetConn;

                  if (productDetailData.isEmpty) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
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
                                style: const TextStyle(color: Colors.black45),
                              ),
                            ),
                          ),

                        ],
                      ),
                    );
                  }else{
                    return  ListView(
                      // shrinkWrap: true,
                      children: [
                        Container(color: Colors.grey.withOpacity(0.1),
                          child: SafeArea(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Obx((){
                                    return SizedBox(
                                      height: 300,
                                      child: Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: [
                                          IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back_ios)),
                                          PhotoViewGallery.builder(
                                            scrollPhysics:
                                            const BouncingScrollPhysics(),
                                            builder:
                                                (BuildContext context, int index) {
                                              return PhotoViewGalleryPageOptions(
                                                disableGestures: true,
                                                imageProvider: NetworkImage( imageUrl + "/"+
                                                    productDetailData[0]
                                                        .image![productDetailsController!
                                                        .selectedImage!.value]),
                                                initialScale:
                                                PhotoViewComputedScale.contained *
                                                   1.0,

                                              );
                                            },
                                            itemCount: productDetailData[0]
                                                .image!.length,
                                            loadingBuilder: (context, progress) =>
                                                Center(
                                                  child: SizedBox(
                                                    width: 20.0,
                                                    height: 20.0,
                                                    child: CircularProgressIndicator(
                                                      value: progress == null
                                                          ? null
                                                          : progress
                                                          .cumulativeBytesLoaded /
                                                          progress
                                                              .expectedTotalBytes!,
                                                    ),
                                                  ),
                                                ),
                                            pageController: null,
                                            backgroundDecoration:
                                            const BoxDecoration(color: Colors.white),
                                            onPageChanged: (int index) {
                                              productDetailsController!.selectedImage!(index);
                                            },
                                          ),

                                          Positioned(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(30),
                                                  color: Colors.black.withOpacity(0.4)),
                                              height: 25,
                                              width: 40,
                                              child: Center(
                                                child:

                                                //Text("5")
                                                Text(
                                                  productDetailData[0]
                                                      .image!.length == 0
                                                      ? '${productDetailsController!.index + 1} '
                                                      '/' +
                                                      '${productDetailData[0]
                                                          .image!.length + 1}'
                                                      : '${productDetailsController!.index + 1} '
                                                      '/' +
                                                      productDetailData[0]
                                                          .image!.length.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 18, color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),

                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10.0,bottom: 5.0,top: 5),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    '\u{20B9}' + double.parse(productDetailData[0].mrpPrice!).toStringAsFixed(0),
                                                    style: TextStyle(
                                                        decoration: TextDecoration.combine(
                                                            [ TextDecoration.lineThrough]),
                                                        fontSize: 20,
                                                        color: Colors.grey),
                                                  ),
                                                  const SizedBox(width: 10,),
                                                  Text(
                                                    '\u{20B9}' + double.parse(productDetailData[0].netPrice!).toStringAsFixed(0),
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                  const SizedBox(width: 10,),
                                                  Text(
                                                    productDetailData[0].discount! + "% off",
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.redAccent),
                                                  ),
                                                ],
                                              ),

                                              // Row(
                                              //   children: [
                                              //     // Obx(() {
                                              //     //   return AnimatedContainer(
                                              //     //     // height:
                                              //     //     //     controller.initbool.value ? 50 : 30,
                                              //     //     duration: Duration(microseconds: 500),
                                              //     //     child: IconButton(
                                              //     //         onPressed: () {
                                              //     //           // controller.makeFavorite(
                                              //     //           //     args.product!.id);
                                              //     //           //
                                              //     //           // homecontroller.fetchProduct();
                                              //     //         },
                                              //     //         icon: productDetailsController!.initbool.value
                                              //     //             ? Icon(
                                              //     //           Icons.favorite,
                                              //     //           color: Colors.red,
                                              //     //           size: 30,
                                              //     //         )
                                              //     //             : Icon(
                                              //     //           Icons.favorite_border,
                                              //     //         )),
                                              //     //   );
                                              //     // }),
                                              //     // FavoriteBTN(
                                              //     //   controller:
                                              //     //       controller.animationController,
                                              //     //   colorTween: controller.colorAnimation,
                                              //     // ),
                                              //     // IconButton(
                                              //     //     onPressed: () {
                                              //     //       Share.share('App link not available');
                                              //     //     },
                                              //     //     icon: Icon(Icons.share)),
                                              //   ],
                                              // )
                                            ],
                                          ),
                                          Text(
                                            productDetailData[0].productName!,
                                            style: const TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                          // SizedBox(
                                          //   height: 5,
                                          // ),
                                          // Row(
                                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          //   children: [
                                          //     InkWell(
                                          //       // onTap: () => Scrollable.ensureVisible(
                                          //       //     dataKey.currentContext!),
                                          //       child: Row(
                                          //         children: [
                                          //           // ProductRating(
                                          //           //   rating: args.product!.avaragereview,
                                          //           //   isReadOnly: true,
                                          //           //   size: 15,
                                          //           //   filledIconData: Icons.star,
                                          //           //   borderColor:
                                          //           //   Colors.red.withOpacity(0.8),
                                          //           //   color: Colors.red,
                                          //           //   halfFilledIconData: Icons.star_half,
                                          //           //   defaultIconData: Icons.star_border,
                                          //           //   starCount: 5,
                                          //           //   allowHalfRating: true,
                                          //           // ),
                                          //           SizedBox(
                                          //             width: 5,
                                          //           ),
                                          //           // Text(
                                          //           //   args.product!.avaragereview.toString(),
                                          //           //   style: TextStyle(color: Colors.red),
                                          //           // ),
                                          //           // Text(
                                          //           //   ' / ' +
                                          //           //       '(${args.product!.noOfReviews}) reviews',
                                          //           //   style: TextStyle(color: Colors.red),
                                          //           // )
                                          //         ],
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10, bottom: 10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              RichText(
                                                  text: TextSpan(
                                                      text: 'Seller:',
                                                      style: const TextStyle(color: Colors.black),
                                                      children: [
                                                        TextSpan(
                                                            text: " "+productDetailData[0].vendorName!,
                                                            style: const TextStyle(color: Colors.black))
                                                      ])),
                                              // Container(
                                              //   decoration: BoxDecoration(
                                              //     border: Border.all(color: Colors.grey),
                                              //   ),
                                              //   child: Padding(
                                              //     padding: const EdgeInsets.all(5.0),
                                              //     child: Text('View Shop',
                                              //         style: TextStyle(color: Colors.green)),
                                              //   ),
                                              // )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  // Container(
                                  //   height: 90,
                                  //   width: double.infinity,
                                  //   decoration: BoxDecoration(color: Colors.white),
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.all(8.0),
                                  //     child: Column(
                                  //       mainAxisAlignment: MainAxisAlignment.start,
                                  //       crossAxisAlignment: CrossAxisAlignment.start,
                                  //       children: [
                                  //         Text(
                                  //           'Easy 7 days return and Exchange',
                                  //           style: TextStyle(
                                  //             fontSize: 16,
                                  //           ),
                                  //         ),
                                  //         SizedBox(
                                  //           height: 5,
                                  //         ),
                                  //         Text(
                                  //           'You can return the product within 7 days if the product is damaged, expired , different from order',
                                  //           overflow: TextOverflow.clip,
                                  //           style: TextStyle(
                                  //               fontSize: 15,
                                  //               color: Colors.black.withOpacity(0.6)),
                                  //         )
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                  const SizedBox(
                                    height: 10,
                                  ),

                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all( 10,),
                                      child:
                                      HtmlWidget(productDetailData[0].description!),
                                      // Html(
                                      //   data: productDetailData[0].description,
                                      //   tagsList: Html.tags..addAll(["bird", "flutter"]),
                                      //   style: {
                                      //     "table": Style(
                                      //       backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                                      //     ),
                                      //     "tr": Style(
                                      //       border: Border(bottom: BorderSide(color: Colors.grey)),
                                      //     ),
                                      //     "th": Style(
                                      //       padding: EdgeInsets.all(6),
                                      //       backgroundColor: Colors.grey,
                                      //     ),
                                      //     "td": Style(
                                      //       padding: EdgeInsets.all(6),
                                      //       alignment: Alignment.topLeft,
                                      //     ),
                                      //     'h5': Style(maxLines: 2, textOverflow: TextOverflow.ellipsis),
                                      //   },
                                      //   customRender: {
                                      //     "table": (context, child) {
                                      //       return SingleChildScrollView(
                                      //         scrollDirection: Axis.horizontal,
                                      //         child:
                                      //         (context.tree as TableLayoutElement).toWidget(context),
                                      //       );
                                      //     },
                                      //     "bird": (RenderContext context, Widget child) {
                                      //       return TextSpan(text: "🐦");
                                      //     },
                                      //     "flutter": (RenderContext context, Widget child) {
                                      //       return FlutterLogo(
                                      //         style: (context.tree.element!.attributes['horizontal'] != null)
                                      //             ? FlutterLogoStyle.horizontal
                                      //             : FlutterLogoStyle.markOnly,
                                      //         textColor: context.style.color!,
                                      //         size: context.style.fontSize!.size! * 5,
                                      //       );
                                      //     },
                                      //   },
                                      //
                                      //   // renderNewlines: true,
                                      //   // defaultTextStyle: TextStyle(
                                      //   //     fontSize: 14.0,
                                      //   //     color: Colors.black87),
                                      // ),

                                      // Column(
                                      //   crossAxisAlignment: CrossAxisAlignment.start,
                                      //   children: [
                                      //     // Text(
                                      //     //   'Specification',
                                      //     //   style: TextStyle(
                                      //     //     fontSize: 16,
                                      //     //   ),
                                      //     // ),
                                      //     // SizedBox(
                                      //     //   height: 5,
                                      //     // ),
                                      //     // Column(
                                      //     //   crossAxisAlignment: CrossAxisAlignment.start,
                                      //     //   children: [
                                      //     //     ...List.generate(
                                      //     //       args.product!.productSpecification!.length,
                                      //     //           (index) => Padding(
                                      //     //         padding: const EdgeInsets.only(bottom: 5),
                                      //     //         child: Row(
                                      //     //           crossAxisAlignment:
                                      //     //           CrossAxisAlignment.start,
                                      //     //           children: [
                                      //     //             Text(
                                      //     //               '•',
                                      //     //               style: TextStyle(fontSize: 18),
                                      //     //             ),
                                      //     //             SizedBox(
                                      //     //               width: 10,
                                      //     //             ),
                                      //     //             Expanded(
                                      //     //               child: Text(
                                      //     //                 args
                                      //     //                     .product!
                                      //     //                     .productSpecification![index]
                                      //     //                     .point!,
                                      //     //                 overflow: TextOverflow.clip,
                                      //     //                 style: TextStyle(
                                      //     //                     fontSize: 15,
                                      //     //                     color: Colors.black
                                      //     //                         .withOpacity(0.6)),
                                      //     //               ),
                                      //     //             ),
                                      //     //           ],
                                      //     //         ),
                                      //     //       ),
                                      //     //     )
                                      //     //   ],
                                      //     // )
                                      //   ],
                                      // ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: ExpansionTile(
                                        expandedAlignment: Alignment.topLeft,
                                        title: const Text(
                                          'Product Details',
                                          style:  TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 15, bottom: 15,right: 15),
                                            child:
                                            // Html(
                                            //   data: productDetailData[0].description,
                                            //   // renderNewlines: true,
                                            //   // defaultTextStyle: TextStyle(
                                            //   //     fontSize: 14.0,
                                            //   //     color: Colors.black87),
                                            // ),
                                            Text(
                                              productDetailData[0].shortDescription.toString(),
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black.withOpacity(0.6)),
                                            ),
                                          )
                                        ],
                                      )),
                                  // SizedBox(height: 10),
                                  // Obx(() {
                                  //   if (!controller.isCommentsLoad.value)
                                  //     return Container(
                                  //       color: Colors.white,
                                  //       // key: dataKey,
                                  //       child: Column(
                                  //         crossAxisAlignment: CrossAxisAlignment.start,
                                  //         mainAxisAlignment: MainAxisAlignment.start,
                                  //         children: [
                                  //           Padding(
                                  //             padding: const EdgeInsets.all(8.0),
                                  //             child: Row(
                                  //               mainAxisAlignment:
                                  //               MainAxisAlignment.spaceBetween,
                                  //               children: [
                                  //                 Text(
                                  //                   'Rating & Reviews (${controller.comments.length})',
                                  //                   style: TextStyle(fontSize: 16),
                                  //                 ),
                                  //                 InkWell(
                                  //                   onTap: () {},
                                  //                   child: Container(
                                  //                     decoration: BoxDecoration(
                                  //                         border: Border.all(
                                  //                             color: Colors.grey
                                  //                                 .withOpacity(0.4))),
                                  //                     child: Padding(
                                  //                       padding: const EdgeInsets.all(8.0),
                                  //                       child: Text(
                                  //                         'Rate Product',
                                  //                         style:
                                  //                         TextStyle(color: Colors.blue),
                                  //                       ),
                                  //                     ),
                                  //                   ),
                                  //                 )
                                  //               ],
                                  //             ),
                                  //           ),
                                  //           ...List.generate(
                                  //               controller.comments.length > 3
                                  //                   ? 3
                                  //                   : controller.comments.length,
                                  //                   (index) => !controller.isCommentsLoad.value
                                  //                   ? Card(
                                  //                 child: Padding(
                                  //                   padding: const EdgeInsets.all(8.0),
                                  //                   child: Column(
                                  //                     mainAxisAlignment:
                                  //                     MainAxisAlignment.start,
                                  //                     crossAxisAlignment:
                                  //                     CrossAxisAlignment.start,
                                  //                     children: [
                                  //                       Row(
                                  //                         crossAxisAlignment:
                                  //                         CrossAxisAlignment.end,
                                  //                         mainAxisAlignment:
                                  //                         MainAxisAlignment
                                  //                             .spaceBetween,
                                  //                         children: [
                                  //                           Text(controller
                                  //                               .comments[index]
                                  //                               .comment!),
                                  //                           Spacer(),
                                  //                           ProductRating(
                                  //                             rating: controller
                                  //                                 .comments[index].rate!
                                  //                                 .toDouble(),
                                  //                             isReadOnly: true,
                                  //                             size: 12,
                                  //                             filledIconData:
                                  //                             Icons.star,
                                  //                             borderColor: Colors.red
                                  //                                 .withOpacity(0.8),
                                  //                             color: Colors.red,
                                  //                             halfFilledIconData:
                                  //                             Icons.star_half,
                                  //                             defaultIconData:
                                  //                             Icons.star_border,
                                  //                             starCount: 5,
                                  //                             allowHalfRating: true,
                                  //                           ),
                                  //                           SizedBox(
                                  //                             width: 15,
                                  //                           )
                                  //                         ],
                                  //                       ),
                                  //                       SizedBox(
                                  //                         height: 20,
                                  //                       ),
                                  //                       Row(
                                  //                         mainAxisAlignment:
                                  //                         MainAxisAlignment
                                  //                             .spaceBetween,
                                  //                         children: [
                                  //                           Text(
                                  //                             controller.comments[index]
                                  //                                 .user!.username!
                                  //                                 .replaceAll(
                                  //                                 '@gmail.com',
                                  //                                 '*****'),
                                  //                             style: TextStyle(
                                  //                                 color: Colors.black
                                  //                                     .withOpacity(
                                  //                                     0.6)),
                                  //                           ),
                                  //                           Text(
                                  //                             ' | ' +
                                  //                                 controller
                                  //                                     .comments[index]
                                  //                                     .whenpublished!,
                                  //                             style: TextStyle(
                                  //                                 fontSize: 14,
                                  //                                 color: Colors.black
                                  //                                     .withOpacity(
                                  //                                     0.6)),
                                  //                           ),
                                  //                           Spacer(),
                                  //                           IconButton(
                                  //                               icon: Icon(
                                  //                                 Icons
                                  //                                     .thumb_up_alt_outlined,
                                  //                                 size: 12,
                                  //                                 color: controller
                                  //                                     .comments[
                                  //                                 index]
                                  //                                     .like ==
                                  //                                     true
                                  //                                     ? Colors.blue
                                  //                                     : Colors.black,
                                  //                               ),
                                  //                               onPressed: () {
                                  //                                 controller.likeBtn(
                                  //                                     controller
                                  //                                         .comments[
                                  //                                     index]
                                  //                                         .id,
                                  //                                     args.product!.id);
                                  //                               }),
                                  //                           Text(
                                  //                             controller.comments[index]
                                  //                                 .getTotalLikes ==
                                  //                                 null
                                  //                                 ? '0'
                                  //                                 : controller
                                  //                                 .comments[index]
                                  //                                 .getTotalLikes
                                  //                                 .toString(),
                                  //                             style: TextStyle(
                                  //                                 fontSize: 12),
                                  //                           ),
                                  //                           IconButton(
                                  //                               icon: Icon(
                                  //                                 Icons
                                  //                                     .thumb_down_outlined,
                                  //                                 size: 12,
                                  //                                 color: controller
                                  //                                     .comments[
                                  //                                 index]
                                  //                                     .dislike ==
                                  //                                     true
                                  //                                     ? Colors.blue
                                  //                                     : Colors.black,
                                  //                               ),
                                  //                               onPressed: () {
                                  //                                 controller.dislikeBtn(
                                  //                                     controller
                                  //                                         .comments[
                                  //                                     index]
                                  //                                         .id,
                                  //                                     args.product!.id);
                                  //                               }),
                                  //                           Text(
                                  //                             controller.comments[index]
                                  //                                 .getTotalDislikes ==
                                  //                                 null
                                  //                                 ? '0'
                                  //                                 : controller
                                  //                                 .comments[index]
                                  //                                 .getTotalDislikes
                                  //                                 .toString(),
                                  //                             style: TextStyle(
                                  //                                 fontSize: 12),
                                  //                           ),
                                  //                         ],
                                  //                       ),
                                  //                     ],
                                  //                   ),
                                  //                 ),
                                  //               )
                                  //                   : CircularProgressIndicator())
                                  //         ],
                                  //       ),
                                  //     );
                                  //   else {
                                  //     return SizedBox.shrink();
                                  //   }
                                  // }),
                                  const SizedBox(height: 10),
                                  // Container(
                                  //   color: Colors.white.withOpacity(0.4),
                                  //   child: Center(
                                  //     child: Padding(
                                  //       padding: const EdgeInsets.all(8.0),
                                  //       child: Text(
                                  //         'You may also like',
                                  //         style: TextStyle(
                                  //             fontSize: 18, fontWeight: FontWeight.bold),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  // Container(child: Obx(() {
                                  //   if (homecontroller.isLoading.value) {
                                  //     final list = homecontroller.productList
                                  //         .where((i) => i.category == args.product!.category)
                                  //         .toList();
                                  //
                                  //     return ProductGridviewTile(
                                  //       productList: list,
                                  //     );
                                  //   } else {
                                  //     return Center(child: CircularProgressIndicator());
                                  //   }
                                  // })),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }



                }else{


                  if (productDetailsController!.isRefresh.value !=
                      true) {
                    return  Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: const Center(child: const CircularProgressIndicator(color: AppColors.appColor)));
                  } else {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                    );
                  }
                }

            }),
          ),




      bottomNavigationBar: AddToCard(
       // product: args.product,
        onChanged: () {
          print("addToCard ${products!.productId!}");

          homecontroller.addToCard(products!.productId!,"1");
        },
      ),
    );
    // return GetBuilder<ProductDetailsController>(
    //     init: ProductDetailsController(apiRepositoryInterface: Get.find(), localRepositoryInterface: Get.find()),
    //     builder: (controller){
    //       final ProductDetailsArguments args =
    //       ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    //
    //       final homecontroller = Get.find<HomeController>();
    //       controller.productid(args.product!.id!);
    //       controller.setInit(args.product!.favorite);
    //
    // });

  }
}























































// import 'package:eshoperapp/constants/app_costants.dart';
// import 'package:eshoperapp/models/main_response.dart';
// import 'package:eshoperapp/models/product.dart';
// import 'package:eshoperapp/models/product_detail.dart';
// import 'package:eshoperapp/models/products.dart';
// import 'package:eshoperapp/package/product_rating.dart';
// import 'package:eshoperapp/pages/details/product_details_controller.dart';
// import 'package:eshoperapp/pages/details/view/add_cart.dart';
// import 'package:eshoperapp/pages/landing_home/home_controller.dart';
// import 'package:eshoperapp/routes/navigation.dart';
// import 'package:eshoperapp/widgets/product_gridview_tile.dart';
// import 'package:eshoperapp/widgets/product_tile.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';
// import 'package:share/share.dart';
// import 'package:eshoperapp/style/theme.dart' as Style;
//
// class ProductDetailsScreen extends StatefulWidget {
//   final Products? products;
//   const ProductDetailsScreen({Key? key, required this.products}) : super(key: key);
//
//   @override
//   State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
// }
//
// class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
//
//   ProductDetailsController? productDetailsController;
//   ProductDetail? productDetail;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     // TODO: implement initState
//     dynamic argumentData = Get.arguments;
//     productDetail = argumentData[0]['productObj'];
//     print("productObj productDetailId ${productDetail!.productId}");
//     productDetailsController = Get.put(ProductDetailsController(
//         apiRepositoryInterface: Get.find(), productDetailId: productDetail!.productId!, localRepositoryInterface: Get.find()));
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//         appBar: AppBar(
//           elevation: 5,
//           backgroundColor: Colors.white,
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back, color: Colors.black,size: 30,),
//             onPressed: () =>
//                 Navigator.of(context, rootNavigator: true).pop(),
//           ),
//           title: Text("${ productDetail!.productName.toString()}",style: TextStyle(fontSize: 20)),
//           actions: [
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.only(right: 20.0),
//                 child: InkWell(
//                   onTap: (){
//                     Navigator.of(context).pushNamed(Routes.cart);
//                   },
//                   child: Stack(
//                     children: <Widget>[
//                       Icon(CupertinoIcons.cart,color: Colors.black,size: 30,),
//                       Obx((){
//                         return  Positioned(
//                           right: 0,
//                           child: Container(
//                             padding: const EdgeInsets.all(1),
//                             decoration: BoxDecoration(
//                               color: Colors.red,
//                               borderRadius: BorderRadius.circular(6),
//                             ),
//                             constraints: const BoxConstraints(
//                               minWidth: 12,
//                               minHeight: 12,
//                             ),
//                             child: Text(
//                               "homecontroller.cartList.length.toString()",
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 8,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         );
//                       }),
//
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         //body: Center(child: Text(controller.totalAmount.toString())),
//         body:
//
//         Obx((){
//
//           if(productDetailsController!.isLoadingProductDetail.value != true){
//
//             MainResponse? mainResponse = productDetailsController!.productDetailObj.value;
//             List<ProductDetail>? productDetailData = [];
//
//             // mainResponse.data!.map((e) => customerProfileData!.add(UpdateCustomerPasswordData.fromJson(e))).toList();
//             mainResponse.data!.forEach((v) {
//               productDetailData.add( ProductDetail.fromJson(v));
//             });
//
//             String? imageUrl = mainResponse.imageUrl ?? "";
//             String? message = mainResponse.message ?? AppConstants.noInternetConn;
//             if (productDetailData.isEmpty) {
//               return Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: 200,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     Text(
//                       message!,
//                       style: TextStyle(color: Colors.black45),
//                     ),
//                   ],
//                 ),
//               );
//             }else{
//               return  Container(color: Colors.grey.withOpacity(0.1),
//                 child: SafeArea(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         Obx(() {
//                           return Container(
//                             height: 300,
//                             child: Stack(
//                               alignment: Alignment.bottomCenter,
//                               children: [
//                                 // IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
//                                 Padding(
//                                     padding: const EdgeInsets.only(left: 10, right: 10),
//                                     child: Hero(
//                                       tag: productDetailData[0].productId!,
//                                       child: Container(
//                                         child: InkWell(
//                                             onDoubleTap: () {
//                                               // navigator!.pushNamed(
//                                               //    Routes.imageScreen,
//                                               //     arguments: ImageScreenArguments(
//                                               //         product: args.product));
//                                             },
//                                             child: PhotoViewGallery.builder(
//                                               scrollPhysics:
//                                               const BouncingScrollPhysics(),
//                                               builder:
//                                                   (BuildContext context, int index) {
//                                                 return PhotoViewGalleryPageOptions(
//                                                   disableGestures: true,
//                                                   imageProvider: NetworkImage(args
//                                                       .product!
//                                                       .images!
//                                                       .length ==
//                                                       0
//                                                       ? 'https://onlinehatiya.herokuapp.com' +
//                                                       args.product!.image!
//                                                       : 'https://onlinehatiya.herokuapp.com' +
//                                                       args
//                                                           .product!
//                                                           .images![controller
//                                                           .selectedImage!.value]
//                                                           .image!),
//                                                   initialScale:
//                                                   PhotoViewComputedScale.contained *
//                                                       0.8,
//                                                 );
//                                               },
//                                               itemCount: args.product!.images!.length,
//                                               loadingBuilder: (context, progress) =>
//                                                   Center(
//                                                     child: Container(
//                                                       width: 20.0,
//                                                       height: 20.0,
//                                                       child: CircularProgressIndicator(
//                                                         value: progress == null
//                                                             ? null
//                                                             : progress
//                                                             .cumulativeBytesLoaded /
//                                                             progress
//                                                                 .expectedTotalBytes!,
//                                                       ),
//                                                     ),
//                                                   ),
//                                               pageController: null,
//                                               backgroundDecoration:
//                                               BoxDecoration(color: Colors.white),
//                                               onPageChanged: (int index) {
//                                                 controller.selectedImage!(index);
//                                               },
//                                             )),
//                                       ),
//                                     )),
//
//                                 Positioned(
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(30),
//                                         color: Colors.black.withOpacity(0.4)),
//                                     height: 25,
//                                     width: 40,
//                                     child: Center(
//                                       child: Text(
//                                         args.product!.images!.length == 0
//                                             ? '${controller.index + 1} '
//                                             '/' +
//                                             '${args.product!.images!.length + 1}'
//                                             : '${controller.index + 1} '
//                                             '/' +
//                                             args.product!.images!.length.toString(),
//                                         style: TextStyle(
//                                             fontSize: 18, color: Colors.white),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         }),
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(10.0),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       'Rs.' + args.product!.price.toString(),
//                                       style: TextStyle(
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.redAccent),
//                                     ),
//                                     Row(
//                                       children: [
//                                         Obx(() {
//                                           return AnimatedContainer(
//                                             // height:
//                                             //     controller.initbool.value ? 50 : 30,
//                                             duration: Duration(microseconds: 500),
//                                             child: IconButton(
//                                                 onPressed: () {
//                                                   controller.makeFavorite(
//                                                       args.product!.id);
//
//                                                   homecontroller.fetchProduct();
//                                                 },
//                                                 icon: controller.initbool.value
//                                                     ? Icon(
//                                                   Icons.favorite,
//                                                   color: Colors.red,
//                                                   size: 30,
//                                                 )
//                                                     : Icon(
//                                                   Icons.favorite_border,
//                                                 )),
//                                           );
//                                         }),
//                                         // FavoriteBTN(
//                                         //   controller:
//                                         //       controller.animationController,
//                                         //   colorTween: controller.colorAnimation,
//                                         // ),
//                                         IconButton(
//                                             onPressed: () {
//                                               Share.share('App link not available');
//                                             },
//                                             icon: Icon(Icons.share)),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                                 Text(
//                                   args.product!.title!,
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 5,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     InkWell(
//                                       // onTap: () => Scrollable.ensureVisible(
//                                       //     dataKey.currentContext!),
//                                       child: Row(
//                                         children: [
//                                           ProductRating(
//                                             rating: args.product!.avaragereview,
//                                             isReadOnly: true,
//                                             size: 15,
//                                             filledIconData: Icons.star,
//                                             borderColor:
//                                             Colors.red.withOpacity(0.8),
//                                             color: Colors.red,
//                                             halfFilledIconData: Icons.star_half,
//                                             defaultIconData: Icons.star_border,
//                                             starCount: 5,
//                                             allowHalfRating: true,
//                                           ),
//                                           SizedBox(
//                                             width: 5,
//                                           ),
//                                           Text(
//                                             args.product!.avaragereview.toString(),
//                                             style: TextStyle(color: Colors.red),
//                                           ),
//                                           Text(
//                                             ' / ' +
//                                                 '(${args.product!.noOfReviews}) reviews',
//                                             style: TextStyle(color: Colors.red),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Container(
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(10),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     RichText(
//                                         text: TextSpan(
//                                             text: 'Seller:',
//                                             style: TextStyle(color: Colors.black),
//                                             children: [
//                                               TextSpan(
//                                                   text: ' DmkMart',
//                                                   style: TextStyle(color: Colors.black))
//                                             ])),
//                                     Container(
//                                       decoration: BoxDecoration(
//                                         border: Border.all(color: Colors.grey),
//                                       ),
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(5.0),
//                                         child: Text('View Shop',
//                                             style: TextStyle(color: Colors.green)),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Container(
//                           height: 90,
//                           width: double.infinity,
//                           decoration: BoxDecoration(color: Colors.white),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Easy 7 days return and Exchange',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 5,
//                                 ),
//                                 Text(
//                                   'You can return the product within 7 days if the product is damaged, expired , different from order',
//                                   overflow: TextOverflow.clip,
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       color: Colors.black.withOpacity(0.6)),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(10),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Specification',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 5,
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     ...List.generate(
//                                       args.product!.productSpecification!.length,
//                                           (index) => Padding(
//                                         padding: const EdgeInsets.only(bottom: 5),
//                                         child: Row(
//                                           crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               '•',
//                                               style: TextStyle(fontSize: 18),
//                                             ),
//                                             SizedBox(
//                                               width: 10,
//                                             ),
//                                             Expanded(
//                                               child: Text(
//                                                 args
//                                                     .product!
//                                                     .productSpecification![index]
//                                                     .point!,
//                                                 overflow: TextOverflow.clip,
//                                                 style: TextStyle(
//                                                     fontSize: 15,
//                                                     color: Colors.black
//                                                         .withOpacity(0.6)),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                             ),
//                             child: ExpansionTile(
//                               expandedAlignment: Alignment.topLeft,
//                               title: Text(
//                                 'Product Details',
//                                 style:  TextStyle(
//                                   fontSize: 16,
//                                 ),
//                               ),
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(left: 20),
//                                   child: Text(
//                                     args.product!.description!,
//                                     style: TextStyle(
//                                         fontSize: 15,
//                                         color: Colors.black.withOpacity(0.6)),
//                                   ),
//                                 )
//                               ],
//                             )),
//                         SizedBox(height: 10),
//                         Obx(() {
//                           if (!controller.isCommentsLoad.value)
//                             return Container(
//                               color: Colors.white,
//                               // key: dataKey,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           'Rating & Reviews (${controller.comments.length})',
//                                           style: TextStyle(fontSize: 16),
//                                         ),
//                                         InkWell(
//                                           onTap: () {},
//                                           child: Container(
//                                             decoration: BoxDecoration(
//                                                 border: Border.all(
//                                                     color: Colors.grey
//                                                         .withOpacity(0.4))),
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(8.0),
//                                               child: Text(
//                                                 'Rate Product',
//                                                 style:
//                                                 TextStyle(color: Colors.blue),
//                                               ),
//                                             ),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                   ...List.generate(
//                                       controller.comments.length > 3
//                                           ? 3
//                                           : controller.comments.length,
//                                           (index) => !controller.isCommentsLoad.value
//                                           ? Card(
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Column(
//                                             mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                             crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                             children: [
//                                               Row(
//                                                 crossAxisAlignment:
//                                                 CrossAxisAlignment.end,
//                                                 mainAxisAlignment:
//                                                 MainAxisAlignment
//                                                     .spaceBetween,
//                                                 children: [
//                                                   Text(controller
//                                                       .comments[index]
//                                                       .comment!),
//                                                   Spacer(),
//                                                   ProductRating(
//                                                     rating: controller
//                                                         .comments[index].rate!
//                                                         .toDouble(),
//                                                     isReadOnly: true,
//                                                     size: 12,
//                                                     filledIconData:
//                                                     Icons.star,
//                                                     borderColor: Colors.red
//                                                         .withOpacity(0.8),
//                                                     color: Colors.red,
//                                                     halfFilledIconData:
//                                                     Icons.star_half,
//                                                     defaultIconData:
//                                                     Icons.star_border,
//                                                     starCount: 5,
//                                                     allowHalfRating: true,
//                                                   ),
//                                                   SizedBox(
//                                                     width: 15,
//                                                   )
//                                                 ],
//                                               ),
//                                               SizedBox(
//                                                 height: 20,
//                                               ),
//                                               Row(
//                                                 mainAxisAlignment:
//                                                 MainAxisAlignment
//                                                     .spaceBetween,
//                                                 children: [
//                                                   Text(
//                                                     controller.comments[index]
//                                                         .user!.username!
//                                                         .replaceAll(
//                                                         '@gmail.com',
//                                                         '*****'),
//                                                     style: TextStyle(
//                                                         color: Colors.black
//                                                             .withOpacity(
//                                                             0.6)),
//                                                   ),
//                                                   Text(
//                                                     ' | ' +
//                                                         controller
//                                                             .comments[index]
//                                                             .whenpublished!,
//                                                     style: TextStyle(
//                                                         fontSize: 14,
//                                                         color: Colors.black
//                                                             .withOpacity(
//                                                             0.6)),
//                                                   ),
//                                                   Spacer(),
//                                                   IconButton(
//                                                       icon: Icon(
//                                                         Icons
//                                                             .thumb_up_alt_outlined,
//                                                         size: 12,
//                                                         color: controller
//                                                             .comments[
//                                                         index]
//                                                             .like ==
//                                                             true
//                                                             ? Colors.blue
//                                                             : Colors.black,
//                                                       ),
//                                                       onPressed: () {
//                                                         controller.likeBtn(
//                                                             controller
//                                                                 .comments[
//                                                             index]
//                                                                 .id,
//                                                             args.product!.id);
//                                                       }),
//                                                   Text(
//                                                     controller.comments[index]
//                                                         .getTotalLikes ==
//                                                         null
//                                                         ? '0'
//                                                         : controller
//                                                         .comments[index]
//                                                         .getTotalLikes
//                                                         .toString(),
//                                                     style: TextStyle(
//                                                         fontSize: 12),
//                                                   ),
//                                                   IconButton(
//                                                       icon: Icon(
//                                                         Icons
//                                                             .thumb_down_outlined,
//                                                         size: 12,
//                                                         color: controller
//                                                             .comments[
//                                                         index]
//                                                             .dislike ==
//                                                             true
//                                                             ? Colors.blue
//                                                             : Colors.black,
//                                                       ),
//                                                       onPressed: () {
//                                                         controller.dislikeBtn(
//                                                             controller
//                                                                 .comments[
//                                                             index]
//                                                                 .id,
//                                                             args.product!.id);
//                                                       }),
//                                                   Text(
//                                                     controller.comments[index]
//                                                         .getTotalDislikes ==
//                                                         null
//                                                         ? '0'
//                                                         : controller
//                                                         .comments[index]
//                                                         .getTotalDislikes
//                                                         .toString(),
//                                                     style: TextStyle(
//                                                         fontSize: 12),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       )
//                                           : CircularProgressIndicator())
//                                 ],
//                               ),
//                             );
//                           else {
//                             return SizedBox.shrink();
//                           }
//                         }),
//                         SizedBox(height: 10),
//                         // Container(
//                         //   color: Colors.white.withOpacity(0.4),
//                         //   child: Center(
//                         //     child: Padding(
//                         //       padding: const EdgeInsets.all(8.0),
//                         //       child: Text(
//                         //         'You may also like',
//                         //         style: TextStyle(
//                         //             fontSize: 18, fontWeight: FontWeight.bold),
//                         //       ),
//                         //     ),
//                         //   ),
//                         // ),
//                         // Container(child: Obx(() {
//                         //   if (homecontroller.isLoading.value) {
//                         //     final list = homecontroller.productList
//                         //         .where((i) => i.category == args.product!.category)
//                         //         .toList();
//                         //
//                         //     return ProductGridviewTile(
//                         //       productList: list,
//                         //     );
//                         //   } else {
//                         //     return Center(child: CircularProgressIndicator());
//                         //   }
//                         // })),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//           }
//
//
//
//           }else{
//           return Container(
//           height: 200,
//           child: Center(
//           child: CircularProgressIndicator(
//           color: Style.Colors.appColor)));
//           }
//
//         })
//
//
//
//
//       // bottomNavigationBar: AddToCard(
//       //   product: args.product,
//       //   onChanged: () {
//       //     homecontroller.addToCard(args.product!.id);
//       //   },
//       // ),
//     );
//     // return GetBuilder<ProductDetailsController>(
//     //     init: ProductDetailsController(apiRepositoryInterface: Get.find(), localRepositoryInterface: Get.find()),
//     //     builder: (controller){
//     //       final ProductDetailsArguments args =
//     //       ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
//     //
//     //       final homecontroller = Get.find<HomeController>();
//     //       controller.productid(args.product!.id!);
//     //       controller.setInit(args.product!.favorite);
//     //
//     // });
//
//   }
// }
//
