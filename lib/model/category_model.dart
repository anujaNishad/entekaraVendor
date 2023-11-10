// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  String? vendorId;
  String? message;
  List<Category>? category;

  CategoryModel({
    this.vendorId,
    this.message,
    this.category,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        vendorId: json["vendor_id"],
        message: json["message"],
        category:
            List<Category>.from(json["data"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "vendor_id": vendorId,
        "message": message,
        "data": List<dynamic>.from(category!.map((x) => x.toJson())),
      };
}

class Category {
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

  Category({
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

  factory Category.fromJson(Map<String, dynamic> json) => Category(
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
