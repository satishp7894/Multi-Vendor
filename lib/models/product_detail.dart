class ProductDetail {
  String? productId;
  String? productName;
  String? productCode;
  String? shortCode;
  String? shortDescription;
  String? description;
  String? stock;
  String? vendorId;
  String? brandId;
  String? categoryId;
  String? childCategory;
  String? qty;
  String? elementId;
  String? attributesId;
  String? mrpPrice;
  String? discount;
  String? discountAmt;
  String? netPrice;
  String? tag;
  String? tax;
  String? gstAmt;
  List<String>? image;
  String? coverImg;
  String? isNewProduct;
  String? isPopularProduct;
  String? isFeatureProduct;
  String? returnOrReplace;
  String? returnReplaceValidity;
  String? policyCovers;
  String? returnPolicy;
  String? metaTitle;
  String? metaDescription;
  String? metaKeyword;
  String? createdBy;
  String? modifiedBy;
  String? created;
  String? modified;
  String? isActive;
  String? vendorName;
  String? categoryName;
  String? brandName;

  ProductDetail(
      {this.productId,
        this.productName,
        this.productCode,
        this.shortCode,
        this.shortDescription,
        this.description,
        this.stock,
        this.vendorId,
        this.brandId,
        this.categoryId,
        this.childCategory,
        this.qty,
        this.elementId,
        this.attributesId,
        this.mrpPrice,
        this.discount,
        this.discountAmt,
        this.netPrice,
        this.tag,
        this.tax,
        this.gstAmt,
        this.image,
        this.coverImg,
        this.isNewProduct,
        this.isPopularProduct,
        this.isFeatureProduct,
        this.returnOrReplace,
        this.returnReplaceValidity,
        this.policyCovers,
        this.returnPolicy,
        this.metaTitle,
        this.metaDescription,
        this.metaKeyword,
        this.createdBy,
        this.modifiedBy,
        this.created,
        this.modified,
        this.isActive,
        this.vendorName,
        this.categoryName,
        this.brandName});

  ProductDetail.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    productCode = json['product_code'];
    shortCode = json['short_code'];
    shortDescription = json['short_description'];
    description = json['description'];
    stock = json['stock'];
    vendorId = json['vendor_id'];
    brandId = json['brand_id'];
    categoryId = json['category_id'];
    childCategory = json['child_category'];
    qty = json['qty'];
    elementId = json['element_id'];
    attributesId = json['attributes_id'];
    mrpPrice = json['mrp_price'];
    discount = json['discount'];
    discountAmt = json['discount_amt'];
    netPrice = json['net_price'];
    tag = json['tag'];
    tax = json['tax'];
    gstAmt = json['gst_amt'];
    image = json['image'].cast<String>();
    coverImg = json['cover_img'];
    isNewProduct = json['is_new_product'];
    isPopularProduct = json['is_popular_product'];
    isFeatureProduct = json['is_feature_product'];
    returnOrReplace = json['return_or_replace'];
    returnReplaceValidity = json['return_replace_validity'];
    policyCovers = json['policy_covers'];
    returnPolicy = json['return_policy'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    metaKeyword = json['meta_keyword'];
    createdBy = json['created_by'];
    modifiedBy = json['modified_by'];
    created = json['created'];
    modified = json['modified'];
    isActive = json['is_active'];
    vendorName = json['vendor_name'];
    categoryName = json['category_name'];
    brandName = json['brand_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_code'] = this.productCode;
    data['short_code'] = this.shortCode;
    data['short_description'] = this.shortDescription;
    data['description'] = this.description;
    data['stock'] = this.stock;
    data['vendor_id'] = this.vendorId;
    data['brand_id'] = this.brandId;
    data['category_id'] = this.categoryId;
    data['child_category'] = this.childCategory;
    data['qty'] = this.qty;
    data['element_id'] = this.elementId;
    data['attributes_id'] = this.attributesId;
    data['mrp_price'] = this.mrpPrice;
    data['discount'] = this.discount;
    data['discount_amt'] = this.discountAmt;
    data['net_price'] = this.netPrice;
    data['tag'] = this.tag;
    data['tax'] = this.tax;
    data['gst_amt'] = this.gstAmt;
    data['image'] = this.image;
    data['cover_img'] = this.coverImg;
    data['is_new_product'] = this.isNewProduct;
    data['is_popular_product'] = this.isPopularProduct;
    data['is_feature_product'] = this.isFeatureProduct;
    data['return_or_replace'] = this.returnOrReplace;
    data['return_replace_validity'] = this.returnReplaceValidity;
    data['policy_covers'] = this.policyCovers;
    data['return_policy'] = this.returnPolicy;
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['meta_keyword'] = this.metaKeyword;
    data['created_by'] = this.createdBy;
    data['modified_by'] = this.modifiedBy;
    data['created'] = this.created;
    data['modified'] = this.modified;
    data['is_active'] = this.isActive;
    data['vendor_name'] = this.vendorName;
    data['category_name'] = this.categoryName;
    data['brand_name'] = this.brandName;
    return data;
  }
}
