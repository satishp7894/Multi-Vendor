class CountryAndState {
  int? id;
  String? name;
  String? iso2;

  CountryAndState({this.id, this.name, this.iso2});

  CountryAndState.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    iso2 = json['iso2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['iso2'] = this.iso2;
    return data;
  }
}
