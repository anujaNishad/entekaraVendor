// To parse this JSON data, do
//
//     final deleteProductModel = deleteProductModelFromJson(jsonString);

import 'dart:convert';

DeleteProductModel deleteProductModelFromJson(String str) =>
    DeleteProductModel.fromJson(json.decode(str));

String deleteProductModelToJson(DeleteProductModel data) =>
    json.encode(data.toJson());

class DeleteProductModel {
  dynamic id;
  dynamic message;

  DeleteProductModel({
    this.id,
    this.message,
  });

  factory DeleteProductModel.fromJson(Map<String, dynamic> json) =>
      DeleteProductModel(
        id: json["id"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
      };
}
