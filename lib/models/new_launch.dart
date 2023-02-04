

class NewLaunch {
  String? productId;
  String? productName;
  String? shortCode;
  String? netPrice;
  String? coverImg;
  String? mrpPrice;
  String? discount;
  String? variantCode;

  NewLaunch(
      {this.productId,
        this.productName,
        this.shortCode,
        this.netPrice,
        this.coverImg,
        this.mrpPrice,
        this.discount,
        this.variantCode});

  NewLaunch.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    shortCode = json['short_code'];
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
    data['short_code'] = this.shortCode;
    data['net_price'] = this.netPrice;
    data['cover_img'] = this.coverImg;
    data['mrp_price'] = this.mrpPrice;
    data['discount'] = this.discount;
    data['variant_code'] = this.variantCode;
    return data;
  }
}
