import 'package:eshoperapp/config/theme.dart';
import 'package:eshoperapp/models/products.dart';
import 'package:eshoperapp/models/product.dart';
import 'package:eshoperapp/package/product_rating.dart';
import 'package:eshoperapp/pages/details/prodcut_details_screen.dart';
import 'package:eshoperapp/routes/navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:shimmer/shimmer.dart';

class ProductTile extends StatelessWidget {
  final Products? products;
  final String? imageUrl;
  final VoidCallback? onTap;
  final bool? brandProductPage;
  ProductTile({this.products, this.onTap, this.imageUrl, this.brandProductPage});

  @override
  Widget build(BuildContext context) {
    return products != null
        ? InkWell(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>  ProductDetailsScreen(
                  products: products!,
                  // article: articles[index],
                )));
      },


            // onTap: () {
            //   if(brandProductPage == true){
            //     navigator!.pushNamed(Routes.brandProduct,
            //         arguments: products!.brandId);
            //   }else{
            //
            //   }
            //
            // },
            child: SizedBox(
              width: 150,
              height: 300,
              child: Stack(
                children: [
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: products!.image![0] == null
                                ? Center(
                                    child: Image.network(
                                    imageUrl! + products!.image![0],
                                    height: 170,
                                    width: 130,
                                    fit: BoxFit.fill,
                                  ))
                                : Center(
                                    child: Image.asset("assets/img/placeholder.jpg", height: 170,
                                      width: 130,
                                      fit: BoxFit.fill,
                                      // height: 170,
                                      // decoration: BoxDecoration(
                                      //     color: AppColors.darkGray
                                      //         .withOpacity(0.2),
                                      //     borderRadius:
                                      //         BorderRadius.circular(6)),
                                    ),
                                  ),
                          ),
                          SizedBox(height: 8),
                          products!.productName! != null
                              ? Text(
                            products!.productName!,
                                  maxLines: 1,
                                //  style: GoogleFonts.ptSans(),
                                  overflow: TextOverflow.ellipsis,
                                )
                              : Container(
                                  height: 20,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color:
                                          AppColors.darkGray.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(6)),
                                ),

                          SizedBox(height: 8),
                          products!.shortDescription! != null
                              ? Text(
                            products!.shortDescription!,
                            maxLines: 2,
                            //  style: GoogleFonts.ptSans(),
                            overflow: TextOverflow.ellipsis,
                          )
                              : Container(
                            height: 20,
                            width: 120,
                            decoration: BoxDecoration(
                                color:
                                AppColors.darkGray.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(6)),
                          ),                          SizedBox(height: 8),
                          products!.mrpPrice != null
                              ? Text('Rs. ' + '${products!.mrpPrice}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFFFF7643)))
                              : Container(
                                  height: 15,
                                  decoration: BoxDecoration(
                                      color:
                                          AppColors.darkGray.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(6)),
                                ),
                          // SizedBox(height: 8),
                          // product != null
                          //     ? ProductRating(
                          //         rating: product!.avaragereview,
                          //         isReadOnly: true,
                          //         size: 15,
                          //         filledIconData: Icons.star,
                          //         borderColor: Colors.red,
                          //         color: Colors.red,
                          //         halfFilledIconData: Icons.star_half,
                          //         defaultIconData: Icons.star_border,
                          //         starCount: 5,
                          //         allowHalfRating: true,
                          //       )
                          //     : Container(
                          //         height: 20,
                          //         width: 100,
                          //         decoration: BoxDecoration(
                          //             color:
                          //                 AppColors.darkGray.withOpacity(0.2),
                          //             borderRadius: BorderRadius.circular(6)),
                          //       ),
                        ],
                      ),
                    ),
                  ),
                  // product != null
                  //     ? Positioned(
                  //         top: 0,
                  //         left: 0,
                  //         child: Container(
                  //           height: 20,
                  //           width: 40,
                  //           decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(5),
                  //               color: Colors.red),
                  //           child: Center(
                  //             child: Text(
                  //               product!.price! <= 5000 ? 'New' : '-30%',
                  //               style: TextStyle(color: Colors.white),
                  //             ),
                  //           ),
                  //         ))
                  //     : const SizedBox.shrink(),
                ],
              ),
            ),
          )
        :
    SizedBox(
            width: 150,
            height: 220,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[900]!,
              highlightColor: Colors.grey[800]!,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            color: AppColors.darkGray.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(6)),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 10,
                      width: 120,
                      decoration: BoxDecoration(
                          color: AppColors.darkGray.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6)),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 15,
                      width: 100,
                      decoration: BoxDecoration(
                          color: AppColors.darkGray.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6)),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 10,
                      width: 110,
                      decoration: BoxDecoration(
                          color: AppColors.darkGray.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6)),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}


class ProductDetailsArguments {
  final Product? product;
  ProductDetailsArguments({this.product});
}
