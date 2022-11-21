import 'package:eshoperapp/pages/search/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/theme.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {


  final searchController = Get.put(SearchController(
      apiRepositoryInterface: Get.find(), localRepositoryInterface: Get.find()));
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
                    padding: const EdgeInsets.only(left: AppSizes.sidePadding,right: AppSizes.sidePadding,top: 10,bottom: 8),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: InkWell(child: Image.asset('assets/img/arrow_left.png',fit: BoxFit.fill,height: 13,width: 18,),onTap: (){
                            Get.back();
                          },),
                        ),
                        SizedBox(width: 16,),
                          Expanded(
                            child: Container(
                              height: 38,
                              // color: Colors.green,
                              child: TextFormField(

                                textInputAction: TextInputAction.done,
                                cursorColor: AppColors.appText1,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.fromLTRB(0,0,0,0),
                                  hintText: 'Search for brands & Products',
                                  // labelText: 'Search for brands & Products',
                                  // border: OutlineInputBorder(),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                                style:  GoogleFonts.inriaSans(
                                    textStyle:
                                    const TextStyle(
                                        fontSize: 12,
                                        fontWeight:
                                        FontWeight
                                            .w400,
                                        color: AppColors
                                            .black)),
                                onChanged: (text){
                                  setState(() {
                                    print("text  ${text}");
                                  });
                                },
                              ),
                            ),
                          ),
                      ],
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

                    if(index == 0){
                      return Padding(
                        padding: index == 0 ? const EdgeInsets.only(right: 8.0,left: 16.0):const EdgeInsets.only(right: 8.0),
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
                                      BorderRadius.circular(100),child: Image.asset(searchController.categoryList[index].categoryImage!,fit: BoxFit.fill,width: 37,height: 40,)),
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
                                    BorderRadius.circular(100),child: Image.asset(searchController.categoryList[index].categoryImage!,fit: BoxFit.fill,width: 35,height: 35,)),
                                const SizedBox(width: 16,),
                                Text(searchController.categoryList[index].categoryName!,style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.black)))
                              ],
                            ),
                          ),
                        ),
                      );
                    }

                  }),
            ),
            SizedBox(height: 16.0,),
            Expanded(
              child: ListView(children: [


                // SizedBox(height: 10.0,),
                Container(
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
                              Text("RECENT SEARCHES",style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.searchTitle))),
                              Text("EDIT",style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.appRed)))
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
                              itemCount: searchController.recentList.length,
                              itemBuilder: (BuildContext c,int index){


                                  return Padding(
                                    padding: index == 0 ? const EdgeInsets.only(right: 16.0,left: 16.0):const EdgeInsets.only(right: 16.0),
                                    child: Container(
                                      width: 65,
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(100),child: Image.asset(searchController.recentList[index].categoryImage!,fit: BoxFit.fill,width: 65,height: 65,)),
                                          const SizedBox(height: 8,),
                                          Text(


                                              searchController.recentList[index].categoryName!,
                                              textAlign : TextAlign.center,
                                              style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.black)))
                                        ],
                                      ),
                                    ),
                                  );


                              }),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.0,),

                // SizedBox(height: 8.0,),
                Container(
                  color: AppColors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: AppColors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16.0,bottom: 16.0,left: 16.0,right: 16.0),
                          child: Text("ITEMS YOU HAVE WISHLIST",style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.searchTitle))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Container(
                          height: 180,
                          color: AppColors.white,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                              searchController.wishList.length,
                              itemBuilder: (c, index) {
                                return Padding(
                                  padding:index == 0 ? const EdgeInsets.only(right: 16.0,left: 16.0):const EdgeInsets.only(right: 16.0),
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
                                        Image.asset(
                                          searchController.wishList[index]
                                              .coverImage!,
                                          fit: BoxFit.fill,
                                          width: double.infinity,
                                          height: 100,
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets
                                              .only(
                                              left: 5.0,
                                              right: 5.0,
                                              bottom: 0.0,
                                              top: 5.0),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                            children: [
                                              Text(
                                                  searchController.wishList[index]
                                                      .productName!,
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
                                              Text(
                                                  searchController.wishList[
                                                  index]
                                                      .shortDescription!,
                                                  maxLines: 2,
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

                                              Row(
                                                children: [
                                                  Text(
                                                      "\u{20B9}${double.parse(searchController.wishList[index].netPrice!).toStringAsFixed(0)} ",
                                                      style: GoogleFonts.inriaSans(
                                                          textStyle: const TextStyle(
                                                              fontSize:
                                                              12,
                                                              fontWeight:
                                                              FontWeight.w400,
                                                              color: AppColors.black))),
                                                  Text(
                                                      "\u{20B9}${double.parse(searchController.wishList[index].mrpPrice!).toStringAsFixed(0)} ",
                                                      style: GoogleFonts.inriaSans(
                                                          textStyle: TextStyle(
                                                              fontSize:
                                                              12,
                                                              decoration:
                                                              TextDecoration.combine([
                                                                TextDecoration.lineThrough
                                                              ]),
                                                              fontWeight:
                                                              FontWeight.w400,
                                                              color: AppColors.appText1))),

                                                ],
                                              ),
                                              Text(
                                                  "${searchController.wishList[index].discount!}% OFF",
                                                  style: GoogleFonts.inriaSans(
                                                      textStyle: const TextStyle(
                                                          fontSize:
                                                          14,
                                                          fontWeight:
                                                          FontWeight.w400,
                                                          color: AppColors.off)))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 15.0,),

                // SizedBox(height: 8.0,),
                Container(
                  color: AppColors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: AppColors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16.0,bottom: 16.0,left: 16.0,right: 16.0),
                          child: Text("ITEMS YOU HAVE WISHLIST",style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.searchTitle))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Container(
                          height: 180,
                          color: AppColors.white,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                              searchController.wishList.length,
                              itemBuilder: (c, index) {
                                return Padding(
                                  padding:index == 0 ? const EdgeInsets.only(right: 16.0,left: 16.0):const EdgeInsets.only(right: 16.0),
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
                                        Image.asset(
                                          searchController.wishList[index]
                                              .coverImage!,
                                          fit: BoxFit.fill,
                                          width: double.infinity,
                                          height: 100,
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets
                                              .only(
                                              left: 5.0,
                                              right: 5.0,
                                              bottom: 0.0,
                                              top: 5.0),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                            children: [
                                              Text(
                                                  searchController.wishList[index]
                                                      .productName!,
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
                                              Text(
                                                  searchController.wishList[
                                                  index]
                                                      .shortDescription!,
                                                  maxLines: 2,
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

                                              Row(
                                                children: [
                                                  Text(
                                                      "\u{20B9}${double.parse(searchController.wishList[index].netPrice!).toStringAsFixed(0)} ",
                                                      style: GoogleFonts.inriaSans(
                                                          textStyle: const TextStyle(
                                                              fontSize:
                                                              12,
                                                              fontWeight:
                                                              FontWeight.w400,
                                                              color: AppColors.black))),
                                                  Text(
                                                      "\u{20B9}${double.parse(searchController.wishList[index].mrpPrice!).toStringAsFixed(0)} ",
                                                      style: GoogleFonts.inriaSans(
                                                          textStyle: TextStyle(
                                                              fontSize:
                                                              12,
                                                              decoration:
                                                              TextDecoration.combine([
                                                                TextDecoration.lineThrough
                                                              ]),
                                                              fontWeight:
                                                              FontWeight.w400,
                                                              color: AppColors.appText1))),

                                                ],
                                              ),
                                              Text(
                                                  "${searchController.wishList[index].discount!}% OFF",
                                                  style: GoogleFonts.inriaSans(
                                                      textStyle: const TextStyle(
                                                          fontSize:
                                                          14,
                                                          fontWeight:
                                                          FontWeight.w400,
                                                          color: AppColors.off)))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                ),

              ],),
            ),
          ],
        ),
      ),
    );
  }
}
