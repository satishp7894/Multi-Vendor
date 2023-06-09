import 'package:eshoperapp/constants/app_costants.dart';
import 'package:eshoperapp/models/categories.dart';
import 'package:eshoperapp/models/category.dart';
import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/pages/category_product/category_product_screen.dart';
import 'package:eshoperapp/routes/navigation.dart';
import 'package:eshoperapp/utils/check_internet.dart';
import 'package:eshoperapp/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eshoperapp/style/theme.dart' as Style;
import 'categories_controller.dart';

class CategorieScreen extends StatelessWidget {
  final controller = Get.find<CatergoriesController>();

  // final int index;
  // CategorieScreen(this.index);

  final List<dynamic> data = [
    {
      "title": "Laptop",
      "backgroundImage":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRcEXNnZ0CnYE8tdgXZ0m4fjvz83a2p3Ls2EA&usqp=CAU",
      "children": [
        {"title": "Asus", "children": []},
        {"title": "Lenovo", "children": []},
        {"title": "Asus", "children": []},
        {"title": "Dell", "children": []},
        {"title": "Hp", "children": []},
        {"title": "Apple", "children": []}
      ]
    },
    {
      "title": "Electronic",
      "backgroundImage":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVURCfvW8GxNa-5jA9Olm0INPbdAYjO4JHrg&usqp=CAU",
      "children": [
        {
          "title": "charger",
          "children": [
            {"title": "mobile charger", "children": []}
          ]
        },
        {"title": "mobile charger", "children": []},
        {"title": "Earphone", "children": []}
      ]
    },
    {
      "title": "Electronic",
      "backgroundImage":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVURCfvW8GxNa-5jA9Olm0INPbdAYjO4JHrg&usqp=CAU",
      "children": [
        {
          "title": "charger",
          "children": [
            {"title": "mobile charger", "children": []}
          ]
        },
        {"title": "mobile charger", "children": []},
        {"title": "Earphone", "children": []}
      ]
    },
    {
      "title": "Mobile",
      "backgroundImage":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSfQjBqIF4Kf2aSdXWlfLo7h58OJlpaz36VFA&usqp=CAU",
      "children": [
        {"title": "Xiomi", "children": []},
        {"title": "Lenovo", "children": []},
        {"title": "iphone", "children": []},
        {"title": "Gionee", "children": []},
        {"title": "Samsung", "children": []},
        {"title": "Nokia", "children": []}
      ]
    },
    {
      "title": "Electronic",
      "backgroundImage":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVURCfvW8GxNa-5jA9Olm0INPbdAYjO4JHrg&usqp=CAU",
      "children": [
        {
          "title": "charger",
          "children": [
            {"title": "mobile charger", "children": []}
          ]
        },
        {"title": "mobile charger", "children": []},
        {"title": "Earphone", "children": []}
      ]
    },
    {
      "title": "Laptop",
      "backgroundImage":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRcEXNnZ0CnYE8tdgXZ0m4fjvz83a2p3Ls2EA&usqp=CAU",
      "children": [
        {"title": "Asus", "children": []},
        {"title": "Lenovo", "children": []},
        {"title": "Asus", "children": []},
        {"title": "Dell", "children": []},
        {"title": "Hp", "children": []},
        {"title": "Apple", "children": []}
      ]
    },
    {
      "title": "Mobile",
      "backgroundImage":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSfQjBqIF4Kf2aSdXWlfLo7h58OJlpaz36VFA&usqp=CAU",
      "children": [
        {"title": "Xiomi", "children": []},
        {"title": "Lenovo", "children": []},
        {"title": "iphone", "children": []},
        {"title": "Gionee", "children": []},
        {"title": "Samsung", "children": []},
        {"title": "Nokia", "children": []}
      ]
    },
    {
      "title": "Electronic",
      "backgroundImage":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVURCfvW8GxNa-5jA9Olm0INPbdAYjO4JHrg&usqp=CAU",
      "children": [
        {
          "title": "charger",
          "children": [
            {"title": "mobile charger", "children": []}
          ]
        },
        {"title": "mobile charger", "children": []},
        {"title": "Earphone", "children": []}
      ]
    },
    {
      "title": "Clothes",
      "backgroundImage":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZh4v6LJHR1kvVSsiO92BxMEDNASByiT4_lw&usqp=CAU",
      "children": [
        {"title": "Hoodies", "children": []},
        {"title": "Nice", "children": []},
        {"title": "T-shirts", "children": []},
        {"title": "Shirts", "children": []}
      ]
    },
  ];

  _buldContainer(List<Category> data) {
    return Column(
      children: [
        ...List.generate(
            data.length,
            (index) => data[index].children!.length != 0
                ? ExpansionTile(
                    title: Text(data[index].title!),
                    children: [_buldAgainContainer(data[index].children!)],
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: double.infinity,
                        child: Text(
                          data[index].title!,
                          textAlign: TextAlign.start,
                        )),
                  ))
      ],
    );
  }

  _buldAgainContainer(List<Category> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(
            data.length,
            (index) => data[index].children!.length != 0
                ? ExpansionTile(
                    title: Text(data[index].title!),
                    children: [],
                  )
                : Container(
                    width: double.infinity,
                    child: Text(
                      data[index].title!,
                      textAlign: TextAlign.start,
                    )))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // final List<Category> categoryList =
    //     data.map((dynamic e) => Category.fromJson(e)).toList();

    return SafeArea(
      child: SajiloDokanScaffold(
        title: 'Categories',
        leading: false,
        searchOnTab: () {},
        background: Colors.grey.withOpacity(0.1),
        body:
            // body: SingleChildScrollView(
            //   child: Column(
            //     children: [
            //       ...List.generate(
            //           categoryList.length,
            //           (index) => Padding(
            //                 padding: const EdgeInsets.symmetric(vertical: 10),
            //                 child: Container(
            //                   child: ExpansionTile(
            //                     title: Container(
            //                       height: 80,
            //                       decoration: BoxDecoration(),
            //                       child: Row(
            //                         children: [
            //                           Image.asset('assets/images/facebook.png'),
            //                           SizedBox(
            //                             width: 50,
            //                           ),
            //                           Text(categoryList[index].title),
            //                         ],
            //                       ),
            //                     ),
            //                     children: [_buldContainer(categoryList[index].children)],
            //                   ),
            //                 ),
            //               ))
            //     ],
            //   ),
            // ),

            RefreshIndicator(
          onRefresh: () {
            CheckInternet.checkInternet();
            return controller.getCategory(true);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() {
              if (controller.isLoadingGetCategory.value != true) {
                MainResponse? mainResponse = controller.getCategoryObj.value;
                List<Categories>? getCategoryData = [];
                // mainResponse.data!.map((e) => customerProfileData!.add(UpdateCustomerPasswordData.fromJson(e))).toList();

                if(mainResponse.data != null){
                  mainResponse.data!.forEach((v) {
                    getCategoryData.add(Categories.fromJson(v));
                  });
                }


                String? imageUrl = mainResponse.imageUrl ?? "";
                String? message =
                    mainResponse.message ?? AppConstants.noInternetConn;

                if (getCategoryData.isEmpty) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: ListView(
                      // physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height-200,
                          //height: MediaQuery.of(context).size.height,
                          alignment: Alignment.center,
                          child: Center(
                            child: Text(
                              message!,
                              style: TextStyle(color: Colors.black45),
                            ),
                          ),
                        ),

                      ],
                    ),
                  );
                } else {
                  return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              // maxCrossAxisExtent: 200,
                              // childAspectRatio: 3 / 2,
                              crossAxisCount: 3,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 0),
                      itemCount: getCategoryData.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return Card(
                          elevation: 5,
                          child: InkWell(
                            onTap: () {
                              // Get.toNamed(Routes.categoryProduct, arguments: [
                              //   {"categoryObj": getCategoryData[index]}
                              // ]);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoryProductScreen(
                                    category:getCategoryData[index],
                                  ),
                                ),
                              );
                              // controller.loadCategoryProducts(
                              //     getCategoryData[index].title);
                              // navigator!.pushNamed(Routes.categoryProduct,
                              //     arguments: CategoryArguments(
                              //         categoryName: getCategoryData[index].categoryName,
                              //         product: controller.categoryProducts,
                              //         category: getCategoryData[index].children));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Stack(
                                children: [
                                  getCategoryData[index].categoryImage == ""
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10.0),
                                          child: Container(
                                              height: 200,
                                              width: 200,
                                              decoration: BoxDecoration(
                                                //  border: Border.all(color: Colors.white,width: 2)
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                // color: Colors.grey,
                                              ),
                                              child: Image.asset(
                                                "assets/img/placeholder.jpg",
                                                fit: BoxFit.fill,
                                              )),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10.0),
                                          child: Container(
                                              height: 200,
                                              width: 200,
                                              decoration: BoxDecoration(
                                                //  border: Border.all(color: Colors.white,width: 2)
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                // color: Colors.grey,
                                              ),
                                              child: Image.network(
                                                imageUrl +
                                                    getCategoryData[index]
                                                        .categoryImage
                                                        .toString(),
                                                fit: BoxFit.contain,
                                              )),
                                        ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        // color: Colors.black26,
                                        //  border: Border.all(color: Colors.white,width: 2)
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          // border: Border.all(color: Colors.white,width: 2)
                                          // borderRadius: BorderRadius.circular(15)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Text(
                                            getCategoryData[index]
                                                .categoryName
                                                .toString(),
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }
              }

              // return CategoriesTile(
              //   categoriesList: categoryList,
              //   onChanged: (index) {
              //     controller.loadCategoryProducts(categoryList[index].title);
              //     navigator!.pushNamed(SajiloDokanRoutes.categoryProduct,
              //         arguments: CategoryArguments(
              //             categoryName: categoryList[index].title,
              //             product: controller.categoryProducts,
              //             category: categoryList[index].children));
              //   },
              // );
              else {
                if (controller.isRefresh.value !=
                    true) {
                  return Container(
                    //  height: MediaQuery.of(context).size.height-120,
                      child: Center(
                          child: CircularProgressIndicator(
                              color: Style.Colors.appColor))
                  );
                } else {
                  return Container(
                    // height: 200,
                  );
                }
                // return const Center(
                //   child: CircularProgressIndicator(),
                // );
              }
            }),
          ),
        ),
        bottomMenuIndex: 1,
      ),
    );
  }
}
