// To parse this JSON data, do
//
//     final documentTypeModel = documentTypeModelFromJson(jsonString);

import 'dart:convert';

DocumentTypeModel documentTypeModelFromJson(String str) =>
    DocumentTypeModel.fromJson(json.decode(str));

String documentTypeModelToJson(DocumentTypeModel data) =>
    json.encode(data.toJson());

class DocumentTypeModel {
  String? message;
  List<Datum>? data;

  DocumentTypeModel({
    this.message,
    this.data,
  });

  factory DocumentTypeModel.fromJson(Map<String, dynamic> json) =>
      DocumentTypeModel(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  String? name;

  Datum({
    this.id,
    this.name,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
