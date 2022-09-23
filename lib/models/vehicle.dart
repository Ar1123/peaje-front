// To parse this JSON data, do
//
//     final VehicleModel = VehicleModelFromJson(jsonString);

// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

VehicleModel VehicleModelFromJson(String str) =>
    VehicleModel.fromJson(json.decode(str));

String VehicleModelToJson(VehicleModel data) => json.encode(data.toJson());

class VehicleModel {
  VehicleModel({
    this.code,
    this.msg,
    this.body,
  });

  String? code;
  String? msg;
  List<BodyV>? body;

  factory VehicleModel.fromJson(Map<String, dynamic> json) => VehicleModel(
        code: (json["code"] == null) ? "" : json["code"],
        msg: (json["msg"] == null) ? "" : json["msg"],
        body: json["body"] == null
            ? []
            : List<BodyV>.from(json["body"].map((x) => BodyV.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": (code == null) ? "" : code,
        "msg": (msg == null) ? "" : msg,
        "body": body == null
            ? []
            : List<dynamic>.from(body!.map((x) => x.toJson())),
      };
}

class BodyV {
  BodyV({
    this.id,
    this.description,
    this.idCategoy,
    this.weigth,
    this.axles,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.url,
    this.category,
  });

  String? id;
  String? description;
  String? idCategoy;
  String? category;
  int? weigth;
  int? axles;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? url;

  factory BodyV.fromJson(Map<String, dynamic> json) => BodyV(
        id: (json["_id"] == null) ? "" : json["_id"],
        description: (json["description"] == null) ? "" : json["description"],
        idCategoy: (json["idCategoy"] == null) ? "" : json["idCategoy"],
        category: (json["category"] == null) ? "" : json["category"],
        weigth: (json["weigth"] == null) ? 0 : json["weigth"],
        axles: (json["axles"] == null) ? 0 : json["axles"],
        createdAt: json["createdAt"] == null
            ? DateTime.now()
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? DateTime.now()
            : DateTime.parse(json["updatedAt"]),
        v: (json["__v"] == null) ? 0 : json["__v"],
        url: (json["url"] == null) ? "" : json["url"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "description": description,
        "idCategoy": idCategoy,
        "weigth": weigth,
        "axles": axles,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "category": category,
        "__v": v,
        "url": url,
      };
}
