class LayananKami {
  LayananKami({
    this.id,
    this.icon,
    this.judul,
    this.deskripsi,
    this.createdBy,
    this.updatedBy,
  });

  String? id;
  String? icon;
  String? judul;
  String? deskripsi;
  String? createdBy;
  String? updatedBy;

  factory LayananKami.fromJson(Map<String, dynamic> json) => LayananKami(
        id: json["id"].toString(),
        icon: json["icon"].toString(),
        judul: json["judul"].toString(),
        deskripsi: json["deskripsi"].toString(),
        createdBy: json["created_by"].toString(),
        updatedBy: json["updated_by"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "icon": icon,
        "judul": judul,
        "deskripsi": deskripsi,
        "created_by": createdBy,
        "updated_by": updatedBy,
      };
}
