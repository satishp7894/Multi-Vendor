class MainResponse {
  bool? status;
  String? message;
  String? imageUrl;
  List<dynamic>? data;


  MainResponse({this.status, this.message, this.data});

  MainResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    imageUrl = json['image_url'];
    if (json['data'] != null) {
      data = json['data'];
      // data = <dynamic>[];
      // json['data'].forEach((v) {
      //   data!.add(new UpdateCustomerPasswordData.fromJson(v));
      // });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['image_url'] = this.imageUrl;
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
