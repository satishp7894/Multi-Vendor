class CouponListModel {
  String? couponId;
  String? couponTitle;
  String? couponCode;
  String? couponAmount;
  String? purchaseAmount;
  String? startDate;
  String? expiryDate;
  String? description;

  CouponListModel(
      {this.couponId,
        this.couponTitle,
        this.couponCode,
        this.couponAmount,
        this.purchaseAmount,
        this.startDate,
        this.expiryDate,
        this.description});

  CouponListModel.fromJson(Map<String, dynamic> json) {
    couponId = json['coupon_id'];
    couponTitle = json['coupon_title'];
    couponCode = json['coupon_code'];
    couponAmount = json['coupon_amount'];
    purchaseAmount = json['purchase_amount'];
    startDate = json['start_date'];
    expiryDate = json['expiry_date'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coupon_id'] = this.couponId;
    data['coupon_title'] = this.couponTitle;
    data['coupon_code'] = this.couponCode;
    data['coupon_amount'] = this.couponAmount;
    data['purchase_amount'] = this.purchaseAmount;
    data['start_date'] = this.startDate;
    data['expiry_date'] = this.expiryDate;
    data['description'] = this.description;
    return data;
  }
}
