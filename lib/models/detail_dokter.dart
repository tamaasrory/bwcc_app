class DetailDokter {
  String? id;
  String? userId;
  String? avatar;
  String? nama;
  String? slug;
  String? icon;
  String? spesialis;
  String? jenisKelamin;
  String? phone;
  String? createdAt;
  String? updatedAt;
  List<Jadwal>? jadwal;

  DetailDokter(
      {this.id,
      this.userId,
      this.avatar,
      this.nama,
      this.slug,
      this.icon,
      this.spesialis,
      this.jenisKelamin,
      this.phone,
      this.createdAt,
      this.updatedAt,
      this.jadwal});

  DetailDokter.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    userId = json['user_id'].toString();
    avatar = json['avatar'];
    nama = json['nama'].toString();
    slug = json['slug'].toString();
    icon = json['icon'];
    spesialis = json['spesialis'] ?? 'Belum ada detail spesialis';
    jenisKelamin = json['jenis_kelamin'].toString();
    phone = json['phone'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    if (json['jadwal'] != null) {
      jadwal = List<Jadwal>.from(json['jadwal'].map((value) {
        // logApp('DetailDokterService ==> ' + jsonEncode(value));
        return Jadwal.fromJson(value);
      }));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['avatar'] = avatar;
    data['nama'] = nama;
    data['slug'] = slug;
    data['jenis_kelamin'] = jenisKelamin;
    data['phone'] = phone;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (jadwal != null) {
      data['jadwal'] = jadwal!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Jadwal {
  String? poliId;
  String? poli;
  String? hari;
  String? jamAwal;
  String? jamAkhir;
  String? kuota;
  String? kuotamenit;
  String? ots;
  String? otsmenit;

  Jadwal(
      {this.poliId,
      this.poli,
      this.hari,
      this.jamAwal,
      this.jamAkhir,
      this.kuota,
      this.kuotamenit,
      this.ots,
      this.otsmenit});

  Jadwal.fromJson(Map<String, dynamic> json) {
    poliId = json['poli_id'].toString();
    poli = json['poli'].toString();
    hari = json['hari'].toString();
    jamAwal = json['jam_awal'].toString();
    jamAkhir = json['jam_akhir'].toString();
    kuota = json['kuota'].toString();
    kuotamenit = json['kuotamenit'].toString();
    ots = json['ots'].toString();
    otsmenit = json['otsmenit'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['poli_id'] = poliId;
    data['poli'] = poli;
    data['hari'] = hari;
    data['jam_awal'] = jamAwal;
    data['jam_akhir'] = jamAkhir;
    data['kuota'] = kuota;
    data['kuotamenit'] = kuotamenit;
    data['ots'] = ots;
    data['otsmenit'] = otsmenit;
    return data;
  }
}
