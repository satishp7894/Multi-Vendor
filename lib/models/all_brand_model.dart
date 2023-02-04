class AllBrandModel {
  String? letter;
  List<Value>? value;

  AllBrandModel({this.letter, this.value});

  AllBrandModel.fromJson(Map<String, dynamic> json) {
    letter = json['letter'];
    if (json['value'] != null) {
      value = <Value>[];
      json['value'].forEach((v) {
        value!.add(new Value.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['letter'] = this.letter;
    if (this.value != null) {
      data['value'] = this.value!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Value {
  String? brandName;
  String? brandId;

  Value({this.brandName, this.brandId});

  Value.fromJson(Map<String, dynamic> json) {
    brandName = json['brand_name'];
    brandId = json['brand_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_name'] = this.brandName;
    data['brand_id'] = this.brandId;
    return data;
  }
}
