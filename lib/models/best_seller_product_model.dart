class BestSellerProduct {
  String? productId;
  String? productName;
  String? brandName;
  String? shortCode;
  String? netPrice;
  String? coverImg;
  String? mrpPrice;
  String? discount;
  String? variantCode;
  String? qtyCnt;
  String? totalStar;
  Variants? variants;
  bool? wishList;

  BestSellerProduct(
      {this.productId,
        this.productName,
        this.shortCode,
        this.netPrice,
        this.coverImg,
        this.mrpPrice,
        this.discount,
        this.variantCode,
        this.brandName,
        this.qtyCnt,
        this.variants,
        this.totalStar,
      this.wishList});

  BestSellerProduct.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    shortCode = json['short_code'];
    netPrice = json['net_price'];
    coverImg = json['cover_img'];
    mrpPrice = json['mrp_price'];
    brandName = json['brand_name'];
    discount = json['discount'];
    variantCode = json['variant_code'];
    qtyCnt = json['qtyCnt'];
    totalStar = json['totalstar'];
    variants = json['variants'] != null
        ? new Variants.fromJson(json['variants'])
        : null;
    wishList = json['wishlist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['short_code'] = this.shortCode;
    data['net_price'] = this.netPrice;
    data['cover_img'] = this.coverImg;
    data['brand_name'] = this.brandName;
    data['mrp_price'] = this.mrpPrice;
    data['discount'] = this.discount;
    data['variant_code'] = this.variantCode;
    data['qtyCnt'] = this.qtyCnt;
    data['totalstar'] = this.totalStar;
    if (this.variants != null) {
      data['variants'] = this.variants!.toJson();
    }
    data['wishlist'] = this.wishList;
    return data;
  }
}

class Variants {
  String? size;
  String? color;

  Variants({this.size, this.color});

  Variants.fromJson(Map<String, dynamic> json) {
    size = json['Size'];
    color = json['Color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Size'] = this.size;
    data['Color'] = this.color;
    return data;
  }
}
