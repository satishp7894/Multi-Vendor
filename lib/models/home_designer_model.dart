class HomeDesignerModel {
  String? designerId;
  String? name;
  String? image;
  String? totalProduct;

  HomeDesignerModel({this.designerId, this.name, this.image, this.totalProduct});

  HomeDesignerModel.fromJson(Map<String, dynamic> json) {
    designerId = json['designer_id'];
    name = json['name'];
    image = json['image'];
    totalProduct = json['total_product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['designer_id'] = this.designerId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['total_product'] = this.totalProduct;
    return data;
  }
}
