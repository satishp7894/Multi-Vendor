class OrderHistoryModel {
  String? productId;
  String? orderId;
  String? deliverDate;
  String? productName;
  String? returnReplaceValidity;
  String? coverImg;
  String? orderNumber;
  String? orderDate;
  String? vendorName;
  String? brandName;

  OrderHistoryModel(
      {
        this.orderId,
        this.productId,
        this.deliverDate,
        this.productName,
        this.returnReplaceValidity,
        this.coverImg,
        this.orderNumber,
        this.orderDate,
        this.vendorName,
        this.brandName});

  OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    productId = json['product_id'];
    deliverDate = json['deliver_date'];
    productName = json['product_name'];
    returnReplaceValidity = json['return_replace_validity'];
    coverImg = json['cover_img'];
    orderNumber = json['order_number'];
    orderDate = json['order_date'];
    vendorName = json['vendor_name'];
    brandName = json['brand_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    data['deliver_date'] = this.deliverDate;
    data['product_name'] = this.productName;
    data['return_replace_validity'] = this.returnReplaceValidity;
    data['cover_img'] = this.coverImg;
    data['order_number'] = this.orderNumber;
    data['order_date'] = this.orderDate;
    data['vendor_name'] = this.vendorName;
    data['brand_name'] = this.brandName;
    return data;
  }
}
