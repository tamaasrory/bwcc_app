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


  static Future<Responses<RiwayatReservasi>> getDetailRiwayat({required String noReservasi}) async {
    try {
      var response = await ApiService.get("reservasi/detail", query: {'no_reservasi': noReservasi});

      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        // ignore: prefer_typing_uninitialized_variables
        var results;
        if (jsonObject['results'] != null) {
          results = (jsonObject as Map<String, dynamic>)['results'];
          results = RiwayatReservasi.fromJson(results);
        }

        return Responses<RiwayatReservasi>(
          condition: jsonObject['condition'] as bool,
          message: jsonObject['message'],
          results: results,
        );
      } else {
        return Responses<RiwayatReservasi>(
          condition: false,
          message: 'Tidak dapat melakukan login',
          results: null,
        );
      }
    } catch (e) {
      logApp('message ERROR => ' + e.toString());
      return Responses<RiwayatReservasi>(
        condition: false,
        message: getMessage(e),
        results: null,
      );
    }
  }
}
