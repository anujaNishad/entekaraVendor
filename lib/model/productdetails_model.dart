// To parse this JSON data, do
//
//     final productDetailsModel = productDetailsModelFromJson(jsonString);

import 'dart:convert';

ProductDetailsModel productDetailsModelFromJson(String str) =>
    ProductDetailsModel.fromJson(json.decode(str));

String productDetailsModelToJson(ProductDetailsModel data) =>
    json.encode(data.toJson());

class ProductDetailsModel {
  String? vendorId;
  String? message;
  List<Datum>? data;

  ProductDetailsModel({
    this.vendorId,
    this.message,
    this.data,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailsModel(
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
  dynamic id;
  dynamic vendorId;
  dynamic productId;
  dynamic variantId;
  dynamic price;
  dynamic discount;
  dynamic sku;
  dynamic stock;
  dynamic isADeal;
  dynamic dealDiscount;
  dynamic status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic variantTitle;
  dynamic variantDescription;
  dynamic thumbnailImage;
  dynamic productBrand;
  dynamic productBrandId;
  dynamic productUnit;
  dynamic productTitle;
  dynamic productUnitId;
  dynamic productShortDescription;
  dynamic productDescription;
  dynamic productCountryOfOrigin;
  dynamic productImage;
  dynamic productCgst;
  dynamic productSgst;
  dynamic productHsnCode;

  Datum({
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
    this.variantTitle,
    this.variantDescription,
    this.thumbnailImage,
    this.productBrand,
    this.productBrandId,
    this.productUnit,
    this.productTitle,
    this.productUnitId,
    this.productShortDescription,
    this.productDescription,
    this.productCountryOfOrigin,
    this.productImage,
    this.productCgst,
    this.productSgst,
    this.productHsnCode,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
        variantTitle: json["variant_title"],
        variantDescription: json["variant_description"],
        thumbnailImage: json["thumbnail_image"],
        productBrand: json["product_brand"],
        productBrandId: json["product_brand_id"],
        productUnit: json["product_unit"],
        productTitle: json["product_title"],
        productUnitId: json["product_unit_id"],
        productShortDescription: json["product_short_description"],
        productDescription: json["product_description"],
        productCountryOfOrigin: json["product_country_of_origin"],
        productImage: json["product_image"],
        productCgst: json["product_cgst"],
        productSgst: json["product_sgst"],
        productHsnCode: json["product_hsn_code"],
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
        "variant_title": variantTitle,
        "variant_description": variantDescription,
        "thumbnail_image": thumbnailImage,
        "product_brand": productBrand,
        "product_brand_id": productBrandId,
        "product_unit": productUnit,
        "product_title": productTitle,
        "product_unit_id": productUnitId,
        "product_short_description": productShortDescription,
        "product_description": productDescription,
        "product_country_of_origin": productCountryOfOrigin,
        "product_image": productImage,
        "product_cgst": productCgst,
        "product_sgst": productSgst,
        "product_hsn_code": productHsnCode,
      };
}
