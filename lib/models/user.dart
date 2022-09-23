// To parse this JSON data, do
//
//     final UserModel = UserModelFromJson(jsonString);

import 'dart:convert';

UserModel UserModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String UserModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.id,
    this.user,
    this.rol,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? user;
  String? rol;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: (json["_id"] == null) ? "" : json["_id"],
        user: (json["user"] == null) ? "" : json["user"],
        rol: (json["rol"] == null) ? "" : json["rol"],
        name: (json["name"] == null) ? "" : json["name"],
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
        "user": user,
        "rol": rol,
        "name": name,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
      };
}
