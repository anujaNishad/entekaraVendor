// To parse this JSON data, do
//
//     final verifyOtpModel = verifyOtpModelFromJson(jsonString);

import 'dart:convert';

VerifyOtpModel verifyOtpModelFromJson(String str) =>
    VerifyOtpModel.fromJson(json.decode(str));

String verifyOtpModelToJson(VerifyOtpModel data) => json.encode(data.toJson());

class VerifyOtpModel {
  String? message;
  Data? data;

  VerifyOtpModel({
    this.message,
    this.data,
  });

  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) => VerifyOtpModel(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  String? token;
  int? id;
  int? existing;
  String? vendorName;
  String? ownerName;
  String? mobile;
  String? thumbnail;

  Data(
      {this.token,
      this.id,
      this.existing,
      this.vendorName,
      this.ownerName,
      this.mobile,
      this.thumbnail});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        id: json["id"],
        existing: json["existing"],
        vendorName: json["vendor name"],
        ownerName: json["owner name"],
        mobile: json["mobile"],
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "id": id,
        "existing": existing,
        "vendor name": vendorName,
        "owner name": ownerName,
        "mobile": mobile,
        "thumbnail": mobile,
      };
}
