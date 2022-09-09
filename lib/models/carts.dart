class Carts {
  String? cartId;
  String? customerId;
  String? productId;
  String? productName;
  String? image;
  String? quantity;
  String? netPrice;
  String? totalAmt;
  String? mrp;
  String? discount;
  String? discountAmt;
  String? gst;
  String? gstAmt;

  Carts(
      {this.cartId,
        this.customerId,
        this.productId,
        this.productName,
        this.image,
        this.quantity,
        this.netPrice,
        this.totalAmt,
        this.mrp,
        this.discount,
        this.discountAmt,
        this.gst,
        this.gstAmt});

  Carts.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    customerId = json['customer_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    image = json['image'];
    quantity = json['quantity'];
    netPrice = json['net_price'];
    totalAmt = json['total_amt'];
    mrp = json['mrp'];
    discount = json['discount'];
    discountAmt = json['discount_amt'];
    gst = json['gst'];
    gstAmt = json['gst_amt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = this.cartId;
    data['customer_id'] = this.customerId;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['image'] = this.image;
    data['quantity'] = this.quantity;
    data['net_price'] = this.netPrice;
    data['total_amt'] = this.totalAmt;
    data['mrp'] = this.mrp;
    data['discount'] = this.discount;
    data['discount_amt'] = this.discountAmt;
    data['gst'] = this.gst;
    data['gst_amt'] = this.gstAmt;
    return data;
  }
}
