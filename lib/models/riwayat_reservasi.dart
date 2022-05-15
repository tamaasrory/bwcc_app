class RiwayatReservasi {
  RiwayatReservasi({
    this.id,
    this.noReservasi,
    this.userId,
    this.pasienId,
    this.poliId,
    this.dokterId,
    this.kuotaId,
    this.hari,
    this.jam,
    this.note,
    this.asuransiId,
    this.feePendaftaran,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.nama,
    this.noAntrian,
    this.jamakhir,
    this.image,
    this.statuskonfirm,
    this.poli,
    this.dokter,
    this.additional,
  });

  String? id;
  String? noReservasi;
  String? userId;
  String? pasienId;
  String? poliId;
  String? dokterId;
  String? kuotaId;
  String? hari;
  String? jam;
  String? note;
  String? asuransiId;
  String? feePendaftaran;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? nama;
  String? noAntrian;
  String? jamakhir;
  String? image;
  String? statuskonfirm;
  String? poli;
  String? dokter;
  String? additional;

  factory RiwayatReservasi.fromJson(Map<String, dynamic> json) => RiwayatReservasi(
        id: json["id"].toString(),
        noReservasi: json["no_reservasi"].toString(),
        userId: json["user_id"].toString(),
        pasienId: json["pasien_id"].toString(),
        poliId: json["poli_id"].toString(),
        dokterId: json["dokter_id"].toString(),
        kuotaId: json["kuota_id"].toString(),
        hari: json["hari"].toString(),
        jam: json["jam"].toString(),
        note: json["note"].toString(),
        asuransiId: json["asuransi_id"].toString(),
        feePendaftaran: json["fee_pendaftaran"].toString(),
        status: json["status"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
        nama: json["nama"].toString(),
        noAntrian: json["no_antrian"].toString(),
        jamakhir: json["jamakhir"].toString(),
        image: json["image"].toString(),
        statuskonfirm: json["statuskonfirm"].toString(),
        poli: json["poli"].toString(),
        dokter: json["dokter"].toString(),
        additional: json["additional"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "no_reservasi": noReservasi,
        "user_id": userId,
        "pasien_id": pasienId,
        "poli_id": poliId,
        "dokter_id": dokterId,
        "kuota_id": kuotaId,
        "hari": hari,
        "jam": jam,
        "note": note,
        "asuransi_id": asuransiId,
        "fee_pendaftaran": feePendaftaran,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "nama": nama,
        "no_antrian": noAntrian,
        "jamakhir": jamakhir,
        "image": image,
        "statuskonfirm": statuskonfirm,
        "poli": poli,
        "dokter": dokter,
        "additional": additional,
      };
}
