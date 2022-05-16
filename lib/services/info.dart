import 'dart:convert';

import 'package:bwcc_app/models/info.dart';

import '../config/app.dart';
import '../models/responses.dart';

class InfoService {
  static Future<Responses<List<Info>>> index() async {
    try {
      var response = await ApiService.get('slide-info');

      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        // logApp("jsonObject['results'] ==> " + jsonEncode(jsonObject['results']));

        return Responses<List<Info>>(
          condition: jsonObject['condition'] as bool,
          message: jsonObject['message'],
          results: List<Info>.from(jsonObject['results'].map((value) {
            // logApp('InfoService ==> ' + jsonEncode(value));
            return Info.fromJson(value);
          })),
        );
      } else {
        return Responses<List<Info>>(
          condition: false,
          message: 'Tidak dapat memuat data, Sepertinya ada masalah',
          results: List<Info>.from([]),
        );
      }
    } catch (e) {
      logApp('InfoService error message => ' + e.toString());
      return Responses<List<Info>>(
        condition: false,
        message: 'Sepertinya ada masalah, Mohon periksa jaringan/koneksi anda',
        results: List<Info>.from([]),
      );
    }
  }

  static Future<Responses<Info>> getDetail({required String id}) async {
    try {
      var response = await ApiService.get("slide-info/show", query: {'id': id});

      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        // ignore: prefer_typing_uninitialized_variables
        var results;
        if (jsonObject['results'] != null) {
          results = (jsonObject as Map<String, dynamic>)['results'];
          results = Info.fromJson(results);
        }

        return Responses<Info>(
          condition: jsonObject['condition'] as bool,
          message: jsonObject['message'],
          results: results,
        );
      } else {
        return Responses<Info>(
          condition: false,
          message: 'Info tidak ditemukan',
          results: null,
        );
      }
    } catch (e) {
      logApp('message ERROR => ' + e.toString());
      return Responses<Info>(
        condition: false,
        message: getMessage(e),
        results: null,
      );
    }
  }
}
