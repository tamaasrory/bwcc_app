class Contact {
  Contact({
    this.id,
    this.judul,
    this.slug,
    this.image,
    this.deskripsi,
    this.author,
    this.editor,
  });

  String? id;
  String? judul;
  String? slug;
  String? image;
  String? deskripsi;
  String? author;
  String? editor;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        id: json["id"].toString(),
        judul: json['judul'].toString(),
        slug: json['slug'].toString(),
        image: json['image'].toString(),
        deskripsi: json['deskripsi'].toString(),
        author: json['author'].toString(),
        editor: json['editor'].toString(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'judul': judul,
        'slug': slug,
        'image': image,
        'deskripsi': deskripsi,
        'author': author,
        'editor': editor,
      };
}
