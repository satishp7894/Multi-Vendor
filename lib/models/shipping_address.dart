class ShippingAddress {
  String? addressId;
  String? customerId;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  String? address;
  String? city;
  String? state;
  String? pincode;
  String? country;
  String? addressType;
  // String? createdBy;
  // String? modifiedBy;
  String? created;
  String? modified;
  String? isActive;

  ShippingAddress(
      {this.addressId,
        this.customerId,
        this.firstName,
        this.lastName,
        this.email,
        this.mobile,
        this.address,
        this.city,
        this.state,
        this.pincode,
        this.country,
        this.addressType,
        // this.createdBy,
        // this.modifiedBy,
        this.created,
        this.modified,
        this.isActive});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
    customerId = json['customer_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
    country = json['country'];
    addressType = json['address_type'];
    // createdBy = json['created_by'];
    // modifiedBy = json['modified_by'];
    created = json['created'];
    modified = json['modified'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_id'] = this.addressId;
    data['customer_id'] = this.customerId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['pincode'] = this.pincode;
    data['country'] = this.country;
    data['address_type'] = this.addressType;
    // data['created_by'] = this.createdBy;
    // data['modified_by'] = this.modifiedBy;
    data['created'] = this.created;
    data['modified'] = this.modified;
    data['is_active'] = this.isActive;
    return data;
  }
}
