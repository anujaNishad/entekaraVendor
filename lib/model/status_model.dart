// To parse this JSON data, do
//
//     final statusModel = statusModelFromJson(jsonString);

import 'dart:convert';

StatusModel statusModelFromJson(String str) =>
    StatusModel.fromJson(json.decode(str));

String statusModelToJson(StatusModel data) => json.encode(data.toJson());

class StatusModel {
  String? message;
  Data? data;

  StatusModel({
    this.message,
    this.data,
  });

  factory StatusModel.fromJson(Map<String, dynamic> json) => StatusModel(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  int? existing;
  dynamic isApproved;

  Data({
    this.existing,
    this.isApproved,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        existing: json["existing"],
        isApproved: json["is_approved"] == null ? null : json["is_approved"],
      );

  Map<String, dynamic> toJson() => {
        "existing": existing,
        "is_approved": isApproved,
      };
}
