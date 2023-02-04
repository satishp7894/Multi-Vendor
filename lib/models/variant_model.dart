

class VariantModel {
  String? productId;
  String? variantCode;

  VariantModel({this.productId, this.variantCode});

  VariantModel.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    variantCode = json['variant_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['variant_code'] = this.variantCode;
    return data;
  }
}
