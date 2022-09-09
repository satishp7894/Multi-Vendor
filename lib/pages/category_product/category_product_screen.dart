import 'package:eshoperapp/config/theme.dart';
import 'package:eshoperapp/constants/app_costants.dart';
import 'package:eshoperapp/models/brand.dart';
import 'package:eshoperapp/models/categories.dart';
import 'package:eshoperapp/models/category.dart';
import 'package:eshoperapp/models/category_product.dart';
import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/models/product.dart';
import 'package:eshoperapp/models/products.dart';
import 'package:eshoperapp/routes/navigation.dart';
import 'package:eshoperapp/utils/check_internet.dart';
import 'package:eshoperapp/widgets/product_gridview_tile.dart';
import 'package:eshoperapp/widgets/product_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:eshoperapp/style/theme.dart' as Style;

import 'category_product_controller.dart';

class CategoryProductScreen extends StatefulWidget {
  final Categories? category;
  const CategoryProductScreen({Key? key,required this.category}) : super(key: key);

  @override
  State<CategoryProductScreen> createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen> {
  CategoryProductController? categoryProductController;
  Categories? categories;


  @override
  void initState() {
    // TODO: implement initState
    // dynamic argumentData = Get.arguments;
    // categories = argumentData[0]['categoryObj'];

    // dynamic argumentData = Get.arguments;
    categories = widget.category;
    print("categoryObj categoryId ${categories!.categoryId}");
    categoryProductController = Get.put(CategoryProductController(
        apiRepositoryInterface: Get.find(), categoryId: categories!.categoryId!, localRepositoryInterface: Get.find()));
    initData(categoryProductController!,categories!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final CategoryArguments args =
    //     ModalRoute.of(context)!.settings.arguments as CategoryArguments;

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
              color: Style.Colors.appColor,
              size: 30,
            ),
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          ),
          title: Text("${categories!.categoryName!}", style: TextStyle(fontSize: 20,color: Style.Colors.appColor)),
        ),
        body:  RefreshIndicator(
          onRefresh: () {
            CheckInternet.checkInternet();
            return categoryProductController!.categoryProduct(categories!.categoryId!);
          },
          child: Obx(() {
            if (categoryProductController!.isLoadingCategoryProduct.value != true) {
              CategoryProduct? categoryProduct = categoryProductController!.categoryProductObj.value;
              List<Products>? categoryProductData = [];
              if(categoryProduct.productData != null){
                categoryProduct.productData!.forEach((v) {
                  categoryProductData.add( Products.fromJson(v));
                });
              }

              List<Categories>? categoryData = [];
              if(categoryProduct.categoryData != null){
                categoryProduct.categoryData!.forEach((v) {
                  categoryData.add( Categories.fromJson(v));
                });
              }
              // mainResponse.data!.map((e) => customerProfileData!.add(UpdateCustomerPasswordData.fromJson(e))).toList();


              String? imageUrl = categoryProduct.imageUrl ?? "";
              String? message = categoryProduct.message ?? AppConstants.noInternetConn;
              if (categoryProductData.isEmpty && categoryData.isEmpty) {
                return Container(
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
                            style: TextStyle(color: Colors.black45),
                          ),
                        ),
                      ),

                    ],
                  ),
                );
              }else{

                if(categoryProductData.isNotEmpty){
                  return ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ProductGridviewTile(
                          products: categoryProductData,
                          imageUrl: imageUrl,
                          brandProductPage: true,
                        ),
                      ),
                    ],
                  );
                }else  if(categoryData.isNotEmpty){

                  return  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          // maxCrossAxisExtent: 200,
                          // childAspectRatio: 3 / 2,
                            crossAxisCount: 3,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 0),
                        itemCount: categoryData.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return Card(
                            elevation: 5,
                            child: InkWell(
                              onTap: () {
                                print("onTap");
                                // Get.toNamed(Routes.categoryProduct, arguments: [
                                //   {"categoryObj": categoryData[index]}
                                // ], preventDuplicates: false);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoryProductScreen(
                                      category: categoryData[index],
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
                                    categoryData[index].categoryImage == ""
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
                                                categoryData[index]
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
                                              categoryData[index]
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
                        }),
                  );

                  return Text("kfjdsklfdsf");
                  // return Padding(
                  //   padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                  //   child: ProductGridviewTile(
                  //     products: categoryData,
                  //     imageUrl: imageUrl,
                  //     brandProductPage: true,
                  //   ),
                  // );
                }else{
                  return Container();
            }



              }

            } else {
              return  Container(
                  // height: 200,
                  child: Center(child: CircularProgressIndicator(color: Style.Colors.appColor)));

            }
          }),
        ),


        );
  }


  Future<void> initData(CategoryProductController categoryProductController, Categories categories) async {
    print("categories.categoryId! ${categories.categoryId!}");
    await  Future.delayed(const Duration(microseconds: 0), () {
      categoryProductController.categoryProduct(categories.categoryId!);
    } );
  }

}

class CategoryArguments {
  final String? categoryName;
  final List<Product>? product;
  List<Category>? category;

  CategoryArguments({this.categoryName, this.product, this.category});
}
