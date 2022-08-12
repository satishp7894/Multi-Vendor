import 'package:eshoperapp/models/brand.dart';
import 'package:eshoperapp/models/products.dart';
import 'package:eshoperapp/models/product.dart';
import 'package:eshoperapp/routes/navigation.dart';
import 'package:eshoperapp/widgets/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:eshoperapp/style/theme.dart' as Style;
import 'package:get/get.dart';
class BrandWidget extends StatelessWidget {
  final List<Brand>? brands;
  final String? imageUrl;
  const BrandWidget({this.brands, this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: brands!.length,
        itemBuilder: (context, index) {
          return Container(
            // padding: EdgeInsets.only(top: 0.0, right: 10.0),
            width: 130.0,
            child: GestureDetector(
              onTap: ()  {

                Get.toNamed(Routes.brandProduct,arguments: [
                  {"brandObj": brands![index]}
                ]);
                // final sharedPreferences =
                // await SharedPreferences.getInstance();
                // sharedPreferences.setString(AppConstants.categoryId!,
                //     categoryList[index].categoryId!);
                // sharedPreferences.setString(AppConstants.categoryName!,
                //     categoryList[index].categoryName!);
                // // AppConstants.categoryId!=categoryList[index].categoryId;
                // // AppConstants.categoryName!=categoryList[index].categoryName;
                // // Get.toNamed(Routes.categoryDetails,
                // //     arguments:
                // //     [
                // //       {"categoryId": categoryList[index].categoryId},
                // //       {"categoryName": categoryList[index].categoryName},
                // //     ]
                // //
                // //     // categoryList[index]
                // //
                // // );
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => CategoryDetails(
                //       categoryId: categoryList[index].categoryId,
                //       categoryName: categoryList[index].categoryName,
                //     ),
                //   ),
                // );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  brands![index].brandLogo! == ""
                      ? Expanded(
                        child: Hero(
                    tag: brands![index].brandId!,
                    child: Container(
                          width: 120.0,
                          // height: 115.0,
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                width: 0.5, color: Colors.grey),
                            //shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5.0,
                                spreadRadius: 1.0,
                                offset: Offset(
                                  1.0,
                                  1.0,
                                ),
                              )
                            ],
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                    "assets/img/placeholder.jpg")
                              //AssetImage("assets/logos/abc-news.png")
                            ),
                          )),
                  ),
                      )
                      : Expanded(
                        child: Hero(
                    tag: brands![index].brandId!,
                    child: Container(
                          width: 120.0,
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                width: 0.5, color: Colors.grey),
                            //shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5.0,
                                spreadRadius: 1.0,
                                offset: Offset(
                                  1.0,
                                  1.0,
                                ),
                              )
                            ],
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(imageUrl!+
                                    brands![index].brandLogo!)
                              //AssetImage("assets/logos/abc-news.png")
                            ),
                          )),
                  ),
                      ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    brands![index].brandName!,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        height: 1.4,
                        color: Style.Colors.titleColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0),
                  ),
                  // SizedBox(
                  //   height: 3.0,
                  // ),
                  // Text(
                  //   sources[index].category!,
                  //   maxLines: 2,
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //       height: 1.4,
                  //       color: Style.Colors.titleColor,
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 9.0),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
