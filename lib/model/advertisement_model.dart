// To parse this JSON data, do
//
//     final advertisementModel = advertisementModelFromJson(jsonString);

import 'dart:convert';

List<AdvertisementModel> advertisementModelFromJson(String str) =>
    List<AdvertisementModel>.from(
        json.decode(str).map((x) => AdvertisementModel.fromJson(x)));

String advertisementModelToJson(List<AdvertisementModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdvertisementModel {
  int? id;
  String? title;
  String? content;
  String? image;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  AdvertisementModel({
    this.id,
    this.title,
    this.content,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory AdvertisementModel.fromJson(Map<String, dynamic> json) =>
      AdvertisementModel(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        image: json["image"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "image": image,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
