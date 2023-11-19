// To parse this JSON data, do
//
//     final manageTimeModel = manageTimeModelFromJson(jsonString);

import 'dart:convert';

ManageTimeModel manageTimeModelFromJson(String str) =>
    ManageTimeModel.fromJson(json.decode(str));

String manageTimeModelToJson(ManageTimeModel data) =>
    json.encode(data.toJson());

class ManageTimeModel {
  String? message;
  Data? data;

  ManageTimeModel({
    this.message,
    this.data,
  });

  factory ManageTimeModel.fromJson(Map<String, dynamic> json) =>
      ManageTimeModel(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  dynamic dayId;
  dynamic vendorId;
  dynamic openingTime;
  dynamic closingTime;
  dynamic updatedAt;
  dynamic createdAt;
  dynamic id;

  Data({
    this.dayId,
    this.vendorId,
    this.openingTime,
    this.closingTime,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        dayId: json["day_id"],
        vendorId: json["vendor_id"],
        openingTime: json["opening_time"],
        closingTime: json["closing_time"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "day_id": dayId,
        "vendor_id": vendorId,
        "opening_time": openingTime,
        "closing_time": closingTime,
        "updated_at": updatedAt,
        "created_at": createdAt,
        "id": id,
      };
}
