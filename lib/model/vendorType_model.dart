// To parse this JSON data, do
//
//     final vendorTypeModel = vendorTypeModelFromJson(jsonString);

import 'dart:convert';

VendorTypeModel vendorTypeModelFromJson(String str) =>
    VendorTypeModel.fromJson(json.decode(str));

String vendorTypeModelToJson(VendorTypeModel data) =>
    json.encode(data.toJson());

class VendorTypeModel {
  String? message;
  List<Datum>? data;

  VendorTypeModel({
    this.message,
    this.data,
  });

  factory VendorTypeModel.fromJson(Map<String, dynamic> json) =>
      VendorTypeModel(
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
  String? name;

  Datum({
    this.id,
    this.name,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
