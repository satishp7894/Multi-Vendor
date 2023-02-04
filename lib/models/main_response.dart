class MainResponse {
  bool? status;
  String? message;
  String? imageUrl;
  String? invoiceUrl;
  List<dynamic>? data;
  List<ProductElement>? productElement;
  // List<dynamic>? productElement;
  List<ProductReview>? productReview;
  List<String>? priceRange;


  MainResponse({this.status, this.message, this.data,this.imageUrl,this.invoiceUrl,
    this.productElement,this.productReview,this.priceRange
  });

  MainResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['message'] != null) {
      message = json['message'];
    }

    imageUrl = json['image_url'];
    invoiceUrl = json['invoice_url'];
    if (json['data'] != null) {
      data = json['data'];
      // data =

      // json['data'].forEach((v) {
      //   data!.add(new UpdateCustomerPasswordData.fromJson(v));
      // });
    }
    if (json['product_element'] != null) {
      productElement = <ProductElement>[];
      json['product_element'].forEach((v) {
        productElement!.add(new ProductElement.fromJson(v));
      });
    }

    if (json['product_review'] != null) {
      productReview = <ProductReview>[];
      json['product_review'].forEach((v) {
        productReview!.add(new ProductReview.fromJson(v));
      });
    }

    if( json['price_range'] != null){
      priceRange = json['price_range'].cast<String>();
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['image_url'] = this.imageUrl;
    data['invoice_url'] = this.invoiceUrl;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.productElement != null) {
      data['product_element'] =
          this.productElement!.map((v) => v.toJson()).toList();
    }
    if (this.productReview != null) {
      data['product_review'] =
          this.productReview!.map((v) => v.toJson()).toList();
    }
    data['price_range'] = this.priceRange;
    return data;
  }
}

class UpdateCustomerPasswordData {
  String? customerId;
  String? customerName;
  String? gender;
  String? email;
  String? mobile;

  UpdateCustomerPasswordData(
      {this.customerId,
        this.customerName,
        this.gender,
        this.email,
        this.mobile});

  UpdateCustomerPasswordData.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    customerName = json['customer_name'];
    gender = json['gender'];
    email = json['email'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['customer_name'] = this.customerName;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    return data;
  }
}



class ProductElement {
  String? element;
  List<Value>? value;

  ProductElement({this.element, this.value});

  ProductElement.fromJson(Map<String, dynamic> json) {
    element = json['element'];
    if (json['value'] != null) {
      value = <Value>[];
      json['value'].forEach((v) {
        value!.add(new Value.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['element'] = this.element;
    if (this.value != null) {
      data['value'] = this.value!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Value {
  String? elementName;
  ElementValue? elementValue;

  Value({this.elementName, this.elementValue});

  Value.fromJson(Map<String, dynamic> json) {
    elementName = json['element_name'].toString();
    elementValue = json['element_value'] != null
        ? new ElementValue.fromJson(json['element_value'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['element_name'] = this.elementName;
    if (this.elementValue != null) {
      data['element_value'] = this.elementValue!.toJson();
    }
    return data;
  }
}

class ElementValue {
  String? elementId;
  String? attrId;
  String? attrCode;
  List<String>? pId;
  bool? isSelected;

  ElementValue({this.elementId, this.attrId, this.attrCode, this.pId, this.isSelected});

  ElementValue.fromJson(Map<String, dynamic> json) {
    elementId = json['element_id'];
    attrId = json['attr_id'];
    attrCode = json['attribute_code'];
    pId = json['p_id'].cast<String>();
    isSelected = json['is_selected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['element_id'] = this.elementId;
    data['attr_id'] = this.attrId;
    data['attribute_code'] = this.attrCode;
    data['p_id'] = this.pId;
    data['is_selected'] = this.isSelected;
    return data;
  }
}


class ProductReview {
  int? totalStar;
  int? totalReviewsCount;
  int? totalRatingCount;
  List<Reviews>? reviews;

  ProductReview(
      {this.totalStar,
        this.totalReviewsCount,
        this.totalRatingCount,
        // this.reviews
      });

  ProductReview.fromJson(Map<String, dynamic> json) {
    totalStar = json['total_star'];
    totalReviewsCount = json['total_reviews_count'];
    totalRatingCount = json['total_rating_count'];
    // reviews = json['reviews'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_star'] = this.totalStar;
    data['total_reviews_count'] = this.totalReviewsCount;
    data['total_rating_count'] = this.totalRatingCount;
    // data['reviews'] = this.reviews;
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reviews {
  String? productReviewId;
  String? customerName;
  String? starRate;
  String? reviewTitle;
  String? reviewContent;
  String? reviewDate;

  Reviews(
      {this.productReviewId,
        this.customerName,
        this.starRate,
        this.reviewTitle,
        this.reviewContent,
        this.reviewDate});

  Reviews.fromJson(Map<String, dynamic> json) {
    productReviewId = json['product_review_id'];
    customerName = json['customer_name'];
    starRate = json['star_rate'];
    reviewTitle = json['review_title'];
    reviewContent = json['review_content'];
    reviewDate = json['review_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_review_id'] = this.productReviewId;
    data['customer_name'] = this.customerName;
    data['star_rate'] = this.starRate;
    data['review_title'] = this.reviewTitle;
    data['review_content'] = this.reviewContent;
    data['review_date'] = this.reviewDate;
    return data;
  }
}

