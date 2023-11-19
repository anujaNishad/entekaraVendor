// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  String? message;
  Data? data;

  ProfileModel({
    this.message,
    this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  int? id;
  int? userId;
  String? vendorName;
  String? ownerName;
  String? contact1;
  String? contact2;
  String? address;
  DateTime? registrationDate;
  int? vendorTypeId;
  String? latitude;
  String? longitude;
  String? pincode;
  String? state;
  String? district;
  String? locality;
  String? gstNumber;
  String? documentUpload;
  String? thumbnailImage;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.id,
    this.userId,
    this.vendorName,
    this.ownerName,
    this.contact1,
    this.contact2,
    this.address,
    this.registrationDate,
    this.vendorTypeId,
    this.latitude,
    this.longitude,
    this.pincode,
    this.state,
    this.district,
    this.locality,
    this.gstNumber,
    this.documentUpload,
    this.thumbnailImage,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        vendorName: json["vendor_name"],
        ownerName: json["owner_name"],
        contact1: json["contact1"],
        contact2: json["contact2"],
        address: json["address"],
        registrationDate: DateTime.parse(json["registration_date"]),
        vendorTypeId: json["vendor_type_id"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        pincode: json["pincode"],
        state: json["state"],
        district: json["district"],
        locality: json["locality"],
        gstNumber: json["gst_number"],
        documentUpload: json["document_upload"],
        thumbnailImage: json["thumbnail_image"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "vendor_name": vendorName,
        "owner_name": ownerName,
        "contact1": contact1,
        "contact2": contact2,
        "address": address,
        "registration_date":
            "${registrationDate!.year.toString().padLeft(4, '0')}-${registrationDate!.month.toString().padLeft(2, '0')}-${registrationDate!.day.toString().padLeft(2, '0')}",
        "vendor_type_id": vendorTypeId,
        "latitude": latitude,
        "longitude": longitude,
        "pincode": pincode,
        "state": state,
        "district": district,
        "locality": locality,
        "gst_number": gstNumber,
        "document_upload": documentUpload,
        "thumbnail_image": thumbnailImage,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
