import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:range_slider_flutter/range_slider_flutter.dart';

import '../../config/theme.dart';
import '../../constants/app_costants.dart';
import '../../models/main_response.dart';
import '../../models/product_filter_oprion_model.dart';
import '../landing_home/home_controller.dart';
import 'common_product_list_controller.dart';

class FilterScreen extends StatefulWidget {
  final String id;
  final String apiType;
  final String chooseType;
  final String tag;
  const FilterScreen({Key? key, required this.id, required this.apiType, required this.chooseType,required this.tag}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {

  bool? isFlag = true;
  final homeController = Get.put(HomeController(
      apiRepositoryInterface: Get.find(), localRepositoryInterface: Get.find()));

  CommonProductListController? commonProductListController;
  // List<String> filterList = [
  //   "Age",
  //   "Size",
  //   "Color",
  //   "Categories",
  //   "Price Range",
  //   "Age",
  //   "Size",
  //   "Color",
  //   "Categories",
  //   "Price Range",
  //   "Age",
  //   "Size",
  //   "Color",
  //   "Categories",
  //   "Price Range"
  // ];
  // List<String> filterList2 = [
  //   "0-3 months",
  //   "3-6 months",
  //   "6-9 months",
  //   "9-12 months",
  //   "12-24 months",
  //   "0-3 months",
  //   "3-6 months",
  //   "6-9 months",
  //   "9-12 months",
  //   "12-24 months",
  //   "0-3 months",
  //   "3-6 months",
  //   "6-9 months",
  //   "9-12 months",
  //   "12-24 months"
  // ];


  PageController pageController = PageController();
  int selectedIndex = 0;
   RxBool? idLoaded = false.obs;





  @override
  void initState() {

    print("widget.categoryId ==================================> ${widget.id}");
    commonProductListController = Get.put(CommonProductListController(
        apiRepositoryInterface: Get.find(),
        localRepositoryInterface: Get.find()));

    if(widget.apiType == "ProductByAttributeAndCategory"){
      commonProductListController!.getProductFilterOption("","",widget.chooseType);
    }else if(widget.apiType == "brandProduct"){
      if(widget.chooseType == "All Brands"){
        commonProductListController!.getProductFilterOption("",widget.id,"");
      }else{
        commonProductListController!.getProductFilterOption("",widget.id,widget.chooseType);
      }

    } else if(widget.apiType == "categoryProduct"){
      commonProductListController!.getProductFilterOption(widget.id,"",widget.chooseType);
    } else if(widget.apiType == "getCategoryProductWithOffers"){
      commonProductListController!.getProductFilterOption(widget.id,"",widget.chooseType);
    }else if(widget.apiType == "searchBykeywords"){
      commonProductListController!.getProductFilterOption("","",widget.chooseType);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {


  return  Obx(() {
      if (commonProductListController!.isLoadingGetProductFilterOption.value == true) {
        MainResponse? mainResponse = commonProductListController!.getProductFilterOptionObj.value;

        // getFilterData!.clear();
        List<ProductFilterOption> getFilterData = [];
        if(mainResponse.data != null){

          mainResponse.data!.forEach((v) {
            getFilterData.add(ProductFilterOption.fromJson(v));
            if(commonProductListController!.filterValue.value == ""){
              commonProductListController!.getFilterLoaded!.add(ProductFilterOption.fromJson(v));
            }

            // cardController.getCartDataBottomView!.add(Carts.fromJson(v));
          });

          getFilterData.add(ProductFilterOption(element: "Price",value: []));
          if(commonProductListController!.filterValue.value == ""){
            commonProductListController!.getFilterLoaded!.add(ProductFilterOption(element: "Price",value: []));
          }


          // if(commonProductListController!.filterValue.value == ""){
            if(widget.apiType == "ProductByAttributeAndCategory"){

              commonProductListController!.getFilterLoaded!.forEach((getFilterObj) {

                if(getFilterObj.element == "Color"){
                  getFilterObj.value!.forEach((colorObj) {

                    print("color id ======> ${widget.id}");
                    print("colorObj.elementValue!.attrId ======> ${colorObj.elementValue!.attrId}");
                    if(colorObj.elementValue!.attrId == widget.id){
                      colorObj.isChecked = true;
                    }
                  });
                }

              });

            }else if(widget.apiType == "brandProduct"){
              commonProductListController!.getFilterLoaded!.forEach((getFilterObj) {

                if(getFilterObj.element == "Brand"){
                  getFilterObj.value!.forEach((brandObj) {

                    print("Brand id ======> ${widget.id}");
                    print("brandObj.elementValue!.attrId ======> ${brandObj.elementValue!.attrId}");
                    if(brandObj.elementValue!.attrId == widget.id){
                      brandObj.isChecked = true;
                    }
                  });
                }

              });
            } else if(widget.apiType == "categoryProduct"){
            } else if(widget.apiType == "getCategoryProductWithOffers"){
            }else if(widget.apiType == "searchBykeywords"){
            }
          // }



          if(mainResponse.priceRange != null){

            // mainResponse.priceRange!.forEach((v) {
              if(commonProductListController!.filterValue.value == ""){

                if(isFlag!){
                  print("mainResponse.priceRange![0] ===============> ${mainResponse.priceRange![0]}");
                  print("mainResponse.priceRange![0] ===============> ${mainResponse.priceRange![1]}");
                  commonProductListController!.minValue = double.parse(mainResponse.priceRange![0]);
                  commonProductListController!.maxValue = double.parse(mainResponse.priceRange![1]);
                  commonProductListController!.lowerValue = double.parse(mainResponse.priceRange![0]);
                  commonProductListController!.upperValue = double.parse(mainResponse.priceRange![1]);
                  isFlag = false;
                }


              }

              // cardController.getCartDataBottomView!.add(Carts.fromJson(v));
            // });
          }






        }

        // getFilterLoaded!.clear();
        // for (var i = 0; i < getFilterData.length; i++){
        //   getFilterLoaded!.add(getFilterData[i]);
        // }

        String? imageUrl = mainResponse.imageUrl ?? "";
        String? message = mainResponse.message ?? "";



        if (getFilterData.isEmpty) {
          return Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(
                          16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Filters",
                              style: GoogleFonts.inriaSans(
                                  textStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.appText))),
                          Text("Clear all",
                              style: GoogleFonts.inriaSans(
                                  textStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.appRed)))
                        ],
                      ),
                    ),
                    Container(
                      height: 0.5,
                      width: MediaQuery.of(context).size.width,
                      color: AppColors.tileLine,
                    ),
                    Expanded(
                      child: SizedBox(
                        // width: MediaQuery.of(context).size.width,
                        // height: 200,
                        child: Center(
                          child: Text(
                            message,
                            style: const TextStyle(color: Colors.black45),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border(
                    top: BorderSide(
                      width: 0.5,
                      color: AppColors.tileLine,
                    ),

                    // style: BorderStyle.solid,
                  ),
                ),
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Center(
                            child: Text("CLOSE",
                                style: GoogleFonts.inriaSans(
                                    textStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.closeButtonText))),
                          ),
                        ),
                      ),
                      Container(
                        height: 55,
                        width: 1,
                        color: AppColors.filterBottomBorder,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Center(
                            child: Text("APPLY",
                                style: GoogleFonts.inriaSans(
                                    textStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.appRed))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));


        }else{
          // cardController.selectAllCartInit(getCartData);
          return Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(
                          16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Filters",
                              style: GoogleFonts.inriaSans(
                                  textStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.appText))),
                          InkWell(
                            onTap: (){
                              commonProductListController!.getFilterLoaded!.clear();
                              commonProductListController!.finalData.clear();
                              commonProductListController!.filterValue("");

                              if(widget.apiType == "ProductByAttributeAndCategory"){
                                commonProductListController!.getProductFilterOption("","",widget.chooseType);
                              }else if(widget.apiType == "brandProduct"){
                                if(widget.chooseType == "All Brands"){
                                  commonProductListController!.getProductFilterOption("",widget.id,"");
                                }else{
                                  commonProductListController!.getProductFilterOption("",widget.id,widget.chooseType);
                                }
                              } else if(widget.apiType == "categoryProduct"){
                                commonProductListController!.getProductFilterOption(widget.id,"",widget.chooseType);
                              } else if(widget.apiType == "getCategoryProductWithOffers"){
                                commonProductListController!.getProductFilterOption(widget.id,"",widget.chooseType);
                              }else if(widget.apiType == "searchBykeywords"){
                                commonProductListController!.getProductFilterOption("","",widget.chooseType);
                              }

                              setState(() {
                                selectedIndex = 0;
                              });
                            },
                            child: Text("Clear all",
                                style: GoogleFonts.inriaSans(
                                    textStyle: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.appRed))),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 0.5,
                      width: MediaQuery.of(context).size.width,
                      color: AppColors.tileLine,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 130,
                            // height: MediaQuery.of(context).size.height - 138,
                            child: ListView.separated(
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedIndex = index;
                                        pageController.jumpToPage(index);
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              right: BorderSide(
                                                  color: (selectedIndex == index)
                                                      ? AppColors.white
                                                      : AppColors.brandTopTitle,
                                                  width: 1))),
                                      child: Row(
                                        children: [
                                          // AnimatedContainer(
                                          //   duration: const Duration(milliseconds: 500),
                                          //   height: (selectedIndex == index) ? 100 : 0,
                                          //   width: 5,
                                          //   color: const Color(0xFFFC7663),
                                          // ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: (selectedIndex == index)
                                                    ? const Color(0xFFFC7663)
                                                    : AppColors.filterBg,
                                                borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(5),
                                                    bottomRight: Radius.circular(5))),
                                            width: 5,
                                            height: 50,

                                            // color: const Color(0xFFFC7663),
                                          ),
                                          Expanded(
                                              child: AnimatedContainer(
                                                duration:
                                                const Duration(milliseconds: 500),
                                                alignment: Alignment.center,
                                                height: 50,
                                                color: (selectedIndex == index)
                                                    ? AppColors.white
                                                    : AppColors.filterBg,
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      commonProductListController!.getFilterLoaded![index].element!,
                                                      style: (selectedIndex == index)
                                                          ? GoogleFonts.inriaSans(
                                                          textStyle: const TextStyle(
                                                              fontSize: 14,
                                                              color: AppColors.appRed,
                                                              fontWeight:
                                                              FontWeight.w700))
                                                          : GoogleFonts.inriaSans(
                                                          textStyle: const TextStyle(
                                                              fontSize: 14,
                                                              color: AppColors
                                                                  .closeButtonText,
                                                              fontWeight:
                                                              FontWeight.w300)),
                                                    ),
                                                  ],
                                                ), // Padding
                                              ))
                                          // Container // Expanded
                                        ],
                                      ),
                                    ),
                                  ); // Container
                                },
                                separatorBuilder: (BuildContext context, int index) {
                                  return Container(
                                    height: 1,
                                    color: AppColors.brandTopTitle,
                                  );
                                },
                                itemCount: getFilterData.length),
                          ),
                          // idLoaded!.value == false ?
                          Expanded(
                              child: Container(
                                color: AppColors.white,
                                // height: MediaQuery.of(context).size.height - 147,
                                child: PageView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  controller: pageController,
                                  children: [

                                    // _viewpagerList(getFilterData)
                                  for (var i = 0; i < getFilterData.length; i++)
                              // getFilterLoaded!.add(getFilterData[i]);
                                viewPager(i,commonProductListController!.getFilterLoaded![i])


                                    // Container(
                                    //   child: Text("Page $i"),
                                    // )
                                  ],
                                ),
                              ))
                              // :Container(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border(
                    top: BorderSide(
                      width: 0.5,
                      color: AppColors.tileLine,
                    ),

                    // style: BorderStyle.solid,
                  ),
                ),
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Center(
                            child: Text("CLOSE",
                                style: GoogleFonts.inriaSans(
                                    textStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.closeButtonText))),
                          ),
                        ),
                      ),
                      Container(
                        height: 55,
                        width: 1,
                        color: AppColors.filterBottomBorder,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {


                            // List<ElementValues>  finalData = [];




                            commonProductListController!.finalData = [];
                            for(int i=0;i<getFilterData.length;i++){

                              print("getFilterData==================> ${getFilterData[i].element!}");
                              for(int j=0;j<commonProductListController!.getFilterLoaded![i].value!.length;j++){
                                if(commonProductListController!.getFilterLoaded![i].value![j].isChecked!){
                                  Map<String, String> p = {
                                    '"element_id"': '"${commonProductListController!.getFilterLoaded![i].value![j].elementValue!.elementId!}"',
                                    '"attr_id"': '"${commonProductListController!.getFilterLoaded![i].value![j].elementValue!.attrId!}"'
                                  };
                                  commonProductListController!.finalData.add(p);

                                  // finalData.add(ElementValues(elementId: getFilterLoaded![i].value![j].elementValue!.elementId!,
                                  // attrId: getFilterLoaded![i].value![j].elementValue!.attrId!));
                                  // print("isChecked==================> ${commonProductListController!.getFilterLoaded![i].value![j].isChecked}");
                                  // print("elementName==================> ${commonProductListController!.getFilterLoaded![i].value![j].elementName}");
                                }

                              }

                            }

                            commonProductListController!.finalData.forEach((element) {
                              print("element ${element}");
                            });

                            if(commonProductListController!.finalData.isNotEmpty){
                              commonProductListController!.filterValue("Filter");
                            }else{
                              commonProductListController!.filterValue("");
                            }

                            if(double.parse(mainResponse.priceRange![0]) < commonProductListController!.lowerValue || double.parse(mainResponse.priceRange![1]) > commonProductListController!.upperValue){
                              commonProductListController!.filterValue("Filter");
                              print("commonProductListController!.lowerValue ============ > ${commonProductListController!.lowerValue}");
                              print("commonProductListController!.upperValue ============ > ${commonProductListController!.upperValue}");
                            }




                            if(widget.apiType == "ProductByAttributeAndCategory"){
                              commonProductListController!.productSortByWithFilter("",
                                  commonProductListController!.sortValue.value,
                                  commonProductListController!.finalData,
                                  homeController.customerId.value,
                                  commonProductListController!.genderValue.value,
                                  widget.chooseType,
                                  "",
                                  commonProductListController!.lowerValue.toStringAsFixed(0),
                                  commonProductListController!.upperValue.toStringAsFixed(0)
                              );
                            }else if(widget.apiType == "brandProduct"){

                              if(widget.chooseType == "All Brands"){
                                commonProductListController!.productSortByWithFilter("",
                                    commonProductListController!.sortValue.value,
                                    commonProductListController!.finalData,
                                    homeController.customerId.value,
                                    commonProductListController!.genderValue.value,
                                    "",
                                    "",
                                    commonProductListController!.lowerValue.toStringAsFixed(0),
                                    commonProductListController!.upperValue.toStringAsFixed(0)
                                );
                              }else{
                                commonProductListController!.productSortByWithFilter("",
                                    commonProductListController!.sortValue.value,
                                    commonProductListController!.finalData,
                                    homeController.customerId.value,
                                    commonProductListController!.genderValue.value,
                                    widget.chooseType,
                                    "",
                                    commonProductListController!.lowerValue.toStringAsFixed(0),
                                    commonProductListController!.upperValue.toStringAsFixed(0)
                                );
                              }

                            } else if(widget.apiType == "categoryProduct"){
                              commonProductListController!.productSortByWithFilter(widget.id,
                                  commonProductListController!.sortValue.value,
                                  commonProductListController!.finalData,
                                homeController.customerId.value,
                                  commonProductListController!.genderValue.value,
                                  widget.chooseType,
                                  "",
                                  commonProductListController!.lowerValue.toStringAsFixed(0),
                                  commonProductListController!.upperValue.toStringAsFixed(0)
                              );
                            } else if(widget.apiType == "getCategoryProductWithOffers"){
                              commonProductListController!.productSortByWithFilter(widget.id,
                                  commonProductListController!.sortValue.value,
                                  commonProductListController!.finalData,
                                  homeController.customerId.value,
                                  commonProductListController!.genderValue.value,
                                  widget.chooseType,
                                  "",
                                  commonProductListController!.lowerValue.toStringAsFixed(0),
                                  commonProductListController!.upperValue.toStringAsFixed(0)
                              );
                            }else if(widget.apiType == "searchBykeywords"){
                              commonProductListController!.productSortByWithFilter(widget.id,
                                  commonProductListController!.sortValue.value,
                                  commonProductListController!.finalData,
                                  homeController.customerId.value,
                                  commonProductListController!.genderValue.value,
                                  widget.chooseType,
                                  widget.tag,
                                  commonProductListController!.lowerValue.toStringAsFixed(0),
                                  commonProductListController!.upperValue.toStringAsFixed(0)
                              );
                            }

                            Get.back();
                            // getFilterData.forEach((filterObj) {
                            //   print("filterObj.element!==================> ${filterObj.element!}");
                            //   filterObj.value!.forEach((valueObj) {
                            //     print("valueObj.isChecked!==================> ${valueObj.isChecked!}");
                            //     print("valueObj.elementName!==================> ${valueObj.elementName!}");
                            //     // if(valueObj.isChecked!){
                            //     //   print("valueObj.isChecked!==================> ${valueObj.isChecked!}");
                            //     //   print("valueObj.elementName!==================> ${valueObj.elementName!}");
                            //     // }
                            //
                            //   });
                            //
                            // });
                          },
                          child: Center(
                            child: Text("APPLY",
                                style: GoogleFonts.inriaSans(
                                    textStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.appRed))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        }

      } else {
        // return Container();
        return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(
                        16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Filters",
                            style: GoogleFonts.inriaSans(
                                textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.appText))),
                        Text("Clear all",
                            style: GoogleFonts.inriaSans(
                                textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.appRed)))
                      ],
                    ),
                  ),
                  Container(
                    height: 0.5,
                    width: MediaQuery.of(context).size.width,
                    color: AppColors.tileLine,
                  ),
                  Expanded(
                    child: Container(
                        // height: 200,
                        child: const Center(child: CircularProgressIndicator(color: AppColors.appColor))),
                  )
                ],
              ),
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border(
                  top: BorderSide(
                    width: 0.5,
                    color: AppColors.tileLine,
                  ),

                  // style: BorderStyle.solid,
                ),
              ),
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Center(
                          child: Text("CLOSE",
                              style: GoogleFonts.inriaSans(
                                  textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.closeButtonText))),
                        ),
                      ),
                    ),
                    Container(
                      height: 55,
                      width: 1,
                      color: AppColors.filterBottomBorder,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Center(
                          child: Text("APPLY",
                              style: GoogleFonts.inriaSans(
                                  textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.appRed))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));

      }
    });

  }




  viewPager(int i, ProductFilterOption filterData) {

    if(filterData.value!.isNotEmpty){
      return ListView.builder(
          itemCount: filterData.value!.length,
          itemBuilder: (BuildContext c, int index) {
            return Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 15),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      {
                        setState(() {
                          print("filterData.value![index].isChecked 111111=====================> ${filterData.value![index].isChecked!.toString()}");
                          // idLoaded!(true);
                          filterData.value![index].isChecked = !filterData.value![index].isChecked!;

                          print("filterData.value![index].isChecked 222222=====================> ${filterData.value![index].isChecked!.toString()}");
                          // idLoaded!(false);
                        });

                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 5.0, right: 5.0, bottom: 16, top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              filterData.value![index].isChecked == true
                                  ? Image.asset(
                                "assets/img/Selected_Shape.png",
                                fit: BoxFit.fill,
                                height: 10,
                                width: 14,
                              )
                                  : Image.asset(
                                "assets/img/Shape.png",
                                fit: BoxFit.fill,
                                height: 10,
                                width: 14,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(' ${filterData.value![index].elementName}',
                                  style: GoogleFonts.inriaSans(
                                      textStyle:  TextStyle(
                                          fontSize: 14,
                                          fontWeight: filterData.value![index].isChecked == true ? FontWeight.bold:FontWeight.w300,
                                          color: AppColors.closeButtonText))),
                            ],
                          ),
                          Text('',
                              style: GoogleFonts.inriaSans(
                                  textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      color:
                                      AppColors.closeButtonText
                                  ))),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    color: AppColors.filterBottomBorder,
                  ),
                ],
              ),
            );
          });
    }else{
      // return Container(
      //   height: 50,width: 50,color: Colors.red,
      // );

    return  Column(
      children: [

        Padding(
          padding: const EdgeInsets.only(top: 50.0,right: 40,left: 10),
          child: RangeSliderFlutter(
              // key: Key('3343'),
              values:  [commonProductListController!.lowerValue, commonProductListController!.upperValue],
              rangeSlider: true,
              tooltip: RangeSliderFlutterTooltip(
                alwaysShowTooltip: true,
              ),
              max: commonProductListController!.maxValue,
              textPositionTop: -90,
              handlerHeight: 35,

              trackBar:RangeSliderFlutterTrackBar(
                activeTrackBarHeight: 8,
                inactiveTrackBarHeight: 8,
                activeTrackBar: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                ),
                inactiveTrackBar: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
              ),

              min: commonProductListController!.minValue,
              fontSize: 15,
              textBackgroundColor:Colors.red,

              onDragging: (handlerIndex, _lowerValue, _upperValue) {
                commonProductListController!.lowerValue = _lowerValue;
                commonProductListController!.upperValue = _upperValue;
                setState(() {});
              },
            ),
        ),
      ],
    );
    }


  }


}


