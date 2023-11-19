// To parse this JSON data, do
//
//     final deleteCategoryModel = deleteCategoryModelFromJson(jsonString);

import 'dart:convert';

DeleteCategoryModel deleteCategoryModelFromJson(String str) =>
    DeleteCategoryModel.fromJson(json.decode(str));

String deleteCategoryModelToJson(DeleteCategoryModel data) =>
    json.encode(data.toJson());

class DeleteCategoryModel {
  List<dynamic>? id;
  String? message;

  DeleteCategoryModel({
    this.id,
    this.message,
  });

  factory DeleteCategoryModel.fromJson(Map<String, dynamic> json) =>
      DeleteCategoryModel(
        id: List<dynamic>.from(json["id"].map((x) => x)),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "id": List<dynamic>.from(id!.map((x) => x)),
        "message": message,
      };
}
