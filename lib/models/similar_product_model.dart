class SimilarProductModel {
  String? productId;
  String? productName;
  String? brandName;
  String? childCategory;
  String? shortCode;
  String? shortDescription;
  String? netPrice;
  String? coverImg;
  String? mrpPrice;
  String? discount;
  String? variantCode;

  SimilarProductModel(
      {this.productId,
        this.productName,
        this.brandName,
        this.childCategory,
        this.shortCode,
        this.shortDescription,
        this.netPrice,
        this.coverImg,
        this.mrpPrice,
        this.discount,
        this.variantCode});

  SimilarProductModel.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    brandName = json['brand_name'];
    childCategory = json['child_category'];
    shortCode = json['short_code'];
    shortDescription = json['short_description'];
    netPrice = json['net_price'];
    coverImg = json['cover_img'];
    mrpPrice = json['mrp_price'];
    discount = json['discount'];
    variantCode = json['variant_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['brand_name'] = this.brandName;
    data['child_category'] = this.childCategory;
    data['short_code'] = this.shortCode;
    data['short_description'] = this.shortDescription;
    data['net_price'] = this.netPrice;
    data['cover_img'] = this.coverImg;
    data['mrp_price'] = this.mrpPrice;
    data['discount'] = this.discount;
    data['variant_code'] = this.variantCode;
    return data;
  }
}
