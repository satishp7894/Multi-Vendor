class Customer {
  String? customerId;
  String? customerName;
  String? gender;
  String? email;
  String? mobile;
  String? alterNateNUmber;
  String? birthDate;

  Customer(
      {this.customerId,
        this.customerName,
        this.gender,
        this.email,
        this.mobile, this.alterNateNUmber,this.birthDate});

  Customer.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    customerName = json['customer_name'];
    gender = json['gender'];
    email = json['email'];
    mobile = json['mobile'];
    alterNateNUmber = json['alternate_mobile'];
    birthDate = json['birth_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['customer_name'] = this.customerName;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['alternate_mobile'] = this.alterNateNUmber;
    data['birth_date'] = this.birthDate;
    return data;
  }
}