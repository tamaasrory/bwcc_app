class Dokter {
  Dokter({
    this.id,
    this.avatar,
    this.icon,
    this.namaPoli,
    this.spesialis,
    this.nama,
    this.createdBy,
    this.updatedBy,
  });

  String? id;
  String? avatar;
  String? icon;
  String? namaPoli;
  String? spesialis;
  String? nama;
  String? createdBy;
  String? updatedBy;

  factory Dokter.fromJson(Map<String, dynamic> json) => Dokter(
        id: json["id"].toString(),
        avatar: json["avatar"],
        icon: json["icon"],
        namaPoli: json["nama_poli"],
        spesialis: json["spesialis"],
        nama: json["nama"].toString(),
        createdBy: json["created_by"].toString(),
        updatedBy: json["updated_by"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "avatar": avatar,
        "icon": icon,
        "nama_poli": namaPoli,
        "spesialis": spesialis,
        "nama": nama,
        "created_by": createdBy,
        "updated_by": updatedBy,
      };
}
