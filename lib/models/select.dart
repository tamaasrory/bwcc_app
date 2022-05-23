class Select {
  Select({
    this.value,
    this.text,
    this.id,
  });

  String? value;
  String? text;
  String? id;

  factory Select.fromJson(Map<String, dynamic> json) => Select(
        value: json["value"].toString(),
        text: json['text'].toString(),
        id: json['id'].toString(),
      );

  Map<String, dynamic> toJson() => {
        'value': value,
        'text': text,
        'id': id,
      };
}
