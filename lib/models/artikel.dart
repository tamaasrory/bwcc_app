import 'package:bwcc_app/models/user.dart';

class Artikel {
  Artikel({
    this.id,
    this.judul,
    this.slug,
    this.image,
    this.deskripsi,
    this.author,
    this.editor,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? judul;
  String? slug;
  String? image;
  String? deskripsi;
  User? author;
  String? editor;
  String? createdAt;
  String? updatedAt;

  factory Artikel.fromJson(Map<String, dynamic> json) => Artikel(
        id: json["id"].toString(),
        judul: json['judul'].toString(),
        slug: json['slug'].toString(),
        image: json['image'].toString(),
        deskripsi: json['deskripsi'].toString(),
        author: User.fromJson(json['author']),
        editor: json['editor'].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'judul': judul,
        'slug': slug,
        'image': image,
        'deskripsi': deskripsi,
        'author': author,
        'editor': editor,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
