import 'package:eshoperapp/config/theme.dart';
import 'package:eshoperapp/models/category.dart';
import 'package:eshoperapp/models/product.dart';
import 'package:eshoperapp/widgets/product_gridview_tile.dart';
import 'package:eshoperapp/widgets/product_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import 'categories_controller.dart';

class CategoryProducts extends StatelessWidget {
  final controller = Get.find<CatergoriesController>();

  final list = ['Clothes', 'Hoodies', 'Nice', 'T-shirts'];


  @override
  Widget build(BuildContext context) {
    final CategoryArguments args =
        ModalRoute.of(context)!.settings.arguments as CategoryArguments;

    return Scaffold(
      // backgroundColor: Colors.green.withOpacity(0.1),
        // appBar: AppBar(
        //   actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
        //   elevation: 0,
        // ),

        appBar: AppBar(
          elevation: 5,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          ),
          title: Text("${args.categoryName!}", style: TextStyle(fontSize: 20)),
        ),
        body: SafeArea(
            child: Container(
              color:  Colors.grey.withOpacity(0.1),
              child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Filter',
                            style: TextStyle(fontSize: 20),
                          ),
                          Obx(() {
                            return IconButton(
                                onPressed: () {
                                  controller
                                      .changeGridMode(controller.isGrid.value);
                                },
                                icon: !controller.isGrid.value
                                    ? Icon(Icons.grid_view)
                                    : Icon(Icons.format_list_bulleted));
                          })
                        ],
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: args.category != null
                            ? Row(
                                children: [
                                  Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.redAccent,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Center(
                                        child: Text(
                                          'All',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  ...List.generate(
                                      args.category!.length,
                                      (index) => Padding(
                                            padding:
                                                const EdgeInsets.only(right: 10),
                                            child: Container(
                                              height: 50,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.black,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                child: Center(
                                                  child: Text(
                                                    args.category![index].title!,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ))
                                ],
                              )
                            : SizedBox.shrink(),
                      )
                    ],
                  )),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Obx(() {
                        if (!controller.isCategoryProductsLoading.value) {
                          return !controller.isGrid.value
                              ?
                          ProductGridviewTile(
                                  // productList: args.product,
                            products: null,
                                )
                              : Column(
                                  children: [
                                    ...List.generate(
                                        args.product!.length,
                                        (index) => ProductListTile(
                                              product: args.product![index],
                                            ))
                                  ],
                                );
                        } else {
                          if (!controller.isGrid.value) {
                            return Column(
                              children: [
                                ...List.generate(
                                    1,
                                    (index) => Card(
                                      child: SizedBox(
                                            width: 180,
                                            height: 280,
                                            child: Shimmer.fromColors(
                                              baseColor: Colors.grey[900]!,
                                              highlightColor: Colors.grey[800]!,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      clipBehavior: Clip.antiAlias,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                4),
                                                      ),
                                                      child: Container(
                                                        height: 150,
                                                        width: 180,
                                                        decoration: BoxDecoration(
                                                            color: AppColors
                                                                .darkGray
                                                                .withOpacity(0.2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(6)),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 20),
                                                    Container(
                                                      height: 10,
                                                      width: 180,
                                                      decoration: BoxDecoration(
                                                          color: AppColors.darkGray
                                                              .withOpacity(0.2),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  6)),
                                                    ),
                                                    const SizedBox(height: 15),
                                                    Container(
                                                      height: 15,
                                                      width: 180,
                                                      decoration: BoxDecoration(
                                                          color: AppColors.darkGray
                                                              .withOpacity(0.2),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  6)),
                                                    ),
                                                    const SizedBox(height: 20),
                                                    Container(
                                                      height: 10,
                                                      width: 180,
                                                      decoration: BoxDecoration(
                                                          color: AppColors.darkGray
                                                              .withOpacity(0.2),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  6)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                    ))
                              ],
                            );
                          } else {
                            return Column(
                              children: [
                                ...List.generate(
                                    5,
                                    (index) => Padding(
                                          padding: const EdgeInsets.only(
                                              left: 25, right: 25, bottom: 25),
                                          child: Stack(
                                            children: [
                                              Card(
                                                elevation: 2,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 200,
                                                      width: 150,
                                                      color: AppColors.darkGray
                                                          .withOpacity(0.2),
                                                    ),
                                                    Flexible(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                                8.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              height: 25,
                                                              decoration: BoxDecoration(
                                                                  color: AppColors
                                                                      .darkGray
                                                                      .withOpacity(
                                                                          0.2),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              6)),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Container(
                                                              height: 15,
                                                              width: 100,
                                                              decoration: BoxDecoration(
                                                                  color: AppColors
                                                                      .darkGray
                                                                      .withOpacity(
                                                                          0.2),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              6)),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Container(
                                                              height: 15,
                                                              width: 150,
                                                              decoration: BoxDecoration(
                                                                  color: AppColors
                                                                      .darkGray
                                                                      .withOpacity(
                                                                          0.2),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              6)),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Container(
                                                              height: 15,
                                                              width: 100,
                                                              decoration: BoxDecoration(
                                                                  color: AppColors
                                                                      .darkGray
                                                                      .withOpacity(
                                                                          0.2),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              6)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ))
                              ],
                            );
                          }
                        }
                      }),
                    ),
                  ),
                ),
              ),
          ],
        ),
            ))


        );
  }
}

class CategoryArguments {
  final String? categoryName;
  final List<Product>? product;
  List<Category>? category;

  CategoryArguments({this.categoryName, this.product, this.category});
}
