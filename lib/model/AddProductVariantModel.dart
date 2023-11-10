// To parse this JSON data, do
//
//     final addProductVarientModel = addProductVarientModelFromJson(jsonString);

import 'dart:convert';

AddProductVarientModel addProductVarientModelFromJson(String str) =>
    AddProductVarientModel.fromJson(json.decode(str));

String addProductVarientModelToJson(AddProductVarientModel data) =>
    json.encode(data.toJson());

class AddProductVarientModel {
  String? vendorId;
  String? productId;
  String? variantId;
  String? price;
  String? discount;
  dynamic sku;
  dynamic stock;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  AddProductVarientModel({
    this.vendorId,
    this.productId,
    this.variantId,
    this.price,
    this.discount,
    this.sku,
    this.stock,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory AddProductVarientModel.fromJson(Map<String, dynamic> json) =>
      AddProductVarientModel(
        vendorId: json["vendor_id"],
        productId: json["product_id"],
        variantId: json["variant_id"],
        price: json["price"],
        discount: json["discount"],
        sku: json["sku"],
        stock: json["stock"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "vendor_id": vendorId,
        "product_id": productId,
        "variant_id": variantId,
        "price": price,
        "discount": discount,
        "sku": sku,
        "stock": stock,
        "updated_at": updatedAt,
        "created_at": createdAt,
        "id": id,
      };
}
