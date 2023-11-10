// To parse this JSON data, do
//
//     final signupModel = signupModelFromJson(jsonString);

import 'dart:convert';

SignupModel signupModelFromJson(String str) =>
    SignupModel.fromJson(json.decode(str));

String signupModelToJson(SignupModel data) => json.encode(data.toJson());

class SignupModel {
  String? message;
  String? id;
  String? vendorName;
  String? ownerName;

  SignupModel({
    this.message,
    this.id,
    this.vendorName,
    this.ownerName,
  });

  factory SignupModel.fromJson(Map<String, dynamic> json) => SignupModel(
        message: json["message"],
        id: json["id"],
        vendorName: json["vendor name"],
        ownerName: json["owner name"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "id": id,
        "vendor name": vendorName,
        "owner name": ownerName,
      };
}
