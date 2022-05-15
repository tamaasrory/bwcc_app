class SelectPasien {
  SelectPasien({
    this.value,
    this.text,
    this.jenisKelamin,
    this.tglLahir,
  });

  String? value;
  String? text;
  String? jenisKelamin;
  String? tglLahir;

  factory SelectPasien.fromJson(Map<String, dynamic> json) => SelectPasien(
        value: json["value"].toString(),
        text: json['text'].toString(),
        tglLahir: json['tgl_lahir'],
        jenisKelamin: json['jenis_kelamin'],
      );

  Map<String, dynamic> toJson() => {
        'value': value,
        'text': text,
      };
}
