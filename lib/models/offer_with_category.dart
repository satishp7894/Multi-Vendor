class OfferWithCategory {
  String? keywords;
  String? offerValue;
  String? offerElement;
  String? symbol;
  List<CategoryList>? categoryList;

  OfferWithCategory(
      {this.keywords,
        this.offerValue,
        this.offerElement,
        this.symbol,
        this.categoryList});

  OfferWithCategory.fromJson(Map<String, dynamic> json) {
    keywords = json['keywords'];
    offerValue = json['offer_value'];
    offerElement = json['offer_element'];
    symbol = json['symbol'];
    if (json['category_list'] != null) {
      categoryList = <CategoryList>[];
      json['category_list'].forEach((v) {
        categoryList!.add(CategoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['keywords'] = keywords;
    data['offer_value'] = offerValue;
    data['offer_element'] = offerElement;
    data['symbol'] = symbol;
    if (categoryList != null) {
      data['category_list'] =
          categoryList!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['image'] = image;
    return data;
  }
}
