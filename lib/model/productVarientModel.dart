// To parse this JSON data, do
//
//     final productVarientModel = productVarientModelFromJson(jsonString);

import 'dart:convert';

ProductVarientModel productVarientModelFromJson(String str) =>
    ProductVarientModel.fromJson(json.decode(str));

String productVarientModelToJson(ProductVarientModel data) =>
    json.encode(data.toJson());

class ProductVarientModel {
  String? productId;
  List<Datum>? data;

  ProductVarientModel({
    this.productId,
    this.data,
  });

  factory ProductVarientModel.fromJson(Map<String, dynamic> json) =>
      ProductVarientModel(
        productId: json["product_id"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  dynamic id;
  dynamic productId;
  dynamic variantTitle;
  dynamic variantDescription;
  dynamic thumbnailImage;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

  Datum({
    this.id,
    this.productId,
    this.variantTitle,
    this.variantDescription,
    this.thumbnailImage,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        productId: json["product_id"],
        variantTitle: json["variant_title"],
        variantDescription: json["variant_description"],
        thumbnailImage: json["thumbnail_image"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "variant_title": variantTitle,
        "variant_description": variantDescription,
        "thumbnail_image": thumbnailImage,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };
}
