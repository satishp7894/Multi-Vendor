

class OrderDetailsModel  {
  String? orderId;
  String? productId;
  String? deliverDate;
  String? productName;
  String? variantCode;
  String? quantity;
  String? mrpPrice;
  String? netPrice;
  String? totalAmt;
  String? discountAmt;
  List<ElementsAttributes>? elementsAttributes;
  String? returnReplaceValidity;
  String? coverImg;
  String? shippingAddress;
  List<DeliveryAddress>? deliveryAddress;
  String? orderNumber;
  String? orderDate;
  String? vendorName;
  String? brandName;
  String? customerId;
  String? starRate;
  bool? reviewFlag;

  OrderDetailsModel (
      {this.orderId,
        this.productId,
        this.deliverDate,
        this.productName,
        this.variantCode,
        this.quantity,
        this.mrpPrice,
        this.netPrice,
        this.totalAmt,
        this.discountAmt,
        this.elementsAttributes,
        this.returnReplaceValidity,
        this.coverImg,
        this.shippingAddress,
        this.deliveryAddress,
        this.orderNumber,
        this.orderDate,
        this.vendorName,
        this.brandName,
        this.customerId,
        this.starRate,
        this.reviewFlag});

  OrderDetailsModel .fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    productId = json['product_id'];
    deliverDate = json['deliver_date'];
    productName = json['product_name'];
    variantCode = json['variant_code'];
    quantity = json['quantity'];
    mrpPrice = json['mrp_price'];
    netPrice = json['net_price'];
    totalAmt = json['total_amt'];
    discountAmt = json['discount_amt'];
    if (json['elements_attributes'] != null) {
      elementsAttributes = <ElementsAttributes>[];
      json['elements_attributes'].forEach((v) {
        elementsAttributes!.add(new ElementsAttributes.fromJson(v));
      });
    }
    returnReplaceValidity = json['return_replace_validity'];
    coverImg = json['cover_img'];
    shippingAddress = json['shipping_address'];
    if (json['delivery_address'] != null) {
      deliveryAddress = <DeliveryAddress>[];
      json['delivery_address'].forEach((v) {
        deliveryAddress!.add(new DeliveryAddress.fromJson(v));
      });
    }
    orderNumber = json['order_number'];
    orderDate = json['order_date'];
    vendorName = json['vendor_name'];
    brandName = json['brand_name'];
    customerId = json['customer_id'];
    starRate = json['star_rate'];
    reviewFlag = json['review_flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    data['deliver_date'] = this.deliverDate;
    data['product_name'] = this.productName;
    data['variant_code'] = this.variantCode;
    data['quantity'] = this.quantity;
    data['mrp_price'] = this.mrpPrice;
    data['net_price'] = this.netPrice;
    data['total_amt'] = this.totalAmt;
    data['discount_amt'] = this.discountAmt;
    if (this.elementsAttributes != null) {
      data['elements_attributes'] =
          this.elementsAttributes!.map((v) => v.toJson()).toList();
    }
    data['return_replace_validity'] = this.returnReplaceValidity;
    data['cover_img'] = this.coverImg;
    data['shipping_address'] = this.shippingAddress;
    if (this.deliveryAddress != null) {
      data['delivery_address'] =
          this.deliveryAddress!.map((v) => v.toJson()).toList();
    }
    data['order_number'] = this.orderNumber;
    data['order_date'] = this.orderDate;
    data['vendor_name'] = this.vendorName;
    data['brand_name'] = this.brandName;
    data['customer_id'] = this.customerId;
    data['star_rate'] = this.starRate;
    data['review_flag'] = this.reviewFlag;
    return data;
  }
}

class ElementsAttributes {
  String? element;
  String? value;

  ElementsAttributes({this.element, this.value});

  ElementsAttributes.fromJson(Map<String, dynamic> json) {
    element = json['element'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['element'] = this.element;
    data['value'] = this.value;
    return data;
  }
}

class DeliveryAddress {
  String? name;
  String? mobile;
  String? address;
  String? city;
  String? state;
  String? country;
  String? pincode;

  DeliveryAddress(
      {this.name,
        this.mobile,
        this.address,
        this.city,
        this.state,
        this.country,
        this.pincode});

  DeliveryAddress.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mobile = json['mobile'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['pincode'] = this.pincode;
    return data;
  }
}
