import 'package:eshoperapp/models/product.dart';
import 'package:eshoperapp/routes/navigation.dart';
import 'package:eshoperapp/widgets/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class ProductListTile extends StatelessWidget {
  final Product? product;
  ProductListTile({this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => navigator!.pushNamed(Routes.productDetails,
          arguments: ProductDetailsArguments(product: product)),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
        child: Stack(
          children: [
            Card(
              elevation: 2,
              child: Row(
                children: [
                  Container(
                    height: 200,
                    width: 150,
                    child: Center(
                      child: Image.network(
                        'https://onlinehatiya.herokuapp.com' + product!.image!,
                        height: 150,
                        width: 130,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product!.title!,
                            maxLines: 2,
                           // style: GoogleFonts.ptSans(),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              // ProductRating(
                              //   rating: product.avaragereview,
                              //   isReadOnly: true,
                              //   size: 15,
                              //   filledIconData: Icons.star,
                              //   borderColor: Colors.red,
                              //   color: Colors.red,
                              //   halfFilledIconData: Icons.star_half,
                              //   defaultIconData: Icons.star_border,
                              //   starCount: 5,
                              //   allowHalfRating: true,
                              // ),
                              Text(
                                ' ' + product!.avaragereview.toString(),
                                style: TextStyle(color: Colors.red),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Rs ' + product!.price.toString(),
                            style: TextStyle(color: Colors.redAccent),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
                top: 0,
                left: 0,
                child: Container(
                  height: 20,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.red),
                  child: Center(
                    child: Text(
                      product!.price! <= 30 ? 'New' : '-30%',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )),
            Positioned(
                bottom: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(
                          Icons.favorite_border,
                          color: Colors.red,
                        )),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
