class GetSlider {
  bool? status;
  String? message;
  String? imageUrl;
  List<GetSliderData>? data;

  GetSlider({this.status, this.message, this.imageUrl, this.data});

  GetSlider.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    imageUrl = json['image_url'];
    if (json['data'] != null) {
      data = <GetSliderData>[];
      json['data'].forEach((v) {
        data!.add(new GetSliderData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['image_url'] = this.imageUrl;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetSliderData {
  String? sliderId;
  String? sliderImage;
  String? sliderTitle;
  String? shortDescription;
  String? position;

  GetSliderData(
      {this.sliderId,
        this.sliderImage,
        this.sliderTitle,
        this.shortDescription,
        this.position});

  GetSliderData.fromJson(Map<String, dynamic> json) {
    sliderId = json['slider_id'];
    sliderImage = json['slider_image'];
    sliderTitle = json['slider_title'];
    shortDescription = json['short_description'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slider_id'] = this.sliderId;
    data['slider_image'] = this.sliderImage;
    data['slider_title'] = this.sliderTitle;
    data['short_description'] = this.shortDescription;
    data['position'] = this.position;
    return data;
  }
}
