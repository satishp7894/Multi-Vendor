import 'package:eshoperapp/models/products.dart';
import 'package:eshoperapp/models/product.dart';
import 'package:eshoperapp/widgets/product_tile.dart';
import 'package:flutter/material.dart';
class PopulorProduct extends StatelessWidget {
  final List<Products>? products;
  final String? imageUrl;
  const PopulorProduct({this.products, this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...List.generate(products != null ? products!.length : 3, (index) {
            return ProductTile(

              products: products != null ? products![index] : null,
                imageUrl: imageUrl,
            );
          })
        ],
      ),
    );
  }
}
