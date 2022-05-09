class LayananKami {
  LayananKami({
    this.id,
    this.icon,
    this.judul,
    this.featureImage,
    this.deskripsi,
    this.createdBy,
    this.updatedBy,
  });

  String? id;
  String? icon;
  String? judul;
  String? featureImage;
  String? deskripsi;
  String? createdBy;
  String? updatedBy;

  factory LayananKami.fromJson(Map<String, dynamic> json) => LayananKami(
        id: json["id"].toString(),
        icon: json["icon"].toString(),
        judul: json["judul"].toString(),
        featureImage: json["feature_image"].toString(),
        deskripsi: json["deskripsi"].toString(),
        createdBy: json["created_by"].toString(),
        updatedBy: json["updated_by"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "icon": icon,
        "judul": judul,
        "featureImage": featureImage,
        "deskripsi": deskripsi,
        "created_by": createdBy,
        "updated_by": updatedBy,
      };
}
