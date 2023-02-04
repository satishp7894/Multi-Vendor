
class ChildCategory {
  String? categoryName;
  String? categoryId;
  String? categoryImage;

  ChildCategory({this.categoryName, this.categoryId, this.categoryImage});

  ChildCategory.fromJson(Map<String, dynamic> json) {
    categoryName = json['category_name'];
    categoryId = json['category_id'];
    categoryImage = json['category_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_name'] = this.categoryName;
    data['category_id'] = this.categoryId;
    data['category_image'] = this.categoryImage;
    return data;
  }
}
