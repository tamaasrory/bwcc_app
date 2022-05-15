class Select {
  Select({
    this.value,
    this.text,
  });

  String? value;
  String? text;

  factory Select.fromJson(Map<String, dynamic> json) => Select(
        value: json["value"].toString(),
        text: json['text'].toString(),
      );

  Map<String, dynamic> toJson() => {
        'value': value,
        'text': text,
      };
}
