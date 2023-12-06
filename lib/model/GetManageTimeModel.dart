// To parse this JSON data, do
//
//     final getManageTimeModel = getManageTimeModelFromJson(jsonString);

import 'dart:convert';

GetManageTimeModel getManageTimeModelFromJson(String str) =>
    GetManageTimeModel.fromJson(json.decode(str));

String getManageTimeModelToJson(GetManageTimeModel data) =>
    json.encode(data.toJson());

class GetManageTimeModel {
  String? message;
  List<Datum>? data;

  GetManageTimeModel({
    this.message,
    this.data,
  });

  factory GetManageTimeModel.fromJson(Map<String, dynamic> json) =>
      GetManageTimeModel(
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
  int? dayId;
  int? vendorId;
  String? openingTime;
  String? closingTime;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.dayTitle,
    this.dayId,
    this.vendorId,
    this.openingTime,
    this.closingTime,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        dayTitle: json["day_title"],
        dayId: json["day_id"],
        vendorId: json["vendor_id"],
        openingTime: json["opening_time"],
        closingTime: json["closing_time"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "day_title": dayTitle,
        "day_id": dayId,
        "vendor_id": vendorId,
        "opening_time": openingTime,
        "closing_time": closingTime,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
