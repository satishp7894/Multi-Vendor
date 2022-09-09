import 'package:eshoperapp/models/product.dart';
import 'package:eshoperapp/models/products.dart';
import 'package:eshoperapp/widgets/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProductGridviewTile extends StatelessWidget {
  final List<Products>? products;
  final String? imageUrl;
  final bool? brandProductPage;

  ProductGridviewTile({this.products, this.imageUrl,this.brandProductPage});
  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
        shrinkWrap: true,
        primary: false,
        crossAxisCount: 2,
        itemCount: products!.length ,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        itemBuilder: (context, index) => ProductTile(
              // product: productList != null ? productList![index] : null,
          products: products![index],
          imageUrl: imageUrl,

            ),
        staggeredTileBuilder: (index) => StaggeredTile.fit(1));
  }
}
