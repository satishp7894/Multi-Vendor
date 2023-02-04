class CheckLogin {
  bool? status;
  String? message;
  List<CheckLoginData>? data;

  CheckLogin({this.status, this.message, this.data});

  CheckLogin.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CheckLoginData>[];
      json['data'].forEach((v) {
        data!.add(new CheckLoginData.fromJson(v));
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

class CheckLoginData {
  String? customerId;
  String? customerName;
  String? gender;
  String? mobile;
  String? email;
  String? password;
  // String? showPassword;
  // // String? createdBy;
  // // String? modifiedBy;
  // String? created;
  // String? modified;
  String? isActive;

  CheckLoginData(
      {this.customerId,
        this.customerName,
        this.gender,
        this.mobile,
        this.email,
        this.password,
        // this.showPassword,
        // // this.createdBy,
        // // this.modifiedBy,
        // this.created,
        // this.modified,
        this.isActive
      });

  CheckLoginData.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    customerName = json['customer_name'];
    gender = json['gender'];
    mobile = json['mobile'];
    email = json['email'];
    password = json['password'];
    // showPassword = json['show_password'];
    // // createdBy = json['created_by'];
    // // modifiedBy = json['modified_by'];
    // created = json['created'];
    // modified = json['modified'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customer_id'] = customerId;
    data['customer_name'] = customerName;
    data['gender'] = gender;
    data['mobile'] = mobile;
    data['email'] = email;
    data['password'] = password;
    // data['show_password'] = showPassword;
    // // data['created_by'] = this.createdBy;
    // // data['modified_by'] = this.modifiedBy;
    // data['created'] = created;
    // data['modified'] = modified;
    data['is_active'] = isActive;
    return data;
  }
}
