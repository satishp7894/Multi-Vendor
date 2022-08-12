import 'package:eshoperapp/config/theme.dart';
import 'package:eshoperapp/constants/app_costants.dart';
import 'package:eshoperapp/models/brand.dart';
import 'package:eshoperapp/models/category.dart';
import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/models/product.dart';
import 'package:eshoperapp/models/products.dart';
import 'package:eshoperapp/utils/check_internet.dart';
import 'package:eshoperapp/widgets/product_gridview_tile.dart';
import 'package:eshoperapp/widgets/product_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:eshoperapp/style/theme.dart' as Style;

import 'brand_product_controller.dart';

class BrandProductScreen extends StatefulWidget {

  const BrandProductScreen({Key? key}) : super(key: key);

  @override
  State<BrandProductScreen> createState() => _BrandProductScreenState();
}

class _BrandProductScreenState extends State<BrandProductScreen> {
  BrandProductController? brandProductController;
  Brand? brand;


  @override
  void initState() {
    // TODO: implement initState
    dynamic argumentData = Get.arguments;
    brand = argumentData[0]['brandObj'];
    print("brandObj brandId ${brand!.brandId}");
    brandProductController = Get.put(BrandProductController(
        apiRepositoryInterface: Get.find(), brandId: brand!.brandId!, localRepositoryInterface: Get.find()));
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
          title: Text("${brand!.brandName!}", style: TextStyle(fontSize: 20,color: Style.Colors.appColor)),
        ),
        body: RefreshIndicator(
          onRefresh: () {
            CheckInternet.checkInternet();
            return brandProductController!.brandProduct(brand!.brandId!);
          },
          child: Obx(() {
            if (brandProductController!.isLoadingBrandProduct.value != true) {
              MainResponse? mainResponse = brandProductController!.brandProductObj.value;
              List<Products>? brandProductData = [];
              if(mainResponse.data != null){
                mainResponse.data!.forEach((v) {
                  brandProductData.add( Products.fromJson(v));
                });
              }
              // mainResponse.data!.map((e) => customerProfileData!.add(UpdateCustomerPasswordData.fromJson(e))).toList();


              String? imageUrl = mainResponse.imageUrl ?? "";
              String? message = mainResponse.message ?? AppConstants.noInternetConn;
              if (brandProductData.isEmpty) {
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
                return ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                      child: ProductGridviewTile(
                        products: brandProductData,
                        imageUrl: imageUrl,
                        brandProductPage: true,
                      ),
                    ),
                  ],
                );
              }

            } else {
              return  Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Center(child: CircularProgressIndicator(color: Style.Colors.appColor)));

            }
          }),
        ),


        );
  }
}

class CategoryArguments {
  final String? categoryName;
  final List<Product>? product;
  List<Category>? category;

  CategoryArguments({this.categoryName, this.product, this.category});
}
