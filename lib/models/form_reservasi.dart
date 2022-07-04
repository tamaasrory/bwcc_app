class FormReservasi {
  FormReservasi({
    this.poliId,
    this.dokterId,
    this.kuotaId,
    this.hari,
    this.jamWaktu,
    this.note,
    this.feePendaftaran,
    this.asuransiId,
    this.nama,
    this.nik,
    this.namaPenanggungjawab,
    this.gender,
    this.phone,
    this.alamat,
    this.tglLahir,
    this.email,
  });

  String? poliId;
  String? dokterId;
  String? kuotaId;
  String? hari;
  String? jamWaktu;
  String? note;
  String? email;
  String? feePendaftaran;
  String? asuransiId;
  String? nama;
  String? namaPenanggungjawab;
  String? tglLahir;
  String? nik;
  String? gender;
  String? phone;
  String? alamat;

  Map<String, String> toJson() => {
        'poli_id': poliId.toString(),
        'dokter_id': dokterId.toString(),
        'kuota_id': kuotaId.toString(),
        'hari': hari.toString(),
        'jam_waktu': jamWaktu.toString(),
        'note': note.toString(),
        'email': email.toString(),
        'fee_pendaftaran': feePendaftaran.toString(),
        'asuransi_id': asuransiId.toString(),
        'nama': nama.toString(),
        'nik': nik.toString(),
        'nama_penanggungjawab': namaPenanggungjawab.toString(),
        'tgl_lahir': tglLahir.toString(),
        'gender': gender.toString(),
        'phone': phone.toString(),
        'alamat': alamat.toString(),
      };

  isValid() {
    return poliId.toString() != 'null' &&
        dokterId.toString() != 'null' &&
        jamWaktu.toString() != 'null' &&
        kuotaId.toString() != 'null' &&
        hari.toString() != 'null' &&
        namaPenanggungjawab.toString() != 'null' &&
        nama.toString() != 'null' &&
        nik.toString() != 'null' &&
        tglLahir.toString() != 'null' &&
        asuransiId.toString() != 'null';
  }
}
