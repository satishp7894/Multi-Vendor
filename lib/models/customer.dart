class Customer {
  String? customerId;
  String? customerName;
  String? gender;
  String? email;
  String? mobile;

  Customer(
      {this.customerId,
        this.customerName,
        this.gender,
        this.email,
        this.mobile});

  Customer.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    customerName = json['customer_name'];
    gender = json['gender'];
    email = json['email'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['customer_name'] = this.customerName;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    return data;
  }
}