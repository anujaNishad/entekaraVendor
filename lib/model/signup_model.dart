// To parse this JSON data, do
//
//     final signupModel = signupModelFromJson(jsonString);

import 'dart:convert';

SignupModel signupModelFromJson(String str) =>
    SignupModel.fromJson(json.decode(str));

String signupModelToJson(SignupModel data) => json.encode(data.toJson());

class SignupModel {
  String? message;
  Data? data;

  SignupModel({
    this.message,
    this.data,
  });

  factory SignupModel.fromJson(Map<String, dynamic> json) => SignupModel(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  String? id;
  String? vendorName;
  String? ownerName;

  Data({
    this.id,
    this.vendorName,
    this.ownerName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        vendorName: json["vendor name"],
        ownerName: json["owner name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vendor name": vendorName,
        "owner name": ownerName,
      };
}
