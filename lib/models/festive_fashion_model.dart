class FestiveFashionModel {
  String? categoryId;
  String? categoryName;
  String? description;
  String? categoryImage;

  FestiveFashionModel(
      {this.categoryId,
        this.categoryName,
        this.description,
        this.categoryImage});

  FestiveFashionModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    description = json['description'];
    categoryImage = json['category_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['description'] = this.description;
    data['category_image'] = this.categoryImage;
    return data;
  }
}
