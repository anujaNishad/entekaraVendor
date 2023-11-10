// To parse this JSON data, do
//
//     final updateCategoryModel = updateCategoryModelFromJson(jsonString);

import 'dart:convert';

UpdateCategoryModel updateCategoryModelFromJson(String str) =>
    UpdateCategoryModel.fromJson(json.decode(str));

String updateCategoryModelToJson(UpdateCategoryModel data) =>
    json.encode(data.toJson());

class UpdateCategoryModel {
  String? message;

  UpdateCategoryModel({
    this.message,
  });

  factory UpdateCategoryModel.fromJson(Map<String, dynamic> json) =>
      UpdateCategoryModel(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
