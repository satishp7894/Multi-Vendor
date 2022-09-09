class OrderDetail {
  String? orderdetailId;
  String? orderId;
  String? productId;
  String? productName;
  String? quantity;
  String? netPrice;
  String? totalAmt;
  String? mrpPrice;
  String? discount;
  String? createdBy;
  String? modifiedBy;
  String? created;
  String? modified;
  String? isActive;
  String? coverImg;

  OrderDetail(
      {this.orderdetailId,
        this.orderId,
        this.productId,
        this.productName,
        this.quantity,
        this.netPrice,
        this.totalAmt,
        this.mrpPrice,
        this.discount,
        this.createdBy,
        this.modifiedBy,
        this.created,
        this.modified,
        this.isActive,
        this.coverImg});

  OrderDetail.fromJson(Map<String, dynamic> json) {
    orderdetailId = json['orderdetail_id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    quantity = json['quantity'];
    netPrice = json['net_price'];
    totalAmt = json['total_amt'];
    mrpPrice = json['mrp_price'];
    discount = json['discount'];
    createdBy = json['created_by'];
    modifiedBy = json['modified_by'];
    created = json['created'];
    modified = json['modified'];
    isActive = json['is_active'];
    coverImg = json['cover_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderdetail_id'] = this.orderdetailId;
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['quantity'] = this.quantity;
    data['net_price'] = this.netPrice;
    data['total_amt'] = this.totalAmt;
    data['mrp_price'] = this.mrpPrice;
    data['discount'] = this.discount;
    data['created_by'] = this.createdBy;
    data['modified_by'] = this.modifiedBy;
    data['created'] = this.created;
    data['modified'] = this.modified;
    data['is_active'] = this.isActive;
    data['cover_img'] = this.coverImg;
    return data;
  }
}
