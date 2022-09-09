

class Products {
  String? productId;
  String? productName;
  String? productCode;
  String? shortDescription;
  String? name;
  String? vendorId;
  String? company;
  String? brandId;
  String? brandName;
  String? categoryId;
  String? categoryName;
  String? mrpPrice;
  String? discount;
  String? netPrice;
  String? isNew;
  String? isBestSeller;
  String? coverImage;
  List<String>? image;

  Products(
      {this.productId,
        this.productName,
        this.productCode,
        this.shortDescription,
        this.name,
        this.vendorId,
        this.company,
        this.brandId,
        this.brandName,
        this.categoryId,
        this.categoryName,
        this.mrpPrice,
        this.discount,
        this.netPrice,
        this.isNew,
        this.isBestSeller,
        this.coverImage,
        this.image});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    productCode = json['product_code'];
    shortDescription = json['short_description'];
    name = json['name'];
    vendorId = json['vendor_id'];
    company = json['company'];
    brandId = json['brand_id'];
    brandName = json['brand_name'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    mrpPrice = json['mrp_price'];
    discount = json['discount'];
    netPrice = json['net_price'];
    isNew = json['is_new'];
    isBestSeller = json['is_best_seller'];
    coverImage = json['cover_img'];
    image = json['image'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_code'] = this.productCode;
    data['short_description'] = this.shortDescription;
    data['name'] = this.name;
    data['vendor_id'] = this.vendorId;
    data['company'] = this.company;
    data['brand_id'] = this.brandId;
    data['brand_name'] = this.brandName;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['mrp_price'] = this.mrpPrice;
    data['discount'] = this.discount;
    data['net_price'] = this.netPrice;
    data['is_new'] = this.isNew;
    data['is_best_seller'] = this.isBestSeller;
    data['cover_img'] = this.coverImage;
    data['image'] = this.image;
    return data;
  }
}
