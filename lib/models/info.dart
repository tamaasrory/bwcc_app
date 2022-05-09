class Info {
  Info({
    this.id,
    this.image,
    this.link,
    this.createdBy,
    this.updatedBy,
  });

  String? id;
  String? image;
  String? link;
  String? createdBy;
  String? updatedBy;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        id: json["id"].toString(),
        image: json["image"].toString(),
        link: json["link"].toString(),
        createdBy: json["created_by"].toString(),
        updatedBy: json["updated_by"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "link": link,
        "created_by": createdBy,
        "updated_by": updatedBy,
      };
}
