import 'package:eshoperapp/config/theme.dart';
import 'package:eshoperapp/models/products.dart';
import 'package:eshoperapp/models/product.dart';
import 'package:eshoperapp/package/product_rating.dart';
import 'package:eshoperapp/pages/details/prodcut_details_screen.dart';
import 'package:eshoperapp/routes/navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:shimmer/shimmer.dart';

class AllProductTile extends StatelessWidget {
  final Products? products;
  final String? imageUrl;
  final VoidCallback? onTap;
  final bool? brandProductPage;
  AllProductTile({this.products, this.onTap, this.imageUrl, this.brandProductPage});

  @override
  Widget build(BuildContext context) {
    return products != null
        ?

    InkWell(
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
              width: MediaQuery.of(context).size.width-10,
              // height: 300,
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(

                    children: [
                      Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: products!.coverImage != null
                            ? Center(
                            child: Image.network(
                              imageUrl! + products!.productId! + "/" + products!.coverImage!,
                              height: 100,
                              width: 130,
                              fit: BoxFit.fill,
                            ))
                            : Center(
                          child: Image.asset("assets/img/placeholder.jpg",
                            height: 100,
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
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          SizedBox(height: 2),
                          Container(
                            // width: 100,
                            width: MediaQuery.of(context).size.width-175,
                            child: Text(
                              products!.productName!,
                              maxLines: 1,
                              //  style: GoogleFonts.ptSans(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          SizedBox(height: 2),
                          Container(
                            // width: 100,
                            width: MediaQuery.of(context).size.width-175,
                            child: Text(
                              products!.shortDescription!,
                              maxLines: 2,
                              //  style: GoogleFonts.ptSans(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text('\u{20B9} ' + '${double.parse(products!.mrpPrice!).toStringAsFixed(0)}',
                              style:  TextStyle(
                                  decoration: TextDecoration.combine(
                                      [ TextDecoration.lineThrough]),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                          SizedBox(height: 2),
                         Row(
                           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                           products!.netPrice != null
                               ? Text('\u{20B9} ' + '${double.parse(products!.netPrice!).toStringAsFixed(0)}',
                               style: const TextStyle(
                                   fontSize: 16,
                                   fontWeight: FontWeight.bold,
                                   color: Colors.black))
                               : Container(
                             height: 15,
                             decoration: BoxDecoration(
                                 color:
                                 AppColors.darkGray.withOpacity(0.2),
                                 borderRadius: BorderRadius.circular(6)),
                           ),
                             SizedBox(width: 5),
                           products!.discount != null
                               ? Text('${products!.discount} % off',
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
                         ],)
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
                    ],
                  ),
                ),
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
