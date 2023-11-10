// To parse this JSON data, do
//
//     final updateProductItemModel = updateProductItemModelFromJson(jsonString);

import 'dart:convert';

UpdateProductItemModel updateProductItemModelFromJson(String str) =>
    UpdateProductItemModel.fromJson(json.decode(str));

String updateProductItemModelToJson(UpdateProductItemModel data) =>
    json.encode(data.toJson());

class UpdateProductItemModel {
  int? id;
  String? vendorId;
  String? productId;
  String? variantId;
  String? price;
  String? discount;
  dynamic sku;
  dynamic stock;
  String? isADeal;
  int? dealDiscount;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  UpdateProductItemModel({
    this.id,
    this.vendorId,
    this.productId,
    this.variantId,
    this.price,
    this.discount,
    this.sku,
    this.stock,
    this.isADeal,
    this.dealDiscount,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory UpdateProductItemModel.fromJson(Map<String, dynamic> json) =>
      UpdateProductItemModel(
        id: json["id"],
        vendorId: json["vendor_id"],
        productId: json["product_id"],
        variantId: json["variant_id"],
        price: json["price"],
        discount: json["discount"],
        sku: json["sku"],
        stock: json["stock"],
        isADeal: json["is_a_deal"],
        dealDiscount: json["deal_discount"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vendor_id": vendorId,
        "product_id": productId,
        "variant_id": variantId,
        "price": price,
        "discount": discount,
        "sku": sku,
        "stock": stock,
        "is_a_deal": isADeal,
        "deal_discount": dealDiscount,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
