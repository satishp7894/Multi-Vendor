class CategoryProduct {
  bool? status;
  String? message;
  String? imageUrl;
  List<dynamic>? categoryData;
  List<dynamic>? productData;

  CategoryProduct(
      {this.status,
        this.message,
        this.imageUrl,
        this.categoryData,
        this.productData});

  CategoryProduct.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    imageUrl = json['image_url'];
    if (json['categoryData'] != null) {
      categoryData = json['categoryData'];
    }
    if (json['productData'] != null) {
      productData =  json['productData'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['image_url'] = this.imageUrl;
    if (this.categoryData != null) {
      data['categoryData'] = this.categoryData!.map((v) => v.toJson()).toList();
    }
    if (this.productData != null) {
      data['productData'] = this.productData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

