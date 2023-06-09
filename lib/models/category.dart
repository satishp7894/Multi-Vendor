// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

List<Category> categoryFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  Category({
    this.title,
    this.backgroundImage,
    this.children,
  });

  String? title;
  String? backgroundImage;
  List<Category>? children;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        title: json["title"],
        backgroundImage: json["backgroundImage"],
        children: List<Category>.from(
            json["children"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "backgroundImage": backgroundImage,
        "children": List<dynamic>.from(children!.map((x) => x.toJson())),
      };
}
