import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/theme.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<String> filterList = [
    "Age",
    "Size",
    "Color",
    "Categories",
    "Price Range",
    "Age",
    "Size",
    "Color",
    "Categories",
    "Price Range",
    "Age",
    "Size",
    "Color",
    "Categories",
    "Price Range"
  ];
  List<String> filterList2 = [
    "0-3 months",
    "3-6 months",
    "6-9 months",
    "9-12 months",
    "12-24 months",
    "0-3 months",
    "3-6 months",
    "6-9 months",
    "9-12 months",
    "12-24 months",
    "0-3 months",
    "3-6 months",
    "6-9 months",
    "9-12 months",
    "12-24 months"
  ];

  PageController pageController = PageController();
  int selectedIndex = 0;
  int? _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
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
                                            filterList[index],
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
                          itemCount: filterList.length),
                    ),
                    Expanded(
                        child: Container(
                      color: AppColors.white,
                      // height: MediaQuery.of(context).size.height - 147,
                      child: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: pageController,
                        children: [
                          for (var i = 0; i < filterList.length; i++)
                            viewPager(i),
                          // Container(
                          //   child: Text("Page $i"),
                          // )
                        ],
                      ),
                    )),
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
                InkWell(
                  onTap: () {},
                  child: Text("CLOSE",
                      style: GoogleFonts.inriaSans(
                          textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.closeButtonText))),
                ),
                Container(
                  height: 55,
                  width: 1,
                  color: AppColors.filterBottomBorder,
                ),
                InkWell(
                  onTap: () {},
                  child: Text("APPLY",
                      style: GoogleFonts.inriaSans(
                          textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.appRed))),
                ),
              ],
            ),
          ),
        ));
  }

  viewPager(int i) {
    return ListView.builder(
        itemCount: filterList2.length,
        itemBuilder: (BuildContext c, int index) {
          return Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 15),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    {
                      setState(() {
                        _selectedIndex = index;
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
                            _selectedIndex == index
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
                            Text(' ${filterList2[index]}',
                                style: GoogleFonts.inriaSans(
                                    textStyle:  TextStyle(
                                        fontSize: 14,
                                        fontWeight: _selectedIndex == index ? FontWeight.bold:FontWeight.w300,
                                        color: AppColors.closeButtonText))),
                          ],
                        ),
                        Text('100',
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
  }
}
