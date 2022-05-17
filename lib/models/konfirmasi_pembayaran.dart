class KonfirmasiPembayaran {
  String? noReservasi;
  String? image;

  KonfirmasiPembayaran({this.noReservasi, this.image});

  KonfirmasiPembayaran.fromJson(Map<String, dynamic> json) {
    noReservasi = json['no_reservasi'].toString();
    image = json['image'].toString();
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['no_reservasi'] = noReservasi.toString();
    data['image'] = image.toString();
    return data;
  }
}
