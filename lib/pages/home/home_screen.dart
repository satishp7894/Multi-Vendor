import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:eshoperapp/config/theme.dart';
import 'package:eshoperapp/constants/app_costants.dart';
import 'package:eshoperapp/models/brand.dart';
import 'package:eshoperapp/models/get_slider.dart';
import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/models/products.dart';
import 'package:eshoperapp/pages/home/views/all_product.dart';
import 'package:eshoperapp/pages/home/views/brand.dart';

// import 'package:eshoperapp/pages/home/views/header.dart';
import 'package:eshoperapp/pages/home/views/populor_product.dart';
import 'package:eshoperapp/pages/home/views/sajilo_carousel.dart';
import 'package:eshoperapp/pages/landing_home/home_controller.dart';
import 'package:eshoperapp/pages/landing_home/landing_home.dart';
import 'package:eshoperapp/style/theme.dart' as Style;
import 'package:eshoperapp/utils/check_internet.dart';

// import 'package:eshoperapp/pages/landing_home/home_controller.dart';
import 'package:eshoperapp/widgets/block_header.dart';
import 'package:eshoperapp/widgets/product_gridview_tile.dart';
import 'package:eshoperapp/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../widgets/app_bar.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//
//   }
// }

class Home extends StatefulWidget {
  final int? index;

  Home({this.index});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final homeController = Get.find<HomeController>();
  int? currentIndex = 0;
  bool? isFlag = true;
  Timer? _timer;
  PageController _pageController = PageController(
    initialPage: 0,
  );
  CarouselController? carouselController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    _timer!.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SajiloDokanScaffold(
      leading: false,
      searchOnTab: () {},
      background: AppColors.white,
      bottomMenuIndex: widget.index,
      title: null,
      // background: AppColors.homeBg,
      body: SafeArea(
        child: Column(
          children: [
            AppbarWidget(flag: false,),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () {
                  CheckInternet.checkInternet();
                  homeController.getBrand();
                  homeController.bestSellerProduct();
                  homeController.allProducts();
                  homeController.getSlider();
                  return homeController.newProducts(true);
                },
                child: Obx(() {



                  final orientation = MediaQuery.of(context).orientation;
                  if (homeController.isLoadingNewProducts.value != true) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          SizedBox(height: 18.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:homeController.categoryList1.map((e) {
                              var index = homeController.categoryList1.indexOf(e);
                              return  Padding(
                                padding: index == 0 ? const EdgeInsets.only(right: 15.0,left: 15.0):const EdgeInsets.only(right: 15.0),
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          width: 60,height: 58,

                                          decoration: BoxDecoration(
                                              color: e.color,
                                              borderRadius: BorderRadius.circular(15.0)
                                          ),
                                        ),
                                        ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(15),child: Image.asset(e.categoryImage!,fit: e.fit,width: 60,height: 58,)),
                                      ],
                                    ),
                                    const SizedBox(height: 8,),
                                    Center(child: Text(e.categoryName!,style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.categoryText))))
                                  ],
                                ),
                              );
                            }




                            ).toList(),),
                          SizedBox(height: 15.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:homeController.categoryList2.map((e) {
                              var index = homeController.categoryList2.indexOf(e);
                              return  Padding(
                                padding: index == 0 ? const EdgeInsets.only(right: 15.0,left: 15.0):const EdgeInsets.only(right: 15.0),
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          width: 60,height: 58,

                                          decoration: BoxDecoration(
                                              color: e.color,
                                              borderRadius: BorderRadius.circular(15.0)
                                          ),
                                        ),
                                        ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(15),child: Image.asset(e.categoryImage!,fit: BoxFit.contain,width: 60,height: 58,)),
                                      ],
                                    ),
                                    const SizedBox(height: 8,),
                                    Center(child: Text(e.categoryName!,style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.categoryText))))
                                  ],
                                ),
                              );
                            }

                            ).toList(),),
                          SizedBox(height: 24.0),
                          // Expanded(
                          //   child: Container(
                          //     // height: 70,
                          //     width: MediaQuery.of(context).size.width,
                          //     child: ListView.builder(
                          //       scrollDirection: Axis.horizontal,
                          //         itemCount: homeController.categoryList1.length,
                          //         itemBuilder: (BuildContext c,int index){
                          //       return Column(
                          //         children: [
                          //           Stack(
                          //             children: [
                          //               Container(
                          //                 width: 56,height: 58,
                          //
                          //                 decoration: BoxDecoration(
                          //                     color: homeController.categoryList[index].color,
                          //                     borderRadius: BorderRadius.circular(15.0)
                          //                 ),
                          //               ),
                          //               ClipRRect(
                          //                   borderRadius:
                          //                   BorderRadius.circular(15),child: Image.asset(homeController.categoryList[index].categoryImage!,fit: BoxFit.contain,width: 56,height: 58,)),
                          //             ],
                          //           ),
                          //           // const SizedBox(height: 8,),
                          //           Center(child: Text(homeController.categoryList[index].categoryName!,style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.categoryText))))
                          //         ],
                          //       );
                          //     }),
                          //   ),
                          // ),
                          // Container(
                          //   // height: 100,
                          //   width: MediaQuery.of(context).size.width,
                          //   child: ListView.builder(
                          //       scrollDirection: Axis.horizontal,
                          //       itemCount: homeController.categoryList2.length,
                          //       itemBuilder: (BuildContext c,int index){
                          //         return Column(
                          //           children: [
                          //             Stack(
                          //               children: [
                          //                 Container(
                          //                   width: 56,height: 54,
                          //
                          //                   decoration: BoxDecoration(
                          //                       color: homeController.categoryList[index].color,
                          //                       borderRadius: BorderRadius.circular(15.0)
                          //                   ),
                          //                 ),
                          //                 ClipRRect(
                          //                     borderRadius:
                          //                     BorderRadius.circular(15),child: Image.asset(homeController.categoryList[index].categoryImage!,fit: BoxFit.contain,width: 56,height: 54,)),
                          //               ],
                          //             ),
                          //             // const SizedBox(height: 8,),
                          //             Center(child: Text(homeController.categoryList[index].categoryName!,style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.categoryText))))
                          //           ],
                          //         );
                          //       }),
                          // ),
                          // Catogory
                          // Container(
                          //   color: AppColors.white,
                          //   //padding: const EdgeInsets.only(top: 16,left: 16,right: 16,bottom: 24),
                          //   // height: 400,
                          //   child: GridView.builder(
                          //     physics: const NeverScrollableScrollPhysics(),
                          //     shrinkWrap: true,
                          //     itemCount: homeController.categoryList.length,
                          //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          //         // crossAxisCount: 2,
                          //         crossAxisSpacing: 10,
                          //         mainAxisSpacing: 10,
                          //         childAspectRatio: 0.8,
                          //         crossAxisCount: (orientation == Orientation.portrait) ? 5 : 5),
                          //     itemBuilder: (BuildContext context, int index) {
                          //       return Wrap(
                          //         children: [
                          //           Column(
                          //             children: [
                          //               Stack(
                          //                 children: [
                          //                   Container(
                          //                   width: 56,height: 54,
                          //
                          //                     decoration: BoxDecoration(
                          //                         color: homeController.categoryList[index].color,
                          //                       borderRadius: BorderRadius.circular(15.0)
                          //                     ),
                          //                   ),
                          //                   ClipRRect(
                          //                       borderRadius:
                          //                       BorderRadius.circular(15),child: Image.asset(homeController.categoryList[index].categoryImage!,fit: BoxFit.contain,width: 56,height: 54,)),
                          //                 ],
                          //               ),
                          //               const SizedBox(height: 8,),
                          //               Center(child: Text(homeController.categoryList[index].categoryName!,style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.categoryText))))
                          //             ],
                          //           ),
                          //         ],
                          //       );
                          //       return new Card(
                          //         child: new GridTile(
                          //           // footer: new Text(homeController.imageList[index]['name']),
                          //           child: new Text(homeController.imageList[index]), //just for testing, will fill with image later
                          //         ),
                          //       );
                          //     },
                          //   ),
                          // ),

                          // Slider
                          Obx(() {
                            GetSlider getSliderObj =
                                homeController.getSliderObj.value;
                            if (homeController.isLoadingGetSlider.value != true) {
                              List<GetSliderData>? getSliderDataList =
                                  getSliderObj.data ?? [];
                              String? message =
                                  getSliderObj.message ?? AppConstants.noInternetConn;
                              String? imageUrl = getSliderObj.imageUrl;


                              if (getSliderDataList.isEmpty) {
                                return SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 200,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        message!,
                                        style: const TextStyle(color: Colors.black45),
                                      ),
                                    ],
                                  ),
                                );
                              } else {

                                // return SajiloCarousel(
                                //   sliderList: getSliderDataList,
                                //   imageUrl: imageUrl,
                                // );

                                if(isFlag!){
                                  _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
                                    if (currentIndex! < homeController.img.length) {
                                      currentIndex = currentIndex!+1;
                                    } else {
                                      currentIndex = 0;
                                    }

                                    _pageController.animateToPage(
                                      currentIndex!,
                                      duration: const Duration(milliseconds: 350),
                                      curve: Curves.easeIn,
                                    );
                                  });
                                  isFlag = false;
                                }else{
                                  isFlag = false;
                                }


                                return
                                  SizedBox(
                                  // height: 258,
                                  // width: 300,
                                  child:
                                  Column(
                                    //fit: StackFit.passthrough,
                                    children: [

                                      SizedBox(

                                        child: PageView.builder(

                                          controller: _pageController,
                                          itemCount: homeController.img.length,
                                          onPageChanged: (index){
                                            setState(() {
                                              currentIndex = index;
                                            });
                                          },
                                          itemBuilder: (_, index) {
                                            return ClipRRect(
                                              // borderRadius: BorderRadius.all(Radius.circular(10)),
                                              child: Image.asset("assets/img/slider.png", fit: BoxFit.fill,width: double.infinity),
                                            );
                                          },
                                        ),
                                        height: 215,
                                      ),
                                      SizedBox(height: 5.0,),

                                      SizedBox(

                                        child:

                                        SmoothPageIndicator(
                                          controller: _pageController,
                                          count: homeController.img.length,
                                          effect: const ExpandingDotsEffect(
                                            dotHeight: 2,
                                            dotWidth: 10,
                                            spacing: 2,
                                              activeDotColor : AppColors.appRed,
                                              offset : 5
                                            // type: SwapType.yRotation,
                                            // strokeWidth: 5,
                                          ),
                                        ),
                                        // height: 15,
                                      ),
                                   SizedBox(height: 24,),

                                  //     CarouselSlider(
                                  // carouselController:carouselController,
                                  //       options: CarouselOptions(
                                  //
                                  //           autoPlay: true,
                                  //           //  aspectRatio: 2.0,
                                  //           viewportFraction: 1.0,
                                  //           height: 200,
                                  //           //enlargeCenterPage: true,
                                  //           onPageChanged: (i, re) {
                                  //             // if (kDebugMode) {
                                  //             //   print("index $i");
                                  //             // }
                                  //             setState(() {
                                  //               currentIndex = i;
                                  //             });
                                  //           }),
                                  //       items: homeController.img.map((e) {
                                  //         return ClipRRect(
                                  //           // borderRadius: BorderRadius.all(Radius.circular(10)),
                                  //           child: Image.network(e, fit: BoxFit.cover, width: 1000.0),
                                  //         );
                                  //       }).toList(),
                                  //     ),
                                      // Align(
                                      //   alignment: Alignment.bottomCenter,
                                      //   child: Container(
                                      //     height: 50,
                                      //     // width: 300,
                                      //     child: ListView.builder(
                                      //       shrinkWrap: true,
                                      //         itemCount: homeController.img.length,
                                      //         scrollDirection: Axis.horizontal,
                                      //         itemBuilder: (BuildContext c, int i) {
                                      //           if (currentIndex == i) {
                                      //             return Padding(
                                      //               padding: const EdgeInsets.only(top: 21.0,bottom: 21.0),
                                      //               child: Container(
                                      //                 width: 30.0,
                                      //
                                      //                 // margin: EdgeInsets.symmetric(
                                      //                 //     vertical: 10.0, horizontal: 2.0),
                                      //                 decoration: BoxDecoration(
                                      //                   color: AppColors.black,
                                      //                   borderRadius: BorderRadius.only(
                                      //                     topRight: Radius.circular(100),
                                      //                     topLeft: Radius.circular(100),
                                      //                     bottomLeft: Radius.circular(100),
                                      //                     bottomRight: Radius.circular(100),
                                      //                   ),
                                      //                 ),
                                      //                 // decoration: BoxDecoration(
                                      //                 //     shape: BoxShape.circle, color: Colors.black),
                                      //               ),
                                      //             );
                                      //           } else {
                                      //             return Container(
                                      //               width: 8.0,
                                      //               margin: EdgeInsets.symmetric(
                                      //                   vertical: 21.0, horizontal: 2.0),
                                      //               decoration: BoxDecoration(
                                      //                 color: Colors.grey,
                                      //                 borderRadius: BorderRadius.only(
                                      //                   topRight: Radius.circular(100),
                                      //                   topLeft: Radius.circular(100),
                                      //                   bottomLeft: Radius.circular(100),
                                      //                   bottomRight: Radius.circular(100),
                                      //                 ),),
                                      //             );
                                      //           }
                                      //         }),
                                      //   ),
                                      // )
                                      // AnimatedSmoothIndicator(
                                      //   activeIndex: currentIndex!,
                                      //   count:  6,
                                      //   effect:  WormEffect(),
                                      // ),
                                      // SmoothPageIndicator(
                                      //     controller: controller,
                                      //     count: 5,
                                      //     effect: ScrollingDotsEffect(
                                      //       activeStrokeWidth: 2.6,
                                      //       activeDotScale: 1.3,
                                      //       maxVisibleDots: 5,
                                      //       radius: 8,
                                      //       spacing: 10,
                                      //       dotHeight: 12,
                                      //       dotWidth: 12,
                                      //     )),
                                      // SmoothPageIndicator(
                                      //   controller: carouselController!,
                                      //   count: 10,
                                      //   effect: WormEffect(
                                      //     dotHeight: 16,
                                      //     dotWidth: 16,
                                      //     type: WormType.thin,
                                      //     // strokeWidth: 5,
                                      //   ),
                                      // ),
                                    ],
                                  ),

                                  // IntroductionSlider(
                                  //   items: [
                                  //     IntroductionSliderItem(
                                  //       logo: FlutterLogo(),
                                  //       title: Text("Title 1"),
                                  //       backgroundColor: Colors.red,
                                  //     ),
                                  //     IntroductionSliderItem(
                                  //       logo: FlutterLogo(),
                                  //       title: Text("Title 2"),
                                  //       backgroundColor: Colors.green,
                                  //     ),
                                  //     IntroductionSliderItem(
                                  //       logo: FlutterLogo(),
                                  //       title: Text("Title 3"),
                                  //       backgroundColor: Colors.blue,
                                  //     ),
                                  //   ],
                                  //   done: Done(
                                  //     child: Container(),
                                  //     home: LandingHome(),
                                  //   ),
                                  //   next: Next(child: Container()),
                                  //   back: Back(child: Container()),
                                  //   dotIndicator: DotIndicator(selectedColor: Colors.blue,
                                  //       unselectedColor: Colors.blue.withOpacity(0.5),
                                  //       size: 8.0),
                                  //
                                  // ),

                                  // IntroSlider(
                                  //   key: UniqueKey(),
                                  //   // Content config
                                  //   listContentConfig: listContentConfig,
                                  //   backgroundColorAllTabs: Colors.grey,
                                  //
                                  //   // // Skip button
                                  //   // renderSkipBtn: renderSkipBtn(),
                                  //   // skipButtonStyle: myButtonStyle(),
                                  //
                                  //   // // Next button
                                  //   // renderNextBtn: renderNextBtn(),
                                  //   // onNextPress: onNextPress,
                                  //   // nextButtonStyle: myButtonStyle(),
                                  //
                                  //   // Done button
                                  //   // renderDoneBtn: renderDoneBtn(),
                                  //   // onDonePress: onDonePress,
                                  //   // doneButtonStyle: myButtonStyle(),
                                  //
                                  //   // Indicator
                                  //   indicatorConfig: IndicatorConfig(
                                  //     sizeIndicator: sizeIndicator,
                                  //     indicatorWidget: Container(
                                  //       width: sizeIndicator,
                                  //       height: 10,
                                  //       decoration: BoxDecoration(
                                  //           borderRadius: BorderRadius.circular(4), color: inactiveColor),
                                  //     ),
                                  //     activeIndicatorWidget: Container(
                                  //       width: sizeIndicator,
                                  //       height: 10,
                                  //       decoration: BoxDecoration(
                                  //           borderRadius: BorderRadius.circular(4), color: activeColor),
                                  //     ),
                                  //     spaceBetweenIndicator: 10,
                                  //     typeIndicatorAnimation: TypeIndicatorAnimation.sliding,
                                  //   ),
                                  //
                                  //   // Navigation bar
                                  //   navigationBarConfig: NavigationBarConfig(
                                  //     navPosition: NavPosition.bottom,
                                  //     padding: EdgeInsets.only(
                                  //       top: MediaQuery.of(context).viewPadding.top > 0 ? 20 : 10,
                                  //       bottom: MediaQuery.of(context).viewPadding.bottom > 0 ? 20 : 10,
                                  //     ),
                                  //     backgroundColor: Colors.black.withOpacity(0.5),
                                  //   ),
                                  //
                                  //   // Scroll behavior
                                  //   isAutoScroll: true,
                                  //   isLoopAutoScroll: true,
                                  //   curveScroll: Curves.bounceIn,
                                  //
                                  // ),
                                );
                              }
                              // String? message = getTodayNewsObj.message ?? AppConstants.noInternetConn;

                            } else {
                              if (getSliderObj != true) {
                                return Container(
                                  height: 90,
                                  // child: Center(
                                  //     child:
                                  //     CircularProgressIndicator(color: Colors.red))
                                );
                              } else {
                                return Container(
                                  height: 90,
                                );
                              }
                            }
                          }),


                          Container(
                            color: AppColors.appRed.withOpacity(0.2),
                            child: Column(
                              children: [
                                const SizedBox(height: 16,),
                                Text("BUDGET BUYS", style: GoogleFonts.salsa(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.appText))),
                                const SizedBox(height: 16,),
                                SizedBox(
                                  height: 150,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                      itemCount: homeController.budgetList1.length,
                                      itemBuilder: (c,index){
                                    if(index == 0){
                                      return Padding(
                                        padding: const EdgeInsets.only(left: AppSizes.sidePadding,right: AppSizes.sidePadding),
                                        child: Container(
                                          // height: 120,
                                          width: 110,
                                          decoration: BoxDecoration(
                                            // color: AppColors.budgetBg,
                                            borderRadius: const BorderRadius.only(
                                              topRight: const Radius.circular(100),
                                              topLeft: Radius.circular(100),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                            border: Border.all(
                                              width: 1,
                                              color: AppColors.appRed,
                                              // style: BorderStyle.solid,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: AppColors.budgetUnderBg,
                                                borderRadius: const BorderRadius.only(
                                                  topRight: const Radius.circular(100),
                                                  topLeft: Radius.circular(100),
                                                  bottomLeft: Radius.circular(5),
                                                  bottomRight: Radius.circular(5),
                                                ),
                                                // border: Border.all(
                                                //   width: 1,
                                                //   color: AppColors.budgetBorder,
                                                //   // style: BorderStyle.solid,
                                                // ),
                                              ),
                                              width: 110,
                                              child: Center(child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  const SizedBox(height: 15,),
                                                  Text("UNDER", style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: AppColors.black))),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text("₹", style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 10,fontWeight: FontWeight.w400,color: AppColors.black))),
                                                      Text("399", style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: AppColors.black))),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                            ),
                                          ),
                                        ),
                                      );
                                    }else{
                                      return  Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right: AppSizes.sidePadding),
                                            child: SizedBox(
                                              height: 150,
                                              width: 110,
                                              child: ClipRRect(
                                                  borderRadius: const BorderRadius.only(
                                                    topRight: const Radius.circular(100),
                                                    topLeft: const Radius.circular(100),
                                                    bottomLeft: const Radius.circular(10),
                                                    bottomRight: const Radius.circular(10),
                                                  ),
                                                  // borderRadius:
                                                  // BorderRadius.circular(15),
                                                  child: Image.asset(homeController.budgetList1[index].categoryImage!,fit: BoxFit.fill,width: double.infinity)),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 8.0),
                                            child: Container(

                                                width: 110,
                                                // height: 140,
                                                alignment: Alignment.bottomCenter,
                                                child: Container(
                                                    // color: AppColors.budgetBg,
                                                    decoration: const BoxDecoration(
                                                      color: AppColors.budgetBg,
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(10)
                                                      ),
                                                    ),
                                                        height: 22,
                                                    width: 100,
                                                    child: Center(child: Text(homeController.budgetList1[index].categoryName!, style: GoogleFonts.salsa(textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.appText)))))),
                                          ),
                                        ],
                                      );
                                    }

                                  }),
                                ),
                                SizedBox(height: 16,),
                                SizedBox(
                                  height: 150,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: homeController.budgetList2.length,
                                      itemBuilder: (c,index){
                                        if(index == 0){
                                          return Padding(
                                            padding: const EdgeInsets.only(left: AppSizes.sidePadding,right: AppSizes.sidePadding),
                                            child: Container(
                                              // height: 120,
                                              width: 110,
                                              decoration: BoxDecoration(
                                                // color: AppColors.budgetBg,
                                                borderRadius: const BorderRadius.only(
                                                  topRight: const Radius.circular(100),
                                                  topLeft: Radius.circular(100),
                                                  bottomLeft: Radius.circular(10),
                                                  bottomRight: Radius.circular(10),
                                                ),
                                                border: Border.all(
                                                  width: 1,
                                                  color: AppColors.appRed,
                                                  // style: BorderStyle.solid,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(3.0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: AppColors.budgetUnderBg,
                                                    borderRadius: const BorderRadius.only(
                                                      topRight: const Radius.circular(100),
                                                      topLeft: Radius.circular(100),
                                                      bottomLeft: Radius.circular(5),
                                                      bottomRight: Radius.circular(5),
                                                    ),
                                                    // border: Border.all(
                                                    //   width: 1,
                                                    //   color: AppColors.budgetBorder,
                                                    //   // style: BorderStyle.solid,
                                                    // ),
                                                  ),
                                                  width: 110,
                                                  child: Center(child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      const SizedBox(height: 15,),
                                                      Text("UNDER", style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: AppColors.appText))),
                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text("₹", style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.appText))),
                                                          Text("699", style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: AppColors.appText))),
                                                        ],
                                                      ),
                                                    ],
                                                  )),
                                                ),
                                              ),
                                            ),
                                          );
                                        }else{
                                          return  Stack(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(right: AppSizes.sidePadding),
                                                child: SizedBox(
                                                  height: 150,
                                                  width: 110,
                                                  child: ClipRRect(
                                                      borderRadius: const BorderRadius.only(
                                                        topRight: const Radius.circular(100),
                                                        topLeft: const Radius.circular(100),
                                                        bottomLeft: const Radius.circular(10),
                                                        bottomRight: const Radius.circular(10),
                                                      ),
                                                      // borderRadius:
                                                      // BorderRadius.circular(15),
                                                      child: Image.asset(homeController.budgetList2[index].categoryImage!,fit: BoxFit.fill,width: double.infinity)),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 8.0),
                                                child: Container(

                                                    width: 110,
                                                    // height: 140,
                                                    alignment: Alignment.bottomCenter,
                                                    child: Container(
                                                      // color: AppColors.budgetBg,
                                                        decoration: const BoxDecoration(
                                                          color: AppColors.budgetBg,
                                                          borderRadius: BorderRadius.all(
                                                              Radius.circular(10)
                                                          ),
                                                        ),
                                                        height: 22,
                                                        width: 100,
                                                        child: Center(child: Text(homeController.budgetList2[index].categoryName!, style: GoogleFonts.salsa(textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.appText)))))),
                                              ),
                                            ],
                                          );
                                        }

                                      }),
                                ),
                                SizedBox(height: 16,),
                                SizedBox(
                                  height: 150,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: homeController.budgetList3.length,
                                      itemBuilder: (c,index){
                                        if(index == 0){
                                          return Padding(
                                            padding: const EdgeInsets.only(left: AppSizes.sidePadding,right: AppSizes.sidePadding),
                                            child: Container(
                                              // height: 120,
                                              width: 110,
                                              decoration: BoxDecoration(
                                                // color: AppColors.budgetBg,
                                                borderRadius: const BorderRadius.only(
                                                  topRight: const Radius.circular(100),
                                                  topLeft: Radius.circular(100),
                                                  bottomLeft: Radius.circular(10),
                                                  bottomRight: Radius.circular(10),
                                                ),
                                                border: Border.all(
                                                  width: 1,
                                                  color: AppColors.appRed,
                                                  // style: BorderStyle.solid,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(3.0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: AppColors.budgetUnderBg,
                                                    borderRadius: const BorderRadius.only(
                                                      topRight: const Radius.circular(100),
                                                      topLeft: Radius.circular(100),
                                                      bottomLeft: Radius.circular(5),
                                                      bottomRight: Radius.circular(5),
                                                    ),
                                                    // border: Border.all(
                                                    //   width: 1,
                                                    //   color: AppColors.budgetBorder,
                                                    //   // style: BorderStyle.solid,
                                                    // ),
                                                  ),
                                                  width: 110,
                                                  child: Center(child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      const SizedBox(height: 15,),
                                                      Text("UNDER", style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: AppColors.appText))),
                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text("₹", style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.appText))),
                                                          Text("999", style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: AppColors.appText))),
                                                        ],
                                                      ),
                                                    ],
                                                  )),
                                                ),
                                              ),
                                            ),
                                          );
                                        }else{
                                          return  Stack(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(right: AppSizes.sidePadding),
                                                child: SizedBox(
                                                  height: 150,
                                                  width: 110,
                                                  child: ClipRRect(
                                                      borderRadius: const BorderRadius.only(
                                                        topRight: const Radius.circular(100),
                                                        topLeft: const Radius.circular(100),
                                                        bottomLeft: const Radius.circular(10),
                                                        bottomRight: const Radius.circular(10),
                                                      ),
                                                      // borderRadius:
                                                      // BorderRadius.circular(15),
                                                      child: Image.asset(homeController.budgetList3[index].categoryImage!,fit: BoxFit.fill,width: double.infinity)),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 8.0),
                                                child: Container(

                                                    width: 110,
                                                    // height: 140,
                                                    alignment: Alignment.bottomCenter,
                                                    child: Container(
                                                      // color: AppColors.budgetBg,
                                                        decoration: const BoxDecoration(
                                                          color: AppColors.budgetBg,
                                                          borderRadius: BorderRadius.all(
                                                              Radius.circular(10)
                                                          ),
                                                        ),
                                                        height: 22,
                                                        width: 100,
                                                        child: Center(child: Text(homeController.budgetList3[index].categoryName!, style: GoogleFonts.salsa(textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.appText)))))),
                                              ),
                                            ],
                                          );
                                        }

                                      }),
                                ),
                                SizedBox(height: 16,),
                                // SizedBox(
                                //   height: 150,
                                //   width: MediaQuery.of(context).size.width,
                                //   child: ListView.builder(
                                //       scrollDirection: Axis.horizontal,
                                //       itemCount: homeController.budgetList2.length,
                                //       itemBuilder: (c,index){
                                //         if(index == 0){
                                //           return Padding(
                                //             padding: const EdgeInsets.all(8.0),
                                //             child: Container(
                                //               decoration: BoxDecoration(
                                //                 // color: AppColors.budgetBg,
                                //                 borderRadius: const BorderRadius.only(
                                //                   topRight: const Radius.circular(100),
                                //                   topLeft: const Radius.circular(100),
                                //                   bottomLeft: const Radius.circular(10),
                                //                   bottomRight: const Radius.circular(10),
                                //                 ),
                                //                 border: Border.all(
                                //                   width: 1,
                                //                   color: AppColors.budgetBorder,
                                //                   // style: BorderStyle.solid,
                                //                 ),
                                //               ),
                                //               child: Padding(
                                //                 padding: const EdgeInsets.all(2.0),
                                //                 child: Container(
                                //                   decoration: const BoxDecoration(
                                //                     color: AppColors.budgetBg,
                                //                     borderRadius: const BorderRadius.only(
                                //                       topRight: const Radius.circular(100),
                                //                       topLeft: const Radius.circular(100),
                                //                       bottomLeft: const Radius.circular(10),
                                //                       bottomRight: Radius.circular(10),
                                //                     ),
                                //                     // border: Border.all(
                                //                     //   width: 1,
                                //                     //   color: AppColors.budgetBorder,
                                //                     //   // style: BorderStyle.solid,
                                //                     // ),
                                //                   ),
                                //                   width: 110,
                                //                   child: Center(child: Column(
                                //                     crossAxisAlignment: CrossAxisAlignment.center,
                                //                     mainAxisAlignment: MainAxisAlignment.center,
                                //                     children: [
                                //                       const SizedBox(height: 15,),
                                //                       Text("UNDER", style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: AppColors.appText))),
                                //                       Row(
                                //                         crossAxisAlignment: CrossAxisAlignment.start,
                                //                         mainAxisAlignment: MainAxisAlignment.center,
                                //                         children: [
                                //                           Text("₹", style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.appText))),
                                //                           Text("999", style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: AppColors.appText))),
                                //                         ],
                                //                       ),
                                //                     ],
                                //                   )),
                                //                 ),
                                //               ),
                                //             ),
                                //           );
                                //         }else{
                                //           return  Padding(
                                //             padding: const EdgeInsets.all(8.0),
                                //             child: Stack(
                                //               children: [
                                //                 SizedBox(
                                //                   height: 140,
                                //                   width: 110,
                                //                   child: ClipRRect(
                                //                       borderRadius: const BorderRadius.only(
                                //                         topRight: const Radius.circular(100),
                                //                         topLeft: const Radius.circular(100),
                                //                         bottomLeft: const Radius.circular(10),
                                //                         bottomRight: Radius.circular(10),
                                //                       ),
                                //                       // borderRadius:
                                //                       // BorderRadius.circular(15),
                                //                       child: Image.asset(homeController.budgetList2[index].categoryImage!,fit: BoxFit.fill,width: double.infinity)),
                                //                 ),
                                //                 Padding(
                                //                   padding: const EdgeInsets.only(bottom: 5.0),
                                //                   child: Container(
                                //
                                //                       width: 110,
                                //                       height: 140,
                                //                       alignment: Alignment.bottomCenter,
                                //                       child: Container(
                                //                         // color: AppColors.budgetBg,
                                //                           decoration: const BoxDecoration(
                                //                             color: AppColors.budgetBg,
                                //                             borderRadius: BorderRadius.all(
                                //                                 Radius.circular(20)
                                //                             ),
                                //                           ),
                                //                           height: 22,
                                //                           width: 100,
                                //                           child: Center(child: Text(homeController.budgetList2[index].categoryName!, style: GoogleFonts.salsa(textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.appText)))))),
                                //                 ),
                                //               ],
                                //             ),
                                //           );
                                //         }
                                //
                                //       }),
                                // ),
                                // SizedBox(height: 16,),
                                // SizedBox(
                                //   height: 150,
                                //   width: MediaQuery.of(context).size.width,
                                //   child: ListView.builder(
                                //       scrollDirection: Axis.horizontal,
                                //       itemCount: homeController.budgetList3.length,
                                //       itemBuilder: (c,index){
                                //         if(index == 0){
                                //           return Padding(
                                //             padding: const EdgeInsets.all(8.0),
                                //             child: Container(
                                //               decoration: BoxDecoration(
                                //                 // color: AppColors.budgetBg,
                                //                 borderRadius: const BorderRadius.only(
                                //                   topRight: const Radius.circular(100),
                                //                   topLeft: const Radius.circular(100),
                                //                   bottomLeft: const Radius.circular(10),
                                //                   bottomRight: Radius.circular(10),
                                //                 ),
                                //                 border: Border.all(
                                //                   width: 1,
                                //                   color: AppColors.budgetBorder,
                                //                   // style: BorderStyle.solid,
                                //                 ),
                                //               ),
                                //               child: Padding(
                                //                 padding: const EdgeInsets.all(2.0),
                                //                 child: Container(
                                //                   decoration: const BoxDecoration(
                                //                     color: AppColors.budgetBg,
                                //                     borderRadius: const BorderRadius.only(
                                //                       topRight: const Radius.circular(100),
                                //                       topLeft: Radius.circular(100),
                                //                       bottomLeft: Radius.circular(10),
                                //                       bottomRight: Radius.circular(10),
                                //                     ),
                                //                     // border: Border.all(
                                //                     //   width: 1,
                                //                     //   color: AppColors.budgetBorder,
                                //                     //   // style: BorderStyle.solid,
                                //                     // ),
                                //                   ),
                                //                   width: 110,
                                //                   child: Center(child: Column(
                                //                     crossAxisAlignment: CrossAxisAlignment.center,
                                //                     mainAxisAlignment: MainAxisAlignment.center,
                                //                     children: [
                                //                       const SizedBox(height: 15,),
                                //                       Text("UNDER", style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: AppColors.appText))),
                                //                       Row(
                                //                         crossAxisAlignment: CrossAxisAlignment.start,
                                //                         mainAxisAlignment: MainAxisAlignment.center,
                                //                         children: [
                                //                           Text("₹", style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.appText))),
                                //                           Text("399", style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: AppColors.appText))),
                                //                         ],
                                //                       ),
                                //                     ],
                                //                   )),
                                //                 ),
                                //               ),
                                //             ),
                                //           );
                                //         }else{
                                //           return  Padding(
                                //             padding: const EdgeInsets.all(8.0),
                                //             child: Stack(
                                //               children: [
                                //                 SizedBox(
                                //                   height: 140,
                                //                   width: 110,
                                //                   child: ClipRRect(
                                //                       borderRadius: const BorderRadius.only(
                                //                         topRight: const Radius.circular(100),
                                //                         topLeft: const Radius.circular(100),
                                //                         bottomLeft: Radius.circular(10),
                                //                         bottomRight: Radius.circular(10),
                                //                       ),
                                //                       // borderRadius:
                                //                       // BorderRadius.circular(15),
                                //                       child: Image.asset(homeController.budgetList3[index].categoryImage!,fit: BoxFit.fill,width: double.infinity)),
                                //                 ),
                                //                 Padding(
                                //                   padding: const EdgeInsets.only(bottom: 5.0),
                                //                   child: Container(
                                //
                                //                       width: 110,
                                //                       height: 140,
                                //                       alignment: Alignment.bottomCenter,
                                //                       child: Container(
                                //                         // color: AppColors.budgetBg,
                                //                           decoration: const BoxDecoration(
                                //                             color: AppColors.budgetBg,
                                //                             borderRadius: const BorderRadius.all(
                                //                                 const Radius.circular(20)
                                //                             ),
                                //                           ),
                                //                           height: 22,
                                //                           width: 100,
                                //                           child: Center(child: Text(homeController.budgetList3[index].categoryName!, style: GoogleFonts.salsa(textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.appText)))))),
                                //                 ),
                                //               ],
                                //             ),
                                //           );
                                //         }
                                //
                                //       }),
                                // ),
                                // const SizedBox(height: 8,)
                              ],
                            ),
                          ),
                          const SizedBox(height: 24,),
                           Stack(
                             children: [
                               Container(
                                 height: 200,
                                 decoration: BoxDecoration(
                                   gradient: LinearGradient(
                                       colors: [
                                         const Color(0xFFD1A7A8),
                                         const Color(0xFFE7E7E7),
                                       ],

                                     begin: Alignment.topCenter,
                                     end: Alignment.bottomCenter,),
                                 ),
                               ),
                                Container(
                                  height: 200,

                                    child: Center(child: Column(
                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(height: 16,),
                                        Text("CHEMISTRY", style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400,
                                          letterSpacing:2,color: AppColors.black,))),
                                        Image(image: AssetImage("assets/img/banner.gif"),fit: BoxFit.cover,),
                                      ],
                                    ))),
                             ],
                           ),

                          const SizedBox(height: 24,),
                          Padding(
                            padding: const EdgeInsets.only(left: AppSizes.sidePadding),
                            child: Text("SHOP INDIAN DESIGNERS", style: GoogleFonts.hanuman(textStyle: const TextStyle(fontSize: 14,color: AppColors.black))),
                          ),
                          SizedBox(height: AppSizes.padding14,),

                          SizedBox(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: homeController.shopList.length,
                                itemBuilder: (c,index){

                                    return  Padding(
                                      padding: index == 0 ? const EdgeInsets.only(right: AppSizes.sidePadding,left: AppSizes.sidePadding,):const EdgeInsets.only(right: AppSizes.sidePadding,),
                                      child: Stack(
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                width: 160,
                                                height: 210,

                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  color: homeController.shopList[index].color,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 160,
                                                height: 210,
                                                child: ClipRRect(
                                                    borderRadius: const BorderRadius.all(
                                                        const Radius.circular(10)
                                                    ),
                                                    // borderRadius:
                                                    // BorderRadius.circular(15),
                                                    child: Image.asset(homeController.shopList[index].categoryImage!,fit: BoxFit.fill,width: double.infinity)),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Container(

                                                  decoration: BoxDecoration(
                                                      borderRadius: const BorderRadius.all(
                                                          const Radius.circular(10)
                                                      ),
                                                      gradient: LinearGradient(
                                                        begin: Alignment.topCenter,
                                                        end: Alignment.bottomCenter,
                                                        stops: const [0.0, 2.0],
                                                        colors: [
                                                          AppColors.black.withOpacity(0.0),
                                                          AppColors.black.withOpacity(0.8),
                                                          // Colors.white.withOpacity(0.0),
                                                          // const Color(0xFF030305).withOpacity(0.1),
                                                        ],
                                                      )
                                                  ),
                                                  alignment: Alignment.bottomCenter,
                                                  width: 160,
                                                  height: 200,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Text(homeController.shopList[index].categoryName!.toUpperCase(), style: GoogleFonts.averiaGruesaLibre(textStyle: const TextStyle(fontSize: 14,color: AppColors.white))),
                                                        SizedBox(height: 3,),

                                                        Text("UP TO 30% OFF", style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 10,color: AppColors.white))),
                                                        SizedBox(height: 3,),
                                                        Text("An exclusive range of Luxurious wedding wear", style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 8,color: AppColors.white)),textAlign: TextAlign.center,),
                                                      const SizedBox(height: 5,),
                                                      ],
                                                    ),
                                                  )),
                                            ],
                                            mainAxisAlignment: MainAxisAlignment.end,
                                          ),
                                        ],
                                      ),
                                    );


                                }),
                          ),
                          SizedBox(height: 24,),
                          Padding(
                            padding: const EdgeInsets.only(left: AppSizes.sidePadding),
                            child: Text("CHOOSE YOUR COLOR", style: GoogleFonts.hanuman(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.black))),
                          ),
                          SizedBox(height: 10,),
                          SizedBox(
                            height: 65,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: homeController.colorList.length,
                                itemBuilder: (c,index){
                                 return Padding(
                                   padding:index == 0 ? const EdgeInsets.only(right: AppSizes.sidePadding,left: AppSizes.sidePadding):const EdgeInsets.only(right: AppSizes.sidePadding),
                                   child: Container(
                                      height: 65,width: 65,
                                      decoration: BoxDecoration(
                                        // color: AppColors.budgetBg,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(100)
                                        ),
                                        border: Border.all(
                                          width: 1,
                                          color: AppColors.black,
                                          // style: BorderStyle.solid,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(1.5),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: homeController.colorList[index],
                                            borderRadius: const BorderRadius.all(
                                                const Radius.circular(100)
                                            ),
                                            border: Border.all(
                                              width: 1,
                                              color: AppColors.black,
                                              // style: BorderStyle.solid,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                 );

                                }),
                          ),
                          const SizedBox(height: 24,),
                          Padding(
                            padding: const EdgeInsets.only(left: AppSizes.sidePadding),
                            child: Text("BEST SELLING PRODUCT", style: GoogleFonts.hanuman(textStyle: const TextStyle(fontSize: 14,color: AppColors.black))),
                          ),
                          const SizedBox(height: 10,),
                          // BlockHeader(
                          //   title: 'Best Seller Product',
                          //   // linkText: 'View all',
                          //   linkText: '',
                          //   onLinkTap: () {
                          //     // navigator!.pushNamed(Routes.categoryProduct,
                          //     //     arguments: CategoryArguments(
                          //     //         product: homeController.productList,
                          //     //         categoryName: 'Popular Product'));
                          //   },
                          // ),
                          // Obx(() {
                          //   final list = controller.productList.toList();
                          //   return Padding(
                          //     padding: const EdgeInsets.all(6.0),
                          //     child: PopulorProduct(
                          //       products: controller.isLoading.isTrue ? list : null,
                          //     ),
                          //   );
                          // }),
                          Obx(() {
                            if (homeController.isLoadingBestSellerProducts.value !=
                                true) {
                              MainResponse? mainResponse =
                                  homeController.bestSellerProductObj.value;
                              List<Products>? bestSellerProductsData = [];
                              // print(
                              //     "bestSellerProductObj.data! ${mainResponse.data!}");
                              if (mainResponse.data != null) {
                                mainResponse.data!.forEach((v) {
                                  bestSellerProductsData.add(Products.fromJson(v));
                                });
                              }
                              // mainResponse.data!.map((e) => customerProfileData!.add(UpdateCustomerPasswordData.fromJson(e))).toList();

                              String? imageUrl = mainResponse.imageUrl ?? "";
                              String? message =
                                  mainResponse.message ?? AppConstants.noInternetConn;
                              if (bestSellerProductsData.isEmpty) {
                                return SizedBox(
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
                                            style: const TextStyle(
                                                color: Colors.black45),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              } else {

                                return  SizedBox(
                                  height: 225,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: bestSellerProductsData.length,
                                      itemBuilder: (c,index){

                                          return  Padding(
                                            padding: index == 0 ? const EdgeInsets.only(right: 15.0,left: 15.0):const EdgeInsets.only(right: 15.0),
                                            child: Container(
                                              height: 225,
                                              width: 175,

                                              decoration: BoxDecoration(
                                                color: AppColors.white,
                                                borderRadius: const BorderRadius.all(
                                                    const Radius.circular(10)
                                                ),
                                                border: Border.all(
                                                  width: 1,
                                                  color: AppColors.bestSellingBorder,
                                                  // style: BorderStyle.solid,
                                                ),
                                              ),
                                              child: ClipRRect(
                                                  borderRadius: const BorderRadius.all(
                                                      const Radius.circular(10)
                                                  ),

                                                  // borderRadius:
                                                  // BorderRadius.circular(15),
                                                  child: Column(
                                                    children: [
                                                      Image.network(imageUrl + bestSellerProductsData[index].productId! + "/" + bestSellerProductsData[index].coverImage!,fit: BoxFit.fill,width: double.infinity,height: 110,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 5.0,right: 5.0,bottom: 0.0,top: 5.0),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  child: Text(bestSellerProductsData[index].productName!,
                                                                      maxLines: 1,
                                                                      //  style: GoogleFonts.ptSans(),
                                                                      overflow: TextOverflow.ellipsis,style: GoogleFonts.hanuman(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.black))),
                                                                ),
                                                                Image.asset("assets/img/heart.png",fit: BoxFit.fill,height: 16,width: 16,)

                                                              ],
                                                            ),
                                                            Text(bestSellerProductsData[index].shortDescription!,maxLines: 2,
                                                                //  style: GoogleFonts.ptSans(),
                                                                overflow: TextOverflow.ellipsis, style: GoogleFonts.hanuman(textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.appText1))),
                                                            RatingBar(
                                                            initialRating: 3.5,
                                                            // minRating: 1,
                                                            ignoreGestures:true,
                                                            direction: Axis.horizontal,
                                                            allowHalfRating: true,
                                                            itemCount: 5,
                                                            itemSize: 20,
                                                            // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                                            ratingWidget: RatingWidget(
                                                              full:
                                                                  const Icon(
                                                                Icons.star,
                                                                color: AppColors.startBat,
                                                                size: 10,
                                                              ),
                                                              half:
                                                              const Icon(
                                                                Icons.star_half,
                                                                color: AppColors.startBat,
                                                                size: 10,
                                                              ),
                                                              empty:
                                                              const Icon(
                                                                Icons.star_border_rounded,
                                                                color: AppColors.startBat,
                                                                size: 10,
                                                              ),
                                                            ),
                                                            // itemBuilder: (context, _) =>
                                                            //     Icon(
                                                            //   Icons.star_border_rounded,
                                                            //   color: AppColors.appRed,
                                                            //   size: 10,
                                                            // ),
                                                            onRatingUpdate: (rating) {
                                                              print(rating);
                                                            },
                                                          ),
                                                            Row(children: [
                                                              Text("\u{20B9}${double.parse(bestSellerProductsData[index].netPrice!).toStringAsFixed(0)} ", style: GoogleFonts.hanuman(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.black))),
                                                              Text("\u{20B9}${double.parse(bestSellerProductsData[index].mrpPrice!).toStringAsFixed(0)} ", style: GoogleFonts.hanuman(textStyle: TextStyle(fontSize: 11,
                                                                  decoration: TextDecoration.combine(
                                                                      [ TextDecoration.lineThrough]),fontWeight: FontWeight.w400,color: AppColors.appText1))),
                                                              Text("(${bestSellerProductsData[index].discount!}% OFF)", style: GoogleFonts.hanuman(textStyle: const TextStyle(fontSize: 10,fontWeight: FontWeight.w400,color: AppColors.off)))
                                                            ],)
                                                          ],
                                                        ),
                                                      ),

                                                    ],
                                                  )),
                                            ),
                                          );


                                      }),
                                );
                                // return Padding(
                                //   padding: const EdgeInsets.only(
                                //       left: 5.0, bottom: 3, right: 5.0),
                                //   child: PopulorProduct(
                                //     products: bestSellerProductsData,
                                //     imageUrl: imageUrl,
                                //   ),
                                // );
                              }
                            } else {
                              return Container(
                                height: 200,
                                // child: Center(child: CircularProgressIndicator(color: Style.Colors.appColor))
                              );
                            }
                          }),
                          SizedBox(height: 24,),
                          Padding(
                            padding: const EdgeInsets.only(left:AppSizes.sidePadding),
                            child: Text("INFLUNCERS MODE", style: GoogleFonts.hanuman(textStyle: const TextStyle(fontSize: 14,color: AppColors.black))),
                          ),
                          SizedBox(height: 10,),

                          SizedBox(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: homeController.modeList.length,
                                itemBuilder: (c,index){

                                  return  Padding(
                                    padding: index == 0 ? const EdgeInsets.only(right: AppSizes.sidePadding,left: AppSizes.sidePadding):const EdgeInsets.only(right: AppSizes.sidePadding),
                                    child: Stack(
                                      children: [
                                        SizedBox(
                                          height: 200,
                                          width: 160,
                                          child: ClipRRect(
                                              borderRadius: const BorderRadius.all(
                                                  const Radius.circular(5)
                                              ),
                                              // borderRadius:
                                              // BorderRadius.circular(15),
                                              child: Image.asset(homeController.modeList[index].categoryImage!,fit: BoxFit.fill,height: 200,width: double.infinity,)),
                                        ),
                                        Container(
                                            decoration:  BoxDecoration(
                                              borderRadius:  BorderRadius.all(
                                                  Radius.circular(5)
                                              ),

                                              // gradient: LinearGradient(
                                              //   begin: Alignment.topCenter,
                                              //   end: Alignment.bottomCenter,
                                              //   stops: const [0.0, 2.0],
                                              //   colors: [
                                              //     AppColors.black.withOpacity(0.0),
                                              //     AppColors.black.withOpacity(0.6),
                                              //     // Colors.white.withOpacity(0.0),
                                              //     // const Color(0xFF030305).withOpacity(0.1),
                                              //   ],),
                                              // decoration: BoxDecoration(
                                              //   gradient: LinearGradient(
                                              //     colors: [
                                              //       const Color(0xFFD1A7A8),
                                              //       const Color(0xFFE7E7E7),
                                              //     ],
                                              //
                                              //     begin: Alignment.topCenter,
                                              //     end: Alignment.bottomCenter,),
                                              // ),

                                            ),

                                            width: 160,
                                            height: 200,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(homeController.modeList[index].categoryName!.toUpperCase(), style: GoogleFonts.hanuman(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: AppColors.white))),
                                                  // const SizedBox(height: 5,),

                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("SHOP HER STYLE", style: GoogleFonts.hanuman(textStyle: const TextStyle(fontSize: 10,color: AppColors.white))),
                                                      const SizedBox(width: 4,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 2.0),
                                                        child: Container(
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(1.5),
                                                            child: Image.asset("assets/img/arrow_right.png",color: AppColors.black,),
                                                          ),
                                                          height: 10,
                                                          width: 9.96,
                                                          decoration: const BoxDecoration(
                                                              color: AppColors.white,
                                                              shape: BoxShape.circle
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),

                                                ],
                                              ),
                                            )),
                                      ],
                                    ),
                                  );


                                }),
                          ),


                          // BlockHeader(
                          //   title: 'Brand',
                          //   // linkText: 'View all',
                          //   linkText: '',
                          //   onLinkTap: () {
                          //     // navigator!.pushNamed(Routes.categoryProduct,
                          //     //     arguments: CategoryArguments(
                          //     //         product: homeController.productList,
                          //     //         categoryName: 'Popular Product'));
                          //   },
                          // ),
                          // Obx(() {
                          //   final list = controller.productList.toList();
                          //   return Padding(
                          //     padding: const EdgeInsets.all(6.0),
                          //     child: PopulorProduct(
                          //       products: controller.isLoading.isTrue ? list : null,
                          //     ),
                          //   );
                          // }),
                          // Obx(() {
                          //   if (homeController.isLoadingGetBrand.value != true) {
                          //     MainResponse? mainResponse =
                          //         homeController.getBrandObj.value;
                          //     List<Brand>? getBrandData = [];
                          //     if (mainResponse.data != null) {
                          //       mainResponse.data!.forEach((v) {
                          //         getBrandData.add(Brand.fromJson(v));
                          //       });
                          //     }
                          //     // mainResponse.data!.map((e) => customerProfileData!.add(UpdateCustomerPasswordData.fromJson(e))).toList();
                          //
                          //     String? imageUrl = mainResponse.imageUrl ?? "";
                          //     String? message =
                          //         mainResponse.message ?? AppConstants.noInternetConn;
                          //     if (getBrandData.isEmpty) {
                          //       return SizedBox(
                          //         height: 90.0,
                          //         width: MediaQuery.of(context).size.width,
                          //         child: Column(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           crossAxisAlignment: CrossAxisAlignment.center,
                          //           children: <Widget>[
                          //             Column(
                          //               children: <Widget>[
                          //                 Text(
                          //                   message!,
                          //                   style: const TextStyle(
                          //                       color: Colors.black45),
                          //                 )
                          //               ],
                          //             )
                          //           ],
                          //         ),
                          //       );
                          //     } else {
                          //       return Padding(
                          //         padding: const EdgeInsets.only(
                          //             left: 4.0, top: 5, right: 4.0),
                          //         child: BrandWidget(
                          //           brands: getBrandData,
                          //           imageUrl: imageUrl,
                          //         ),
                          //       );
                          //     }
                          //   } else {
                          //     return Container(
                          //       height: 90,
                          //       // child: Center(child: CircularProgressIndicator(color: Style.Colors.appColor))
                          //     );
                          //   }
                          // }),
                          // BlockHeader(
                          //   title: 'All Product',
                          //   // linkText: 'View all',
                          //   linkText: '',
                          //   onLinkTap: () {
                          //     // navigator!.pushNamed(Routes.categoryProduct,
                          //     //     arguments: CategoryArguments(
                          //     //         product: homeController.productList,
                          //     //         categoryName: 'Popular Product'));
                          //   },
                          // ),
                          // Obx(() {
                          //   final list = controller.productList.toList();
                          //   return Padding(
                          //     padding: const EdgeInsets.all(6.0),
                          //     child: PopulorProduct(
                          //       products: controller.isLoading.isTrue ? list : null,
                          //     ),
                          //   );
                          // }),
                          // Obx(() {
                          //   if (homeController.isLoadingAllProducts.value != true) {
                          //     MainResponse? mainResponse =
                          //         homeController.allProductsObj.value;
                          //     List<Products>? allProductsData = [];
                          //
                          //     if (mainResponse.data != null) {
                          //       mainResponse.data!.forEach((v) {
                          //         allProductsData.add(Products.fromJson(v));
                          //       });
                          //     }
                          //     // mainResponse.data!.map((e) => customerProfileData!.add(UpdateCustomerPasswordData.fromJson(e))).toList();
                          //
                          //     String? imageUrl = mainResponse.imageUrl ?? "";
                          //     String? message =
                          //         mainResponse.message ?? AppConstants.noInternetConn;
                          //     if (allProductsData.isEmpty) {
                          //       return SizedBox(
                          //         height: 200.0,
                          //         width: MediaQuery.of(context).size.width,
                          //         child: Column(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           crossAxisAlignment: CrossAxisAlignment.center,
                          //           children: <Widget>[
                          //             Column(
                          //               children: <Widget>[
                          //                 Text(
                          //                   message!,
                          //                   style: const TextStyle(
                          //                       color: Colors.black45),
                          //                 )
                          //               ],
                          //             )
                          //           ],
                          //         ),
                          //       );
                          //     } else {
                          //       return Padding(
                          //         padding:
                          //             const EdgeInsets.only(left: 5.0, right: 5.0),
                          //         child: AllProduct(
                          //           products: allProductsData,
                          //           imageUrl: imageUrl,
                          //         ),
                          //       );
                          //     }
                          //   } else {
                          //     return const SizedBox(
                          //       height: 200,
                          //       // child: Center(child: CircularProgressIndicator(color: Style.Colors.appColor))
                          //     );
                          //   }
                          // }),



                          // BlockHeader(
                          //   title: 'New Product',
                          //   // linkText: 'View all'
                          //   linkText: '',
                          //   onLinkTap: () {
                          //     print(homeController.productList);
                          //     print('ohmygod');
                          //     // navigator!.pushNamed(Routes.categoryProduct,
                          //     //     arguments: CategoryArguments(
                          //     //         product: homeController.productList,
                          //     //         categoryName: 'New Products'));
                          //   },
                          // ),
                          // Obx(() {
                          //   final list = homeController.productList.toList();
                          //   return ProductGridviewTile(
                          //     productList: homeController.isLoading.value ? list : null,
                          //   );
                          // }),

                          // Obx(() {
                          //   if (homeController.isLoadingNewProducts.value != true) {
                          //     MainResponse? mainResponse =
                          //         homeController.newProductsObj.value;
                          //     List<Products>? newProductsData = [];
                          //     print("mainResponse.data! ${mainResponse.data!}");
                          //     if (mainResponse.data != null) {
                          //       mainResponse.data!.forEach((v) {
                          //         newProductsData.add(Products.fromJson(v));
                          //       });
                          //     }
                          //     // mainResponse.data!.map((e) => customerProfileData!.add(UpdateCustomerPasswordData.fromJson(e))).toList();
                          //
                          //     String? imageUrl = mainResponse.imageUrl ?? "";
                          //     String? message =
                          //         mainResponse.message ?? AppConstants.noInternetConn;
                          //     if (newProductsData.isEmpty) {
                          //       return SizedBox(
                          //         height: 200.0,
                          //         width: MediaQuery.of(context).size.width,
                          //         child: Column(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           crossAxisAlignment: CrossAxisAlignment.center,
                          //           children: <Widget>[
                          //             Column(
                          //               children: <Widget>[
                          //                 Text(
                          //                   message!,
                          //                   style: const TextStyle(
                          //                       color: Colors.black45),
                          //                 )
                          //               ],
                          //             )
                          //           ],
                          //         ),
                          //       );
                          //     } else {
                          //       return Padding(
                          //         padding: const EdgeInsets.only(
                          //             left: 5.0, right: 5.0, bottom: 5.0),
                          //         child: ProductGridviewTile(
                          //           products: newProductsData,
                          //           imageUrl: imageUrl,
                          //         ),
                          //       );
                          //     }
                          //   } else {
                          //     return Container(
                          //       height: 200,
                          //       // child: Center(child: CircularProgressIndicator(color: Style.Colors.appColor))
                          //     );
                          //   }
                          // }),
                          const SizedBox(height: 24,),
                          Container(
                            color: AppColors.finestFestiveFashion,
                            child: Column(
                              children: [
                                const SizedBox(height: AppSizes.sidePadding,),
                                Text("FINEST FESTIVE FASHION", style: GoogleFonts.salsa(textStyle: const TextStyle(fontSize: 14,color: AppColors.appText))),
                                const SizedBox(height: AppSizes.sidePadding,),
                                // Row(
                                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                //     children: homeController.finestList1.map((e)  {
                                //   var index = homeController.finestList1.indexOf(e);
                                //   return Container(
                                //     width: 120,
                                //     height: 170,
                                //     decoration: const BoxDecoration(
                                //       color: AppColors.white,
                                //       borderRadius: const BorderRadius.only(
                                //         topRight: const Radius.circular(100),
                                //         topLeft: Radius.circular(100),
                                //         bottomLeft: Radius.circular(10),
                                //         bottomRight: Radius.circular(10),
                                //       ),
                                //     ),
                                //     child: Padding(
                                //       padding: const EdgeInsets.all(3.0),
                                //       child: Column(
                                //         children: [
                                //           SizedBox(
                                //             height: 110,
                                //             width: 110,
                                //             child: ClipRRect(
                                //                 borderRadius: const BorderRadius.only(
                                //                   topRight: const Radius.circular(100),
                                //                   topLeft: const Radius.circular(100),
                                //                   bottomLeft: const Radius.circular(10),
                                //                   bottomRight: Radius.circular(10),
                                //                 ),
                                //                 // borderRadius:
                                //                 // BorderRadius.circular(15),
                                //                 child: Image.asset(e.categoryImage!,fit: BoxFit.fill,width: double.infinity)),
                                //           ),
                                //           const SizedBox(height: 6,),
                                //           Text(e.categoryName!, style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.appText))),
                                //           const SizedBox(height: 8,),
                                //           Container(
                                //             height: 1.5,
                                //             color: AppColors.finestFestiveFashion,
                                //             width: 60,
                                //           ),
                                //           const SizedBox(height: 5,),
                                //           Text("UP TO 40% OFF", style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.appText)))
                                //         ],
                                //       ),
                                //     ),
                                //   );
                                // }).toList()),


                                Container(
                                  padding: const EdgeInsets.only(left: 8,right: 8,bottom: 16),
                                  // height: 400,
                                  child: GridView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: 6,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      // crossAxisCount: 2,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8,
                                        childAspectRatio: 0.7,
                                        crossAxisCount: (orientation == Orientation.portrait) ? 3 : 3),
                                    itemBuilder: (BuildContext context, int index) {
                                      return Container(
                                        // width: 200,
                                        decoration: const BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius: const BorderRadius.only(
                                            topRight: const Radius.circular(100),
                                            topLeft: Radius.circular(100),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 110,
                                                width: 200,
                                                child: ClipRRect(
                                                    borderRadius: const BorderRadius.only(
                                                      topRight: const Radius.circular(100),
                                                      topLeft: const Radius.circular(100),
                                                      bottomLeft: const Radius.circular(10),
                                                      bottomRight: Radius.circular(10),
                                                    ),
                                                    // borderRadius:
                                                    // BorderRadius.circular(15),
                                                    child: Image.asset(homeController.finestList[index].categoryImage!,fit: BoxFit.fill,width: double.infinity)),
                                              ),
                                              const SizedBox(height: 8,),
                                              Text(homeController.finestList[index].categoryName!, style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.appText))),
                                              const SizedBox(height: 8,),
                                              Container(
                                                height: 1.5,
                                                color: AppColors.finestFestiveFashion,
                                                width: 60,
                                              ),
                                              const SizedBox(height: 5,),
                                              Text("UP TO 40% OFF", style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.appText)))
                                            ],
                                          ),
                                        ),
                                      );
                                      return new Card(
                                        child: new GridTile(
                                          // footer: new Text(homeController.imageList[index]['name']),
                                          child: new Text(homeController.imageList[index]), //just for testing, will fill with image later
                                        ),
                                      );
                                    },
                                  ),
                                ),

                              ],
                            ),
                          ),
                          const SizedBox(height: 24,),

                          Padding(
                            padding: const EdgeInsets.only(left: AppSizes.sidePadding),
                            child: Text("DISCOVER TOP BRANDS", style: GoogleFonts.hanuman(textStyle: const TextStyle(fontSize: 14,color: AppColors.black))),
                          ),
                          SizedBox(height: 10,),

                          SizedBox(
                            height: 205,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: homeController.discoverList.length,
                                itemBuilder: (c,index){

                                  return  Padding(
                                    padding: index == 0 ? const EdgeInsets.only(right: 15.0,left: 15.0):const EdgeInsets.only(right: 15.0),
                                    child: Column(
                                      children: [
                                        Stack(

                                          children: [
                                            Container(
                                              height: 150,
                                              width: 150,
                                              decoration: BoxDecoration(
                                                color: homeController.discoverList[index].color!,
                                                borderRadius: const BorderRadius.only(
                                                  topRight: const Radius.circular(50),

                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 150,
                                              width: 150,
                                              child: ClipRRect(
                                                  borderRadius: const BorderRadius.only(
                                                    topRight: const Radius.circular(50),

                                                  ),
                                                  // borderRadius:
                                                  // BorderRadius.circular(15),
                                                  child: Image.asset(homeController.discoverList[index].categoryImage!,fit: homeController.discoverList[index].fit!,width: double.infinity)),
                                            ),
                                          ],
                                        ),

                                        Container(
                                          height: 35,
                                          width: 50,
                                          child: Image.asset(homeController.discoverList[index].description!),
                                        ),

                                        Text(homeController.discoverList[index].categoryName!, style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.black))),
                                      ],
                                    ),
                                  );


                                }),
                          ),
                          const SizedBox(height: 23,),
                          Padding(
                            padding: const EdgeInsets.only(left: AppSizes.sidePadding),
                            child: Text("NEW LAUNCH", style: GoogleFonts.hanuman(textStyle: const TextStyle(fontSize: 14,color: AppColors.black))),
                          ),
                          SizedBox(height: 10,),

                          SizedBox(
                            height: 190,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: homeController.launchList.length,
                                itemBuilder: (c,index){

                                  // return  Padding(
                                  //   padding: index == 0 ? const EdgeInsets.only(right: 15.0,left: 15.0):const EdgeInsets.only(right: 15.0),
                                  //   child: Stack(
                                  //     children: [
                                  //       SizedBox(
                                  //         height: 190,
                                  //         width: 155,
                                  //         child: ClipRRect(
                                  //             borderRadius: const BorderRadius.all(
                                  //                 const Radius.circular(5)
                                  //             ),
                                  //             // borderRadius:
                                  //             // BorderRadius.circular(15),
                                  //             child: Image.asset(homeController.launchList[index].categoryImage!,fit: BoxFit.fill,width: double.infinity)),
                                  //       ),
                                  //       Container(
                                  //           decoration: const BoxDecoration(
                                  //               borderRadius: const BorderRadius.all(
                                  //                   Radius.circular(10)
                                  //               ),
                                  //
                                  //           ),
                                  //           width: 155,
                                  //           height: 190,
                                  //           child: Padding(
                                  //             padding: const EdgeInsets.all(8.0),
                                  //             child: Column(
                                  //               mainAxisAlignment: MainAxisAlignment.end,
                                  //               crossAxisAlignment: CrossAxisAlignment.start,
                                  //               children: [
                                  //                 Text(homeController.launchList[index].categoryName!, style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.w900,color: AppColors.white))),
                                  //                 Row(
                                  //                   children: [
                                  //                     Text("SHOP NOW", style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.w700,color: AppColors.white))),
                                  //                     const SizedBox(width: 5,),
                                  //                     Container(
                                  //                       child: Padding(
                                  //                         padding: const EdgeInsets.all(1.5),
                                  //                         child: Image.asset("assets/img/arrow_right.png",color: AppColors.black,),
                                  //                       ),
                                  //                       height: 15,
                                  //                       width: 15,
                                  //                       decoration: const BoxDecoration(
                                  //                           color: AppColors.white,
                                  //                         shape: BoxShape.circle
                                  //                       ),
                                  //                     )
                                  //                   ],
                                  //                 ),
                                  //
                                  //               ],
                                  //             ),
                                  //           )),
                                  //     ],
                                  //   ),
                                  // );


                                  return  Padding(
                                    padding: index == 0 ? const EdgeInsets.only(right: AppSizes.sidePadding,left: AppSizes.sidePadding):const EdgeInsets.only(right: AppSizes.sidePadding),
                                    child: Stack(
                                      children: [
                                        SizedBox(
                                          height: 200,
                                          width: 160,
                                          child: ClipRRect(
                                              borderRadius: const BorderRadius.all(
                                                  const Radius.circular(5)
                                              ),
                                              // borderRadius:
                                              // BorderRadius.circular(15),
                                              child: Image.asset(homeController.launchList[index].categoryImage!,fit: BoxFit.fill,height: 200,width: double.infinity,)),
                                        ),
                                        Container(
                                            decoration:  BoxDecoration(
                                              borderRadius:  BorderRadius.all(
                                                  Radius.circular(5)
                                              ),

                                              // gradient: LinearGradient(
                                              //   begin: Alignment.topCenter,
                                              //   end: Alignment.bottomCenter,
                                              //   stops: const [0.0, 2.0],
                                              //   colors: [
                                              //     AppColors.black.withOpacity(0.0),
                                              //     AppColors.black.withOpacity(0.6),
                                              //     // Colors.white.withOpacity(0.0),
                                              //     // const Color(0xFF030305).withOpacity(0.1),
                                              //   ],),
                                              // decoration: BoxDecoration(
                                              //   gradient: LinearGradient(
                                              //     colors: [
                                              //       const Color(0xFFD1A7A8),
                                              //       const Color(0xFFE7E7E7),
                                              //     ],
                                              //
                                              //     begin: Alignment.topCenter,
                                              //     end: Alignment.bottomCenter,),
                                              // ),

                                            ),

                                            width: 160,
                                            height: 200,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(homeController.launchList[index].categoryName!.toUpperCase(), style: GoogleFonts.hanuman(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: AppColors.white))),
                                                  // const SizedBox(height: 5,),

                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("SHOP NOW", style: GoogleFonts.hanuman(textStyle: const TextStyle(fontSize: 10,color: AppColors.white))),
                                                      const SizedBox(width: 4,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 2.0),
                                                        child: Container(
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(1.5),
                                                            child: Image.asset("assets/img/arrow_right.png",color: AppColors.black,),
                                                          ),
                                                          height: 10,
                                                          width: 9.96,
                                                          decoration: const BoxDecoration(
                                                              color: AppColors.white,
                                                              shape: BoxShape.circle
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),

                                                ],
                                              ),
                                            )),
                                      ],
                                    ),
                                  );


                                }),
                          ),
                        ],
                      ),
                    );
                  } else {
                    if (homeController.isRefresh.value != true) {
                      return SizedBox(
                          height: MediaQuery.of(context).size.height - 120,
                          child: const Center(
                              child: const CircularProgressIndicator(
                                  color: Style.Colors.appColor)));
                    } else {
                      return Container(
                        height: 200,
                      );
                    }
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
