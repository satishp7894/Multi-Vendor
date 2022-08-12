class UpdateCustomerPassword {
  bool? status;
  String? message;
  List<UpdateCustomerPasswordData>? data;

  UpdateCustomerPassword({this.status, this.message, this.data});

  UpdateCustomerPassword.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <UpdateCustomerPasswordData>[];
      json['data'].forEach((v) {
        data!.add(new UpdateCustomerPasswordData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UpdateCustomerPasswordData {
  String? customerId;
  String? customerName;
  String? gender;
  String? email;
  String? mobile;

  UpdateCustomerPasswordData(
      {this.customerId,
        this.customerName,
        this.gender,
        this.email,
        this.mobile});

  UpdateCustomerPasswordData.fromJson(Map<String, dynamic> json) {
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
