import 'dart:convert';

import 'package:bwcc_app/models/reservasi_layanan.dart';
import 'package:bwcc_app/models/select.dart';

import '../config/app.dart';
import '../models/responses.dart';

class ReservasiLayananService {
  static Future<Responses<List<Select>>> getPembayaran() async {
    try {
      var response = await ApiService.get('metode-pembayaran');

      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        // logApp("jsonObject['results'] ==> " + jsonEncode(jsonObject['results']));

        return Responses<List<Select>>(
          condition: jsonObject['condition'] as bool,
          message: jsonObject['message'],
          results: List<Select>.from(jsonObject['results'].map((value) {
            // logApp('PoliService ==> ' + jsonEncode(value));
            return Select.fromJson(value);
          })),
        );
      } else {
        return Responses<List<Select>>(
          condition: false,
          message: 'Tidak dapat memuat data, Sepertinya ada masalah',
          results: List<Select>.from([]),
        );
      }
    } catch (e) {
      logApp('PoliService error message => ' + e.toString());
      return Responses<List<Select>>(
        condition: false,
        message: 'Sepertinya ada masalah, Mohon periksa jaringan/koneksi anda',
        results: List<Select>.from([]),
      );
    }
  }

  static Future<Responses<List<Select>>> getLayanan() async {
    try {
      var response = await ApiService.get(
        'reservasi/layanan',
        query: {
          'data': 'layanan',
          'mode': 'select',
        },
      );

      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        // logApp("jsonObject['results'] ==> " + jsonEncode(jsonObject['results']));

        return Responses<List<Select>>(
          condition: jsonObject['condition'] as bool,
          message: jsonObject['message'],
          results: List<Select>.from(jsonObject['results'].map((value) {
            // logApp('PoliService ==> ' + jsonEncode(value));
            return Select.fromJson(value);
          })),
        );
      } else {
        return Responses<List<Select>>(
          condition: false,
          message: 'Tidak dapat memuat data, Sepertinya ada masalah',
          results: List<Select>.from([]),
        );
      }
    } catch (e) {
      logApp('PoliService error message => ' + e.toString());
      return Responses<List<Select>>(
        condition: false,
        message: 'Sepertinya ada masalah, Mohon periksa jaringan/koneksi anda',
        results: List<Select>.from([]),
      );
    }
  }

  static Future<Responses<List>> getHariReservasi({required String layananId}) async {
    try {
      var response = await ApiService.get(
        'reservasi/layanan',
        query: {
          'data': 'hari',
          'mode': 'select',
          'layanan': layananId,
        },
      );

      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        // logApp("jsonObject['results'] ==> " + jsonEncode(jsonObject['results']));

        return Responses<List>(
          condition: jsonObject['condition'] as bool,
          message: jsonObject['message'],
          results: List.from(jsonObject['results'].map((value) {
            // logApp('PoliService ==> ' + jsonEncode(value));
            return value;
          })),
        );
      } else {
        return Responses<List>(
          condition: false,
          message: 'Tidak dapat memuat data, Sepertinya ada masalah',
          results: List.from([]),
        );
      }
    } catch (e) {
      logApp('PoliService error message => ' + e.toString());
      return Responses<List>(
        condition: false,
        message: 'Sepertinya ada masalah, Mohon periksa jaringan/koneksi anda',
        results: List.from([]),
      );
    }
  }

  static Future<Responses<List<Select>>> getWaktuReservasi({
    required String layananId,
    required String hari,
  }) async {
    try {
      var response = await ApiService.get(
        'reservasi/layanan',
        query: {
          'data': 'jam',
          'mode': 'select',
          'layanan': layananId.toString(),
          'hari': hari.toString(),
        },
      );

      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        // logApp("jsonObject['results'] ==> " + jsonEncode(jsonObject['results']));

        return Responses<List<Select>>(
          condition: jsonObject['condition'] as bool,
          message: jsonObject['message'],
          results: List<Select>.from(jsonObject['results'].map((value) {
            // logApp('PoliService ==> ' + jsonEncode(value));
            return Select.fromJson(value);
          })),
        );
      } else {
        return Responses<List<Select>>(
          condition: false,
          message: 'Tidak dapat memuat data, Sepertinya ada masalah',
          results: List<Select>.from([]),
        );
      }
    } catch (e) {
      logApp('PoliService error message => ' + e.toString());
      return Responses<List<Select>>(
        condition: false,
        message: 'Sepertinya ada masalah, Mohon periksa jaringan/koneksi anda',
        results: List<Select>.from([]),
      );
    }
  }

  static Future<Responses<Map<String, dynamic>>> postReservasi(ReservasiLayanan formReservasi) async {
    try {
      var response = await ApiService.post("reservasi/layanan-store", formReservasi.toJson());

      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        // ignore: prefer_typing_uninitialized_variables
        var results;
        if (jsonObject['results'] != null) {
          results = (jsonObject as Map<String, dynamic>)['results'];
          // results = List.from(results);  
        }

        return Responses<Map<String, dynamic>>(
          condition: jsonObject['condition'] as bool,
          message: jsonObject['message'],
          results: results,
        );
      } else {
        return Responses<Map<String, dynamic>>(
          condition: false,
          message: 'Tidak dapat mengirim reservasi, silahkan coba lagi',
          results: null,
        );
      }
    } catch (e) {
      logApp('message ERROR => ' + e.toString());
      return Responses<Map<String, dynamic>>(
        condition: false,
        message: getMessage(e),
        results: null,
      );
    }
  }
}
