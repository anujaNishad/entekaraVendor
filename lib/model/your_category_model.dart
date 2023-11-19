// To parse this JSON data, do
//
//     final yourCategoryModel = yourCategoryModelFromJson(jsonString);

import 'dart:convert';

YourCategoryModel yourCategoryModelFromJson(String str) =>
    YourCategoryModel.fromJson(json.decode(str));

String yourCategoryModelToJson(YourCategoryModel data) =>
    json.encode(data.toJson());

class YourCategoryModel {
  String? vendorId;
  String? message;
  List<Datum>? data;

  YourCategoryModel({
    this.vendorId,
    this.message,
    this.data,
  });

  factory YourCategoryModel.fromJson(Map<String, dynamic> json) =>
      YourCategoryModel(
        vendorId: json["vendor_id"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "vendor_id": vendorId,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  String? name;
  String? image;
  int? parentId;
  int? hasChild;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? parent;
  bool isSelect = false;

  Datum({
    this.id,
    this.name,
    this.image,
    this.parentId,
    this.hasChild,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.parent,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        parentId: json["parent_id"],
        hasChild: json["has_child"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        parent: json["parent"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "parent_id": parentId,
        "has_child": hasChild,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "parent": parent,
      };
}
