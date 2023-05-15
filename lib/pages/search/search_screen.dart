import 'package:eshoperapp/models/order_histrory_model.dart';
import 'package:eshoperapp/pages/landing_home/home_controller.dart';
import 'package:eshoperapp/pages/search/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/theme.dart';
import '../../constants/app_costants.dart';
import '../../models/best_seller_product_model.dart';
import '../../models/frequent_search_model.dart';
import '../../models/main_response.dart';
import '../../models/products.dart';
import '../../models/recent_search_model.dart';
import '../../models/suggestion_model.dart';
import '../../models/wishlist_model.dart';
import '../../utils/check_internet.dart';
import '../../utils/search_api.dart';
import '../category_product/common_product_list_screen.dart';
import '../details/prodcut_details_screen.dart';
import '../wishlist/wishlist_controller.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String selectedCriteria = 'All';
  bool? isEdit = false;

  final homeController = Get.put(HomeController(
      apiRepositoryInterface: Get.find(), localRepositoryInterface: Get.find()));

  final searchController = Get.put(SearchController(
      apiRepositoryInterface: Get.find(), localRepositoryInterface: Get.find()));

  TextEditingController searchTextEditingController = TextEditingController();
  var focusNode = FocusNode();

  @override
  void initState() {
    // wishListController.loadUser();
    if(selectedCriteria == "All"){
      searchController.loadUser("");
    }else{
      searchController.loadUser(selectedCriteria);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.grey[200],
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   leading: Image.asset(
      //     'assets/img/arrow_left.png',
      //     color: AppColors.appText,
      //   ),
      //   title:
      //
      //   TextFormField(
      //     textInputAction: TextInputAction.done,
      //     cursorColor: AppColors.appText1,
      //     decoration: InputDecoration(
      //       hintText: 'Search for brands & Products',
      //       // labelText: 'Search for brands & Products',
      //       // border: OutlineInputBorder(),
      //       border: InputBorder.none,
      //       focusedBorder: InputBorder.none,
      //       enabledBorder: InputBorder.none,
      //       errorBorder: InputBorder.none,
      //       disabledBorder: InputBorder.none,
      //     ),
      //     onChanged: (text){
      //       setState(() {
      //         print("text  ${text}");
      //       });
      //     },
      //   ),
      //   elevation: 1,
      // ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: AppColors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0,right: 0,top: 10,bottom: 8),
                    child: Container(
                      height: 38,
                      // color: Colors.green,
                      // child:
                      // TextFormField(
                      //
                      //   textInputAction: TextInputAction.done,
                      //   cursorColor: AppColors.appText1,
                      //   decoration: InputDecoration(
                      //     contentPadding: EdgeInsets.fromLTRB(0,0,0,0),
                      //     hintText: 'Search for brands & Products',
                      //     // labelText: 'Search for brands & Products',
                      //     // border: OutlineInputBorder(),
                      //     border: InputBorder.none,
                      //     focusedBorder: InputBorder.none,
                      //     enabledBorder: InputBorder.none,
                      //     errorBorder: InputBorder.none,
                      //     disabledBorder: InputBorder.none,
                      //   ),
                      //   style:  GoogleFonts.inriaSans(
                      //       textStyle:
                      //       const TextStyle(
                      //           fontSize: 12,
                      //           fontWeight:
                      //           FontWeight
                      //               .w400,
                      //           color: AppColors
                      //               .black)),
                      //   onChanged: (text){
                      //     setState(() {
                      //       print("text  ${text}");
                      //     });
                      //   },
                      // ),


                      child: TypeAheadField<String>(

                        // errorBuilder: (BuildContext context, Object error) {
                        //   // print("focusNode.hasFocus ==================> ${focusNode.hasFocus}");
                        //   if(searchTextEditingController.text.isEmpty && focusNode.hasFocus){
                        //     // return const Padding(
                        //     //   padding:  EdgeInsets.only(top: 20.0,bottom: 20,left: 15),
                        //     //   child: Text(
                        //     //       'Please enter 1 or more characters',
                        //     //
                        //     //   ),
                        //     // );
                        //   }else{
                        //     // return Padding(
                        //     //   padding: EdgeInsets.only(top: 20.0,bottom: 20,left: 15),
                        //     //   child: Text(
                        //     //       '$error',
                        //     //       style: TextStyle(
                        //     //           color: Theme.of(context).errorColor
                        //     //       )
                        //     //   ),
                        //     // );
                        //   }
                        //
                        // }
                        // ,

                        noItemsFoundBuilder: (BuildContext context) {
                          return const Padding(
                            padding: EdgeInsets.only(top: 20.0,bottom: 20,left: 15),
                            child: Text(
                              'No data found!',

                            ),
                          );
                        }
                        ,
                        hideSuggestionsOnKeyboardHide: false,
                        textFieldConfiguration: TextFieldConfiguration(
                          focusNode: focusNode,
                          onSubmitted: (value) async {
                            print("value -----> $value");

                            if(selectedCriteria == "All"){
                          final result = await    Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CommonProductListScreen(title: value,
                                    apiType: 'searchBykeywords',
                                    id: "",
                                    offerId: "",
                                    chooseType: "",
                                  ),
                                ),
                              );
                          if(result != null){
                            if(selectedCriteria == "All"){
                              searchController.loadUser("");
                            }else{
                              searchController.loadUser(selectedCriteria);
                            }
                          }
                            }else{
                              final result = await   Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CommonProductListScreen(title: value,
                                    apiType: 'searchBykeywords',
                                    id: "",
                                    offerId: "",
                                    chooseType: selectedCriteria,
                                  ),
                                ),
                              );

                              if(result != null){
                                if(selectedCriteria == "All"){
                                  searchController.loadUser("");
                                }else{
                                  searchController.loadUser(selectedCriteria);
                                }
                              }
                            }



                          },
                          controller: searchTextEditingController,
                            decoration: InputDecoration(

                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: InkWell(child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Image.asset('assets/img/arrow_left.png',fit: BoxFit.contain,height: 13,width: 18,color: AppColors.black,),
                                ),onTap: (){
                                  Get.back();
                                },),
                              ),

                              contentPadding: EdgeInsets.fromLTRB(AppSizes.sidePadding,8.5,AppSizes.sidePadding,10),
                              hintText: 'Search for brands & Products',
                              hintStyle: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: AppColors.appText1)),
                              // labelText: 'Search for brands & Products',
                              // border: OutlineInputBorder(),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                        ),
                        suggestionsCallback: (pattern) {

                    return      Future.delayed(const Duration(milliseconds: 200), () {



                            print("controllerEquipmentName.text ==========> ${searchTextEditingController.text}");
                            if(selectedCriteria == "All"){
                              return SearchApi.getSearchSuggestions(searchTextEditingController.text,homeController.customerId.value,"");
                            }else{
                              return SearchApi.getSearchSuggestions(searchTextEditingController.text,homeController.customerId.value,selectedCriteria);
                            }

                          });


                        },
                        // suggestionsCallback: UserApi.getUserSuggestions(),
                        itemBuilder: (context, String suggestion) {
                          final categoryObj = suggestion;

                          return Padding(
                            padding: const EdgeInsets.only(left: 16.0,right: 16,top: 16,bottom: 0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Image.asset('assets/img/search.png',fit: BoxFit.fill,height: 16,width: 16,color: AppColors.appText1,),
                                    SizedBox(width: 10,),
                                    Text(categoryObj,style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.normal,color: AppColors.appText))),

                                  ],
                                ),
                                SizedBox(height: 16,),
                                Container(height: 0.5,width: MediaQuery.of(context).size.width,color: AppColors.tileLine,),
                              ],
                            ),
                          );
                        },

                        onSuggestionSelected: (String suggestion) async {
                          if(selectedCriteria == "All"){
                            final result = await    Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CommonProductListScreen(title: suggestion,
                                  apiType: 'searchBykeywords',
                                  id: "",
                                  offerId: "",
                                  chooseType: "",
                                ),
                              ),
                            );
                            if(result != null){
                              if(selectedCriteria == "All"){
                                searchController.loadUser("");
                              }else{
                                searchController.loadUser(selectedCriteria);
                              }
                            }
                          }else{
                            final result = await   Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CommonProductListScreen(title: suggestion,
                                  apiType: 'searchBykeywords',
                                  id: "",
                                  offerId: "",
                                  chooseType: selectedCriteria,
                                ),
                              ),
                            );

                            if(result != null){
                              if(selectedCriteria == "All"){
                                searchController.loadUser("");
                              }else{
                                searchController.loadUser(selectedCriteria);
                              }
                            }
                          }

                        },
                      ),
                    ),
                  ),
                  Container(height: 0.5,width: MediaQuery.of(context).size.width,color: AppColors.tileLine,),
                ],
              ),
            ),
            SizedBox(height: 16.0,),
            Container(
              // color: AppColors.red,
              height: 45,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: searchController.categoryList.length,
                  itemBuilder: (BuildContext c,int index){

                    if(selectedCriteria == searchController.categoryList[index].categoryName ){
                      return Padding(
                        padding: index == 0 ? const EdgeInsets.only(right: 8.0,left: 8.0):const EdgeInsets.only(right: 8.0),
                        child: Container(


                          decoration: BoxDecoration(
                            // color: AppColors.white,
                            color: AppColors.validationBg,
                            borderRadius:  BorderRadius.circular(100),
                            border: Border.all(
                              width: 1,
                              color: AppColors.appRed,
                              // style: BorderStyle.solid,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5.0,bottom: 5.0,right: 12.0,left: 12.0),
                            child: Row(
                              children: [
                                Container(

                                  decoration: BoxDecoration(

                                    borderRadius:  BorderRadius.circular(100),
                                    border: Border.all(
                                      width: 2,
                                      color: AppColors.white,
                                      // style: BorderStyle.solid,
                                    ),
                                  ),
                                  height: 35,width: 35,
                                  child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(100),child: Image.asset(searchController.categoryList[index].categoryImage!,fit: BoxFit.cover,width: 37,height: 40,)),
                                ),
                                const SizedBox(width: 16,),
                                Text(searchController.categoryList[index].categoryName!,style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.black)))
                              ],
                            ),
                          ),
                        ),
                      );
                    }else{
                      return Padding(
                        padding: index == 0 ? const EdgeInsets.only(right: 8.0,left: 8.0):const EdgeInsets.only(right: 8.0),
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              selectedCriteria = searchController.categoryList[index].categoryName!;
                              isEdit = false;
                              if(selectedCriteria == "All"){
                                searchController.loadUser("");
                              }else{
                                searchController.loadUser(selectedCriteria);
                              }

                            });
                          },
                          child: Container(

                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius:  BorderRadius.circular(100),
                              border: Border.all(
                                width: 1,
                                color: AppColors.toggleBg,
                                // style: BorderStyle.solid,
                              ),
                            ),

                            child: Padding(
                              padding: const EdgeInsets.only(top: 5.0,bottom: 5.0,right: 12.0,left: 12.0),
                              child: Row(
                                children: [
                                  ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(100),child: Image.asset(searchController.categoryList[index].categoryImage!,fit: BoxFit.cover,width: 35,height: 35,)),
                                  const SizedBox(width: 16,),
                                  Text(searchController.categoryList[index].categoryName!,style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.black)))
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }

                  }),
            ),
            SizedBox(height: 16.0,),
            Expanded(
              child:
              RefreshIndicator(
                onRefresh: () async {
                  CheckInternet.checkInternet();
                  // cardController.homecontroller.getSlider();
                  // cardController.homecontroller.getBrand();
                  // cardController.homecontroller.bestSellerProduct();
                  // cardController.homecontroller.allProducts();
                  if(selectedCriteria == "All"){
                   return searchController.loadUser("");
                  }else{
                  return  searchController.loadUser(selectedCriteria);
                  }
                },
                child: ListView(children: [


                  // Container(
                  //   color: AppColors.white,
                  //   child: Column(
                  //     children: [
                  //       Container(
                  //         color: AppColors.white,
                  //         child: Padding(
                  //           padding: const EdgeInsets.only(top: 13.0,bottom: 16.0,left: 16.0,right: 16.0),
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Text("RECENT SEARCHES",style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: AppColors.searchTitle))),
                  //               isEdit == true ?InkWell(
                  //                   onTap: (){
                  //                     setState(() {
                  //                       isEdit = false;
                  //                     });
                  //                   },
                  //                   child: Text("DONE",style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.appRed))))
                  //              : InkWell(
                  //                   onTap: (){
                  //                     setState(() {
                  //                       isEdit = true;
                  //                     });
                  //                   },
                  //                   child: Text("EDIT",style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.appRed))))
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       Container(
                  //         color: AppColors.white,
                  //         height: 130,
                  //         width: MediaQuery.of(context).size.width,
                  //         child: Padding(
                  //           padding: const EdgeInsets.only(top: 8.0),
                  //           child: ListView.builder(
                  //               scrollDirection: Axis.horizontal,
                  //               itemCount: searchController.recentList.length,
                  //               itemBuilder: (BuildContext c,int index){
                  //
                  //
                  //                   return Padding(
                  //                     padding: index == 0 ? const EdgeInsets.only(right: 16.0,left: 16.0):const EdgeInsets.only(right: 16.0),
                  //                     child: Stack(
                  //                       children: [
                  //                         Container(
                  //                           width: 65,
                  //                           child: Column(
                  //                             children: [
                  //                               ClipRRect(
                  //                                   borderRadius:
                  //                                   BorderRadius.circular(100),child: Image.asset(searchController.recentList[index].categoryImage!,fit: BoxFit.fill,width: 65,height: 65,)),
                  //                               const SizedBox(height: 8,),
                  //                               Text(
                  //
                  //
                  //                                   searchController.recentList[index].categoryName!,
                  //                                   textAlign : TextAlign.center,
                  //                                   style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.black)))
                  //                             ],
                  //                           ),
                  //                         ),
                  //                         isEdit == true ?
                  //                         Positioned(
                  //                             right: 0,
                  //                             top: 0,
                  //                             child: Image.asset('assets/img/close_circle.png',fit: BoxFit.fill,height: 23,width: 23,)):Container()
                  //                       ],
                  //                     ),
                  //                   );
                  //
                  //
                  //               }),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Obx(() {
                    if (searchController.isLoadingGetRecentsearchkeywords.value == true) {
                      MainResponse? mainResponse = searchController.getRecentsearchkeywordsObj.value;
                      List<RecentSearchModel>? getRecentSearchListData = [];

                      if(mainResponse.data != null){
                        mainResponse.data!.forEach((v) {
                          getRecentSearchListData.add(RecentSearchModel.fromJson(v));
                        });

                      }

                      String? imageUrl = mainResponse.imageUrl ?? "";
                      String? message = mainResponse.message ?? AppConstants.noInternetConn;



                      if (getRecentSearchListData.isEmpty) {



                        return Obx(() {
                          if (searchController.isLoadingGetFrequentSearch.value == true) {
                            MainResponse? mainResponse = searchController.getFrequentSearchObj.value;
                            List<FrequentSearchModel>? getFrequentSearchListData = [];

                            if(mainResponse.data != null){
                              mainResponse.data!.forEach((v) {
                                getFrequentSearchListData.add(FrequentSearchModel.fromJson(v));
                                // cardController.getCartDataBottomView!.add(Carts.fromJson(v));
                              });

                            }


                            // print("getCartData total ------------- ${getCartData[0].totalAmt!}");
                            // cardController.homecontroller.cartList(getCartData);


                            // cardController.homecontroller.refreshTotal();
                            // mainResponse.data!.map((e) => customerProfileData!.add(UpdateCustomerPasswordData.fromJson(e))).toList();


                            String? imageUrl = mainResponse.imageUrl ?? "";
                            String? message = mainResponse.message ?? AppConstants.noInternetConn;



                            if (getFrequentSearchListData.isEmpty) {
                              return Container(
                              );


                            }else{
                              // cardController.selectAllCartInit(getCartData);
                              return   Container(
                                color: AppColors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      color: AppColors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 16.0,bottom: 16.0,left: 16.0,right: 16.0),
                                        child: Text("FREQUENTLY SEARCHED",style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: AppColors.searchTitle))),
                                      ),
                                    ),
                                    Container(
                                      // padding: const EdgeInsets.only(top: 18,left: 18,right: 18,bottom: 16),
                                      // height: 400,
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 16),
                                        child: Container(
                                          height: 180,
                                          color: AppColors.white,
                                          width: MediaQuery.of(context).size.width,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                              getFrequentSearchListData.length,
                                              itemBuilder: (c, index) {
                                                return Padding(
                                                  padding:index == 0 ? const EdgeInsets.only(right: 16.0,left: 16.0):const EdgeInsets.only(right: 16.0),
                                                  child: InkWell(
                                                    onTap: (){
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>  ProductDetailsScreen(
                                                                products: Products(productId: getFrequentSearchListData[index].productId!,productName: getFrequentSearchListData[index].productName!,variantCode: getFrequentSearchListData[index].variantCode??""),
                                                                // article: articles[index],
                                                              )));
                                                    },
                                                    child: Container(
                                                      height: 180,
                                                      width: 140,
                                                      decoration: BoxDecoration(
                                                        color: AppColors.white,
                                                        // borderRadius: const BorderRadius
                                                        //         .all(
                                                        //     const Radius.circular(10)),
                                                        border: Border.all(
                                                          width: 1,
                                                          color: AppColors
                                                              .bestSellingBorder,
                                                          // style: BorderStyle.solid,
                                                        ),
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          Image.network(
                                                            imageUrl+getFrequentSearchListData[index].productId!+"/"+getFrequentSearchListData[index]
                                                                .coverImg!,
                                                            fit: BoxFit.cover,
                                                            width: double.infinity,
                                                            height: 98,
                                                          ),
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 8.0,
                                                                right: 6.0,
                                                                bottom: 5.0,
                                                                top: 6.0),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                    getFrequentSearchListData[index]
                                                                        .brandName!,
                                                                    maxLines:
                                                                    1,
                                                                    //  style: GoogleFonts.ptSans(),
                                                                    overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                    style: GoogleFonts.inriaSans(
                                                                        textStyle: const TextStyle(
                                                                            fontSize: 14,
                                                                            fontWeight: FontWeight.w400,
                                                                            color: AppColors.black))),
                                                                // SizedBox(height: 6,),
                                                                Text(
                                                                    getFrequentSearchListData[
                                                                    index]
                                                                        .productName!,
                                                                    maxLines: 1,
                                                                    //  style: GoogleFonts.ptSans(),
                                                                    overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                    style: GoogleFonts.inriaSans(
                                                                        textStyle: const TextStyle(
                                                                            fontSize:
                                                                            14,
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                            color: AppColors
                                                                                .appText1))),
                                                                // SizedBox(height: 6,),

                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                        "\u{20B9}${double.parse(getFrequentSearchListData[index].netPrice!).toStringAsFixed(0)} ",
                                                                        style: GoogleFonts.inriaSans(
                                                                            textStyle: const TextStyle(
                                                                                fontSize:
                                                                                12,
                                                                                fontWeight:
                                                                                FontWeight.w700,
                                                                                color: AppColors.black))),
                                                                    getFrequentSearchListData[index].discount != "0"?Text(
                                                                        "\u{20B9}${double.parse(getFrequentSearchListData[index].mrpPrice!).toStringAsFixed(0)} ",
                                                                        style: GoogleFonts.inriaSans(
                                                                            textStyle: TextStyle(
                                                                                fontSize:
                                                                                12,
                                                                                decoration:
                                                                                TextDecoration.combine([
                                                                                  TextDecoration.lineThrough
                                                                                ]),
                                                                                fontWeight:
                                                                                FontWeight.w700,
                                                                                color: AppColors.appText1))):Container(),

                                                                  ],
                                                                ),
                                                                // SizedBox(height: 6,),
                                                                getFrequentSearchListData[index].discount != "0"?Text( getFrequentSearchListData[index].discount != null ?
                                                                getFrequentSearchListData[index].discount! + "% OFF":"",
                                                                    style: GoogleFonts.inriaSans(
                                                                        textStyle: const TextStyle(
                                                                            fontSize:
                                                                            12,
                                                                            fontWeight:
                                                                            FontWeight.w700,
                                                                            color: AppColors.off))):Container()
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }

                          } else {
                            // return Container();
                            return  Container(
                                height: 200,
                                child: const Center(child: CircularProgressIndicator(color: AppColors.appColor)));

                          }
                        });


                      }else{
                        // searchController.isFlag(false);
                        // cardController.selectAllCartInit(getCartData);
                        return    Container(
                          color: AppColors.white,
                          child: Column(
                            children: [
                              Container(
                                color: AppColors.white,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 13.0,bottom: 16.0,left: 16.0,right: 16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("RECENT SEARCHES",style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: AppColors.searchTitle))),
                                      homeController.customerId.value == ""?Container():
                                      isEdit == true ?InkWell(
                                          onTap: (){
                                            setState(() {
                                              isEdit = false;
                                            });
                                          },
                                          child: Text("DONE",style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.appRed))))
                                          : InkWell(
                                          onTap: (){
                                            setState(() {
                                              isEdit = true;
                                            });
                                          },
                                          child: Text("EDIT",style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.appRed))))
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                color: AppColors.white,
                                height: 130,
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: getRecentSearchListData.length,
                                      itemBuilder: (BuildContext c,int index){


                                        return Padding(
                                          padding: index == 0 ? const EdgeInsets.only(right: 16.0,left: 16.0):const EdgeInsets.only(right: 16.0),
                                          child: InkWell(
                                            onTap: ()  {
                                              if(selectedCriteria == "All"){
                                               Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => CommonProductListScreen(title: getRecentSearchListData[index]
                                                        .keyword!,
                                                      apiType: 'searchBykeywords',
                                                      id: "",
                                                      offerId: "",
                                                      chooseType: "",
                                                    ),
                                                  ),
                                                );

                                              }else{
                                                 Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => CommonProductListScreen(title: getRecentSearchListData[index]
                                                        .keyword!,
                                                      apiType: 'searchBykeywords',
                                                      id: "",
                                                      offerId: "",
                                                      chooseType: selectedCriteria,
                                                    ),
                                                  ),
                                                );


                                              }
                                            },
                                            child: Stack(
                                              children: [
                                                Container(
                                                  width: 65,
                                                  child: Column(
                                                    children: [
                                                      ClipRRect(
                                                          borderRadius:
                                                          BorderRadius.circular(100),child: Image.network( imageUrl+getRecentSearchListData[index]
                                                          .productId!+"/"+getRecentSearchListData[index]
                                                          .image!,fit: BoxFit.cover,width: 65,height: 65,)),
                                                      const SizedBox(height: 8,),
                                                      Text(


                                                          getRecentSearchListData[index].keyword!,
                                                          textAlign : TextAlign.center,
                                                          maxLines: 2,
                                                          overflow:
                                                          TextOverflow
                                                              .ellipsis,
                                                          style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.black)))
                                                    ],
                                                  ),
                                                ),
                                                isEdit == true ?
                                                Positioned(
                                                    right: 0,
                                                    top: 0,
                                                    child:   InkWell(
                                                        onTap: () async {
                                                          print("searchId! ==========> ${getRecentSearchListData[index].searchId!}");
                                                          print("customerId ==========> ${homeController.customerId.value}");
                                                          if(selectedCriteria == "All"){
                                                            searchController.removeRecentSearch(homeController.customerId.value, getRecentSearchListData[index].searchId!,"");
                                                          }else{
                                                            searchController.removeRecentSearch(homeController.customerId.value, getRecentSearchListData[index].searchId!,selectedCriteria);
                                                          }

                                                        },

                                                        child: Image.asset('assets/img/close_circle.png',fit: BoxFit.fill,height: 23,width: 23,))):Container()
                                              ],
                                            ),
                                          ),
                                        );


                                      }),
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                    } else {
                      // return Container();
                      return  Container(
                          height: 200,
                          child: const Center(child: CircularProgressIndicator(color: AppColors.appColor)));

                    }
                  }),


                  Obx(() {
                    if (searchController.isLoadingGetWishList.value == true) {
                      MainResponse? mainResponse = searchController.getWishListObj.value;
                      List<WishListModel>? getWishListData = [];

                      if(mainResponse.data != null){
                        mainResponse.data!.forEach((v) {
                          getWishListData.add(WishListModel.fromJson(v));
                          // cardController.getCartDataBottomView!.add(Carts.fromJson(v));
                        });

                      }

                      String? imageUrl = mainResponse.imageUrl ?? "";
                      String? message = mainResponse.message ?? AppConstants.noInternetConn;



                      if (getWishListData.isEmpty) {
                        return Container(
                        );


                      }else{
                        // cardController.selectAllCartInit(getCartData);
                        return   Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Container(
                            color: AppColors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  color: AppColors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 16.0,bottom: 16.0,left: 16.0,right: 16.0),
                                    child: Text("ITEMS YOU HAVE WISHLIST",style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: AppColors.searchTitle))),
                                  ),
                                ),
                                Container(
                                  // padding: const EdgeInsets.only(top: 18,left: 18,right: 18,bottom: 16),
                                  // height: 400,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: Container(
                                      height: 180,
                                      color: AppColors.white,
                                      width: MediaQuery.of(context).size.width,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                          getWishListData.length,
                                          itemBuilder: (c, index) {
                                            return Padding(
                                              padding:index == 0 ? const EdgeInsets.only(right: 16.0,left: 16.0):const EdgeInsets.only(right: 16.0),
                                              child: InkWell(
                                                onTap: (){
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>  ProductDetailsScreen(
                                                            products: Products(productId: getWishListData[index].productId!,productName: getWishListData[index].productName!,variantCode: getWishListData[index].variantCode!),
                                                            // article: articles[index],
                                                          )));
                                                },
                                                child: Container(
                                                  height: 180,
                                                  width: 140,
                                                  decoration: BoxDecoration(
                                                    color: AppColors.white,
                                                    // borderRadius: const BorderRadius
                                                    //         .all(
                                                    //     const Radius.circular(10)),
                                                    border: Border.all(
                                                      width: 1,
                                                      color: AppColors
                                                          .bestSellingBorder,
                                                      // style: BorderStyle.solid,
                                                    ),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Image.network(
                                                        imageUrl+getWishListData[index].productId!+"/"+getWishListData[index]
                                                            .coverImg!,
                                                        fit: BoxFit.cover,
                                                        width: double.infinity,
                                                        height: 98,
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .only(
                                                            left: 8.0,
                                                            right: 6.0,
                                                            bottom: 5.0,
                                                            top: 6.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Text(
                                                                getWishListData[index]
                                                                    .brandName!,
                                                                maxLines:
                                                                1,
                                                                //  style: GoogleFonts.ptSans(),
                                                                overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                                style: GoogleFonts.inriaSans(
                                                                    textStyle: const TextStyle(
                                                                        fontSize: 14,
                                                                        fontWeight: FontWeight.w400,
                                                                        color: AppColors.black))),
                                                            // SizedBox(height: 6,),
                                                            Text(
                                                                getWishListData[
                                                                index]
                                                                    .productName!,
                                                                maxLines: 1,
                                                                //  style: GoogleFonts.ptSans(),
                                                                overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                                style: GoogleFonts.inriaSans(
                                                                    textStyle: const TextStyle(
                                                                        fontSize:
                                                                        14,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                        color: AppColors
                                                                            .appText1))),
                                                            // SizedBox(height: 6,),

                                                            Row(
                                                              children: [
                                                                Text(
                                                                    "\u{20B9}${double.parse(getWishListData[index].netPrice!).toStringAsFixed(0)} ",
                                                                    style: GoogleFonts.inriaSans(
                                                                        textStyle: const TextStyle(
                                                                            fontSize:
                                                                            12,
                                                                            fontWeight:
                                                                            FontWeight.w700,
                                                                            color: AppColors.black))),
                                                                getWishListData[index].discount != "0"?Text(
                                                                    "\u{20B9}${double.parse(getWishListData[index].mrpPrice!).toStringAsFixed(0)} ",
                                                                    style: GoogleFonts.inriaSans(
                                                                        textStyle: TextStyle(
                                                                            fontSize:
                                                                            12,
                                                                            decoration:
                                                                            TextDecoration.combine([
                                                                              TextDecoration.lineThrough
                                                                            ]),
                                                                            fontWeight:
                                                                            FontWeight.w700,
                                                                            color: AppColors.appText1))):Container(),

                                                              ],
                                                            ),
                                                            // SizedBox(height: 6,),
                                                            getWishListData[index].discount != "0"?Text( getWishListData[index].discount != null ?
                                                            getWishListData[index].discount! + "% OFF":"",
                                                                style: GoogleFonts.inriaSans(
                                                                    textStyle: const TextStyle(
                                                                        fontSize:
                                                                        12,
                                                                        fontWeight:
                                                                        FontWeight.w700,
                                                                        color: AppColors.off))):Container()
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                    } else {
                      // return Container();
                      return  Container(
                          height: 200,
                          child: const Center(child: CircularProgressIndicator(color: AppColors.appColor)));

                    }
                  }),

                  // SizedBox(height: 15.0,),
                  //
                  // // SizedBox(height: 8.0,),
                  // Container(
                  //   color: AppColors.white,
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Container(
                  //         color: AppColors.white,
                  //         child: Padding(
                  //           padding: const EdgeInsets.only(top: 16.0,bottom: 16.0,left: 16.0,right: 16.0),
                  //           child: Text("TRENDING NEAR YOU",style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.searchTitle))),
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.only(bottom: 16),
                  //         child: Container(
                  //           height: 180,
                  //           color: AppColors.white,
                  //           width: MediaQuery.of(context).size.width,
                  //           child: ListView.builder(
                  //               scrollDirection: Axis.horizontal,
                  //               itemCount:
                  //               searchController.wishList.length,
                  //               itemBuilder: (c, index) {
                  //                 return Padding(
                  //                   padding:index == 0 ? const EdgeInsets.only(right: 16.0,left: 16.0):const EdgeInsets.only(right: 16.0),
                  //                   child: Container(
                  //                     height: 180,
                  //                     width: 140,
                  //                     decoration: BoxDecoration(
                  //                       color: AppColors.white,
                  //                       // borderRadius: const BorderRadius
                  //                       //         .all(
                  //                       //     const Radius.circular(10)),
                  //                       border: Border.all(
                  //                         width: 1,
                  //                         color: AppColors
                  //                             .bestSellingBorder,
                  //                         // style: BorderStyle.solid,
                  //                       ),
                  //                     ),
                  //                     child: Column(
                  //                       children: [
                  //                         Image.asset(
                  //                           searchController.wishList[index]
                  //                               .coverImage!,
                  //                           fit: BoxFit.fill,
                  //                           width: double.infinity,
                  //                           height: 100,
                  //                         ),
                  //                         Padding(
                  //                           padding:
                  //                           const EdgeInsets
                  //                               .only(
                  //                               left: 5.0,
                  //                               right: 5.0,
                  //                               bottom: 0.0,
                  //                               top: 5.0),
                  //                           child: Column(
                  //                             crossAxisAlignment:
                  //                             CrossAxisAlignment
                  //                                 .start,
                  //                             children: [
                  //                               Text(
                  //                                   searchController.wishList[index]
                  //                                       .productName!,
                  //                                   maxLines:
                  //                                   1,
                  //                                   //  style: GoogleFonts.ptSans(),
                  //                                   overflow:
                  //                                   TextOverflow
                  //                                       .ellipsis,
                  //                                   style: GoogleFonts.inriaSans(
                  //                                       textStyle: const TextStyle(
                  //                                           fontSize: 14,
                  //                                           fontWeight: FontWeight.w400,
                  //                                           color: AppColors.black))),
                  //                               Text(
                  //                                   searchController.wishList[
                  //                                   index]
                  //                                       .shortDescription!,
                  //                                   maxLines: 2,
                  //                                   //  style: GoogleFonts.ptSans(),
                  //                                   overflow:
                  //                                   TextOverflow
                  //                                       .ellipsis,
                  //                                   style: GoogleFonts.inriaSans(
                  //                                       textStyle: const TextStyle(
                  //                                           fontSize:
                  //                                           14,
                  //                                           fontWeight:
                  //                                           FontWeight
                  //                                               .w400,
                  //                                           color: AppColors
                  //                                               .appText1))),
                  //
                  //                               Row(
                  //                                 children: [
                  //                                   Text(
                  //                                       "\u{20B9}${double.parse(searchController.wishList[index].netPrice!).toStringAsFixed(0)} ",
                  //                                       style: GoogleFonts.inriaSans(
                  //                                           textStyle: const TextStyle(
                  //                                               fontSize:
                  //                                               12,
                  //                                               fontWeight:
                  //                                               FontWeight.w400,
                  //                                               color: AppColors.black))),
                  //                                   Text(
                  //                                       "\u{20B9}${double.parse(searchController.wishList[index].mrpPrice!).toStringAsFixed(0)} ",
                  //                                       style: GoogleFonts.inriaSans(
                  //                                           textStyle: TextStyle(
                  //                                               fontSize:
                  //                                               12,
                  //                                               decoration:
                  //                                               TextDecoration.combine([
                  //                                                 TextDecoration.lineThrough
                  //                                               ]),
                  //                                               fontWeight:
                  //                                               FontWeight.w400,
                  //                                               color: AppColors.appText1))),
                  //
                  //                                 ],
                  //                               ),
                  //                               Text(
                  //                                   "${searchController.wishList[index].discount!}% OFF",
                  //                                   style: GoogleFonts.inriaSans(
                  //                                       textStyle: const TextStyle(
                  //                                           fontSize:
                  //                                           14,
                  //                                           fontWeight:
                  //                                           FontWeight.w400,
                  //                                           color: AppColors.off)))
                  //                             ],
                  //                           ),
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 );
                  //               }),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),


                  Obx(() {
                    if (searchController.isLoadingBestSellerProducts.value == true) {
                      MainResponse? mainResponse = searchController.bestSellerProductObj.value;
                      List<BestSellerProduct>? bestSellerProductData = [];

                      if(mainResponse.data != null){
                        mainResponse.data!.forEach((v) {
                          bestSellerProductData.add(BestSellerProduct.fromJson(v));
                        });
                      }

                      String? imageUrl = mainResponse.imageUrl ?? "";
                      String? message = mainResponse.message ?? AppConstants.noInternetConn;



                      if (bestSellerProductData.isEmpty) {
                        return Container(
                        );


                      }else{
                        // cardController.selectAllCartInit(getCartData);
                        return   Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Container(
                            color: AppColors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  color: AppColors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 16.0,bottom: 16.0,left: 16.0,right: 16.0),
                                    child: Text("TRENDING NEAR YOU",style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: AppColors.searchTitle))),
                                  ),
                                ),
                                Container(
                                  // padding: const EdgeInsets.only(top: 18,left: 18,right: 18,bottom: 16),
                                  // height: 400,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: Container(
                                      height: 180,
                                      color: AppColors.white,
                                      width: MediaQuery.of(context).size.width,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                          bestSellerProductData.length,
                                          itemBuilder: (c, index) {
                                            return Padding(
                                              padding:index == 0 ? const EdgeInsets.only(right: 16.0,left: 16.0):const EdgeInsets.only(right: 16.0),
                                              child: InkWell(
                                                onTap: (){
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>  ProductDetailsScreen(
                                                            products: Products(productId: bestSellerProductData[index].productId!,productName: bestSellerProductData[index].productName!,variantCode: bestSellerProductData[index].variantCode??""),
                                                            // article: articles[index],
                                                          )));
                                                },
                                                child: Container(
                                                  height: 180,
                                                  width: 140,
                                                  decoration: BoxDecoration(
                                                    color: AppColors.white,
                                                    // borderRadius: const BorderRadius
                                                    //         .all(
                                                    //     const Radius.circular(10)),
                                                    border: Border.all(
                                                      width: 1,
                                                      color: AppColors
                                                          .bestSellingBorder,
                                                      // style: BorderStyle.solid,
                                                    ),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Image.network(
                                                        imageUrl+bestSellerProductData[index].productId!+"/"+bestSellerProductData[index]
                                                            .coverImg!,
                                                        fit: BoxFit.cover,
                                                        width: double.infinity,
                                                        height: 98,
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .only(
                                                            left: 8.0,
                                                            right: 6.0,
                                                            bottom: 5.0,
                                                            top: 6.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Text(
                                                                bestSellerProductData[index]
                                                                    .brandName!,
                                                                maxLines:
                                                                1,
                                                                //  style: GoogleFonts.ptSans(),
                                                                overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                                style: GoogleFonts.inriaSans(
                                                                    textStyle: const TextStyle(
                                                                        fontSize: 14,
                                                                        fontWeight: FontWeight.w400,
                                                                        color: AppColors.black))),
                                                            // SizedBox(height: 6,),
                                                            Text(
                                                                bestSellerProductData[
                                                                index]
                                                                    .productName!,
                                                                maxLines: 1,
                                                                //  style: GoogleFonts.ptSans(),
                                                                overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                                style: GoogleFonts.inriaSans(
                                                                    textStyle: const TextStyle(
                                                                        fontSize:
                                                                        14,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                        color: AppColors
                                                                            .appText1))),
                                                            // SizedBox(height: 6,),

                                                            Row(
                                                              children: [
                                                                Text(
                                                                    "\u{20B9}${double.parse(bestSellerProductData[index].netPrice!).toStringAsFixed(0)} ",
                                                                    style: GoogleFonts.inriaSans(
                                                                        textStyle: const TextStyle(
                                                                            fontSize:
                                                                            12,
                                                                            fontWeight:
                                                                            FontWeight.w700,
                                                                            color: AppColors.black))),
                                                                bestSellerProductData[index].discount != "0"?Text(
                                                                    "\u{20B9}${double.parse(bestSellerProductData[index].mrpPrice!).toStringAsFixed(0)} ",
                                                                    style: GoogleFonts.inriaSans(
                                                                        textStyle: TextStyle(
                                                                            fontSize:
                                                                            12,
                                                                            decoration:
                                                                            TextDecoration.combine([
                                                                              TextDecoration.lineThrough
                                                                            ]),
                                                                            fontWeight:
                                                                            FontWeight.w700,
                                                                            color: AppColors.appText1))):Container(),

                                                              ],
                                                            ),
                                                            // SizedBox(height: 6,),
                                                            bestSellerProductData[index].discount != "0"?Text( bestSellerProductData[index].discount != null ?
                                                            bestSellerProductData[index].discount! + "% OFF":"",
                                                                style: GoogleFonts.inriaSans(
                                                                    textStyle: const TextStyle(
                                                                        fontSize:
                                                                        12,
                                                                        fontWeight:
                                                                        FontWeight.w700,
                                                                        color: AppColors.off))):Container()
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                    } else {
                      // return Container();
                      return  Container(
                          height: 200,
                          child: const Center(child: CircularProgressIndicator(color: AppColors.appColor)));

                    }
                  }),

                ],),
              )

              ,
            ),
          ],
        ),
      ),
    );
  }
}
