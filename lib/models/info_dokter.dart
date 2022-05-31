class InfoDokter {
  String? id;
  String? informasi;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;

  InfoDokter({this.id, this.informasi, this.createdBy, this.updatedBy, this.createdAt, this.updatedAt});

  InfoDokter.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    informasi = json['informasi'].toString();
    createdBy = json['created_by'].toString();
    updatedBy = json['updated_by'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id.toString();
    data['informasi'] = informasi.toString();
    data['created_by'] = createdBy.toString();
    data['updated_by'] = updatedBy.toString();
    data['created_at'] = createdAt.toString();
    data['updated_at'] = updatedAt.toString();
    return data;
  }
}
