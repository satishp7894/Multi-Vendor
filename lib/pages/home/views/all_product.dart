import 'package:eshoperapp/models/products.dart';
import 'package:eshoperapp/models/product.dart';
import 'package:eshoperapp/widgets/all_product_tile.dart';
import 'package:eshoperapp/widgets/product_tile.dart';
import 'package:flutter/material.dart';
class AllProduct extends StatelessWidget {
  final List<Products>? products;
  final String? imageUrl;
  const AllProduct({this.products, this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...List.generate(products != null ? products!.length : 3, (index) {
            return AllProductTile(

              products: products != null ? products![index] : null,
                imageUrl: imageUrl,
            );
          })
        ],
      ),
    );
  }
}
