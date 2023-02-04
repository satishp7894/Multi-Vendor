class AddressRequest {
  const AddressRequest(
    this.firstName,
    this.lastName,
    // this.email,
    this.mobile,
    this.address,
    // this.locality,
    // this.landmark,
    this.city,
    this.state,
    this.pincode,
    this.country,
      this.setDefault,
    this.addressType,
  );

  final String? firstName;
  final String? lastName;
  // final String? email;
  final String? mobile;
  final String? address;
  // final String? locality;
  // final String? landmark;
  final String? city;
  final String? state;
  final String? pincode;
  final String? country;
  final String? setDefault;
  final String? addressType;
}
