class RecentSearchModel {
  String? keyword;
  String? image;
  String? searchId;
  String? productId;

  RecentSearchModel({this.keyword, this.image, this.searchId, this.productId});

  RecentSearchModel.fromJson(Map<String, dynamic> json) {
    keyword = json['keyword'];
    image = json['image'];
    searchId = json['search_id'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['keyword'] = this.keyword;
    data['image'] = this.image;
    data['search_id'] = this.searchId;
    data['product_id'] = this.productId;
    return data;
  }
}
