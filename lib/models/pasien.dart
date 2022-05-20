class Pasien {
  String? value;
  String? text;
  String? id;
  String? userId;
  String? nrm;
  String? golonganDarah;
  String? avatar;
  String? nama;
  String? namaPenanggungjawab;
  String? jenisKelamin;
  String? note;
  String? umur;
  String? phone;
  String? tempatLahir;
  String? tglLahir;
  String? alamat;
  String? provinsi;
  String? kabKota;
  String? kecamatan;
  String? desa;
  String? kodepos;
  String? createdAt;
  String? updatedAt;

  Pasien(
      {this.value,
      this.text,
      this.id,
      this.userId,
      this.nrm,
      this.golonganDarah,
      this.avatar,
      this.nama,
      this.namaPenanggungjawab,
      this.jenisKelamin,
      this.note,
      this.umur,
      this.phone,
      this.tempatLahir,
      this.tglLahir,
      this.alamat,
      this.provinsi,
      this.kabKota,
      this.kecamatan,
      this.desa,
      this.kodepos,
      this.createdAt,
      this.updatedAt});

  Pasien.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
    id = json['id'];
    userId = json['user_id'];
    nrm = json['nrm'];
    golonganDarah = json['golongan_darah'];
    avatar = json['avatar'];
    nama = json['nama'];
    namaPenanggungjawab = json['nama_penanggungjawab'];
    jenisKelamin = json['jenis_kelamin'];
    note = json['note'];
    umur = json['umur'];
    phone = json['phone'];
    tempatLahir = json['tempat_lahir'];
    tglLahir = json['tgl_lahir'];
    alamat = json['alamat'];
    provinsi = json['provinsi'];
    kabKota = json['kab_kota'];
    kecamatan = json['kecamatan'];
    desa = json['desa'];
    kodepos = json['kodepos'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['text'] = text;
    data['id'] = id;
    data['user_id'] = userId;
    data['nrm'] = nrm;
    data['golongan_darah'] = golonganDarah;
    data['avatar'] = avatar;
    data['nama'] = nama;
    data['nama_penanggungjawab'] = namaPenanggungjawab;
    data['jenis_kelamin'] = jenisKelamin;
    data['note'] = note;
    data['umur'] = umur;
    data['phone'] = phone;
    data['tempat_lahir'] = tempatLahir;
    data['tgl_lahir'] = tglLahir;
    data['alamat'] = alamat;
    data['provinsi'] = provinsi;
    data['kab_kota'] = kabKota;
    data['kecamatan'] = kecamatan;
    data['desa'] = desa;
    data['kodepos'] = kodepos;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
