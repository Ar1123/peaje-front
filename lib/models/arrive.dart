// To parse this JSON data, do
//
//     final arrive = arriveFromJson(jsonString);

import 'dart:convert';

Arrive arriveFromJson(String str) => Arrive.fromJson(json.decode(str));

String arriveToJson(Arrive data) => json.encode(data.toJson());

class Arrive {
  Arrive({
    this.code,
    this.msg,
    this.body,
  });

  String? code;
  String? msg;
  BodyArrive? body;

  factory Arrive.fromJson(Map<String, dynamic> json) => Arrive(
        code: (json["code"] == null) ? "" : json["code"],
        msg: (json["msg"] == null) ? "" : json["msg"],
        body: json["body"] == null
            ? BodyArrive.fromJson({})
            : BodyArrive.fromJson(json["body"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "msg": msg,
        "body": body,
      };
}

class BodyArrive {
  BodyArrive({
    this.porCate,
    this.priceByCar,
    this.totalV,
    this.valTurno,
    this.vehiT,
  });

  List<PorCate>? porCate;
  List<PorCate>? priceByCar;
  int? totalV;
  List<ValTurno>? valTurno;
  List<ValTurno>? vehiT;

  factory BodyArrive.fromJson(Map<String, dynamic> json) => BodyArrive(
        porCate: json["porCate"] == null
            ? []
            : List<PorCate>.from(
                json["porCate"].map((x) => PorCate.fromJson(x))),
        priceByCar: json["priceByCar"] == null
            ? []
            : List<PorCate>.from(
                json["priceByCar"].map((x) => PorCate.fromJson(x))),
        totalV: json["totalV"] == null ? 0 : json["totalV"],
        valTurno: json["valTurno"] == null
            ? []
            : List<ValTurno>.from(
                json["valTurno"].map((x) => ValTurno.fromJson(x))),
        vehiT: json["vehiT"] == null
            ? []
            : List<ValTurno>.from(
                json["vehiT"].map((x) => ValTurno.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "porCate": porCate,
        "priceByCar": priceByCar,
        "totalV": totalV,
        "valTurno": valTurno,
        "vehiT": vehiT,
      };
}

class PorCate {
  PorCate({
    this.id,
    this.count,
  });

  PorCateId? id;
  int? count;

  factory PorCate.fromJson(Map<String, dynamic> json) => PorCate(
        id: json["_id"] == null
            ? PorCateId.fromJson({})
            : PorCateId.fromJson(json["_id"]),
        count: (json["count"] == null) ? 0 : json["count"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "count": count,
      };
}

class PorCateId {
  PorCateId({
    this.category,
  });

  String? category;

  factory PorCateId.fromJson(Map<String, dynamic> json) => PorCateId(
        category: json["category"] == null ? null : json["category"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
      };
}

class ValTurno {
  ValTurno({
    this.id,
    this.count,
  });

  ValTurnoId? id;
  int? count;

  factory ValTurno.fromJson(Map<String, dynamic> json) => ValTurno(
        id: json["_id"] == null
            ? ValTurnoId.fromJson({})
            : ValTurnoId.fromJson(json["_id"]),
        count: (json["count"] == null) ? 0 : json["count"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "count": count,
      };
}

class ValTurnoId {
  ValTurnoId({
    this.idTurno,
  });

  String? idTurno;

  factory ValTurnoId.fromJson(Map<String, dynamic> json) => ValTurnoId(
        idTurno: json["idTurno"] == null ? "" : json["idTurno"],
      );

  Map<String, dynamic> toJson() => {
        "idTurno": idTurno,
      };
}
