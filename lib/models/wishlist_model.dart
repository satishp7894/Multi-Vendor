

class WishListModel {
  String? whishListId;
  String? customerId;
  String? productId;
  String? productName;
  String? brandName;
  String? shortCode;
  String? variantCode;
  String? netPrice;
  String? mrpPrice;
  String? discount;
  String? coverImg;

  WishListModel(
      {this.whishListId,
        this.customerId,
        this.productId,
        this.productName,
        this.brandName,
        this.variantCode,
        this.shortCode,
        this.netPrice,
        this.mrpPrice,
        this.discount,
        this.coverImg});

  WishListModel.fromJson(Map<String, dynamic> json) {
    whishListId = json['whish_list_id'];
    customerId = json['customer_id'];
    productId = json['product_id'];
    variantCode = json['variant_code'];
    productName = json['product_name'];
    brandName = json['brand_name'];
    shortCode = json['short_code'];
    netPrice = json['net_price'];
    mrpPrice = json['mrp_price'];
    discount = json['discount'];
    coverImg = json['cover_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['whish_list_id'] = this.whishListId;
    data['customer_id'] = this.customerId;
    data['product_id'] = this.productId;
    data['variant_code'] = this.variantCode;
    data['product_name'] = this.productName;
    data['brand_name'] = this.brandName;
    data['short_code'] = this.shortCode;
    data['net_price'] = this.netPrice;
    data['mrp_price'] = this.mrpPrice;
    data['discount'] = this.discount;
    data['cover_img'] = this.coverImg;
    return data;
  }
}
