// To parse this JSON data, do
//
//     final daysModel = daysModelFromJson(jsonString);

import 'dart:convert';

DaysModel daysModelFromJson(String str) => DaysModel.fromJson(json.decode(str));

String daysModelToJson(DaysModel data) => json.encode(data.toJson());

class DaysModel {
  String? message;
  List<Datum>? data;

  DaysModel({
    this.message,
    this.data,
  });

  factory DaysModel.fromJson(Map<String, dynamic> json) => DaysModel(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  String? dayTitle;
  bool? isSelect = false;

  Datum({
    this.id,
    this.dayTitle,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        dayTitle: json["day_title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "day_title": dayTitle,
      };
}
