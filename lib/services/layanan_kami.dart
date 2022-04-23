import 'dart:convert';

import '../config/app.dart';
import '../models/responses.dart';
import '../models/layanan_kami.dart';

class LayananKamiService {
  static Future<Responses<List<LayananKami>>> index() async {
    try {
      var response = await ApiService.get('layanan-kami');

      if (response.statusCode == 200) {
        logApp(response.body.toString());
        var jsonObject = jsonDecode(response.body);
        logApp("jsonObject['results'] ==> " + jsonEncode(jsonObject['results']));

        return Responses<List<LayananKami>>(
          condition: jsonObject['condition'] as bool,
          message: jsonObject['message'],
          results: List<LayananKami>.from(jsonObject['results'].map((value) {
            // logApp('LayananKamiService ==> ' + jsonEncode(value));
            return LayananKami.fromJson(value);
          })),
        );
      } else {
        return Responses<List<LayananKami>>(
          condition: false,
          message: 'Tidak dapat memuat data, Sepertinya ada masalah',
          results: List<LayananKami>.from([]),
        );
      }
    } catch (e) {
      logApp('LayananKamiService error message => ' + e.toString());
      return Responses<List<LayananKami>>(
        condition: false,
        message: 'Sepertinya ada masalah, Mohon periksa jaringan/koneksi anda',
        results: List<LayananKami>.from([]),
      );
    }
  }
}
