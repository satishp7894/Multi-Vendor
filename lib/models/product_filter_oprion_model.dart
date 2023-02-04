

class ProductFilterOption {
  String? element;
  List<Values>? value;

  ProductFilterOption({this.element, this.value});

  ProductFilterOption.fromJson(Map<String, dynamic> json) {
    element = json['element'];
    if (json['value'] != null) {
      value = <Values>[];
      json['value'].forEach((v) {
        value!.add(new Values.fromJson(v));
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

class Values {
  String? elementName;
  bool? isChecked;
  ElementValues? elementValue;

  Values({this.elementName, this.elementValue, this.isChecked});

  Values.fromJson(Map<String, dynamic> json) {
    elementName = json['element_name'];
    isChecked = false;
    elementValue = json['element_value'] != null
        ? new ElementValues.fromJson(json['element_value'])
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

class ElementValues {
  String? elementId;
  String? attributeCode;
  String? attrId;

  ElementValues({this.elementId, this.attributeCode, this.attrId});

  ElementValues.fromJson(Map<String, dynamic> json) {
    elementId = json['element_id'];
    attributeCode = json['attribute_code'];
    attrId = json['attr_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['element_id'] = this.elementId;
    data['attribute_code'] = this.attributeCode;
    data['attr_id'] = this.attrId;
    return data;
  }
}
