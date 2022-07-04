class Pasien {
  String? value;
  String? text;
  String? id;
  String? userId;
  String? nrm;
  String? golonganDarah;
  String? avatar;
  String? nama;
  String? nik;
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
      this.nik,
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
    nik = json['nik'];
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

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['value'] = value.toString();
    data['text'] = text.toString();
    data['id'] = id.toString();
    data['user_id'] = userId.toString();
    data['nrm'] = nrm.toString();
    data['golongan_darah'] = golonganDarah.toString();
    data['avatar'] = avatar.toString();
    data['nama'] = nama.toString();
    data['nik'] = nik.toString();
    data['nama_penanggungjawab'] = namaPenanggungjawab.toString();
    data['jenis_kelamin'] = jenisKelamin.toString();
    data['note'] = note.toString();
    data['umur'] = umur.toString();
    data['phone'] = phone.toString();
    data['tempat_lahir'] = tempatLahir.toString();
    data['tgl_lahir'] = tglLahir.toString();
    data['alamat'] = alamat.toString();
    data['provinsi'] = provinsi.toString();
    data['kab_kota'] = kabKota.toString();
    data['kecamatan'] = kecamatan.toString();
    data['desa'] = desa.toString();
    data['kodepos'] = kodepos.toString();
    data['created_at'] = createdAt.toString();
    data['updated_at'] = updatedAt.toString();
    return data;
  }
}
