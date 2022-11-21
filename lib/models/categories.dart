import 'package:flutter/cupertino.dart';

class Categories {
  String? categoryId;
  String? categoryName;
  String? description;
  Color? color;
  BoxFit? fit;
  String? categoryImage;

  Categories(
      {this.categoryId,
        this.categoryName,
        this.description,
        this.color,
        this.fit,
        this.categoryImage});

  Categories.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    description = json['description'];
    color = json['color'];
    fit = json['fit'];
    categoryImage = json['category_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['description'] = this.description;
    data['color'] = this.color;
    data['fit'] = this.fit;
    data['category_image'] = this.categoryImage;
    return data;
  }
}
