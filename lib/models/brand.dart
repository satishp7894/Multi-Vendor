class Brand {
  String? brandId;
  String? brandName;
  String? brandLogo;

  Brand({this.brandId, this.brandName, this.brandLogo});

  Brand.fromJson(Map<String, dynamic> json) {
    brandId = json['brand_id'];
    brandName = json['brand_name'];
    brandLogo = json['brand_logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_id'] = this.brandId;
    data['brand_name'] = this.brandName;
    data['brand_logo'] = this.brandLogo;
    return data;
  }
}
