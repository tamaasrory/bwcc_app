class ReservasiLayanan {
  String? idLayanan;
  String? kuotaLayananId;
  String? email;
  String? nama;
  String? namaPenanggungjawab;
  String? hari;
  String? jamWaktu;
  String? note;
  String? tglLahir;

  ReservasiLayanan({
    this.idLayanan,
    this.kuotaLayananId,
    this.email,
    this.nama,
    this.namaPenanggungjawab,
    this.hari,
    this.jamWaktu,
    this.note,
    this.tglLahir,
  });

  ReservasiLayanan.fromJson(Map<String, dynamic> json) {
    idLayanan = json['id_layanan'].toString();
    kuotaLayananId = json['kuota_layanan_id'].toString();
    email = json['email'].toString();
    nama = json['nama'].toString();
    hari = json['hari'].toString();
    jamWaktu = json['jam_waktu'].toString();
    note = json['note'].toString();
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['id_layanan'] = idLayanan.toString();
    data['kuota_layanan_id'] = kuotaLayananId.toString();
    data['email'] = email.toString();
    data['nama'] = nama.toString();
    data['nama_penanggungjawab'] = namaPenanggungjawab.toString();
    data['hari'] = hari.toString();
    data['jam_waktu'] = jamWaktu.toString();
    data['note'] = note.toString();
    data['tgl_lahir'] = tglLahir.toString();
    return data;
  }
}
