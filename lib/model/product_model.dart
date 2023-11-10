// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  String? vendorId;
  String? message;
  List<Datum>? data;

  ProductModel({
    this.vendorId,
    this.message,
    this.data,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
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
  String? title;
  int? unitId;
  String? brand;
  String? shortDescription;
  String? description;
  String? countryOfOrigin;
  String? image;
  int? cgst;
  int? sgst;
  String? hsnCode;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  int? brandId;
  String? unit;

  Datum({
    this.id,
    this.title,
    this.unitId,
    this.brand,
    this.shortDescription,
    this.description,
    this.countryOfOrigin,
    this.image,
    this.cgst,
    this.sgst,
    this.hsnCode,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.brandId,
    this.unit,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        unitId: json["unit_id"],
        brand: json["brand"],
        shortDescription: json["short_description"],
        description: json["description"],
        countryOfOrigin: json["country_of_origin"],
        image: json["image"],
        cgst: json["cgst"],
        sgst: json["sgst"],
        hsnCode: json["hsn_code"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        brandId: json["brand_id"],
        unit: json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "unit_id": unitId,
        "brand": brand,
        "short_description": shortDescription,
        "description": description,
        "country_of_origin": countryOfOrigin,
        "image": image,
        "cgst": cgst,
        "sgst": sgst,
        "hsn_code": hsnCode,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "brand_id": brandId,
        "unit": unit,
      };
}
