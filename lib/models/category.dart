// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  Category({
    this.code,
    this.msg,
    this.body,
  });

  String? code;
  String? msg;
  Body? body;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        code: (json["code"] == null) ? "" : json["code"],
        msg: (json["msg"] == null) ? "" : json["msg"],
        body: json["body"] == null
            ? Body.fromJson({})
            : Body.fromJson(json["body"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "msg": msg,
        "body": body,
      };
}

class Body {
  Body({
    this.id,
    this.category,
    this.description,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? category;
  String? description;
  int? price;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        id: (json["_id"] == null) ? "" : json["_id"],
        category: (json["category"] == null) ? "" : json["category"],
        description: (json["description"] == null) ? "" : json["description"],
        price: (json["price"] == null) ? 0 : json["price"],
        createdAt: json["createdAt"] == null
            ? DateTime.now()
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? DateTime.now()
            : DateTime.parse(json["updatedAt"]),
        v: (json["__v"] == null) ? 0 : json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "category": category,
        "description": description,
        "price": price,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
      };
}
