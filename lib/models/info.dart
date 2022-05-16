import 'package:bwcc_app/models/user.dart';

class Info {
  Info({
    this.id,
    this.image,
    this.link,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? image;
  String? link;
  User? createdBy;
  User? updatedBy;
  String? createdAt;
  String? updatedAt;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        id: json["id"].toString(),
        image: json["image"].toString(),
        link: json["link"].toString(),
        createdBy: json["created_by"] != null ? User.fromJson(json["created_by"]) : User(),
        updatedBy: json["updated_by"] != null ? User.fromJson(json["updated_by"]) : User(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "link": link,
        "created_by": createdBy,
        "updated_by": updatedBy,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
