

class TopBrands {
  String? brandId;
  String? brandName;
  String? shortCode;
  String? brandLogo;
  String? qtyCnt;

  TopBrands(
      {this.brandId,
        this.brandName,
        this.shortCode,
        this.brandLogo,
        this.qtyCnt});

  TopBrands.fromJson(Map<String, dynamic> json) {
    brandId = json['brand_id'];
    brandName = json['brand_name'];
    shortCode = json['short_code'];
    brandLogo = json['brand_logo'];
    qtyCnt = json['qtyCnt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_id'] = this.brandId;
    data['brand_name'] = this.brandName;
    data['short_code'] = this.shortCode;
    data['brand_logo'] = this.brandLogo;
    data['qtyCnt'] = this.qtyCnt;
    return data;
  }
}
