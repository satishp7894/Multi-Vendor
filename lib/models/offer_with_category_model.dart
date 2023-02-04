

class OfferWithCategoryModel {
  String? offerId;
  String? keywords;
  String? offerValue;
  String? offerElement;
  String? symbol;
  List<CategoryList>? categoryList;

  OfferWithCategoryModel(
      {this.offerId,
        this.keywords,
        this.offerValue,
        this.offerElement,
        this.symbol,
        this.categoryList});

  OfferWithCategoryModel.fromJson(Map<String, dynamic> json) {
    offerId = json['offer_id'];
    keywords = json['keywords'];
    offerValue = json['offer_value'];
    offerElement = json['offer_element'];
    symbol = json['symbol'];
    if (json['category_list'] != null) {
      categoryList = <CategoryList>[];
      json['category_list'].forEach((v) {
        categoryList!.add(new CategoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offer_id'] = this.offerId;
    data['keywords'] = this.keywords;
    data['offer_value'] = this.offerValue;
    data['offer_element'] = this.offerElement;
    data['symbol'] = this.symbol;
    if (this.categoryList != null) {
      data['category_list'] =
          this.categoryList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryList {
  String? name;
  String? id;
  String? image;

  CategoryList({this.name, this.id, this.image});

  CategoryList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['image'] = this.image;
    return data;
  }
}
