class MainResponse {
  bool? status;
  String? message;
  String? imageUrl;
  List<dynamic>? data;
  List<dynamic>? productElement;


  MainResponse({this.status, this.message, this.data, this.productElement});

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
    if (json['product_element'] != null) {
      productElement = json['product_element'];
      // productElement = <ProductElement>[];
      // json['product_element'].forEach((v) {
      //   productElement!.add(new ProductElement.fromJson(v));
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
    if (this.productElement != null) {
      data['product_element'] =
          this.productElement!.map((v) => v.toJson()).toList();
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

class ProductElement {
  String? elemant;
  List<String>? value;

  ProductElement({this.elemant, this.value});

  ProductElement.fromJson(Map<String, dynamic> json) {
    elemant = json['elemant'];
    value = json['value'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['elemant'] = this.elemant;
    data['value'] = this.value;
    return data;
  }
}
