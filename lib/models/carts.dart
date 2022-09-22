class Carts {
  String? cartId;
  String? customerId;
  String? productId;
  String? quantity;
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
  Null? elementId;
  Null? attributesId;
  String? unitPrice;
  String? mrpPrice;
  String? discount;
  String? discountAmt;
  String? netPrice;
  Null? tag;
  String? tax;
  String? gstAmt;
  List<String>? image;
  String? coverImg;
  String? isNewProduct;
  String? isPopularProduct;
  String? isFeatureProduct;
  Null? returnOrReplace;
  Null? returnReplaceValidity;
  Null? policyCovers;
  Null? returnPolicy;
  String? metaTitle;
  String? metaDescription;
  String? metaKeyword;
  String? createdBy;
  String? modifiedBy;
  String? created;
  String? modified;
  String? isActive;

  Carts(
      {this.cartId,
        this.customerId,
        this.productId,
        this.quantity,
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
        this.unitPrice,
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
        this.isActive});

  Carts.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    customerId = json['customer_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
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
    unitPrice = json['unit_price'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = this.cartId;
    data['customer_id'] = this.customerId;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
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
    data['unit_price'] = this.unitPrice;
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
    return data;
  }
}
