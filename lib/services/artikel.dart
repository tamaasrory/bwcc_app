import 'dart:convert';

import 'package:bwcc_app/models/artikel.dart';

import '../config/app.dart';
import '../models/responses.dart';

class ArtikelService {
  static Future<Responses<List<Artikel>>> index() async {
    try {
      var response = await ApiService.get('artikel');

      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        // logApp("jsonObject['results'] ==> " + jsonEncode(jsonObject['results']));

        return Responses<List<Artikel>>(
          condition: jsonObject['condition'] as bool,
          message: jsonObject['message'],
          results: List<Artikel>.from(jsonObject['results'].map((value) {
            // logApp('ArtikelService ==> ' + jsonEncode(value));
            return Artikel.fromJson(value);
          })),
        );
      } else {
        return Responses<List<Artikel>>(
          condition: false,
          message: 'Tidak dapat memuat data, Sepertinya ada masalah',
          results: List<Artikel>.from([]),
        );
      }
    } catch (e) {
      logApp('ArtikelService error message => ' + e.toString());
      return Responses<List<Artikel>>(
        condition: false,
        message: 'Sepertinya ada masalah, Mohon periksa jaringan/koneksi anda',
        results: List<Artikel>.from([]),
      );
    }
  }
}
