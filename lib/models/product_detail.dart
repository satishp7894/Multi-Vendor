class ProductDetail {
  String? productId;
  String? productName;
  String? productCode;
  String? shortCode;
  String? shortDescription;
  String? description;
  String? vendorId;
  String? company;
  String? categoryId;
  String? categoryName;
  String? brandId;
  String? brandName;
  String? unit;
  String? mrpPrice;
  String? discount;
  String? netPrice;
  String? tax;
  String? onhandQuantity;
  String? isNew;
  String? isBestSeller;
  List<String>? image;

  ProductDetail(
      {this.productId,
        this.productName,
        this.productCode,
        this.shortCode,
        this.shortDescription,
        this.description,
        this.vendorId,
        this.company,
        this.categoryId,
        this.categoryName,
        this.brandId,
        this.brandName,
        this.unit,
        this.mrpPrice,
        this.discount,
        this.netPrice,
        this.tax,
        this.onhandQuantity,
        this.isNew,
        this.isBestSeller,
        this.image});

  ProductDetail.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    productCode = json['product_code'];
    shortCode = json['short_code'];
    shortDescription = json['short_description'];
    description = json['description'];
    vendorId = json['vendor_id'];
    company = json['company'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    brandId = json['brand_id'];
    brandName = json['brand_name'];
    unit = json['unit'];
    mrpPrice = json['mrp_price'];
    discount = json['discount'];
    netPrice = json['net_price'];
    tax = json['tax'];
    onhandQuantity = json['onhand_quantity'];
    isNew = json['is_new'];
    isBestSeller = json['is_best_seller'];
    image = json['image'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_code'] = this.productCode;
    data['short_code'] = this.shortCode;
    data['short_description'] = this.shortDescription;
    data['description'] = this.description;
    data['vendor_id'] = this.vendorId;
    data['company'] = this.company;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['brand_id'] = this.brandId;
    data['brand_name'] = this.brandName;
    data['unit'] = this.unit;
    data['mrp_price'] = this.mrpPrice;
    data['discount'] = this.discount;
    data['net_price'] = this.netPrice;
    data['tax'] = this.tax;
    data['onhand_quantity'] = this.onhandQuantity;
    data['is_new'] = this.isNew;
    data['is_best_seller'] = this.isBestSeller;
    data['image'] = this.image;
    return data;
  }
}
