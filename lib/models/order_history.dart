class OrderHistory {
  String? orderId;
  String? orderNumber;
  String? customerId;
  String? totalQuantity;
  String? totalAmount;
  String? gstAmount;
  int? shipAmount;
  int? grandTotal;
  String? billId;
  String? orderDate;
  String? deliveryStatusId;
  String? createdBy;
  String? modifiedBy;
  String? created;
  String? modified;
  String? isActive;

  OrderHistory(
      {this.orderId,
        this.orderNumber,
        this.customerId,
        this.totalQuantity,
        this.totalAmount,
        this.gstAmount,
        this.shipAmount,
        this.grandTotal,
        this.billId,
        this.orderDate,
        this.deliveryStatusId,
        this.createdBy,
        this.modifiedBy,
        this.created,
        this.modified,
        this.isActive});

  OrderHistory.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    orderNumber = json['order_number'];
    customerId = json['customer_id'];
    totalQuantity = json['total_quantity'];
    totalAmount = json['total_amount'];
    gstAmount = json['gst_amount'];
    shipAmount = json['ship_amount'];
    grandTotal = json['grand_total'];
    billId = json['bill_id'];
    orderDate = json['order_date'];
    deliveryStatusId = json['delivery_status_id'];
    createdBy = json['created_by'];
    modifiedBy = json['modified_by'];
    created = json['created'];
    modified = json['modified'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['order_number'] = this.orderNumber;
    data['customer_id'] = this.customerId;
    data['total_quantity'] = this.totalQuantity;
    data['total_amount'] = this.totalAmount;
    data['gst_amount'] = this.gstAmount;
    data['ship_amount'] = this.shipAmount;
    data['grand_total'] = this.grandTotal;
    data['bill_id'] = this.billId;
    data['order_date'] = this.orderDate;
    data['delivery_status_id'] = this.deliveryStatusId;
    data['created_by'] = this.createdBy;
    data['modified_by'] = this.modifiedBy;
    data['created'] = this.created;
    data['modified'] = this.modified;
    data['is_active'] = this.isActive;
    return data;
  }
}
